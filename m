From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 8 Nov 2013 08:58:30 +0800
Subject: [PATCH v3 9/9] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <527C049B.4030608@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131107134033.59bd127a@xhacker> <527B67A1.3020803@gmail.com>
 <201311071720.47489.arnd@arndb.de> <527C049B.4030608@gmail.com>
Message-ID: <20131108085830.5368c92b@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Thu, 7 Nov 2013 13:22:35 -0800
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 11/07/2013 05:20 PM, Arnd Bergmann wrote:
> > On Thursday 07 November 2013, Sebastian Hesselbarth wrote:
> >> Actually, IIRC smp_twd does not compile without SMP set, so the above
> >> should at least be 'HAVE_ARM_TWD if SMP'. If you shrink MULTI_V7 down
> >> to non-SMP cores, you can disable it and it will fail to compile.
> >
> > If there are UP-systems for which TWD is the best clocksource, we should
> > probably fix the code to allow that configuration. IIRC there were already
> > patches recently in this area, maybe it's already solved.

The problems is twd is not mandatory in CA9 UP system, so it may not exist.
However, I got answers from soc people, the BG2CD does configured and enabled
TWD. so we are lucky and can add HAVE_TWD for BG2CD.

> 
> I just tried barebox bootloader to use TWD as timer on berlin2cd and it
> perfectly works, i.e. with time related commands I can see the timer
> register decreasing. So the timer is available on this UP SoC.

Yep. It is available.

> 
> As said before, compiling linux without CONFIG_SMP but with
> CONFIG_HAVE_ARM_TWD gives:
> 
> warning: (SOC_OMAP5 && ARCH_ROCKCHIP && ARCH_SHMOBILE_MULTI && 
> MACH_BERLIN_BG2 && MACH_BERLIN_BG2CD) selects HAVE_ARM_TWD which has 
> unmet direct dependencies (SMP)
> 
> and
> 
> arch/arm/kernel/smp_twd.c: In function 'twd_local_timer_of_register':
> arch/arm/kernel/smp_twd.c:391: error: 'setup_max_cpus' undeclared (first 
> use in this function)
> arch/arm/kernel/smp_twd.c:391: error: (Each undeclared identifier is 
> reported only once
> arch/arm/kernel/smp_twd.c:391: error: for each function it appears in.)
> make[1]: *** [arch/arm/kernel/smp_twd.o] Error 1
> 
> I haven't looked deeper into this, but I guess it will not be hard
> to make ARM_TWD independent of SMP.
> 
> Sebastian
> 
