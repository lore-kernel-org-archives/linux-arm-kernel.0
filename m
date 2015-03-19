From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 19 Mar 2015 10:43:54 +0530
Subject: [PATCH 3/3] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20150318152658.GO3318@x1>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
 <CAJe_Zhc1uLf_grsbzOs3ahJHJXXZ+BF__702mEPPL=SWPU5nzw@mail.gmail.com>
 <20150318131226.GM3318@x1>
 <CABb+yY2HwZn3VSvZ4iVfWE8GrsLDA6Tx_V2HZiOBvJb9UHY2Mg@mail.gmail.com>
 <20150318152658.GO3318@x1>
Message-ID: <CABb+yY0tMwYTFDvF2Gce4h5xhKOboLS=32yK42-eoksZ8SAbZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 8:56 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Mar 2015, Jassi Brar wrote:

>> >> > +                       mbox->irq = irq_create_mapping(mbinst->irq_domain,
>> >> > +                                                      mbox->rx_id);
>> >> >
>> >> simply assigning same IRQ to all controller DT nodes and using
>> >> IRQF_SHARED for the common handler, wouldn't work?
>> >
>> > I do have intentions to simplify this driver somewhat, but that will
>> > take some time as it will require a great deal of consultation and
>> > testing from the ST side.  This is the current internal implementation
>> > which is used in the wild and has been fully tested.  If you'll allow
>> > me to conduct my adaptions subsequently we can have full history and a
>> > possible reversion plan if anything untoward take place i.e. I mess
>> > something up.
>> >
>> OK, but wouldn't that break the bindings of this driver when you
>> eventually do that?
>
> That's going to happen regardless, since these bindings are already in
> use internally.  Mainline (i.e. v4.0+) isn't going to be used in
> products for years to come, so we have a lot of time until any new
> bindings become ABI.
>
I thought time starts from upstream. It doesn't seem right to
knowingly introduce a binding that we are going to break in coming
weeks. For this reason, it needs ACK from some DT maintainer.


>> >> > + * struct sti_mbox_msg - sti mailbox message description
>> >> > + * @dsize:             data payload size
>> >> > + * @pdata:             message data payload
>> >> > + */
>> >> > +struct sti_mbox_msg {
>> >> > +       u32             dsize;
>> >> > +       u8              *pdata;
>> >> > +};
>> >> >
>> >> There isn't any client driver in this patchset to tell exactly, but it
>> >> seems the header could be split into one shared between mailbox
>> >> clients and provider and another internal to client/provider ?
>> >
>> > I believe only the above will be required by the client.  Seems silly
>> > to create a client specific header just for that, don't you think?
>> >
>> Do you mean to have copies of the structure in controller and client driver? :O
>
> I do not.  I planned on sharing the main header with with client
> also.
>
> But I guess by your reaction you suggest having a teeny client header
> as the best way forward then.
>
Yes, please. And also no header that's included by exactly one file.
