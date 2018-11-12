From: Robert.Richter@cavium.com (Richter, Robert)
Date: Mon, 12 Nov 2018 08:54:10 +0000
Subject: [PATCH 01/10] irqdomain: Add interface to request an irq domain
In-Reply-To: <efea8ead-6432-7cc4-fe54-034e34ce2f2d@arm.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-2-rrichter@cavium.com>
 <e640a85d-6e2c-835b-d104-ef42eada8fde@arm.com>
 <20181108150355.GA4064@rric.localdomain>
 <efea8ead-6432-7cc4-fe54-034e34ce2f2d@arm.com>
Message-ID: <20181112085402.GG4064@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julien,

On 09.11.18 09:05:11, Julien Thierry wrote:
> On 08/11/18 15:05, Richter, Robert wrote:

> >>>+static void irq_domain_handle_requests(struct fwnode_handle *fwnode,
> >>>+                        enum irq_domain_bus_token bus_token)
> >>>+{
> >>>+     struct irq_domain *domain;
> >>>+     struct irq_domain_request *request;
> >>>+
> >>>+     if (!fwnode)
> >>>+             return;
> >>>+redo:
> >>>+     domain = irq_find_matching_fwnode(fwnode, bus_token);
> >>>+     if (!domain)
> >>>+             return;
> >>>+
> >>>+     mutex_lock(&irq_domain_mutex);
> >>>+
> >>
> >>Why do we need to take the mutex before checking the domain fields?
> >>Can't we delay it?
> >
> >The list is protected by the mutex. irq_find_matching_fwnode() also
> >accesses the list and must use the same mutex.
> >
> >>
> >>>+     if ((domain->fwnode != fwnode) && (domain->bus_token != bus_token)) {
> >>
> >>Why do we even need that check?
> >
> >The domain token might have changed after irq_find_matching_fwnode()
> >and before mutex_lock(), we do a recheck here. Some sort of try-lock.
> >
> >Note: I found the check being wrong here, it needs to be corrected to:
> >
> >      if ((domain->fwnode != fwnode) || (domain->bus_token != bus_token)) {
> >
> >>
> >>Isn't the point of passing fwnode and bus_token to
> >>irq_find_matching_fwnode to find a domain with those properties?
> >
> >Yes, but properties may change and also the list itself.
> 
> Hmmm, that check is unrelated to the list, you're just checking the
> domain you just retrieved.
> 
> Can you clarify which properties may change? If the irq_domain fields
> can change (I guess if e.g. another cpu modifies the domain with
> irq_domain_update_bus_token), they could still be changed between the
> moment you retrieved the domain and the moment you call the handler. Why
> is that not an issue if we worried about properties changing before
> removing the request from the list?
> 
> Maybe some comment would help here.

The check makes sure we can use the irq_domain_requests list for the
serialization of irq domain updates. Suppose the following:

Thread1         Thread2

~~~~~~~~~~~~~~~~~~~~~~~~~       mutex
fwnode
token1
handler1                        request_fwnode()
~~~~~~~~~~~~~~~~~~~~~~~~~
domain1
fwnode
token1                          find_fwnode()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain1
                fwnode
                token1          find_fwnode()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain1
                fwnode
                token1
                handler1        call_handler()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain1
                fwnode
                token2          update_token()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain2
                fwnode
                token1          update_token()
~~~~~~~~~~~~~~~~~~~~~~~~~
                fwnode
                token1
                handler1        request_fwnode(), reschedule request
~~~~~~~~~~~~~~~~~~~~~~~~~
domain1                         <---- called with wrong domain, should be domain2
fwnode
token1
handler1                        call_handler()
~~~~~~~~~~~~~~~~~~~~~~~~~

The check handles a corner case and as such the conditions for
triggering it are rare and might look a bit constructed, but it *can*
happen. So see the check more like an assertion in the code that does
not hurt much. How about the following comment:?

	/*
	 * For serialization of irq domain updates make sure to handle
	 * (and remove) the request only if the domain still matches
	 * the request.
	 */

> 
> >
> >>
> >>>+             mutex_unlock(&irq_domain_mutex);
> >>>+             goto redo;
> >>>+     }
> >>>+
> >>>+     list_for_each_entry(request, &irq_domain_requests, list) {
> >>
> >>Shouldn't you use list_for_each_safe if you want to remove elements of
> >>the list inside the loop?
> >
> >No, we do a complete redo again without further iterating the list. We
> >need to do this since the handler must be called with the mutex
> >unlocked (to be able to manipulate the irq domain list in the callback
> >and to be in non-atomic context). After we unlocked the mutex, we must
> >restart again as the list may have changed.
> >
> >>
> >>>+             if (request->fwnode != fwnode ||
> >>>+                 request->bus_token != bus_token)
> >>>+                     continue;
> >>>+
> >>>+             list_del(&request->list);
> >>>+             mutex_unlock(&irq_domain_mutex);
> >>>+
> >>>+             irq_domain_call_handler(domain, request->callback,
> >>>+                                     request->name, request->priv);
> >>>+             irq_domain_free_request(request);
> >>>+
> >>>+             goto redo;
> >>>+     }
> >>>+
> >>>+     mutex_unlock(&irq_domain_mutex);
> >>>+}
> >>>+
> >>>+static int __init irq_domain_drain_requests(void)
> >>>+{
> >>>+     struct irq_domain_request *request;
> >>>+     struct irq_domain *domain;
> >>>+     int ret = 0;
> >>>+redo:
> >>>+     mutex_lock(&irq_domain_mutex);
> >>>+
> >>>+     list_for_each_entry(request, &irq_domain_requests, list) {
> >>
> >>Same remark.
> >
> >Same here, the difference is that we can directly operate with the
> >request, no need to check the domain.
> >
> >>
> >>>+             list_del(&request->list);
> >>>+             mutex_unlock(&irq_domain_mutex);
> >>>+
> >>>+             domain = irq_find_matching_fwnode(request->fwnode,
> >>>+                                             request->bus_token);
> >>>+             if (domain) {
> >>>+                     irq_domain_call_handler(domain, request->callback,
> >>>+                                             request->name, request->priv);
> >>>+             } else {
> >>>+                     ret = -ENODEV;
> >>>+                     pr_err("%s-%d: Unhandled domain request\n",
> >>>+                             request->name, request->bus_token);
> >>>+             }
> >>>+
> >>>+             irq_domain_free_request(request);
> >>>+
> >>>+             goto redo;
> >>
> >>Hmmm, are you starting a loop to break out of it at each iteration?
> >
> >We have to as the list lock was released which is needed for
> >irq_find_matching_fwnode() and the callback handler.
> >
> >>
> >>Wouldn't it be much simpler to have something like the following?
> >>
> >>        while (!list_empty(&irq_domain_requests) {
> >>                mutex_lock(&irq_domain_mutex);
> >>                request = list_first_entry_or_null(&irq_domain_requests,
> >>                                        struct irq_domain_request,
> >>                                        list);
> >>                if (request)
> >>                        list_del(&request->list);
> >>                mutex_unlock(&irq_domain_mutex);
> >
> >At this point my implmentation has only 5 lines of code and uses one
> >list command less than your's. I am also not happy using list_empty()
> >without the lock hold (though it seems to be used that way elsewhere).
> 
> I'm not sure why the number of list commands is relevant.

You said "simpler".

> "list_for_each_entry" just already combines a bunch of operations, but
> caries a completely different meaning (and probably expands code in the
> function that is never used).
> 
> For irq_domain_drain, you take the first element as long as there is one
> and do stuff with it, so having something like:
> 
>        mutex_lock();
>        while (!list_empty()) {
>                request = list_first_entry();
>                list_del(request->list);
> 
>                // unlock and relock as you please
>                // and do stuff
>        }
>        mutex_unlock();
> 
> Or if you are really concerned about the number of list commands:
> 
>        mutex_lock();
>        while ((request = list_first_entry_or_null()) != NULL) {
>                list_del(request->list);
> 
>                // unlock and relock as you please
>                // and do stuff
>        }
>        mutex_unlock();
> 
> To me this makes it much easier to get what you are trying to do and I
> don't think it is less efficient that your version (but I could be wrong).

Both is not much far away from what I have now. To me it is just a
flavor. I don't like the assignment in a condition. And if you fill in
the args it doesn't fit into a single line and doesn't look that easy
anymore.

> 
> 
> For irq_domain_handle_request, I think I agree that it is actually
> different from irq_domain_drain, but it is hard to see in my opinion
> because of how the functions are structured. So I would suggest
> something like:
> 
>        while ((domain = irq_domain_find(...)) != NULL) {
>                struct irq_domain_request *found = NULL;
> 
>                mutex_lock();
> 
>                // Do the check on domain if it is needed
> 
>                list_for_each_entry(request, ..., list) {
>                        if (request->fwnode != fwnode ||
>                            request->bus_token != bus_token)
>                                continue;
> 
>                        list_del(request->list);
>                        found = request;
>                        break;
>                }
>                mutex_unlock();
> 
>                if (found) {
>                        // call handler, etc...
>                }
>        }
> 
> 
> Personally, I find those flow much easier to follow than when using
> gotos to break out of loops.

This does not work and ends up in an endless loop, only the request is
removed from the request list, not the node from the node list.

> 
> This is just my suggestion so feel free to disregard if the maintainers
> agree with your current approach.

Yeah, I probably can live with an alternative implementation, but
let's wait for others to comment.

Thanks again,

-Robert
