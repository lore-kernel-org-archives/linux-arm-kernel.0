From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 15:20:14 -0400
Subject: [PATCH v3 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <1376335016-16400-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376335016-16400-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376335016-16400-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130812192014.GT25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 04:16:55PM -0300, Ezequiel Garcia wrote:
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
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../bindings/timer/marvell,armada-370-xp-timer.txt | 27 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)

As there are no native DT-booting Marvell products in the wild yet,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

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
