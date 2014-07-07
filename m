From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Jul 2014 10:34:43 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <20140704205144.GK21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <E1X39Wr-0000ly-RF@rmk-PC.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk>
Message-ID: <20140707093443.GA3676@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jul 04, 2014 at 09:51:44PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 04, 2014 at 10:11:06PM +0200, Arnd Bergmann wrote:
> > On Friday 04 July 2014 20:52:17 Russell King wrote:
> > >         /*
> > >          * HWCAP_TLS is available only on 1136 r1p0 and later,
> > >          * see also kuser_get_tls_init.
> > >          */
> > > -       if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
> > > +       if (read_cpuid_part() == ARM_CPU_PART_ARM1136 &&
> > > +           ((id >> 20) & 3) == 0) {
> > >                 elf_hwcap &= ~HWCAP_TLS;
> > > +               return;
> > > +       }
> > > 
> > 
> > Would it make sense to tie this check to the ARMv6K architecture level?
> > 
> > I see that cpu_architecture currently reports the same value for plain
> > ARMv6 (1136r0) and for ARMv6K (1136r1+ or any other ARM11), but we already
> > distinguish them at compile time in a number of places and it seems you
> > make the exact same distinction here at runtime.
> 
> Hmm, we need guidance from ARM people on that.
> 
> There may well be a better way to detect between ARMv6 and ARMv6K, which
> is given by the architecture spec.  G7.3 of an early DDI0406 says that
> the MPIDR (mp affinity register) aliases to MIDR for ARMv6, but is of
> course implemented for ARMv6K.

I don't think MPIDR exists on any 1136 (i.e. probably UNDEFs).

> This seems to be carried through to the latest ARM ARM.  So it seems
> this would be a more correct way to tell ARMv6 from ARMv6K.
> 
> If so, we can certainly expand cpu_architecture() to detect between the
> two and add a CPU_ARCH_ARMv6K in there.
> 
> Let's see what Will has to say about that when he's next around...
> though I think it'll require another trawl through lots of
> documentation.

Well, looking at the ARM11 CPUs, I think our get_cpu_architecture()
implementation will return CPU_ARCH_ARM_V7 for 1176 and 11MPCore whilst
1136 and 1156 will return CPU_ARCH_ARM_V6. So this really boils down to
whether we should go out of our way to treat 1136 r1pX as v6k instead of
v6, I'd be inclined not to bother...

Will
