From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 6 Feb 2017 14:58:59 +0000
Subject: [PATCH] ARM: shmobile: r7s72100: Enable L2 cache
In-Reply-To: <CAMuHMdU6kJDxGtjUT1S2JkQTLvzrgtF3mkqa5Xo08oF6d3tUbw@mail.gmail.com>
References: <20170202212000.10768-1-chris.brandt@renesas.com>
 <CAMuHMdU6kJDxGtjUT1S2JkQTLvzrgtF3mkqa5Xo08oF6d3tUbw@mail.gmail.com>
Message-ID: <SG2PR06MB11657125A12CC1BDE6AD17748A400@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Monday, February 06, 2017, Geert Uytterhoeven wrote:
> CC linux-arm-kernel
> 
> On Thu, Feb 2, 2017 at 10:20 PM, Chris Brandt <chris.brandt@renesas.com>
> wrote:
> > This enables the 128KB L2 cache in the RZ/A1 (R7S72100).
> >
> > The 'Write full line of zeros mode' of this Cortex-A9 cannot be used
> > because the sideband signals between the CA9 and PL310 are not connected.
> > Since there is no option to disable this feature in the cache-l2x0
> > driver, our only option is to specify a secure write function which
> > will then cause the cache-l2x0 driver to not enable this feature.
> 
> What about adding a DT property (e.g. "arm,pl310-broken-sideband", cfr.
> "arm,pl330-broken-no-flushp"), and handling this in arch/arm/mm/cache-
> l2x0.c instead?

Well, first I have to say that 'broken-sideband' is not actually "accurate"
in this case.

>From the RZ/A1H Hardware Manual:

4.  Secondary Cache
4.1 Features

  * Sideband signal from CA9: No


So the chip designers knew the sideband signals were not connected.
If you have a look at the next chapter "5. LSI Internal Bus", you'll notice
that the CA9 is on the North bus (fig 5.2) but the PL310 is on the south
bus (fig 5.3) in between the AXI and the SDRAM/QSPI controller. So in this
in SoC, maybe the PL310 looks more like a L3 than an L2 cache???

So, I would say "arm,pl310-no-sideband" is a better name.


I agree that faking out a secure write function just so the fill-zeros
sideband feature is not enabled is a bit of a hack, but I'm not sure if
modifying the cache-l2x0.c was an option.


If you think so, I can try the "arm,pl310-no-sideband" path first,
and if that doesn't get in I can fall back to what I'm doing now.

Thoughts???



> > +static void r7s72100_l2c_write_sec(unsigned long val, unsigned int
> > +reg) {
> > +       static void __iomem *base;
> > +
> > +       if (!base)
> > +               base = ioremap_nocache(0x3ffff000, SZ_4K);
> 
> FWIW, plain ioremap() is fine.

Of course they both go to the same thing for ARM, but I thought the "_nocache"
version should be used for sanity purposes (as ie, "yes, I know what I'm
doing").


Thanks,
Chris
