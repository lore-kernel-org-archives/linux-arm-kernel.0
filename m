From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 24 Aug 2011 10:45:02 +0800
Subject: [PATCH 4/6] ARM: mx31: use generic function for displaying
	silicon revision
In-Reply-To: <20110823131347.GQ31404@pengutronix.de>
References: <1314104864-3725-1-git-send-email-jason.hui@linaro.org>
	<1314104864-3725-5-git-send-email-jason.hui@linaro.org>
	<20110823131347.GQ31404@pengutronix.de>
Message-ID: <CAB4PhKcx44z0jPwjUgH=0EbuqbNhmpwxL91cxMhsbFSXgp17PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sascha,

2011/8/23 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Aug 23, 2011 at 09:07:42PM +0800, Jason Liu wrote:
>> Update to use generic function for displaying silicon revision
>>
>> Signed-off-by: Jason Liu <jason.hui@linaro.org>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> ?arch/arm/mach-imx/clock-imx31.c ? ? ? | ? ?5 +++--
>> ?arch/arm/mach-imx/cpu-imx31.c ? ? ? ? | ? 21 +++++++++++++--------
>> ?arch/arm/plat-mxc/include/mach/mx3x.h | ? 11 ++---------
>> ?3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
>> index d973770..dd8373e 100644
>> --- a/arch/arm/mach-imx/clock-imx31.c
>> +++ b/arch/arm/mach-imx/clock-imx31.c
>> @@ -610,11 +610,12 @@ int __init mx31_clocks_init(unsigned long fref)
>>
>> ? ? ? clk_enable(&gpt_clk);
>> ? ? ? clk_enable(&emi_clk);
>> - ? ? clk_enable(&iim_clk);
>>
>> ? ? ? clk_enable(&serial_pll_clk);
>>
>> - ? ? mx31_read_cpu_rev();
>> + ? ? clk_enable(&iim_clk);
>> + ? ? imx_print_silicon_rev("i.MX31", mx31_revision());
>> + ? ? clk_disable(&iim_clk);
>>
>> ? ? ? if (mx31_revision() >= IMX_CHIP_REVISION_2_0) {
>> ? ? ? ? ? ? ? reg = __raw_readl(MXC_CCM_PMCR1);
>> diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
>> index a378070..a5b8686 100644
>> --- a/arch/arm/mach-imx/cpu-imx31.c
>> +++ b/arch/arm/mach-imx/cpu-imx31.c
>> @@ -14,15 +14,14 @@
>> ?#include <mach/hardware.h>
>> ?#include <mach/iim.h>
>>
>> -unsigned int mx31_cpu_rev;
>> -EXPORT_SYMBOL(mx31_cpu_rev);
>> +static int mx31_cpu_rev = -1;
>>
>> ?static struct {
>> ? ? ? u8 srev;
>> ? ? ? const char *name;
>> ? ? ? const char *v;
>> ? ? ? unsigned int rev;
>> -} mx31_cpu_type[] __initdata = {
>> +} mx31_cpu_type[] = {
>> ? ? ? { .srev = 0x00, .name = "i.MX31(L)", .v = "1.0", ?.rev = IMX_CHIP_REVISION_1_0 ?},
>> ? ? ? { .srev = 0x10, .name = "i.MX31", ? ?.v = "1.1", ?.rev = IMX_CHIP_REVISION_1_1 ?},
>> ? ? ? { .srev = 0x11, .name = "i.MX31L", ? .v = "1.1", ?.rev = IMX_CHIP_REVISION_1_1 ?},
>> @@ -34,7 +33,7 @@ static struct {
>> ? ? ? { .srev = 0x29, .name = "i.MX31L", ? .v = "2.0", ?.rev = IMX_CHIP_REVISION_2_0 ?},
>> ?};
>>
>> -void __init mx31_read_cpu_rev(void)
>> +static int mx31_read_cpu_rev(void)
>> ?{
>> ? ? ? u32 i, srev;
>>
>> @@ -47,11 +46,17 @@ void __init mx31_read_cpu_rev(void)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "CPU identified as %s, silicon rev %s\n",
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mx31_cpu_type[i].name, mx31_cpu_type[i].v);
>
> It seems now we print the silicon revision twice, right?

Yes, correct. I will fix it.

>
> The .v field should be unused now and can be removed.

Accepted.

>
> Also, you can call imx_print_silicon_rev from here and pass the cpu name
> from the array.

Yes, Thanks for the review.

Jason

>
> Sascha
>
>>
>> - ? ? ? ? ? ? ? ? ? ? mx31_cpu_rev = mx31_cpu_type[i].rev;
>> - ? ? ? ? ? ? ? ? ? ? return;
>> + ? ? ? ? ? ? ? ? ? ? return mx31_cpu_type[i].rev;
>> ? ? ? ? ? ? ? }
>>
>> - ? ? mx31_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
>> + ? ? return IMX_CHIP_REVISION_UNKNOWN;
>> +}
>> +
>> +int mx31_revision(void)
>> +{
>> + ? ? if (mx31_cpu_rev == -1)
>> + ? ? ? ? ? ? mx31_cpu_rev = mx31_read_cpu_rev();
>>
>> - ? ? printk(KERN_WARNING "Unknown CPU identifier. srev = %02x\n", srev);
>> + ? ? return mx31_cpu_rev;
>> ?}
>> +EXPORT_SYMBOL(mx31_revision);
>> diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
>> index 388a407..e1850f4 100644
>> --- a/arch/arm/plat-mxc/include/mach/mx3x.h
>> +++ b/arch/arm/plat-mxc/include/mach/mx3x.h
>> @@ -187,15 +187,6 @@
>> ?/* Mandatory defines used globally */
>>
>> ?#if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
>> -
>> -extern unsigned int mx31_cpu_rev;
>> -extern void mx31_read_cpu_rev(void);
>> -
>> -static inline int mx31_revision(void)
>> -{
>> - ? ? return mx31_cpu_rev;
>> -}
>> -
>> ?extern unsigned int mx35_cpu_rev;
>> ?extern void mx35_read_cpu_rev(void);
>>
>> @@ -203,6 +194,8 @@ static inline int mx35_revision(void)
>> ?{
>> ? ? ? return mx35_cpu_rev;
>> ?}
>> +
>> +extern int mx31_revision(void);
>> ?#endif
>>
>> ?#endif /* ifndef __MACH_MX3x_H__ */
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
