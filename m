From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 17 Jul 2015 14:10:26 +0100
Subject: [Xen-devel] [PATCH v2 03/20] xen/grant: Introduce helpers to
 split a page into grant
In-Reply-To: <55A7D6AC.5060004@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-4-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161526030.17378@kaball.uk.xensource.com>
 <55A7D6AC.5060004@citrix.com>
Message-ID: <55A8FEC2.1030307@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/15 17:07, Julien Grall wrote:
>>> +    pfn = xen_page_to_pfn(page) + (offset >> XEN_PAGE_SHIFT);
>>> +
>>> +    while (len) {
>>> +        glen = min_t(unsigned int, XEN_PAGE_SIZE - goffset, len);
>>
>> Similarly I don't think we want to support glen != XEN_PAGE_SIZE here
> 
> See my answer above.
> 
>>
>>
>>> +        fn(pfn_to_mfn(pfn), goffset, &glen, data);
>>
>> Allowing the callee to change glen makes the interface more complex and
>> certainly doesn't match the gnttab_foreach_grant function name anymore.
> 
> Why? Each time the callback is called, there is a new grant allocated.

As discussed IRL, I will rename this function into
gnttab_foreach_grant_in_range.

> 
>> If netback needs it, could it just do the work inside its own function?
>> I would rather keep gnttab_foreach_grant simple and move the complexity
>> there.
> 
> Moving the complexity in netback means adding a loop in the callback
> which will do exactly the same as this loop.
> 
> That also means to use XEN_PAGE_SIZE & co which I'm trying to avoid in
> order to not confuse the developer. If they are hidden it likely mean
> less problem on 64KB when the developper is working on 4KB.
> 
> IHMO, the complexity is not so bad and will be more lisible than yet
> another loop.

After the IRL talk, I will give a look if I can move the "netback
problem" in a different helper. We can see later if we could improve the
code.

Regards,

-- 
Julien Grall
