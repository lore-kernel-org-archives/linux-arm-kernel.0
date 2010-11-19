From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Nov 2010 14:09:38 +0200
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
Message-ID: <20101119120938.GN2329@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 05:50:19AM -0600, Kanigeri, Hari wrote:
>Thanks for your comments :).

np.

>I think handling of per-message callback should be handled at one
>level above mailbox, like in IPC modules such as dspbridge,
>syslink..etc.

then you'll have duplication of functionality :-)

>Mailbox module should be free of any protocols and should take care of

it's not a protocol that I'm proposing. It's just one way to give
mailbox users a more async API.

>just writing to the mailbox fifo and delivering the message to the
>interested listener(s).

exactly. Only to the interested listener. With your patch, you'll be
delivering the message to all listeners and listeners have to check if
that particular message belongs to them.

>> What will happen is that every user will have to check if every message
>> belongs to them based on the notifications.
>>
>> Imagine a hypothetical situation where you have 100 users each with 100
>> messages. You will have 100 * 100 (10.000)
>> "does-this-message-belongs-to-me" checks.
>>
>
>Ideally one shouldn't design their IPC this way. They should have a
>IPC driver and the knowledge of notification to multiple users should
>be routed from there.

only if the message is interesting for N listeners. But if each
listeners will have its own message towards the other side of the link,
then mailbox should only give the result to one listener.

>What my patch is addressing is ensure that the users of mailbox don't
>mess with the mailbox's internal pointer, and also provide the
>flexibility of multiple listeners. Designers of IPC should make their
>own judgment whether to use the flexibility option based on their use
>cases.

but with your patch, you are delivering the same message to all
listeners. You give the oportunity even for some attacks. I could fiddle
with other listeners' message just by attaching a notifier_block and
checking what's the content of every message.

>> Rather than doing it this way, I would, as the easiest path, add a
>> "callback" parameter to omap_mbox_request_send() and then, internally,
>> allocate a e.g. struct omap_mbox_request and add that to a list of pending
>> messages. Something like:
>>
>> struct omap_mbox_request {
>> ? ? ? ?struct omap_mbox ? ? ? ?*mbox;
>> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? (*complete)(void *context);
>> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?*context;
>> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?*buf;
>> ? ? ? ?unsigned ? ? ? ? ? ? ? ?len;
>> ? ? ? ?struct list_head ? ? ? ?list;
>> };
>>
>> [...]
>>
>> int omap_mbox_request_send(struct omap_mbox *mbox, mbox_msg_t msg, int
>> ? ? ? ? ? ? ? ?(*complete)(void *context), void *context, gfp_t flags)
>> {
>> ? ? ? ?struct omap_mbox_queue ?*mq = mbox->txq;
>> ? ? ? ?struct omap_mbox_request ? ? ? ?*req;
>> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? ret = 0;
>> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? len;
>>
>> ? ? ? ?req = kzalloc(sizeof(*req), flags);
>> ? ? ? ?if (!req) {
>> ? ? ? ? ? ? ? ?[...]
>> ? ? ? ?}
>>
>> ? ? ? ?memcpy(req->buf, &msg, sizeof(msg));
>> ? ? ? ?req->len = sizeof(msg));
>> ? ? ? ?req->mbox = msg;
>> ? ? ? ?req->complete = complete;
>> ? ? ? ?req->context = context;
>> ? ? ? ?INIT_LIST_HEAD(&req->list);
>>
>> ? ? ? ?list_add_tail(&req->list, &mq->req_list);
>>
>> ? ? ? ?/* kick the tasklet here */
>>
>> ? ? ? ?return 0;
>> }
>>
>> then on your tasklet, you simply iterate over the list and start sending
>> one by one and calling callback when it completes. You would be giving
>> your users a more asynchronous API and you wouldn't need this notifier
>> which, IMO, isn't a good solution at all.
>>
>
>Your ideas are good. But this type of intelligence is already inbuilt
>in IPC drivers such as dspbridge and syslink. And I think mailbox
>driver should be free of protocols.

Like I said before, this is not a protocol. And if both dspbridge and
syslink have the same kind of thing, don't you think it's a duplication?
Don't you, also, think common features should be done at framework
levels ? Since we don't have an IPC framework, we consider the mailbox
driver a framework for using the OMAP mailbox, then the API I proposed
is just one way to address the problem you described. There's nothing
like a protocol here.

In any case, you are the one taking care of those drivers and it's your
call how to handle multiple users, but keep in mind you'll be allowing
anyone to see all messages that are going through mailbox just by
attaching a notifier block :-) If that's ok for you, if you don't see
any troubles with that, go for it. If you also don't see any troubles
with having hundreds of users each with hundreds of messages and you
notifying all of them about all messages as a problem, go for it :-p

-- 
balbi
