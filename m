From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 16:08:53 +0100
Subject: [PATCH 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <CAHrpEqTwwb0P1wE+AOYVPgPz8=tBbEKn92amWaoN63GPOJxRgw@mail.gmail.com>
References: <1431378955-991-1-git-send-email-Frank.Li@freescale.com>
 <20150519025758.GK1071@dragon>
 <CAHrpEqTwwb0P1wE+AOYVPgPz8=tBbEKn92amWaoN63GPOJxRgw@mail.gmail.com>
Message-ID: <20150519150852.GI2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:52:54AM -0500, Zhi Li wrote:
> On Mon, May 18, 2015 at 9:57 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> >> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> >> index de5047c..95467c7 100644
> >> --- a/arch/arm/mach-imx/headsmp.S
> >> +++ b/arch/arm/mach-imx/headsmp.S
> >> @@ -29,3 +29,8 @@ ENTRY(v7_secondary_startup)
> >>       set_diag_reg
> >>       b       secondary_startup
> >>  ENDPROC(v7_secondary_startup)
> >> +
> >> +ENTRY(ca7_secondary_startup)
> >> +     bl      v7_invalidate_l1
> >> +     b       secondary_startup
> >> +ENDPROC(ca7_secondary_startup)
> >
> > v7_secondary_startup doesn't work for you?
> 
> Yes,
> v7_secondary_startup check debug register and cause halt.

A better question is, why do we have the diagnostic register setting at
platform level... and should we move it into the core SMP code so that
we can guarantee that all CPUs are setup the same.  I guess there are
problems on big.LITTLE systems where we have to deal with different CPU
types.

A separate issue is the v7_invalidate_l1, and looking at this again, I
wonder whether the v7_flush_dcache_louis in __v7_setup is really the
right thing to be doing there.  At that point, the caches are disabled,
so we're not using them.  Any dirty cache lines at that point would be
inaccessible to the CPU, and so would be a bug.  I think that should
become v7_invalidate_l1, which would then elimiante all the platforms
which are doing this local hack.

In fact, on CPUs prior to ARMv6, we have always invalidated the caches,
rather than asking them to write back dirty cache lines.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
