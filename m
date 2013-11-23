From: tony@atomide.com (Tony Lindgren)
Date: Sat, 23 Nov 2013 08:32:40 -0800
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <CAL_JsqKV7K+QdLHS+3LtfcVx5Dpc7n6A8UwwNWKBP33Gs19c8g@mail.gmail.com>
References: <20131123004334.GJ10023@atomide.com>
 <20131123005509.GJ16735@n2100.arm.linux.org.uk>
 <20131123010850.GN10023@atomide.com>
 <20131123011515.GO10023@atomide.com>
 <20131123015034.GP10023@atomide.com>
 <CAL_JsqKV7K+QdLHS+3LtfcVx5Dpc7n6A8UwwNWKBP33Gs19c8g@mail.gmail.com>
Message-ID: <20131123163240.GW5928@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [131123 07:43]:
> On Fri, Nov 22, 2013 at 7:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [131122 17:16]:
> >> * Tony Lindgren <tony@atomide.com> [131122 17:09]:
> >> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [131122 16:56]:
> >> > > On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
> >> > > > +               /* See of_device_resource_notify for populating interrupts */
> >> > > > +               for (i = 0; i < num_irq; i++, res++) {
> >> > > > +                       res->flags = IORESOURCE_IRQ;
> >> > > > +                       res->start = -EPROBE_DEFER;
> >> > > > +                       res->end = -EPROBE_DEFER;
> >> > >
> >> > > NAK.  Definitely a bad idea to start introducing magic values other into
> >> > > resources.  Please don't do this.
> >> >
> >> > Do you have any better ideas on how to sort out this issue then?
> >>
> >> I guess we could allocate all the resources lazily here, I'll take a look
> >> at that.
> >
> > Here's a version that allocates the resources lazily with the notifier.
> > Seems to boot, need to play with it a bit more though to make sure we're
> > not overwriting resources for any legacy devices.
> 
> Have you seen Thierry's series[1]? While your approach is certainly
> more concise, it seems like a work-around for the problem. I don't
> think a notifier is the right long term solution.

OK cool. I think we can fix the $Subject bug first without making all
those changes, then do the rest of the reorg for v3.14.

The bug is that we try to populate IRQ resources at a wrong time
when they may not exist.

Based on a quick look it seems we could combine Thierry's addition
of the new function of_platform_probe(struct platform_device *pdev)
and use that to allocate all resources at driver probe time like my
patch is doing. And then there's no need for the notifier.

Regards,

Tony

 
> [1] http://www.spinics.net/lists/arm-kernel/msg274110.html
