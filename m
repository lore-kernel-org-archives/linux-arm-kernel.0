From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 21 Jul 2010 22:29:37 +0900
Subject: [PATCH v3 2/8] ARM: S5PV310: Add new CPU initialization support
In-Reply-To: <009701cb28d4$0ead3040$2c0790c0$%kim@samsung.com>
References: <1279627861-23047-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTikYjSIZzT-WHpAYbaHC1R9DU2T89qUVoAYASEZv@mail.gmail.com>
	<009701cb28d4$0ead3040$2c0790c0$%kim@samsung.com>
Message-ID: <AANLkTimQqAKUlCXgRFMWMvI_zVXlHJOFCx3c3lrU5kpP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 9:55 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> On Tue, Jul 20, 2010 at 9:11 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > From: Changhwan Youn <chaos.youn@samsung.com>
>> >
>> > This patch adds Samsung S5PV310/S5PC210 CPU support.
>> > The S5PV310/S5PC210 integrates a ARM Cortex A9 multi-core.
>> >
>> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
>> > Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
>> > Signed-off-by: Jiseong Oh <jiseong.oh@samsung.com>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> > ---
>> > Changes since v2:
>> > - Re-model platsmp.c on the Versatile Express as per Russell King's
> suggestion.
>> > ?And tested on the board.
>> >
>> > - Compared Versatile Express SMP code with Realview SMP code and
> modified
>> as needed.
>> >
>
> Hi,
>
> (snip)
>
>> > +static void arch_detect_cpu(void)
>> > +{
>> > + ? ? ? /* we do not need to do any cpu detection here at the moment. */
>> > +
>> > + ? ? ? fifo_mask = S5PV210_UFSTAT_TXMASK;
>> > + ? ? ? fifo_max = 63 << S5PV210_UFSTAT_TXSHIFT;
>>
>> It's only valid when use the UART1. others 255 for UART0, 15 for others.
>
> Ok..will fix it.
>
> (snip)
>
>> > +#define VMALLOC_END ? ? ?(0xE0000000)
>>
>> Increase to 0xF000'0000. but it will be removed from Eric's patch.
>>
> Right now, the 0xE0000000 is no problem as default.
> But I will check this is appropriate again.
Since maybe you use the 2g/2g configuration. try to use the 3g/1g
configuration with more the 512MiB.

>
> And according to his '[PATCH 08/13] [ARM] Make VMALLOC_END into a global
> variable if not defined',
> it doesn't mean absolutely remove it. why did you say like that.
>
> +#ifndef VMALLOC_END
> +extern unsigned long vmalloc_end;
> +#define VMALLOC_END (vmalloc_end)
> +#endif
> +
>
> And if required modify it for some machine, you can do it later with
> mach_desc after applying Eric's patch.
> Or as Russell said, there is the way to do it is to specify a vmalloc=
> parameter to the kernel.

I don't have confidence with HIGHMEM with VIPT (it's same as PIPT).
So I want to use lowmem if possible,

>
> (snip)
>
>> > + ? ? ? ? ? ? ? /*
>> > + ? ? ? ? ? ? ? ?* Write the address of secondary startup into the
>> > + ? ? ? ? ? ? ? ?* system-wide flags register. The boot monitor waits
>> > + ? ? ? ? ? ? ? ?* until it receives a soft interrupt, and then the
>> > + ? ? ? ? ? ? ? ?* secondary CPU branches to this address.
>> > + ? ? ? ? ? ? ? ?*/
>> > + ? ? ? __raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)),
>> S5P_INFORM0);
>>
>> Do you really use the INFORM0? historically it's used for sleep &
>> wakeup. new SoC has several INFORM register. So I recommend to use
>> others.
>>
>
> It doesn't mean we should use INFORM0 for sleep & wakeup even though
> historically used.
> ...I mean it doesn't matter and as you know, just need to sync with
> boot-loader for it.
that's reason I said, we got unused INFORM{3,4,5,...} so if we use it,
no problem.
>
> (snip)
>
>> > +void s3c_i2c0_cfg_gpio(struct platform_device *dev)
>> > +{
>> > +/* will be implemented later */
>> > +}
>>
>> Remove it and send separate patch. e.g.,I2C support on s5pc210.
>>
> I think i2c0 is un-conditionally compiled. So need to add i2c0 support in
> here.
It mean all samsung SoC have i2c0. okay if you want it.
>
> (snip)
>
>> > +#define S5P_VA_COREPERI_BASE ? S3C_ADDR(0x00800000)
>> > +#define S5P_VA_COREPERI(x) ? ? (S5P_VA_COREPERI_BASE + (x))
>> > +#define S5P_VA_SCU ? ? ? ? ? ? S5P_VA_COREPERI(0x0)
>> > +#define S5P_VA_GIC_CPU ? ? ? ? S5P_VA_COREPERI(0x100)
>> > +#define S5P_VA_TWD ? ? ? ? ? ? S5P_VA_COREPERI(0x600)
>> > +#define S5P_VA_GIC_DIST ? ? ? ? ? ? ? ?S5P_VA_COREPERI(0x1000)
>> > +
>> > +#define S5P_VA_L2CC ? ? ? ? ? ?S3C_ADDR(0x00900000)
>>
>> I'm not sure it's proper prefix.
>>
> It's no problem.
>
> (snip)
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
