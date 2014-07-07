From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 10:41:28 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU
 advertises it has exclusives
In-Reply-To: <20140707093443.GA3676@arm.com>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <E1X39Wr-0000ly-RF@rmk-PC.arm.linux.org.uk> <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <20140707093443.GA3676@arm.com>
Message-ID: <20140707094128.GY21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 10:34:43AM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Fri, Jul 04, 2014 at 09:51:44PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Jul 04, 2014 at 10:11:06PM +0200, Arnd Bergmann wrote:
> > > On Friday 04 July 2014 20:52:17 Russell King wrote:
> > > >         /*
> > > >          * HWCAP_TLS is available only on 1136 r1p0 and later,
> > > >          * see also kuser_get_tls_init.
> > > >          */
> > > > -       if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
> > > > +       if (read_cpuid_part() == ARM_CPU_PART_ARM1136 &&
> > > > +           ((id >> 20) & 3) == 0) {
> > > >                 elf_hwcap &= ~HWCAP_TLS;
> > > > +               return;
> > > > +       }
> > > > 
> > > 
> > > Would it make sense to tie this check to the ARMv6K architecture level?
> > > 
> > > I see that cpu_architecture currently reports the same value for plain
> > > ARMv6 (1136r0) and for ARMv6K (1136r1+ or any other ARM11), but we already
> > > distinguish them at compile time in a number of places and it seems you
> > > make the exact same distinction here at runtime.
> > 
> > Hmm, we need guidance from ARM people on that.
> > 
> > There may well be a better way to detect between ARMv6 and ARMv6K, which
> > is given by the architecture spec.  G7.3 of an early DDI0406 says that
> > the MPIDR (mp affinity register) aliases to MIDR for ARMv6, but is of
> > course implemented for ARMv6K.
> 
> I don't think MPIDR exists on any 1136 (i.e. probably UNDEFs).

There has long been a requirement (back to ARMv4 I believe) that
instructions such as:

	mrc	p15, 0, rd, c0, c0, X

all return the MIDR unless they are implemented.  This is certainly
carried forward to the latest ARM ARMs.  This is done to explicitly
allow the presence of additional registers to be detected.

I would be very surprised if the 1136 did undef on this.

If I dig out my 1136 FPGA (which according to the docs would be r0p2)
I can explicitly verify this... provided Integrator CP still works.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
