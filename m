From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 20 Jun 2011 10:50:42 -0600
Subject: [PATCH 3/6] watchdog: s3c2410: Add support for device tree based
	probe
In-Reply-To: <1308567752-13451-4-git-send-email-thomas.abraham@linaro.org>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <BANLkTikkxpOC6M1R0g=dGvDXvCkG6EOJhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 5:02 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> This patch adds the of_match_table to enable s3c2410-wdt driver
> to be probed when watchdog device node is found in the device tree.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

You need to send this to Wim and the linux-watchdog mailing lists.  As
far as I'm concerned, it can be merged immediately.

g.

> ---
> ?.../devicetree/bindings/watchdog/samsung-wdt.txt ? | ? 12 ++++++++++++
> ?drivers/watchdog/s3c2410_wdt.c ? ? ? ? ? ? ? ? ? ? | ? 10 ++++++++++
> ?2 files changed, 22 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> new file mode 100644
> index 0000000..f2617e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -0,0 +1,12 @@
> +* Samsung's Watchdog Timer Controller
> +
> +The Samsung's Watchdog controller is used for resuming system operation
> +after a preset amount of time during which the WDT reset event has not
> +occured.
> +
> +Required properties:
> +- compatible : should be "samsung,s3c2410-wdt"
> +- reg : base physical address of the controller and length of memory mapped
> + ? ? ? region.
> +- interrupts : interrupt number to the cpu.
> +
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index f7f5aa0..30da88f 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -589,6 +589,15 @@ static int s3c2410wdt_resume(struct platform_device *dev)
> ?#define s3c2410wdt_resume ?NULL
> ?#endif /* CONFIG_PM */
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id s3c2410_wdt_match[] = {
> + ? ? ? { .compatible = "samsung,s3c2410-wdt" },
> + ? ? ? {},
> +};
> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
> +#else
> +#define s3c2410_wdt_match NULL
> +#endif
>
> ?static struct platform_driver s3c2410wdt_driver = {
> ? ? ? ?.probe ? ? ? ? ?= s3c2410wdt_probe,
> @@ -599,6 +608,7 @@ static struct platform_driver s3c2410wdt_driver = {
> ? ? ? ?.driver ? ? ? ? = {
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> ? ? ? ? ? ? ? ?.name ? = "s3c2410-wdt",
> + ? ? ? ? ? ? ? .of_match_table = s3c2410_wdt_match,
> ? ? ? ?},
> ?};
>
> --
> 1.6.6.rc2
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
