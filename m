From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Aug 2013 16:26:21 +0100
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <1376404995-24548-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376404995-24548-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130814152621.GA18868@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 13, 2013 at 03:43:14PM +0100, Ezequiel Garcia wrote:
> This commit fixes the DT binding for the Armada 370/XP SoC timer.
> The previous "marvell,armada-370-xp-timer" compatible is removed and
> two new compatible strings are introduced: "marvell,armada-xp-timer"
> and "marvell,armada-370-timer".
> 
> The rationale behind this change is that the Armada 370 SoC and the
> Armada XP SoC timers are not really compatible:
> 
>   * Armada 370 has no 25 MHz fixed timer.
> 
>   * Armada XP cannot work properly without such 25 MHz fixed timer
>     as doing otherwise leads to using a clocksource whose frequency
>     varies when doing cpufreq frequency changes.
> 
> This commit also removes the "marvell,timer-25Mhz" property, given
> it's now meaningless.

Given we have a mechanism already for handling this, I'm not sure. The
new binding certainly looks nicer (and if there's no-one using it, then
migrating makes sense), but I still have concerns about it. From the
description of the problem, and a look at the driver, the timer hardware
actually has (at least) two clock inputs:

(a) Wired to a fixed 25MHz clock on the XP, but not described.
    Not wired to anything on the 370?

(b) Wired to the CPU clock on the XP?
    Wired to some external clock on the 370.

If that's the case, this should be described, even if we can't use that
information right now. (a) can be a 25MHz fixed-clock on the XP, and
just not described on the 370. We can use clock-names to handle the
optional presence of any input clock.

Having separate compatible strings may still make sense, but I'd prefer
to understand the hardware better first. Not having full visibility over
a piece of hardware at review stage is precisely why we get into a mess
trying to change bindings later.

Thanks,
Mark.

> 
> Cc: devicetree at vger.kernel.org
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../bindings/timer/marvell,armada-370-xp-timer.txt | 27 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> index 3638112..4c453b2 100644
> --- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> @@ -2,14 +2,31 @@ Marvell Armada 370 and Armada XP Timers
>  ---------------------------------------
>  
>  Required properties:
> -- compatible: Should be "marvell,armada-370-xp-timer"
> +- compatible: Should be either "marvell,armada-370-timer" or
> +  "marvell,armada-xp-timer" as appropriate.
>  - interrupts: Should contain the list of Global Timer interrupts and
>    then local timer interrupts
>  - reg: Should contain location and length for timers register. First
>    pair for the Global Timer registers, second pair for the
>    local/private timers.
> -- clocks: clock driving the timer hardware
> +- clocks: clock driving the timer hardware, only required for
> +  "marvell,armada-370-timer";
>  
> -Optional properties:
> -- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
> -  Mhz fixed mode (available on Armada XP and not on Armada 370)
> +Examples:
> +
> +- Armada 370:
> +
> +	timer {
> +		compatible = "marvell,armada-370-timer";
> +		reg = <0x20300 0x30>, <0x21040 0x30>;
> +		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
> +		clocks = <&coreclk 2>;
> +	};
> +
> +- Armada XP:
> +
> +	timer {
> +		compatible = "marvell,armada-xp-timer";
> +		reg = <0x20300 0x30>, <0x21040 0x30>;
> +		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
> +	};
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
