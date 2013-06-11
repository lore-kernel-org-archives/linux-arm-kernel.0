From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Jun 2013 11:07:25 +0100
Subject: [PATCH 4/8] ARM: vexpress: use generic cpu idle function for wfi
In-Reply-To: <51B6B691.1040305@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-5-git-send-email-sanjay.rawat@linaro.org>
 <1370617870.4852.23.camel@hornet> <51B6B691.1040305@linaro.org>
Message-ID: <1370945245.3116.10.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-06-11 at 06:33 +0100, Sanjay Singh Rawat wrote:
> >> use cpu_do_idle for entering the wfi mode.
> >>
> >> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> >> ---
> >>   arch/arm/mach-vexpress/hotplug.c |    3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
> >> index f0ce6b8..b3dffc2 100644
> >> --- a/arch/arm/mach-vexpress/hotplug.c
> >> +++ b/arch/arm/mach-vexpress/hotplug.c
> >> @@ -60,7 +60,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> >>   	 * code will have already disabled interrupts
> >>   	 */
> >>   	for (;;) {
> >> -		wfi();
> >> +		/* enter WFI mode */
> >> +		cpu_do_idle();
> >>
> >>   		if (pen_release == cpu_logical_map(cpu)) {
> >>   			/*
> >
> > I probably don't get the whole picture, but may I ask what is the
> > rationale behind this change? As in: why cpu_do_idle() is better?
>
> commit: 8553cb67d2318db327071018fc81084cbabccc46 explains that

Oh, I've noticed the dsb there, I'm just asking why is it necessary in
the cpu_die() case? The core is going down anyway, it left the coherency
domain and we could cut the power now (if only it was possible). All
cache maintenance (which undoubtedly included dsb) has been long done.

Now, don't get me wrong - I'm not saying it's wrong to do the dsb. I
simply would like to know if and why is required (I'm admitting my
ignorance here ;-) But if you simply grep-ed for "wfi()" in the whole
kernel and automatically replaced them with "cpu_do_idle()", it doesn't
make sense.

Regards

Pawel
