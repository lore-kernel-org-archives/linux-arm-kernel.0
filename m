From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 10:55:55 +0100
Subject: [PATCH 1/3] clocksource/drivers/timer-atmel-pit: Enable mck clock
In-Reply-To: <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
References: <57C05026.7010905@linaro.org>
 <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160830095555.GB1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 26, 2016 at 04:20:43PM +0200, Daniel Lezcano wrote:
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> mck is needed to get the PIT working. Explicitly prepare_enable it instead
> of assuming it is enabled.
> 
> This solves an issue where the system is freezing when the ETM/ETB drivers
> are enabled.
> 
> Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/timer-atmel-pit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
> index 1ffac0c..3494bc5 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -261,6 +261,12 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
>  		return PTR_ERR(data->mck);
>  	}
>  
> +	ret = clk_prepare_enable(data->mck);
> +	if (ret) {
> +		pr_err("Unable to enable mck\n");
> +		return ret;
> +	}
> +

Apologies if the below is a duplicate report.

When building v4.8-rc4 multi_v7_defconfig, I get:

[mark at leverpostej:~/src/linux]% uselinaro 15.08 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j10 -s
drivers/clocksource/timer-atmel-pit.c: In function 'at91sam926x_pit_dt_init':
drivers/clocksource/timer-atmel-pit.c:264:2: error: 'ret' undeclared (first use in this function)
  ret = clk_prepare_enable(data->mck);
  ^
drivers/clocksource/timer-atmel-pit.c:264:2: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [drivers/clocksource/timer-atmel-pit.o] Error 1
make[1]: *** [drivers/clocksource] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

As far as I can see, there's no local 'ret' variable. Locally I've fixed this
up with:

----8----
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 3494bc5..7f0f5b2 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -240,6 +240,7 @@ static int __init at91sam926x_pit_common_init(struct pit_data *data)
 static int __init at91sam926x_pit_dt_init(struct device_node *node)
 {
        struct pit_data *data;
+       int ret;
 
        data = kzalloc(sizeof(*data), GFP_KERNEL);
        if (!data)
---->8----

Thanks,
Mark.
