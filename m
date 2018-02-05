From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 5 Feb 2018 16:33:34 +0100
Subject: [PATCH v6 40/41] ARM: da8xx-dt: switch to device tree clocks
In-Reply-To: <CAMRc=McJsneYdh8zDmYcUsFLiAyOmSeyOKhKfim4or7LwyEH1w@mail.gmail.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-41-git-send-email-david@lechnology.com>
 <335d92c8-1af2-da64-e366-95d7513ad69d@lechnology.com>
 <CAMRc=McJsneYdh8zDmYcUsFLiAyOmSeyOKhKfim4or7LwyEH1w@mail.gmail.com>
Message-ID: <CAMRc=MdtgYB6Fa3ZeARncTDWfEXrZ4EYFXC0Lf=RHv0-ZSZf5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-05 15:04 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2018-01-24 4:26 GMT+01:00 David Lechner <david@lechnology.com>:
>> On 01/20/2018 11:14 AM, David Lechner wrote:
>>>
>>> This removes all of the clock init code from da8xx-dt.c. This includes
>>> all of the OF_DEV_AUXDATA that was just used for looking up clocks.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>
>>> v6 changes:
>>> - removed misleading statement from commit message
>>>
>>>   arch/arm/mach-davinci/da8xx-dt.c | 61
>>> +---------------------------------------
>>>   1 file changed, 1 insertion(+), 60 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c
>>> b/arch/arm/mach-davinci/da8xx-dt.c
>>
>>
>>>   static void __init da850_init_machine(void)
>>>   {
>>> -       /* All existing boards use 100MHz SATA refclkpn */
>>> -       static const unsigned long sata_refclkpn = 100 * 1000 * 1000;
>>> -
>>> -       int ret;
>>> -
>>> -       ret = da8xx_register_usb20_phy_clk(false);
>>> -       if (ret)
>>> -               pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
>>> -                       __func__, ret);
>>> -       ret = da8xx_register_usb11_phy_clk(false);
>>> -       if (ret)
>>> -               pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
>>> -                       __func__, ret);
>>> -
>>> -       ret = da850_register_sata_refclk(sata_refclkpn);
>>> -       if (ret)
>>> -               pr_warn("%s: registering SATA REFCLK failed: %d",
>>> -                       __func__, ret);
>>> -
>>> -       of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
>>> +       of_platform_default_populate(NULL, NULL, NULL);
>>
>>
>> of_platform_default_populate() can actually be removed completely.
>> of_platform_default_populate_init() is called implicitly during
>> arch_initcall_sync
>>
>>>         davinci_pm_init();
>>>         pdata_quirks_init();
>>>   }
>
> Hi David,
>
> this patch breaks nand on da850-lcdk (and probably on da850-evm) since
> the nand driver can no longer clk_get() the nand clock. We would need
> to keep the dev_auxdata at least for aemif.
>
> Thanks,
> Bartosz

Actually scratch that last e-mail, I missed the fact that the nand
node is only there in the board dts files. I've just sent you a patch
that enables nand on da850-lcdk. Please include it in your series.
I'll do the same for evm shortly.

Thanks,
Bartosz
