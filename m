From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Fri, 19 Nov 2010 05:50:19 -0600
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
Message-ID: <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Fri, Nov 19, 2010 at 2:50 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Nov 18, 2010 at 01:15:42PM -0600, Hari Kanigeri wrote:
>>
>> In the current mailbox driver, the mailbox internal pointer for
>> callback can be directly manipulated by the Users, so a second
>> User can easily corrupt the first user's callback pointer.
>> The initial effort to correct this issue can be referred here:
>> https://patchwork.kernel.org/patch/107520/
>>
>> Along with fixing the above stated issue, this patch ?adds the
>> flexibility option to register notifications from
>> multiple readers to the events received on a mailbox instance.
>> The discussion regarding this can be referred here.
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg30671.html
>>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>
> Personally, I don't like this patch. I think it's much better to have a
> per-message callback then a "global" notification which all users will
> listen to.
>

Thanks for your comments :).
I think handling of per-message callback should be handled at one
level above mailbox, like in IPC modules such as dspbridge,
syslink..etc.
Mailbox module should be free of any protocols and should take care of
just writing to the mailbox fifo and delivering the message to the
interested listener(s).


> What will happen is that every user will have to check if every message
> belongs to them based on the notifications.
>
> Imagine a hypothetical situation where you have 100 users each with 100
> messages. You will have 100 * 100 (10.000)
> "does-this-message-belongs-to-me" checks.
>

Ideally one shouldn't design their IPC this way. They should have a
IPC driver and the knowledge of notification to multiple users should
be routed from there.

What my patch is addressing is ensure that the users of mailbox don't
mess with the mailbox's internal pointer, and also provide the
flexibility of multiple listeners. Designers of IPC should make their
own judgment whether to use the flexibility option based on their use
cases.

> Rather than doing it this way, I would, as the easiest path, add a
> "callback" parameter to omap_mbox_request_send() and then, internally,
> allocate a e.g. struct omap_mbox_request and add that to a list of pending
> messages. Something like:
>
> struct omap_mbox_request {
> ? ? ? ?struct omap_mbox ? ? ? ?*mbox;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? (*complete)(void *context);
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?*context;
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?*buf;
> ? ? ? ?unsigned ? ? ? ? ? ? ? ?len;
> ? ? ? ?struct list_head ? ? ? ?list;
> };
>
> [...]
>
> int omap_mbox_request_send(struct omap_mbox *mbox, mbox_msg_t msg, int
> ? ? ? ? ? ? ? ?(*complete)(void *context), void *context, gfp_t flags)
> {
> ? ? ? ?struct omap_mbox_queue ?*mq = mbox->txq;
> ? ? ? ?struct omap_mbox_request ? ? ? ?*req;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? ret = 0;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? len;
>
> ? ? ? ?req = kzalloc(sizeof(*req), flags);
> ? ? ? ?if (!req) {
> ? ? ? ? ? ? ? ?[...]
> ? ? ? ?}
>
> ? ? ? ?memcpy(req->buf, &msg, sizeof(msg));
> ? ? ? ?req->len = sizeof(msg));
> ? ? ? ?req->mbox = msg;
> ? ? ? ?req->complete = complete;
> ? ? ? ?req->context = context;
> ? ? ? ?INIT_LIST_HEAD(&req->list);
>
> ? ? ? ?list_add_tail(&req->list, &mq->req_list);
>
> ? ? ? ?/* kick the tasklet here */
>
> ? ? ? ?return 0;
> }
>
> then on your tasklet, you simply iterate over the list and start sending
> one by one and calling callback when it completes. You would be giving
> your users a more asynchronous API and you wouldn't need this notifier
> which, IMO, isn't a good solution at all.
>

Your ideas are good. But this type of intelligence is already inbuilt
in IPC drivers such as dspbridge and syslink. And I think mailbox
driver should be free of protocols.

Thank you,
Best regards,
Hari
