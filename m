From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 10:30:07 +0200
Subject: [PATCH v3 4/6] ARM: kirkwood: move device tree nodes to DT
 irqchip and clocksource
In-Reply-To: <1370536034-23956-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1370536034-23956-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130607103007.415575c8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu,  6 Jun 2013 18:27:12 +0200, Sebastian Hesselbarth wrote:

> -		wdt at 20300 {
> +		wdt: watchdog-timer at 20300 {
>  			compatible = "marvell,orion-wdt";
>  			reg = <0x20300 0x28>;
> +			interrupt-parent = <&bridge_intc>;
> +			interrupts = <3>;
>  			clocks = <&gate_clk 7>;
>  			status = "okay";
>  		};

The watchdog driver is mapping the same registers as the timer driver
(0x20300) and is poking into the same TIMER_CTRL register that controls
both the timers and the watchdog.

In addition to this, the watchdog driver also pokes into some other
registers, such as BRIDGE_CAUSE and RSTOUTn_MASK.

As we want to bring watchdog support for Armada 370/XP, I'm wondering
if we should fix those problems, and if yes, how:

 (1) The timer driver is also responsible for handling the watchdog
     (probably the easiest solution)

 (2) Have some sort of 'common code' between the timer driver and the
     watchdog driver to control the access to the shared TIMER_CTRL
     register.

 (3) Something else.

And this still does not solve the access to BRIDGE_CAUSE and
RSTOUTn_MASK.

Ideas?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
