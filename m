From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 18:14:07 +0000
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify
 already reset timer counter
In-Reply-To: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <20151215181407.GB8568@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 10:54:04AM +0530, Jassi Brar wrote:
> The GT counter is common to every core in a cluster. There is a usecase
> when Linux is spawned by a 'master' firmware/OS running on some core of
> the same cluster and the GT is used by the both.
>  Linux, upon boot, resetting the GT counter is obviously fatal to the
> other OS. So provide a way for DT to tell Linux if it's running in that
> 'slave' mode and must not reset the counter.

Is the other OS only using the counter?

Or are there other porions of the global timer that it assumes its in
sole control of?

> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/global_timer.txt |  6 ++++++
>  drivers/clocksource/arm_global_timer.c                 | 12 +++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> index bdae3a8..bb897a9 100644
> --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> @@ -17,6 +17,12 @@
>  
>  - clocks : Should be phandle to a clock.
>  
> +
> +** Optional properties:
> +
> +- arm,gt_no_reset : Firmware/bootloader already initialized the
> +	global timer-counter and expects it to be not reset again.

s/_/-/ in property names.

No need for the "gt" prefix, this is on tthe glboal timer node.

It "no-counter-reset" seems like a better description, though that
really depends on how the other OS is using this.

Mark.
