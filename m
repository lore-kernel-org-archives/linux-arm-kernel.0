From: joelf@ti.com (Joel Fernandes)
Date: Fri, 22 Nov 2013 10:36:23 -0600
Subject: [PATCH 6/8] devicetree: doc: Document ti,timer-parent property
In-Reply-To: <20131122155838.GF10023@atomide.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
 <1385085414-9034-7-git-send-email-joelf@ti.com>
 <20131122155838.GF10023@atomide.com>
Message-ID: <528F8807.7050803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Thanks for your comments, few replies inline below..

On 11/22/2013 09:58 AM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [131121 18:00]:
>> +Required properties for system timers (clockevents/clocksource):
>> +- ti,timer-parent:	System timer's parent mux clock needs to be setup.
>> +			This is currently hardcoded in code, for DT boot we
>> +			move this to DT.
>> +
> 
> This can be replaced with just clk_set_rate, or clk_set_parent if needed.
> Or by having a clocks = <&32k_clk> property in the dmtimer node in the
> .dts file.
> 

Sure, but clock-data is still not available to make this possible in mainline.
We also discussed earlier right that we don't want dependencies as much as
possible to get one chunk in and working at a time. I was thinking like for a
first-pass since there's a lot of unrelated code that doesn't have dependencies,
but needs this to work, we can introduce this property for now and drop it later
as a "cost of migration"?

>>  Optional properties:
>>  - ti,timer-alwon:	Indicates the timer is in an alway-on power domain.
> 
> Hmm this we may not need, this can probably be deciphered from the compatible
> flag already?

How? Compatible contains the same string, for example for OMAP4:

timer8 has:
                        compatible = "ti,omap4430-timer";
                        ti,timer-pwm;
                        ti,timer-dsp;

and timer9 has:
                        compatible = "ti,omap4430-timer";
                        ti,hwmods = "timer9";
                        ti,timer-pwm;


> 
> Then for the users of a specific dmtimer, they can select the right one using
> the interrupt-parent property:
> 
> timer1: timer at 0x4800abcd {
> 	compatible = "ti,omap5430-timer";
> 	#interrupt-cells = <1>;		/* needs irqchip implemented for dmtimer */
> 	interrupt-controller;
> 	#clock-cells = <1>;		/* needs clocksource implemented for dmtimer */
> 	clock-output-names = "32k", "sys_ck";
> 	...
> };

In reference to my last thread reply, irqchip may not be available early in the
boot process (.init_time) for system timer usage?

thanks,

-Joel
