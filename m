From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Thu, 29 Mar 2018 11:12:45 +0000
Subject: [PATCH v3 4/8] reset: Renesas RZ/N1 reboot driver
In-Reply-To: <1522309629-10152-5-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-5-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <OSBPR01MB205430EB7EE4F338829135EDD2A20@OSBPR01MB2054.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29 March 2018 08:47, I messed up:
[snip]
>
> The Renesas RZ/N1 Family (Part #R9A06G0xx) needs a small driver to reboot
> the Cortex-A7 cores. This driver is a sub driver of the sysctrl MFD.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  drivers/power/reset/Kconfig       |   7 +++
>  drivers/power/reset/Makefile      |   1 +
>  drivers/power/reset/rzn1-reboot.c | 105
[snip]
> +
> +parent = pdev->dev.parent;
> +if (!parent || !parent->of_node)

Not sure what went on when I had all the patches loaded in the editor before sending, but I've deleted a brace here. Will be fixed in v4... :/

Michel


> +dev_err(&pdev->dev, "couldn't find sysctrl node\n");
> +return -ENODEV;
> +}
> +sysctrl = syscon_node_to_regmap(parent->of_node);
> +if (IS_ERR(sysctrl)) {
> +dev_err(&pdev->dev, "couldn't find find regmap\n");
> +return PTR_ERR(sysctrl);
> +}
> +err = register_restart_handler(&rzn1_reboot_nb);
> +if (err) {
> +dev_err(&pdev->dev, "register restart handler
> failed(err=%d)\n",
> +err);
> +}
> +
> +return err;
> +}
> +
> +static const struct of_device_id rzn1_reboot_of_match[] = {
> +{ .compatible = "renesas,rzn1-reboot" },
> +{}
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_reboot_of_match);
> +
> +static struct platform_driver rzn1_reboot_driver = {
> +.probe = rzn1_reboot_probe,
> +.driver = {
> +.name = "rzn1-reboot",
> +.of_match_table = rzn1_reboot_of_match,
> +},
> +};
> +module_platform_driver(rzn1_reboot_driver);
> +
> +MODULE_DESCRIPTION("RZ/N1 reboot driver");
> MODULE_AUTHOR("Michel Pollet
> +<michel.pollet@bp.renesas.com>, <buserror@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
