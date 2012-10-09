From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Oct 2012 22:08:02 +0100
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
 <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
 <20120918100438.GC32204@mudshark.cambridge.arm.com>
 <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
Message-ID: <20121009210802.GA31615@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 06:05:53PM +0100, Valentin Pistol wrote:
> Will,

Hi Valentin,

> On Tue, Sep 18, 2012 at 3:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Fri, Sep 14, 2012 at 09:08:24AM +0100, Valentin Pistol wrote:
> > > Is there a reliable way to determine that they are locked down?
> > > Any particular register/bit I can check to confirm?
> >
> > You can take a look at the DBGAUTHSTATUS register and try to determine the
> > signal values for SPNIDEN, DBGEN and NIDEN.
> 
> DBGAUTHSTATUS=0xaa confirming DBGEN is LOW. Since then I found out
> that there are two types of OMAP devices:
> GP (General Purpose) and HS (High Security) and supposedly Debug
> Capabilities are only available on GP devices.
> Thus, I ordered a Pandaboard ES with OMAP4460 and tested it with a
> prebuilt Ubuntu 12.04 image.
> After boot monitor mode is still not set, the DSCR reads the same
> 0x01030002 just as with the previous Galaxy Nexus.

Can you try this with my hw-breakpoint branch please? I've reworked a fair
amount of code there, so it might at least be more verbose if it fails.

> I contacted TI and they seem to say hw breakpoints/watchpoints are
> available on Pandaboard but they are confused about monitor mode,
> saying it's not available on Pandaboard GP.
> See http://e2e.ti.com/support/omap/f/849/p/216276/770995.aspx for the
> discussion.

In that discussion, the TI folks are confusing `Monitor-mode Debug' with
`Secure Monitor Mode'. They are two completely different things and (for the
purposes of this discussion), unrelated. You should press them further on
this!

> Have you used a Pandaboard and can comment on how to enable the
> breakpoints/watchpoints?

I haven't tried it, but I do have a Panda now so I could give it a go when I
get a chance. I suspect there's something related to power-management at
play... for JTAG, you need to hack MLO as described here:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka15314.html

maybe something similar is required for self-hosted (monitor mode) debug?

> Could you also mention a specific development board that you are using
> and recommend for access to these features?

I use the ARM Versatile Express platform, but I think it's probably quite
expensive to get hold of if you don't work for ARM.

Will
