From: ethan@ethantuttle.com (Ethan Tuttle)
Date: Wed, 27 Jun 2018 07:39:29 -0700
Subject: [PATCH] ARM: mvebu: declare asm symbols as character arrays in
 pmsu.c
In-Reply-To: <87wouk92dm.fsf@bootlin.com>
References: <20180620043109.1190-1-ethan@ethantuttle.com>
 <87wouk92dm.fsf@bootlin.com>
Message-ID: <CACzLR4s7v8sxkvVvv1H2KKJHazfgCBmhAeb2Upa5JRoxTqm5nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory.

On Tue, Jun 26, 2018 at 11:20 PM, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> Hi Ethan,
>
>  On mar., juin 19 2018, Ethan Tuttle <ethan@ethantuttle.com> wrote:
>
>> With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
>> detect buffer overflows.  If src or dest is declared as a char, attempts to
>> copy more than byte will result in a fortify_panic().
>>
>> Address this problem in mvebu_setup_boot_addr_wa() by declaring
>> mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
>> a couple addressof operators to avoid "arithmetic on pointer to an
>> incomplete type" compiler error.
>>
>> See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
>> not single characters") for a similar fix.
>>
>> Fixes "detected buffer overflow in memcpy" error during init on some mvebu
>> systems (armada-370-xp, armada-375):
>>
>> (fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
>> (mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
>> (mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
>> (do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
>> (kernel_init_freeable) from (kernel_init+0x8/0x114)
>> (kernel_init) from (ret_from_fork+0x14/0x2c)
>>
>> Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
>> Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
>
> Out of curiosity on which platform did you test it?

I found the problem on my Mirabox after a kernel upgrade, and verified the fix
on the Mirabox as well.

I just observed in the code that the panic should also happen on armada-375,
didn't do any testing there.

BTW, just realizing I did not test with CONFIG_FORTIFY_SOURCE off.  But
I imagine it will work.  Let me know if you think that requires testing.

> Applied on mvebu/arm

Excellent!  Thank you.

Ethan

>
> Thanks,
>
> Gregory
>
>
>
>> ---
>>  arch/arm/mach-mvebu/pmsu.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>> index 27a78c80e5b1..73d5d72dfc3e 100644
>> --- a/arch/arm/mach-mvebu/pmsu.c
>> +++ b/arch/arm/mach-mvebu/pmsu.c
>> @@ -116,8 +116,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>>               PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
>>  }
>>
>> -extern unsigned char mvebu_boot_wa_start;
>> -extern unsigned char mvebu_boot_wa_end;
>> +extern unsigned char mvebu_boot_wa_start[];
>> +extern unsigned char mvebu_boot_wa_end[];
>>
>>  /*
>>   * This function sets up the boot address workaround needed for SMP
>> @@ -130,7 +130,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
>>                            phys_addr_t resume_addr_reg)
>>  {
>>       void __iomem *sram_virt_base;
>> -     u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
>> +     u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
>>
>>       mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
>>       mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Gregory Clement, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com
