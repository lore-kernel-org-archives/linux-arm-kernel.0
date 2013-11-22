From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Nov 2013 07:58:45 -0800
Subject: [PATCH 6/8] devicetree: doc: Document ti,timer-parent property
In-Reply-To: <1385085414-9034-7-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
 <1385085414-9034-7-git-send-email-joelf@ti.com>
Message-ID: <20131122155838.GF10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [131121 18:00]:
> +Required properties for system timers (clockevents/clocksource):
> +- ti,timer-parent:	System timer's parent mux clock needs to be setup.
> +			This is currently hardcoded in code, for DT boot we
> +			move this to DT.
> +

This can be replaced with just clk_set_rate, or clk_set_parent if needed.
Or by having a clocks = <&32k_clk> property in the dmtimer node in the
.dts file.

>  Optional properties:
>  - ti,timer-alwon:	Indicates the timer is in an alway-on power domain.

Hmm this we may not need, this can probably be deciphered from the compatible
flag already?

Then for the users of a specific dmtimer, they can select the right one using
the interrupt-parent property:

timer1: timer at 0x4800abcd {
	compatible = "ti,omap5430-timer";
	#interrupt-cells = <1>;		/* needs irqchip implemented for dmtimer */
	interrupt-controller;
	#clock-cells = <1>;		/* needs clocksource implemented for dmtimer */
	clock-output-names = "32k", "sys_ck";
	...
};

counter32k: counter at 4ae04000 {
	compatible = "ti,omap-counter32k";
	#clock-cells = <1>;		/* needs clocksource implemented for 32k counter */
	clock-output-names = "32k";
	...
};

timer {
	compatible = "ti,omap5-timer";
	interrupt-parent = <&timer1>;
	interrupts = <1>;
	clocks = <&timer1 0>,		/* use timer1 as clockevent, clock index 0 = 32k, 1 = sys_ck ... */
		 <&counter32k 0>;	/* use 32k counter as clocksource */
};

>  - ti,timer-dsp:		Indicates the timer can interrupt the on-chip DSP in

This can be probably also be mapped based on the compatible property?

Regards,

Tony
