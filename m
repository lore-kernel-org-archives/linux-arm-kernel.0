From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Tue, 10 Apr 2012 16:00:34 +0530
Subject: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
In-Reply-To: <20120410101609.GJ20616@arwen.pp.htv.fi>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410092441.GB20616@arwen.pp.htv.fi>
 <CAKdam56-Pu+WJKLUpodTzOzGuGbAHuqZ3F-zVmrAtFM7EDhxpg@mail.gmail.com>
 <20120410101609.GJ20616@arwen.pp.htv.fi>
Message-ID: <CAKdam55V0oRh34TPgc83Xj2xdk8=Dgaz7-441PFOj94mDZY__g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Tue, Apr 10, 2012 at 3:46 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> On Tue, Apr 10, 2012 at 03:37:28PM +0530, Poddar, Sourav wrote:
> > Hi Felipe,
> >
> > On Tue, Apr 10, 2012 at 2:54 PM, Felipe Balbi <balbi@ti.com> wrote:
> >
> > ? ? On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
> > ? ? > +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
> > ? ? > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? u32 offset, u32 value)
> > ? ? > +{
> > ? ? > + ? ? return __raw_writel(value, keypad_data->base + offset);
> > ? ? > +}
> > ? ? > +
> > ? ? > +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
> > ? ? > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? u32 offset, u32 value)
> > ? ? > +{
> > ? ? > + ? ? return __raw_writel(value, keypad_data->base + offset);
> > ? ? > +}
> >
> > ? ? if this only writes to irqenable, why do you pass offset as an argument?
> > ? ? likewise for irqstatus.
> >
> >
> > Actually, here the offset is the "irqenable" register addresss offset and
> > "irqstatus" register
> > address offset from the base address.
> > Since, the above two address are different in case of Omap4 and omap5, we are
> > passing an offset
> > depending on the particular revision of the keyboard selected during probe.
>
> but you already have those in keypad_data->irqenable/irqstatus right ?

Yes.
>
> Meaning you can access them directly here and save on the arguments:
>
> static int kbd_write_irqenable(struct omap4_keypad *keypad_data, u32 value)
> {
> ? ? return __raw_writel(value, keypad_data->base + keypad_data->irqenable);
> }
>
Thanks a lot for pointing this out. Yes, we should be able to directly use
the driver data for the above api.
Will make the necessary change in the next version.
~Sourav
>
>
> --
> balbi
