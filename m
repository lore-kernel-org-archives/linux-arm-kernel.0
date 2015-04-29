From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 10:49:07 +0200
Subject: [PATCH v7 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1430259045-19012-5-git-send-email-lho@apm.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <1430259045-19012-5-git-send-email-lho@apm.com>
Message-ID: <4492781.xynGhSMMir@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 April 2015 16:10:44 Loc Ho wrote:
> +
> +       rc = platform_driver_register(&xgene_edac_mc_driver);
> +       if (rc) {
> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "MCU fails to register\n");
> +               goto reg_mc_failed;
> +       }
> +       rc = platform_driver_register(&xgene_edac_pmd_driver);
> +       if (rc) {
> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "PMD fails to register\n");
> +               goto reg_pmd_failed;
> +       }
> +       rc = platform_driver_register(&xgene_edac_l3_driver);
> +       if (rc) {
> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "L3 fails to register\n");
> +               goto reg_l3_failed;
> +       }
> +       rc = platform_driver_register(&xgene_edac_soc_driver);
> +       if (rc) {
> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "SoC fails to register\n");
> +               goto reg_soc_failed;
> +       }
> 

I had not looked at the driver before, but I have one comment now:

I think this can be simplified to registering a single platform_driver
that just matches all four compatible strings, with an appropriate data:

+static struct of_device_id xgene_edac_of_match[] = {
+       { .compatible = "apm,xgene-edac-mcu", .data = &xgene_edac_mcu_data },
+       { .compatible = "apm,xgene-edac-pmd", .data = &xgene_edac_pmd_data },
+       { .compatible = "apm,xgene-edac-l3",  .data = &xgene_edac_l3_data },
+       { .compatible = "apm,xgene-edac-soc", .data = &xgene_edac_soc_data },
+       {},
+};
+MODULE_DEVICE_TABLE(of, xgene_edac_soc_of_match);
+
+static struct platform_driver xgene_edac_soc_driver = {
+       .probe = xgene_edac_soc_probe,
+       .remove = xgene_edac_soc_remove,
+       .driver = {
+               .name = "xgene-edac-soc",
+               .owner = THIS_MODULE,
+               .of_match_table = xgene_edac_of_match,
+       },
+};

You can probably share most of the four probe and release
functions as well, and put the differences into the data structure
that is attached to the of_device_id entry.

As a style-only comment, you can also remove the #ifdef CONFIG_OF and
of_match_ptr(), because the driver depends on OF anyway.

	Arnd
