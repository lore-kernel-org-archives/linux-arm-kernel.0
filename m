From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 18 Apr 2011 16:42:28 +0800
Subject: [PATCH 7/7] gpio-vbus: ask for vbus_draw regulator before
	registering xceiv
In-Reply-To: <1301666188-11822-7-git-send-email-dbaryshkov@gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
	<1301666188-11822-7-git-send-email-dbaryshkov@gmail.com>
Message-ID: <BANLkTimhus3KjV=RXbpLmn6hy2xY9ZZM+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 9:56 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Ask for vbus_draw regulator before registering tranceiver to disallow possible
> race between registration and set_power/etc.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

Greg, can you help take this patch. This looks like a good fix.

> ---
> ?drivers/usb/otg/gpio_vbus.c | ? 14 +++++++-------
> ?1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/otg/gpio_vbus.c b/drivers/usb/otg/gpio_vbus.c
> index 221c444..52733d9 100644
> --- a/drivers/usb/otg/gpio_vbus.c
> +++ b/drivers/usb/otg/gpio_vbus.c
> @@ -279,6 +279,13 @@ static int __init gpio_vbus_probe(struct platform_device *pdev)
> ? ? ? ?}
> ? ? ? ?INIT_WORK(&gpio_vbus->work, gpio_vbus_work);
>
> + ? ? ? gpio_vbus->vbus_draw = regulator_get(&pdev->dev, "vbus_draw");
> + ? ? ? if (IS_ERR(gpio_vbus->vbus_draw)) {
> + ? ? ? ? ? ? ? dev_dbg(&pdev->dev, "can't get vbus_draw regulator, err: %ld\n",
> + ? ? ? ? ? ? ? ? ? ? ? PTR_ERR(gpio_vbus->vbus_draw));
> + ? ? ? ? ? ? ? gpio_vbus->vbus_draw = NULL;
> + ? ? ? }
> +
> ? ? ? ?/* only active when a gadget is registered */
> ? ? ? ?err = otg_set_transceiver(&gpio_vbus->otg);
> ? ? ? ?if (err) {
> @@ -287,13 +294,6 @@ static int __init gpio_vbus_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto err_otg;
> ? ? ? ?}
>
> - ? ? ? gpio_vbus->vbus_draw = regulator_get(&pdev->dev, "vbus_draw");
> - ? ? ? if (IS_ERR(gpio_vbus->vbus_draw)) {
> - ? ? ? ? ? ? ? dev_dbg(&pdev->dev, "can't get vbus_draw regulator, err: %ld\n",
> - ? ? ? ? ? ? ? ? ? ? ? PTR_ERR(gpio_vbus->vbus_draw));
> - ? ? ? ? ? ? ? gpio_vbus->vbus_draw = NULL;
> - ? ? ? }
> -
> ? ? ? ?return 0;
> ?err_otg:
> ? ? ? ?free_irq(irq, &pdev->dev);
> --
> 1.7.4.1
>
>
