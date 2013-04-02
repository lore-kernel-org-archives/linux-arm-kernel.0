From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Apr 2013 11:02:52 +0300
Subject: [PATCH 3/5] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <87obe3irxl.fsf@ashishki-desk.ger.corp.intel.com>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-4-git-send-email-mkl@pengutronix.de>
 <20130308163300.GF32368@arwen.pp.htv.fi>
 <CAB7JpEGP4HXrbGs539pV8ruPrS2ZOT0EYhGR74vvFDtHM4GsQg@mail.gmail.com>
 <513A1743.8070102@pengutronix.de>
 <CAB7JpEE8L+NR109+tnO_dueWtXBPnQVjegojsQNBUgBHPyk5eg@mail.gmail.com>
 <20130310143734.GA9804@arwen.pp.htv.fi>
 <87y5d7ixqb.fsf@ashishki-desk.ger.corp.intel.com>
 <20130328114417.GA23223@arwen.pp.htv.fi>
 <87obe3irxl.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130402080252.GB30286@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 28, 2013 at 03:18:14PM +0200, Alexander Shishkin wrote:
> >> >> >>>> +     dr_mode = ci->platdata->dr_mode;
> >> >> >>>> +     if (dr_mode == USB_DR_MODE_UNKNOWN || dr_mode == USB_DR_MODE_DUAL_ROLE)
> >> >> >>>> +             dr_mode = USB_DR_MODE_OTG;
> >> >> >>>> +
> >> >> >>>>       /* initialize role(s) before the interrupt is requested */
> >> >> >>>> -     ret = ci_hdrc_host_init(ci);
> >> >> >>>> -     if (ret)
> >> >> >>>> -             dev_info(dev, "doesn't support host\n");
> >> >> >>>> +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> >> >> >>>
> >> >> >>> this is not something you should be passing via pdata; chipidea core
> >> >> >>> should know how to read this data by itself. Meaning that chipidea core
> >> >> >>> should be taught about devicetree. But make it optional since now all
> >> >> >>> users use DT.
> >> >> >>
> >> >> >> And I don't think I like the idea of chipidea core calling into device
> >> >> >> tree code directly.
> >> >> >
> >> >> > Hmmm....this means draw :)
> >> >> 
> >> >> Well, we could go for something like
> >> >> 
> >> >> ci_hdrc-$(CONFIG_OF) += of.o
> >> >> 
> >> >> and try to contain the damage there, maybe? Ideas? I would very much
> >> >> like to keep the clutter away from the core probe if possible.
> >> >
> >> > damage, what damage ? DeviceTree is quite real and drivers need to cope
> >> > with it. If not all platforms support devicetree, make it optional. It's
> >> > easy enough to make the choice based on device.of_node being valid or
> >> > not.
> >> 
> >> We have dr_mode and phy_mode (so far). The latter is simple, but the
> >> former one needs to see some special cases, based on its setting. Now,
> >> if we're a pci device, for example, we don't have phandles and stuff and
> >> we will still get this information via platform data.
> >
> > fair enough:
> >
> > if (pdev->dev.of_node)
> > 	chipidea_init_from_dt(ci);
> > else
> > 	chipidea_init_from_pdata(ci);
> 
> You mean, you want to have two instances of the similar logic? Don't
> forget that they might fail to fetch certain phandles and still
> continue, but failing to fetch other phandles will be fatal for
> probe(). The above snipped can also be shortened to
> 
>   chipidea_just_do_the_right_thing(ci); /* I'd like that, btw */
> 
> The devil is in the details.
> 
> Then, I hate to bring it up, but what do you do for acpi devices? PnP
> devices? PCMCIA devices?

those look like PCI devices right ? What's the problem with them ?

> Right now, the core is a platform driver. It gets all the information
> from platform data. That's all it needs for its purpose, and all the
> platform specific details are abstracted away. It's the purpose of the
> glue layer's existance to fetch all the relevant bits from the glue
> driver knows where and supply it in a *consistent* manner to the core.

I still that e.g. requesting regulators in glue and passing a regulator
pointer through platform_data is really, really wrong.

> Note, it's totally different for regulators or clocks or phys. It is
> totally unacceptable to pass objects around between glue and core and
> glue shouldn't have to deal with those. And, of course, you can request
> all those in the core code in a platform-agnostic manner.

how ? If your regulator is bound to the glue, how will you
regulator_get() from core driver ?

> >> So, what we'll end up with is some glue drivers (that don't have device
> >> tree) passing all sorts of stuff via platform data and others just
> >> expecting the chipidea to take care of it. That's inconsistent at best.
> >
> > it's not inconsistent at all.
> >
> > Some drivers pass data through DT and some pass data through pdata.
> >
> > Regardless of which driver type you have, chipidea core still needs to
> > fetch the data, either by of_property_*() calls or by reading
> > pdata->$field.
> >
> > I wouldn't call it inconsistency, it's just coping with both ways of
> > receiving data.
> >
> >> > At the end of the day, it's the chipidea IP which needs dr_mode, not the
> >> > glue. Passing the responsability of decoding dr_mode to the glue is
> >> > moronic. It's just like asking the glue to control chipidea's clocks.
> >> 
> >> Now, now. There's something to be said about stuffing core drivers with
> >> support for all sorts of resource management protocols du jour, but
> >> we'll leave that for another day.
> >> 
> >> As for the clocks, if they are external to chipidea controller, the
> >> latter has no business messing with them. It's like asking chipidea to
> >
> > heh, that's not what I said...
> >
> >> do power management on your SoC for you. :)
> >
> > right, asking other layers to do your work is stupid, that's exactly
> > what I said. Shuving DT knowledge in glue layer just so chipidea core
> > only understands pdata is stupid.
> 
> Why? Especially if the glue drivers have to fetch stuff for their own
> needs from DT anyway. Might easily happen.

why ? Because it's poor encapsulation. Why would you give another entity
knowledge about yourself ?

> > You end up allocating memory twice to
> > hold the same data (once for DT and once for the pdata copies of it).
> 
> It would have been one valid reason for teaching chipidea core about DT,
> if we could duplicate *all* of the pdata fields in DT. Otherwise we
> still need pdata. And supposing that we can (which we can't) do that,
> and supposing that extra 32 bytes of memory actually matter, it still
> doesn't justify the extra code in the core to deal with DT. I'm still
> not convinced.

fair enough, it's your headache in the end of the day anyway. When you
get bug reports such as one we saw recently of clocks being left on even
though probe failed, you'll understand.

You have worked with MUSB before and should already know that giving too
much knowledge to your glue layers is a recipe for disaster.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/43647640/attachment.sig>
