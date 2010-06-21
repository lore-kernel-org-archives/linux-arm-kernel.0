From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 12:16:12 +0100
Subject: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<20100621091952.GB7702@n2100.arm.linux.org.uk>
	<AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
Message-ID: <20100621111612.GJ7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 06:39:10PM +0800, Eric Miao wrote:
> On Mon, Jun 21, 2010 at 5:19 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jun 21, 2010 at 05:05:34PM +0800, Eric Miao wrote:
> >> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> >> > +void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
> >> > +{
> >> > + ? ? ? struct samsung_keypad_platdata *npd;
> >> > +
> >> > + ? ? ? if (!pd) {
> >> > + ? ? ? ? ? ? ? printk(KERN_ERR "%s: no platform data\n", __func__);
> >> > + ? ? ? ? ? ? ? return;
> >> > + ? ? ? }
> >> > +
> >> > + ? ? ? npd = kmemdup(pd, sizeof(struct samsung_keypad_platdata), GFP_KERNEL);
> >> > + ? ? ? if (!npd)
> >> > + ? ? ? ? ? ? ? printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> >>
> >> This part of the code is actually duplicated again and again and again
> >> for each device, PXA and other legacy platforms are bad references for
> >> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are three
> >> major points:
> >>
> >> ?1. A minimum 'struct pxa_device_desc' for a simple description of a
> >> ? ? device (more than 90% of the devices can be described that way),
> >> ? ? and avoid using a comparatively heavier weight platform_device,
> >> ? ? which can be generated at run-time
> >>
> >> ?2. pxa_register_device() to allocate and register the platform_device
> >> ? ? at run-time, along with the platform data
> >
> > It's a bad idea to make platform data be run-time discardable like this:
> >
> >> > +struct samsung_keypad_platdata {
> >> > + ? ? ? const struct matrix_keymap_data *keymap_data;
> >
> > What you end up with is some platform data structures which must be kept
> > (those which have pointers to them from the platform data), and others
> > (the platform data itself) which can be discarded at runtime.
> >
> > We know that the __initdata attributations cause lots of problems -
> > they're frequently wrong. ?Just see the constant hastle with __devinit
> > et.al. ?The same issue happens with __initdata as well.
> >
> > So why make things more complicated by allowing some platform data
> > structures to be discardable and others not to be? ?Is their small
> > size (maybe 6 words for this one) really worth the hastle of getting
> > __initdata attributations wrong (eg, on the keymap data?)
> >
> 
> Russell,
> 
> The benefit I see is when multiple boards are compiled in, those
> data not used can be automatically discarded.

Yes, but only some of the data can be discarded.  Continuing with the
example in hand, while you can discard the six words which represent
samsung_keypad_platdata, but the keymap_data can't be because that won't
be re-allocated, which is probably a much larger data structure.

So, samsung_keypad_platdata can be marked with __initdata, but the keymap
data must not be - and this is where the confusion about what can be
marked with __initdata starts - and eventually leads to the keymap data
also being mistakenly marked __initdata.

Is saving six words (or so) worth the effort to track down stuff
inappropriately marked with __initdata ?  I'm sure there's bigger savings
to be had in other parts of the kernel (such as shrinking the size of
tcp hash tables, reducing the kernel message ring buffer, etc) if size is
really a concern.
