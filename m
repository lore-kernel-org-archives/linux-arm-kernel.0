From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 8 Oct 2010 11:27:47 +0300
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <20101007074853.GZ28242@pengutronix.de>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<2306a14fec6647b68a4aee1743a75d040ec141b1.1286412080.git.amit.kucheria@linaro.org>
	<20101007074853.GZ28242@pengutronix.de>
Message-ID: <AANLkTi=JZHWpECbpgwrjXeofDCqL==irE5fQASpmV+vV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 7, 2010 at 10:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Added Daniel to Cc as he might say something here aswell.
>
> On Thu, Oct 07, 2010 at 03:58:48AM +0300, Amit Kucheria wrote:
>> The OTG initialisation is the same for all MX51 boards currently known. Move
>> to a common file.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>> ?arch/arm/mach-mx5/Makefile ? ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/mach-mx5/board-cpuimx51.c ? ? | ? 25 +-------------------
>> ?arch/arm/mach-mx5/board-mx51_babbage.c | ? 25 +-------------------
>> ?arch/arm/mach-mx5/board-mx51_efikamx.c | ? 23 +-----------------
>> ?arch/arm/mach-mx5/usb.c ? ? ? ? ? ? ? ?| ? 40 ++++++++++++++++++++++++++++++++
>> ?5 files changed, 44 insertions(+), 71 deletions(-)
>> ?create mode 100644 arch/arm/mach-mx5/usb.c
>>
>> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
>> index d1aac9c..1daba15 100644
>> --- a/arch/arm/mach-mx5/Makefile
>> +++ b/arch/arm/mach-mx5/Makefile
>> @@ -3,7 +3,7 @@
>> ?#
>>
>
> [snip]
>
>> ?{
>> ? ? ? u32 v;
>> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
>> index b00502a..93734ae 100644
>> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
>> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
>> @@ -37,7 +37,7 @@
>> ?#include "devices-imx51.h"
>> ?#include "devices.h"
>>
>> -#define ? ? ?MX51_USB_PLL_DIV_24_MHZ 0x01
>> +extern int initialize_otg_port(struct platform_device *pdev);
>>
>> ?static struct pad_desc mx51efikamx_pads[] = {
>> ? ? ? /* UART1 */
>> @@ -65,27 +65,6 @@ static inline void mxc_init_imx_uart(void)
>> ?}
>> ?#endif /* SERIAL_IMX */
>>
>> -/* This function is board specific as the bit mask for the plldiv will also
>> - * be different for other Freescale SoCs, thus a common bitmask is not
>> - * possible and cannot get place in /plat-mxc/ehci.c.
>> - */
>> -static int initialize_otg_port(struct platform_device *pdev)
>> -{
>> - ? ? u32 v;
>> - ? ? void __iomem *usb_base;
>> - ? ? void __iomem *usbother_base;
>> - ? ? usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
>> - ? ? usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
>> -
>> - ? ? /* Set the PHY clock to 19.2MHz */
>> - ? ? v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
>> - ? ? v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
>> - ? ? v |= MX51_USB_PLL_DIV_24_MHZ;
>> - ? ? __raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
>> - ? ? iounmap(usb_base);
>> - ? ? return 0;
>> -}
>> -
>> ?static struct mxc_usbh_platform_data dr_utmi_config = {
>> ? ? ? .init ? = initialize_otg_port,
>> ? ? ? .portsc = MXC_EHCI_UTMI_16BIT,
>> diff --git a/arch/arm/mach-mx5/usb.c b/arch/arm/mach-mx5/usb.c
>> new file mode 100644
>> index 0000000..277f957
>> --- /dev/null
>> +++ b/arch/arm/mach-mx5/usb.c
>> @@ -0,0 +1,40 @@
>> +/*
>> + * Copyright (C) 2010 Linaro Limited
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +
>> +#include <mach/hardware.h>
>> +#include <mach/mxc_ehci.h>
>> +
>> +#define ? ? ?MX51_USB_PLL_DIV_24_MHZ 0x01
>> +
>> +/* This function is SoC specific as the bit mask for the plldiv will also
>> + * be different for other Freescale SoCs, thus a common bitmask is not
>> + * possible and cannot get place in /plat-mxc/ehci.c.
>> + */
>> +int initialize_otg_port(struct platform_device *pdev)
>> +{
>
> First of all please do not introduce global functions without the
> correct prefix, mx51_ in this case.
>
> I have recently looked at the way the USB phy settings are handled on
> i.MX and it's coming to its limits. Currently the phy settings are coded
> into generic flags, passed to the usb driver which then calls
> mxc_initialize_usb_hw() which dispatches the different SoCs and translates
> the generic flags back into SoC specific ones. ?While this was doable
> until now it fails badly on i.MX51 as we see here.
> The phy settings are totally static to a given board, so we could simply
> let the board call a mx51_init_usb_phy() which gets a pointer to a
> struct with all relevant register settings. And we could pass this
> function SoC specific register settings without having to encode them
> into generic flags and decode them again later.

OK, working on a patch for mx51 now. It it looks ok, I can convert the rest.

/Amit
