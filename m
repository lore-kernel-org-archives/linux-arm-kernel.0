From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Apr 2015 11:57:09 -0500
Subject: [PATCH v7 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <4492781.xynGhSMMir@wuerfel>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <1430259045-19012-5-git-send-email-lho@apm.com>
 <4492781.xynGhSMMir@wuerfel>
Message-ID: <CAL_Jsq+5f_dFJBnQ=vBj7dS8ebqGQe9_5c00CgmA7gT1yp=mZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 3:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 28 April 2015 16:10:44 Loc Ho wrote:
>> +
>> +       rc = platform_driver_register(&xgene_edac_mc_driver);
>> +       if (rc) {
>> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "MCU fails to register\n");
>> +               goto reg_mc_failed;
>> +       }
>> +       rc = platform_driver_register(&xgene_edac_pmd_driver);
>> +       if (rc) {
>> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "PMD fails to register\n");
>> +               goto reg_pmd_failed;
>> +       }
>> +       rc = platform_driver_register(&xgene_edac_l3_driver);
>> +       if (rc) {
>> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "L3 fails to register\n");
>> +               goto reg_l3_failed;
>> +       }
>> +       rc = platform_driver_register(&xgene_edac_soc_driver);
>> +       if (rc) {
>> +               edac_printk(KERN_ERR, EDAC_MOD_STR, "SoC fails to register\n");
>> +               goto reg_soc_failed;
>> +       }
>>
>
> I had not looked at the driver before, but I have one comment now:
>
> I think this can be simplified to registering a single platform_driver
> that just matches all four compatible strings, with an appropriate data:
>
> +static struct of_device_id xgene_edac_of_match[] = {
> +       { .compatible = "apm,xgene-edac-mcu", .data = &xgene_edac_mcu_data },
> +       { .compatible = "apm,xgene-edac-pmd", .data = &xgene_edac_pmd_data },
> +       { .compatible = "apm,xgene-edac-l3",  .data = &xgene_edac_l3_data },
> +       { .compatible = "apm,xgene-edac-soc", .data = &xgene_edac_soc_data },
> +       {},
> +};

What exactly is shared here to combine all this into one driver? I
would argue these are all independent functions and should be separate
drivers. Add some library functions if there are common parts. The
bindings are still a bit broken IMO.

Rob
