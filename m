From: khilman@ti.com (Kevin Hilman)
Date: Fri, 06 Apr 2012 14:18:47 -0700
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to	check
 presence of 32k timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Fri, 6 Apr 2012 05:21:52 +0000")
References: <CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
 <CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
 <CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
 <CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
 <CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
 <CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
 <87sjgmt211.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
 <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
 <20120405095221.GC25053@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
 <87hawxkgoi.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
Message-ID: <874nswftjc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

[...]

> I liked Santosh's idea in using command line argument "clocksource=" and 
> make decision based on this. I have implemented it and tried it on both
> OMAP3EVM and beaglebone and it works great.
>
> I have introduced something like this in mach-omap2/timer.c,
>
> static int __init omap2_override_clocksource(char* str)
> {
> 	if (!str)
> 		return 0;
> 	/*
> 	 * For OMAP architecture, we only have two options
> 	 *    - sync_32k (default)
> 	 *    - gp timer
> 	 */
> 	if (!strcmp(str, "gp timer"))
> 		use_gptimer_clksrc = true;
>
> 	return 0;
> }
> early_param("clocksource", omap2_override_clocksource);

How does this interact with the existing clocksource cmdline parameter
already in kernel/time/clocksource.c? (c.f. boot_override_clocksource()) 

IMO, this duplicates that functionality but less elegantly.

What should happen is to let clocksource selection happen normally
(based on presence or lack of HW, or cmdline override.)  Once that has
happened, you can then setup_sched_clock() with parameters from querying
the clocksource itself.

Kevin
