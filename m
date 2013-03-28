From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 28 Mar 2013 13:13:00 +0200
Subject: [PATCH 3/5] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <20130310143734.GA9804@arwen.pp.htv.fi>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-4-git-send-email-mkl@pengutronix.de>
 <20130308163300.GF32368@arwen.pp.htv.fi>
 <CAB7JpEGP4HXrbGs539pV8ruPrS2ZOT0EYhGR74vvFDtHM4GsQg@mail.gmail.com>
 <513A1743.8070102@pengutronix.de>
 <CAB7JpEE8L+NR109+tnO_dueWtXBPnQVjegojsQNBUgBHPyk5eg@mail.gmail.com>
 <20130310143734.GA9804@arwen.pp.htv.fi>
Message-ID: <87y5d7ixqb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Fri, Mar 08, 2013 at 10:55:46PM +0200, Alexander Shishkin wrote:
>> >>>> +     dr_mode = ci->platdata->dr_mode;
>> >>>> +     if (dr_mode == USB_DR_MODE_UNKNOWN || dr_mode == USB_DR_MODE_DUAL_ROLE)
>> >>>> +             dr_mode = USB_DR_MODE_OTG;
>> >>>> +
>> >>>>       /* initialize role(s) before the interrupt is requested */
>> >>>> -     ret = ci_hdrc_host_init(ci);
>> >>>> -     if (ret)
>> >>>> -             dev_info(dev, "doesn't support host\n");
>> >>>> +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>> >>>
>> >>> this is not something you should be passing via pdata; chipidea core
>> >>> should know how to read this data by itself. Meaning that chipidea core
>> >>> should be taught about devicetree. But make it optional since now all
>> >>> users use DT.
>> >>
>> >> And I don't think I like the idea of chipidea core calling into device
>> >> tree code directly.
>> >
>> > Hmmm....this means draw :)
>> 
>> Well, we could go for something like
>> 
>> ci_hdrc-$(CONFIG_OF) += of.o
>> 
>> and try to contain the damage there, maybe? Ideas? I would very much
>> like to keep the clutter away from the core probe if possible.
>
> damage, what damage ? DeviceTree is quite real and drivers need to cope
> with it. If not all platforms support devicetree, make it optional. It's
> easy enough to make the choice based on device.of_node being valid or
> not.

We have dr_mode and phy_mode (so far). The latter is simple, but the
former one needs to see some special cases, based on its setting. Now,
if we're a pci device, for example, we don't have phandles and stuff and
we will still get this information via platform data.

So, what we'll end up with is some glue drivers (that don't have device
tree) passing all sorts of stuff via platform data and others just
expecting the chipidea to take care of it. That's inconsistent at best.

> At the end of the day, it's the chipidea IP which needs dr_mode, not the
> glue. Passing the responsability of decoding dr_mode to the glue is
> moronic. It's just like asking the glue to control chipidea's clocks.

Now, now. There's something to be said about stuffing core drivers with
support for all sorts of resource management protocols du jour, but
we'll leave that for another day.

As for the clocks, if they are external to chipidea controller, the
latter has no business messing with them. It's like asking chipidea to
do power management on your SoC for you. :)

Regards,
--
Alex
