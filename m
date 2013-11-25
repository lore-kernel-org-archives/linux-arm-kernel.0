From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Nov 2013 10:34:35 +0100
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131123163240.GW5928@atomide.com>
References: <20131123004334.GJ10023@atomide.com>
 <20131123005509.GJ16735@n2100.arm.linux.org.uk>
 <20131123010850.GN10023@atomide.com>
 <20131123011515.GO10023@atomide.com>
 <20131123015034.GP10023@atomide.com>
 <CAL_JsqKV7K+QdLHS+3LtfcVx5Dpc7n6A8UwwNWKBP33Gs19c8g@mail.gmail.com>
 <20131123163240.GW5928@atomide.com>
Message-ID: <20131125093434.GE22043@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 08:32:40AM -0800, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [131123 07:43]:
> > On Fri, Nov 22, 2013 at 7:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Tony Lindgren <tony@atomide.com> [131122 17:16]:
> > >> * Tony Lindgren <tony@atomide.com> [131122 17:09]:
> > >> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [131122 16:56]:
> > >> > > On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
> > >> > > > +               /* See of_device_resource_notify for populating interrupts */
> > >> > > > +               for (i = 0; i < num_irq; i++, res++) {
> > >> > > > +                       res->flags = IORESOURCE_IRQ;
> > >> > > > +                       res->start = -EPROBE_DEFER;
> > >> > > > +                       res->end = -EPROBE_DEFER;
> > >> > >
> > >> > > NAK.  Definitely a bad idea to start introducing magic values other into
> > >> > > resources.  Please don't do this.
> > >> >
> > >> > Do you have any better ideas on how to sort out this issue then?
> > >>
> > >> I guess we could allocate all the resources lazily here, I'll take a look
> > >> at that.
> > >
> > > Here's a version that allocates the resources lazily with the notifier.
> > > Seems to boot, need to play with it a bit more though to make sure we're
> > > not overwriting resources for any legacy devices.
> > 
> > Have you seen Thierry's series[1]? While your approach is certainly
> > more concise, it seems like a work-around for the problem. I don't
> > think a notifier is the right long term solution.
> 
> OK cool. I think we can fix the $Subject bug first without making all
> those changes, then do the rest of the reorg for v3.14.
> 
> The bug is that we try to populate IRQ resources at a wrong time
> when they may not exist.
> 
> Based on a quick look it seems we could combine Thierry's addition
> of the new function of_platform_probe(struct platform_device *pdev)
> and use that to allocate all resources at driver probe time like my
> patch is doing. And then there's no need for the notifier.

My series already does the allocation at probe time as well. That was
the whole point. The reason why I added of_platform_probe() is because I
think we'll be needing this for other types of resources in the future
as well, so it could serve as a central place to do all of that.

There was also a proposal[0] by Arnd a few weeks ago that solved this in
a more generic way. I've said it before, and I'll say again that the
idea scares me somewhat, but it does solve some interesting aspects and
has the potential to get rid of a whole lot of boilerplate code. While
the original purpose was to handle all things devm_*(), I suspect that
same mechanism could be used to resolve DT references at probe time.

Thierry

[0]: http://www.spinics.net/lists/devicetree/msg10684.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/dced6001/attachment.sig>
