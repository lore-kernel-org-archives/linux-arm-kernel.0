From: robherring2@gmail.com (Rob Herring)
Date: Sat, 23 Nov 2013 09:42:44 -0600
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131123015034.GP10023@atomide.com>
References: <20131123004334.GJ10023@atomide.com>
 <20131123005509.GJ16735@n2100.arm.linux.org.uk>
 <20131123010850.GN10023@atomide.com>
 <20131123011515.GO10023@atomide.com>
 <20131123015034.GP10023@atomide.com>
Message-ID: <CAL_JsqKV7K+QdLHS+3LtfcVx5Dpc7n6A8UwwNWKBP33Gs19c8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 7:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [131122 17:16]:
>> * Tony Lindgren <tony@atomide.com> [131122 17:09]:
>> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [131122 16:56]:
>> > > On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
>> > > > +               /* See of_device_resource_notify for populating interrupts */
>> > > > +               for (i = 0; i < num_irq; i++, res++) {
>> > > > +                       res->flags = IORESOURCE_IRQ;
>> > > > +                       res->start = -EPROBE_DEFER;
>> > > > +                       res->end = -EPROBE_DEFER;
>> > >
>> > > NAK.  Definitely a bad idea to start introducing magic values other into
>> > > resources.  Please don't do this.
>> >
>> > Do you have any better ideas on how to sort out this issue then?
>>
>> I guess we could allocate all the resources lazily here, I'll take a look
>> at that.
>
> Here's a version that allocates the resources lazily with the notifier.
> Seems to boot, need to play with it a bit more though to make sure we're
> not overwriting resources for any legacy devices.

Have you seen Thierry's series[1]? While your approach is certainly
more concise, it seems like a work-around for the problem. I don't
think a notifier is the right long term solution.

Rob

[1] http://www.spinics.net/lists/arm-kernel/msg274110.html
