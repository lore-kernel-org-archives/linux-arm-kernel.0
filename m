From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Apr 2011 18:39:38 +0800
Subject: [PATCH v1 1/3]ARM: mmp: add pxa910 mmc resource
In-Reply-To: <BANLkTi=Awfu-yYWrtMPFVnSAdBkKL2y0Kg@mail.gmail.com>
References: <BANLkTinSnWHmAP29AbWmbN=4go-6P4YayA@mail.gmail.com>
	<BANLkTi=Awfu-yYWrtMPFVnSAdBkKL2y0Kg@mail.gmail.com>
Message-ID: <BANLkTikNnothK_CAYLTuaMootKvBahanEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And CC'ed linux-arm-kernel ML.

On Wed, Apr 20, 2011 at 6:39 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Apr 20, 2011 at 6:34 PM, Jun Nie <niej0001@gmail.com> wrote:
>> ARM: mmp: add pxa910 mmc resource
>>
>> Add resource, devices, etc
>>
>> Signed-off-by: Jun Nie <njun@marvell.com>
>> ---
>> ?arch/arm/mach-mmp/include/mach/pxa910.h | ? 19 +++++++++++++++++++
>> ?arch/arm/mach-mmp/pxa910.c ? ? ? ? ? ? ?| ? 13 +++++++++++++
>> ?2 files changed, 32 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h
>> b/arch/arm/mach-mmp/include/mach/pxa910.h
>> index 91be755..ac0aaa3 100644
>> --- a/arch/arm/mach-mmp/include/mach/pxa910.h
>> +++ b/arch/arm/mach-mmp/include/mach/pxa910.h
>> @@ -10,6 +10,7 @@ extern void __init pxa910_init_irq(void);
>> ?#include <linux/i2c/pxa-i2c.h>
>> ?#include <mach/devices.h>
>> ?#include <plat/pxa3xx_nand.h>
>> +#include <plat/sdhci.h>
>>
>> ?extern struct pxa_device_desc pxa910_device_uart1;
>> ?extern struct pxa_device_desc pxa910_device_uart2;
>> @@ -20,6 +21,9 @@ extern struct pxa_device_desc pxa910_device_pwm2;
>> ?extern struct pxa_device_desc pxa910_device_pwm3;
>> ?extern struct pxa_device_desc pxa910_device_pwm4;
>> ?extern struct pxa_device_desc pxa910_device_nand;
>> +extern struct pxa_device_desc pxa910_device_sdh0;
>> +extern struct pxa_device_desc pxa910_device_sdh1;
>> +extern struct pxa_device_desc pxa910_device_sdh2;
>>
>> ?static inline int pxa910_add_uart(int id)
>> ?{
>> @@ -76,4 +80,19 @@ static inline int pxa910_add_nand(struct
>> pxa3xx_nand_platform_data *info)
>> ?{
>> ? ? ? ?return pxa_register_device(&pxa910_device_nand, info, sizeof(*info));
>> ?}
>> +
>> +static inline int pxa910_add_sdhost(int id, struct sdhci_pxa_platdata *data)
>> +{
>> + ? ? ? struct pxa_device_desc *d = NULL;
>> +
>> + ? ? ? switch (id) {
>> + ? ? ? case 0: d = &pxa910_device_sdh0; break;
>> + ? ? ? case 1: d = &pxa910_device_sdh1; break;
>> + ? ? ? case 2: d = &pxa910_device_sdh2; break;
>> + ? ? ? default:
>> + ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? ? }
>> +
>> + ? ? ? return pxa_register_device(d, data, sizeof(*data));
>> +}
>> ?#endif /* __ASM_MACH_PXA910_H */
>> diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
>> index 8f92ccd..b257c3b 100644
>> --- a/arch/arm/mach-mmp/pxa910.c
>> +++ b/arch/arm/mach-mmp/pxa910.c
>> @@ -29,6 +29,10 @@
>> ?#include "clock.h"
>>
>> ?#define MFPR_VIRT_BASE (APB_VIRT_BASE + 0x1e000)
>> +#ifdef APMU_SDH2
>> +#undef APMU_SDH2
>> +#endif
>> +#define APMU_SDH2 ? ? ? APMU_REG(0x0e0)
>
> This is a bit weird. Does PXA910 define the SDH2 registers elsewhere, if
> so, maybe we can define a new APMU_SDH2_PXA910 for this. Otherwise
> looks very good.
>
>>
>> ?static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
>> ?{
>> @@ -112,6 +116,9 @@ static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
>>
>> ?static APMU_CLK(nand, NAND, 0x01db, 208000000);
>> ?static APMU_CLK(u2o, USB, 0x1b, 480000000);
>> +static APMU_CLK(sdh0, SDH0, 0x001b, 48000000);
>> +static APMU_CLK(sdh1, SDH1, 0x001b, 48000000);
>> +static APMU_CLK(sdh2, SDH2, 0x001b, 48000000);
>>
>> ?/* device and clock bindings */
>> ?static struct clk_lookup pxa910_clkregs[] = {
>> @@ -125,6 +132,9 @@ static struct clk_lookup pxa910_clkregs[] = {
>> ? ? ? ?INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
>> ? ? ? ?INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
>> ? ? ? ?INIT_CLKREG(&clk_u2o, "pxa-u2o", "U2OCLK"),
>> + ? ? ? INIT_CLKREG(&clk_sdh0, "sdhci-pxa.0", "PXA-SDHCLK"),
>> + ? ? ? INIT_CLKREG(&clk_sdh1, "sdhci-pxa.1", "PXA-SDHCLK"),
>> + ? ? ? INIT_CLKREG(&clk_sdh2, "sdhci-pxa.2", "PXA-SDHCLK"),
>> ?};
>>
>> ?static int __init pxa910_init(void)
>> @@ -180,3 +190,6 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE,
>> 0xd401a400, 0x10);
>> ?PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
>> ?PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
>> ?PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
>> +PXA910_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
>> +PXA910_DEVICE(sdh1, "sdhci-pxa", 1, MMC, 0xd4280800, 0x120);
>> +PXA910_DEVICE(sdh2, "sdhci-pxa", 2, MMC, 0xd4281000, 0x120);
>> --
>> 1.7.0.4
>>
>
