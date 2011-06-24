From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jun 2011 10:37:50 +0100
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering
	sleep mode
In-Reply-To: <007401cc3242$48947160$d9bd5420$%kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
	<20110622145715.GS23234@n2100.arm.linux.org.uk>
	<007401cc3242$48947160$d9bd5420$%kim@samsung.com>
Message-ID: <20110624093750.GD23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 04:42:26PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> 
> > Stop bodging stuff (like you have for the SCU stuff.) and start _talking_
> > to people if the code doesn't do what you need it to do.
> 
> Hi Russell and all,
> 
> I'd like to share requirement of EXYNOS4210 PM.
> 
> Now if there is wakeup source which is pending before entering suspend mode,
> PMU(Power Management Unit) handles WFI instruction as NOP on EXYNOS4210. But
> it seems that current cpu_suspend() cannot support this. So how can/should
> we handle this case?

See patch from June 13th posted to the hibernate thread.  This allows
the finisher function to return, though it should only return if it is
certain that the system will not enter suspend.

Is this true of the current exynos4 code?  It seems that the current
code will panic() if the WFI is executed as a NOP.

> And this is another case. For example, assume that ARM is power down mode
> and outer cache(L2 cache) data is retention state to use L2 cache data after
> wakeup. In this case, according to wakeup sequence, firstly L1 cache is
> enabled in cpu_resume() then L2 cache will be enabled which is implemented
> in Samsung SoC specific code. So how can be handled the coherency problem
> between L1 cache and L2 cache?

You could ensure that L2 is ready to be re-enabled before calling
cpu_resume.  As the C bit in the control register will be cleared,
L2 should not be used at that point, until after the MMU is re-
initialized.
