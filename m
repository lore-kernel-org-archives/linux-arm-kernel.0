From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 23 Jun 2010 10:47:31 +0900
Subject: Samsung SoCs: preparation for single kernel
In-Reply-To: <AANLkTil-AOEqhMOXydaiA1X_v0rjoNQxALrO0UY638AS@mail.gmail.com>
References: <AANLkTinGwWzIAOe2tj6V2kCrMiPT7PHlYs1kFS-IsiN4@mail.gmail.com>
	<AANLkTil-AOEqhMOXydaiA1X_v0rjoNQxALrO0UY638AS@mail.gmail.com>
Message-ID: <AANLkTil1i_ZGI8bY14HhjrAk9RooVreAJsTteqqrMgqJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 9:50 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Jun 23, 2010 at 7:27 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>> To Ben,
>>
>> I really need single kernel for s5pc110 (cortex A8) and s5pc210
>> (cortex A9) at least.
>> Fortunately arm move to these approaches recently. but current Samsung
>> SoCs not prepare these one.
>>
>> So I wonder do you have a plan or how to address these issues?
>> How to assign the address at resources and use it at runtime?
>>
>> Personally I want to use cpu_is_*. but you reject it to use.
>> Other way is that we can create the base address variables and assign
>> it at init time.
>>
>> Please give your opinions.
>>
>> Thank you,
>> Kyungmin Park
>>
>> e.g., cpu_is_* usage at OMAP tree
>>
>> static void omap_init_mcspi(void)
>> {
>> ? ? ? ?if (cpu_is_omap44xx())
>> ? ? ? ? ? ? ? ?omap4_mcspi_fixup();
>>
>> ? ? ? ?platform_device_register(&omap2_mcspi1);
>> ? ? ? ?platform_device_register(&omap2_mcspi2);
>>
>> ? ? ? ?if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
>> ? ? ? ? ? ? ? ?omap2_mcspi3_init();
>>
>> ? ? ? ?if (cpu_is_omap343x() || cpu_is_omap44xx())
>> ? ? ? ? ? ? ? ?omap2_mcspi4_init();
>> }
>
> Just my two cents: cpu_is_*() can be used, but only when absolutely necessary.
> The s3c does a CPU detection at startup, so I guess the usage of cpu_is_*()
> can be even reduced.

My concern is that most device resources use the S3C_* or S5P_* prefix
and defined at each arch differently.

E.G., mmc resource drivers use the S3C_PA_HSMMC0. but each mach has
different base address.
then how to handle this or make it possible?

#define S5PV210_PA_HSMMC(x)     (0xEB000000 + ((x) * 0x100000))
#define S3C_PA_HSMMC0           S5PV210_PA_HSMMC(0)
#define S3C_PA_HSMMC1           S5PV210_PA_HSMMC(1)
#define S3C_PA_HSMMC2           S5PV210_PA_HSMMC(2)

#define S5PC100_PA_HSMMC(x)     (0xED800000 + ((x) * 0x100000))
#define S3C_PA_HSMMC0           S5PC100_PA_HSMMC(0)
#define S3C_PA_HSMMC1           S5PC100_PA_HSMMC(1)
#define S3C_PA_HSMMC2           S5PC100_PA_HSMMC(2)

#define S3C64XX_PA_HSMMC(x)     (0x7C200000 + ((x) * 0x100000))
#define S3C64XX_PA_HSMMC0       S3C64XX_PA_HSMMC(0)
#define S3C64XX_PA_HSMMC1       S3C64XX_PA_HSMMC(1)
#define S3C64XX_PA_HSMMC2       S3C64XX_PA_HSMMC(2)
#define S3C_PA_HSMMC0           S3C64XX_PA_HSMMC0
#define S3C_PA_HSMMC1           S3C64XX_PA_HSMMC1
#define S3C_PA_HSMMC2           S3C64XX_PA_HSMMC2

>
> I'm not sure if the above case is a good reference or not. The omap_init_mcspi
> is called from omap2_init_devices(), while the registration can actually be
> made into the board init code when that device is used (some of the McSPIs are
> not used, and it's not necessary to register them), and the differences be
> handled in the driver.

that's just example how to use cpu_is_* in others. the current schme
in samsung SoCs. we passed the different platform name for each arch.
e.g., s3c2410_i2c or s3c2440_i2c then i2c driver detect it and handle
properly. of course it assume base address is set correctly as above.

Thank you,
Kyungmin Park
>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
