From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 27 Nov 2013 09:56:20 -0500
Subject: [PATCH v2 2/2] clk: add accuracy support for fixed clock
In-Reply-To: <1385556285-19180-3-git-send-email-b.brezillon@overkiz.com>
References: <1385556285-19180-1-git-send-email-b.brezillon@overkiz.com>
 <1385556285-19180-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131127145620.GR2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris,

Thanks for posting this series.  Bear with me as I'm attempting to give
MikeT a hand.  Don't be afraid to tell me a question is stupid :-)

On Wed, Nov 27, 2013 at 01:44:45PM +0100, Boris BREZILLON wrote:
> This patch adds support for accuracy retrieval on fixed clocks.
> It also adds a new dt property called 'clock-accuracy' to define the clock
> accuracy.
> 
> This can be usefull for oscillator (RC, crystal, ...) definitions which are
> always given an accuracy characteristic.

I think we need to be more explicit in the binding and the API,
especially when providing a method to recalculate the accuracy.  I
presume this recalculated value would be relative against the root
clock?

There really needs to be two attributes here:  the rated accuracy from
the manufacturer, and the calculated accuracy wrt another clock in the
system.  We only need a binding for the manufacturer rating since the
calculated accuracy is determined at runtime.

I would also prefer to see an unknown accuracy be -1.  There are already
clocks on the market (PPS reference clocks) with accuracies of
0.1ppb/day [1].  Obviously, these aren't system clocks.  So the limit on
accuracy may be a non-issue.  However, it may be worth changing the
binding property to express the units.

> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  .../devicetree/bindings/clock/fixed-clock.txt      |    3 ++
>  drivers/clk/clk-fixed-rate.c                       |   43 +++++++++++++++++---
>  include/linux/clk-provider.h                       |    4 ++
>  3 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.txt b/Documentation/devicetree/bindings/clock/fixed-clock.txt
> index 0b1fe78..48ea0ad 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.txt
> @@ -10,6 +10,8 @@ Required properties:
>  - clock-frequency : frequency of clock in Hz. Should be a single cell.
>  
>  Optional properties:
> +- clock-accuracy : accuracy of clock in ppb (parts per billion).
> +		   Should be a single cell.

I would prefer to call this property 'clock-rated-ppb'.

>  - gpios : From common gpio binding; gpio connection to clock enable pin.
>  - clock-output-names : From common clock binding.
>  
> @@ -18,4 +20,5 @@ Example:
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <1000000000>;
> +		clock-accuracy = <100>;
>  	};

thx,

Jason.

[1] http://www.vectron.com/products/modules/md-010.htm
