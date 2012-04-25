From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 25 Apr 2012 13:29:22 +0530
Subject: [PATCH 15/19] ARM: OMAP4430: PM: workaround for DDR corruption on
 second CS
In-Reply-To: <1335338762.2149.103.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-16-git-send-email-t-kristo@ti.com> <4F96EF56.5020604@ti.com>
 <1335338762.2149.103.camel@sokoban>
Message-ID: <CAMQu2gzn06PWBQxBgRN-su191Zp4d9Ywzg=5NLgAW0on9B0PDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 12:56 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Tue, 2012-04-24 at 13:22 -0500, Jon Hunter wrote:
>> Hi Tero,
>>
>> On 04/20/2012 04:33 AM, Tero Kristo wrote:
>> > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >
>> > Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
>> > Transition When CS1 Is Used On EMIF" which impacts OMAP443x silicon
>> > The issue occurs when EMIF_SDRAM_CONFIG is restored first before
>> > EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuration
>> > is not set properly, we apply the required workaround allowing
>> > the restore sequence to work properly.
>> >
>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > [t-kristo at ti.com: moved workaround from omap-sar.c to pm44xx.c]
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> > ---
>> > ?.../include/mach/ctrl_module_wkup_44xx.h ? ? ? ? ? | ? ?2 +
>> > ?arch/arm/mach-omap2/pm44xx.c ? ? ? ? ? ? ? ? ? ? ? | ? 24 ++++++++++++++++++++
>> > ?2 files changed, 26 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>> > index a0af9ba..b763a79 100644
>> > --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>> > +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>> > @@ -28,6 +28,8 @@
>> > ?#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION ? ? ? ? 0x0000
>> > ?#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO ? ? ? ? ? 0x0004
>> > ?#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG ? ? ? ? ? ? ? ?0x0010
>> > +#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG ?0x0114
>> > +#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG ?0x011c
>> > ?#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0 ? ? ? ?0x0460
>> > ?#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1 ? ? ? ?0x0464
>> > ?#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2 ? ? ? ?0x0468
>> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
>> > index 0472921..d4d18d9 100644
>> > --- a/arch/arm/mach-omap2/pm44xx.c
>> > +++ b/arch/arm/mach-omap2/pm44xx.c
>> > @@ -17,6 +17,9 @@
>> > ?#include <linux/err.h>
>> > ?#include <linux/slab.h>
>> > ?#include <asm/system_misc.h>
>> > +#include <linux/io.h>
>> > +
>> > +#include <mach/ctrl_module_wkup_44xx.h>
>> >
>> > ?#include "common.h"
>> > ?#include "clockdomain.h"
>> > @@ -215,6 +218,27 @@ static int __init omap4_pm_init(void)
>> >
>> > ? ? pr_err("Power Management for TI OMAP4.\n");
>> >
>> > + ? /*
>> > + ? ?* Work around for OMAP443x Errata i632: "LPDDR2 Corruption After OFF
>> > + ? ?* Mode Transition When CS1 Is Used On EMIF":
>> > + ? ?* Overwrite EMIF1/EMIF2
>> > + ? ?* SECURE_EMIF1_SDRAM_CONFIG2_REG
>> > + ? ?* SECURE_EMIF2_SDRAM_CONFIG2_REG
>> > + ? ?*/
>> > + ? if (cpu_is_omap443x()) {
>> > + ? ? ? ? ? void __iomem *secure_ctrl_mod;
>> > +
>> > + ? ? ? ? ? secure_ctrl_mod = ioremap(OMAP4_CTRL_MODULE_WKUP, SZ_4K);
>> > + ? ? ? ? ? BUG_ON(!secure_ctrl_mod);
>> > +
>> > + ? ? ? ? ? __raw_writel(0x10, secure_ctrl_mod +
>> > + ? ? ? ? ? ? ? ? ? ? ? ?OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG);
>> > + ? ? ? ? ? __raw_writel(0x10, secure_ctrl_mod +
>> > + ? ? ? ? ? ? ? ? ? ? ? ?OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG);
>>
>> According to the erratum description the above registers are used to
>> restore the EMIFx_SDRAM_CONFIG2 registers. So although the value 0x10,
>> maybe the value being used for EMIFx_SDRAM_CONFIG2 registers, shouldn't
>> we read the EMIFx_SDRAM_CONFIG2 registers and store them in the above
>> registers?
>
> This might be a good idea, however, this patch might be tagged as TEMP
> until the EMIF driver is in place, this fix should rather be located
> there. I'll take a look at this if I can change the implementation a
> bit.
>
This patch doesn't have any dependency with EMIF driver since it's more of
SAR restore BUG. If the dependency is from the regsister macro etc point
of view, PM code can to the mapping and since it is needed only once
in the init. EMIF driver is unware of SAR restore phase and that was the
purpose of the DMA bases SAR restore design.

Hope this clarifies.

Regards
Santosh
