From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 24 Aug 2011 10:40:10 +0800
Subject: [PATCH 1/6] ARM: imx: Introduce generic function for displaying
	silicon revision
In-Reply-To: <20110823130956.GP31404@pengutronix.de>
References: <1314104864-3725-1-git-send-email-jason.hui@linaro.org>
	<1314104864-3725-2-git-send-email-jason.hui@linaro.org>
	<20110823130956.GP31404@pengutronix.de>
Message-ID: <CAB4PhKcFQK-FBvJkVFTwFU+zQcfXKsG4Qg3f77h2ewDYyY+U3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sascha,

2011/8/23 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Aug 23, 2011 at 09:07:39PM +0800, Jason Liu wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Currently each i.MX processor has its own function for displaying the silicon
>> revision.
>>
>> Introduce a generic function for this purpose, so that all i.MX processors can
>> reuse it.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> ?arch/arm/plat-mxc/cpu.c ? ? ? ? ? ? ? ? | ? 10 ++++++++++
>> ?arch/arm/plat-mxc/include/mach/common.h | ? ?1 +
>> ?2 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-mxc/cpu.c b/arch/arm/plat-mxc/cpu.c
>> index 386e0d5..f081ef0 100644
>> --- a/arch/arm/plat-mxc/cpu.c
>> +++ b/arch/arm/plat-mxc/cpu.c
>> @@ -1,5 +1,6 @@
>>
>> ?#include <linux/module.h>
>> +#include <mach/hardware.h>
>>
>> ?unsigned int __mxc_cpu_type;
>> ?EXPORT_SYMBOL(__mxc_cpu_type);
>> @@ -9,3 +10,12 @@ void mxc_set_cpu_type(unsigned int type)
>> ? ? ? __mxc_cpu_type = type;
>> ?}
>>
>> +void imx_print_silicon_rev(const char *cpu, int srev)
>> +{
>> + ? ? if (srev == IMX_CHIP_REVISION_UNKNOWN)
>> + ? ? ? ? ? ? pr_info("CPU identified as %s, unknown revision\n", cpu);
>> + ? ? else
>> + ? ? ? ? ? ? pr_info("CPU identified as %s, silicon rev %d.%d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? cpu, (srev >> 4) & 0xf, srev & 0xf);
>> +}
>> +EXPORT_SYMBOL(imx_print_silicon_rev);
>
> No Need to export this. It is not supposed to be used by modules.

OK, I will remove it. Thanks,

>
> Sascha
>
>> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
>> index 4e3d978..318e0da 100644
>> --- a/arch/arm/plat-mxc/include/mach/common.h
>> +++ b/arch/arm/plat-mxc/include/mach/common.h
>> @@ -72,4 +72,5 @@ extern void mxc_arch_reset_init(void __iomem *);
>> ?extern void mx51_efikamx_reset(void);
>> ?extern int mx53_revision(void);
>> ?extern int mx53_display_revision(void);
>> +extern void imx_print_silicon_rev(const char *cpu, int srev);
>> ?#endif
>> --
>> 1.7.4.1
>>
>>
>>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
