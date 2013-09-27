From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 09:45:04 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <20130927025116.GG25146@S2101-09.ap.freescale.net>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
 <20130927025116.GG25146@S2101-09.ap.freescale.net>
Message-ID: <20130927084504.GW12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 10:51:17AM +0800, Shawn Guo wrote:
> On Thu, Sep 26, 2013 at 11:35:43PM +0200, Linus Walleij wrote:
> > On Thu, Sep 26, 2013 at 10:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > > On Thu, Sep 26, 2013 at 4:51 PM, Russell King - ARM Linux
> > 
> > >> I mean the stuff which looks like this:
> > >>
> > >> #define MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0           0x1e8 0x5b8 0x858 0x2 0x0
> > >
> > > Let me try to decode it:
> > >
> > > 0x1e8: Offset of IOMUXC_SW_MUX_CTL_PAD_ENET_MDC register
> > >
> > > 0x5b8: Offset of IOMUXC_SW_PAD_CTL_PAD_ENET_MDC register
> > >
> > > 0x2: This means that the MUX_MODE field selects the ESAI_TX5_RX0 function
> > > in this pad
> > >
> > > 0x0: SELECT_INPUT not used for this pad
> > 
> > This I guess predates the inctroduction of defines into the DTC,
> > but we can do a lot better now.
> > 
> > Can someone from the i.MX camp take a sweep and convert this
> > to defines in some include/dt-bindings/imx.h or similar file so
> > this thing becomes readable?
> 
> We call those macros like MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0 in
> imx6q-pinfunc.h pin function ID.  It's all about choosing a pinmux
> function (ESAI_TX5_RX0) for given pad (MX6QDL_PAD_ENET_MDC), and
> that's all what users care and need to read from the macro.  The
> decoding of the macro is the register details that users do not care in
> general.  But fsl,pinctrl bindings doc documented these details anyway.

No Shawn, they don't.

To me, encountering this for the first time, the documentation is
_wrong_ no two ways about it - as I said in my initial email.  Please
fix it, or delete it.  Don't leave it in its current crap state.  Bad
or misleading documentation is worse than no documentation.

I am a "user" of this crap, and it is _very_ confusing that the
documentation is wrong, and the fact that I sent my initial email in
this thread is proof that your statement above is wrong.

For instance, "two integers array" is a lie, plain and simple.  Yes, it
may be true that what users care about is a macro and a number but that
is not a "two integers array".  It would be helpful here to explain that
PIN_FUNC refers to a macro in the imx*-pinfunc.h header file, which
expands to four or five integers.

Bit 31 (or even bit 30) in the config number are not documented
either.

All the numbers come into play when you're trying to port a platform,
because when you encounter something like this:

+       IOMUX_PAD(0x05E0, 0x0210, 3, 0x0790, 1, PAD_CTL_PKE | PAD_CTL_PUE | \
+               PAD_CTL_PUS_100K_DOWN | PAD_CTL_SPEED_LOW |     \
+               PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS),

you need to be able to find out which of these C macros that corresponds
to for the pinfunc.h mess.

As it is, sorting out the pinmuxing on IMX is a nightmare - I've so far
spent almost 8 hours on this problem trying to work out what the right
way to describe this stuff is in DT, and its far from what I'd call fun.
And I've still more to do on this.

Please fix the documentation.
