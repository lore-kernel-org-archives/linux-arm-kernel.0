From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 2 Feb 2016 11:44:42 +0100
Subject: [PATCH v4 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <1454396212.2847.15.camel@mtksdaap41>
References: <1453270097-53853-1-git-send-email-jamesjj.liao@mediatek.com>
 <1453270097-53853-2-git-send-email-jamesjj.liao@mediatek.com>
 <56ADF556.6070402@gmail.com> <1454396212.2847.15.camel@mtksdaap41>
Message-ID: <56B0889A.1010305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/02/16 07:56, James Liao wrote:
> Hi Matthias,
>
> On Sun, 2016-01-31 at 12:51 +0100, Matthias Brugger wrote:
>> >
>> >On 20/01/16 07:08, James Liao wrote:
>>> > >Refine scpsys driver common code to support multiple SoC / platform.
>>> > >
>>> > >Signed-off-by: James Liao<jamesjj.liao@mediatek.com>
>>> > >---
>>> > >   drivers/soc/mediatek/mtk-scpsys.c | 418 ++++++++++++++++++++------------------
>>> > >   drivers/soc/mediatek/mtk-scpsys.h |  55 +++++
>>> > >   2 files changed, 270 insertions(+), 203 deletions(-)
>>> > >   create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
>> >
>> >In general this approach looks fine to me, comments below.
>> >
>>> > >
>>> > >diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>>> > >index 0221387..339adfc 100644
>>> > >--- a/drivers/soc/mediatek/mtk-scpsys.c
>>> > >+++ b/drivers/soc/mediatek/mtk-scpsys.c
>>> > >@@ -11,29 +11,17 @@
>>> > >    * GNU General Public License for more details.
>>> > >    */
>>> > >   #include <linux/clk.h>
>>> > >-#include <linux/delay.h>
>>> > >+#include <linux/init.h>
>>> > >   #include <linux/io.h>
>>> > >-#include <linux/kernel.h>
>>> > >   #include <linux/mfd/syscon.h>
>> >
>> >When at it, do we need this include?
> syscon_regmap_lookup_by_phandle() is declared in this head file.
>
>>> > >-#include <linux/init.h>
>>> > >   #include <linux/of_device.h>
>>> > >   #include <linux/platform_device.h>
>>> > >   #include <linux/pm_domain.h>
>>> > >-#include <linux/regmap.h>
>>> > >-#include <linux/soc/mediatek/infracfg.h>
>>> > >   #include <linux/regulator/consumer.h>
>>> > >-#include <dt-bindings/power/mt8173-power.h>
>>> > >+#include <linux/soc/mediatek/infracfg.h>
>>> > >+
>>> > >+#include "mtk-scpsys.h"
>>> > >
>>> > >-#define SPM_VDE_PWR_CON			0x0210
>>> > >-#define SPM_MFG_PWR_CON			0x0214
>>> > >-#define SPM_VEN_PWR_CON			0x0230
>>> > >-#define SPM_ISP_PWR_CON			0x0238
>>> > >-#define SPM_DIS_PWR_CON			0x023c
>>> > >-#define SPM_VEN2_PWR_CON		0x0298
>>> > >-#define SPM_AUDIO_PWR_CON		0x029c
>>> > >-#define SPM_MFG_2D_PWR_CON		0x02c0
>>> > >-#define SPM_MFG_ASYNC_PWR_CON		0x02c4
>>> > >-#define SPM_USB_PWR_CON			0x02cc
>> >
>> >I would prefer to keep this defines and declare SoC specific ones where
>> >necessary. It makes the code more readable.
> Some register address may be reused by other modules among SoCs, so it's
> not easy to maintain the defines when we implement multiple SoC drivers
> in the same file. For example, offset 0x0298 is VEN2_PWR_CON on MT8173,
> but it is MJC_PWR_CON on other chips.
>

So that sounds as if 0x0298 offset is MT8173 specific.
I checked [VDE, MFG, VEN, IFR, ISP, DIS, DPY]_PWR_CON on mt8173, mt8135 
and mt6589 and they all have the same offset. So it doesn't seem as if 
the offset randomly changes for every SoC.

> Furthermore, these register offsets are only used in scp_domain_data[],
> and each element has its own power domain name. So I think it's enough
> to know which power domain are using these registers and status bits.
>

Yes that's true, but it will make it easier for another person to 
understand the driver, especially if he want's to implement the driver 
for a new SoC.

Regards,
Matthias
