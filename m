From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 3 Dec 2015 20:08:24 +0200
Subject: [PATCH 2/2] ARM: OMAP2+: Change core_initcall levels to
 postcore_initcall
In-Reply-To: <20151203164113.GS23396@atomide.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
 <1448900789-4034-3-git-send-email-tony@atomide.com>
 <20151203160014.GL23396@atomide.com> <56606F20.9050805@ti.com>
 <20151203164113.GS23396@atomide.com>
Message-ID: <56608518.7060406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2015 06:41 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [151203 08:35]:
>> On 12/03/2015 06:00 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [151130 08:29]:
>>>> We want to be able to probe a few selected device drivers before hwmod
>>>> code populates the clocks in omap_hwmod_setup_all(). This allows us to
>>>> convert most of the clock drivers into regular device drivers.
>>
>> if understand things right, ti clks now will be populated and initialized
>> from
>> __omap_sync32k_timer_init
>>   - omap_clk_init()
>>     - ..
>>     - of_clk_init()
>>     - ..
>>     - omap_clk_soc_init()
>>
>> and __omap_sync32k_timer_init(), in turn, will be called from:
>> arch/arm/kernel/time.c
>>   - time_init()
>> 	machine_desc->init_time();
>> (without your patch 1).
> 
> Yes that's the current approach, but we can do better. We only need the following
> clocks for system timers at that point:
> 
> - mux clocks to select between the 32k and hf oscillator source
> 
> - clkctrl driver to gate the ocp clock
> 
> All the other clocks can be initialized at core_initcall time with this change.
> 
>> So, I don't see real dependency here between clk initialization and hwmods :(
> 
> You don't because it's only implemented so far for the dm814x ADPLL clock :)
> 
> That I posted as "[PATCH 0/2] Clock driver for dm814x ADPLL". Note how it's
> just a regular device driver that also works as loadable module on boards that
> have all the necessary clocks enabled already by the bootloader.
> 

Ah. Thanks. I see it now.

-- 
regards,
-grygorii
