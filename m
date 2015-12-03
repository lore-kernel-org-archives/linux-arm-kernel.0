From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 11:23:10 -0800
Subject: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
In-Reply-To: <566087DD.2040006@ti.com>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
 <20151118141537.GC10644@leverpostej> <564C9ACF.6040107@ti.com>
 <20151203163311.GP23396@atomide.com>
 <20151203163708.GR23396@atomide.com> <566087DD.2040006@ti.com>
Message-ID: <20151203192310.GY23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151203 10:21]:
> On 12/03/2015 06:37 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [151203 08:34]:
> >>
> >> It seems we should apply this as a fix unless somebody has better ideas.
> > 
> > Actually I think the fix for now is "[4.4-rc][PATCH v2] ARM: dts: am4372: fix
> > clock source for arm twd and global timers" until PM starts working?
> > 
> 
> Yes. if no PM it should work, but PM patches are on the fly for Am43.

OK let's not merge this one then.

> But, again, main reason I've posted this patch is that I do not see the
> way how to enable/disable or limit functionality of these timer by using 
> Kconfig options in case of Muliplatform builds :( (or by boot parameters).
> 
> Example 1 (this is how 4.4 kernel is working):
> 1) OMAP4 has ARM TWD timer and properly supports it, so in Kconfig we have
> "select HAVE_ARM_TWD" and corresponding "local-timer" is defined in DT.
> AM437x has ARM TWD timer, but does not support it yet, so corresponding "local-timer"
> defined in DT and in Kconfig HAVE_ARM_TWD is not selected.
> (patch http://www.spinics.net/lists/arm-kernel/msg459649.html
>  is not merged yet)
> 
> Result: ARM TWD timer will be enabled on AM437x !? :(
> 
> Example 2:
> ARM Global timer can't be used as clocksource device if CPUFreq is enabled
> (this is not supported even by Timekeeping core now).
> 
> So, there are two options:
> 1) update selection for config SOC_AM43XX
> + select ARM_GLOBAL_TIMER if !CPU_FREQ
> 2) updated ARM GT driver and don't register clocksource device if CPUFreq is enabled
> 
> Both options will not work:
> 1) ARM_GLOBAL_TIMER will be selected if any other SoC in multiplatform build
> will select ARM_GLOBAL_TIMER
> 2) clocksource device will never be registered if at least one SoC will
> select CPU_FREQ. And this might break SoC which expect it to be registered,
> because CPU_FREQ is not enabled on these SoCs (no CPUFreq drivers registered).
> 
> So, as alternative to this patch, ARM timers nodes can be disabled in
> platform DTS files, but then all platform DTS files will need to be updated.

Yes I don't see any other option right now until we have the clocksource
switching happening. Only then will the scoring work properly.

Regards,

Tony
