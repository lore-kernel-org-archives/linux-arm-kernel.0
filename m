From: kapilh@broadcom.com (Kapil Hali)
Date: Tue, 10 Nov 2015 21:51:32 +0530
Subject: [PATCH RESEND v2 3/4] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <CAGVrzca34xrVznoEE2e26JyR11Q9L1sT4mJcNZ=NuprqUnZnjw@mail.gmail.com>
References: <1446839371-22601-1-git-send-email-kapilh@broadcom.com>
 <1446839371-22601-4-git-send-email-kapilh@broadcom.com>
 <CACRpkdZN-iwdR_VwktdHsw+rGQLhCgmWnERYVDE+KaYOqJR30w@mail.gmail.com>
 <CAGVrzca34xrVznoEE2e26JyR11Q9L1sT4mJcNZ=NuprqUnZnjw@mail.gmail.com>
Message-ID: <5642198C.2040205@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian, Linus,

On 11/10/2015 7:59 AM, Florian Fainelli wrote:
> 2015-11-09 2:09 GMT-08:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Fri, Nov 6, 2015 at 8:49 PM, Kapil Hali <kapilh@broadcom.com> wrote:
>>
>>> Add SMP support for Broadcom's Northstar Plus SoC
>>> cpu enable method. This changes also consolidates
>>> iProc family's - BCM NSP and BCM Kona, platform
>>> SMP handling in a common file.
>>>
>>> Northstar Plus SoC is based on ARM Cortex-A9
>>> revision r3p0 which requires configuration for ARM
>>> Errata 764369 for SMP. This change adds the needed
>>> configuration option.
>>>
>>> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
>>
>> This version looks saner to me.
>>
>>> +static int nsp_write_lut(void)
>>> +{
>>> +       void __iomem *sku_rom_lut;
>>> +       phys_addr_t secondary_startup_phy;
>>> +
>>> +       if (!secondary_boot) {
>>> +               pr_warn("required secondary boot register not specified\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       sku_rom_lut = ioremap_nocache((phys_addr_t)secondary_boot,
>>> +                                               sizeof(secondary_boot));
>>
>> Why is this address not just taken directly from the device tree?
> 
> It comes directly from DT, that's what bcm_smp_prepare_cpus() does
> read from Device Tree.
> 
>>
>> If it is not in the device tree: why?
>>
>> Also give it a sane name, bcm_sec_boot_address or so.
>> "secondary_boot" sounds like a function you call to boot
>> the second core.
> 
> Agree with that, there could be a better name which better reflects
> this is a variable.
> 
As this change is consolidating SMP implementation, I kept the same 
name of the variable which was used in kona_smp.c so that the changes
in the common code is minimal. Also, the fact that the change is part
of up-streamed code, I didn't alter with the variable name. Shall I 
change it in the next patch?

Thanks,
Kapil
