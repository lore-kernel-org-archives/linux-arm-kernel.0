From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 1 Nov 2010 15:05:39 -0500
Subject: [patch v3 01/10] efikamx: read board id
In-Reply-To: <86A0E76937111F4C92FABEC0A20988510523CAD8@az33exm21>
References: <20101026200723.839428019@rtp-net.org>
	<20101026200953.996305184@rtp-net.org>
	<86A0E76937111F4C92FABEC0A20988510523CAD8@az33exm21>
Message-ID: <AANLkTins+aNBte6fqwDa_kSEzZNtBVJgKNWn6=bi7-Sy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I agree wholeheartedly with this.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Mon, Nov 1, 2010 at 10:24 AM, Nguyen Dinh-R00091
<R00091@freescale.com> wrote:
> Hi,
>
>>-----Original Message-----
>>From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-arm-kernel-
>>bounces at lists.infradead.org] On Behalf Of Arnaud Patard
>>Sent: Tuesday, October 26, 2010 3:07 PM
>>To: linux-arm-kernel at lists.infradead.org
>>Cc: matt at genesi-usa.com; Sascha Hauer; Arnaud Patard; Amit Kucheria
>>Subject: [patch v3 01/10] efikamx: read board id
>>
>>read board id value from the GPIO3_16/17/11
>>
>>Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>>Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
>>===================================================================
>>--- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c
> 2010-10-21 08:29:23.000000000 +0200
>>+++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
> 2010-10-21 08:29:46.000000000 +0200
>>@@ -39,12 +39,26 @@
>>
>> #define ? ? ? MX51_USB_PLL_DIV_24_MHZ 0x01
>>
>>+#define EFIKAMX_PCBID0 ? ? ? ? ? ? ? ?(2*32 + 16)
>>+#define EFIKAMX_PCBID1 ? ? ? ? ? ? ? ?(2*32 + 17)
>>+#define EFIKAMX_PCBID2 ? ? ? ? ? ? ? ?(2*32 + 11)
>>+
>>+/* the pci ids pin have pull up. they're driven low according to board
> id */
>>+#define MX51_PAD_PCBID0 ? ? ? IOMUX_PAD(0x518, 0x130, 3, 0x0, ? 0,
> PAD_CTL_PUS_100K_UP)
>>+#define MX51_PAD_PCBID1 ? ? ? IOMUX_PAD(0x51C, 0x134, 3, 0x0, ? 0,
> PAD_CTL_PUS_100K_UP)
>>+#define MX51_PAD_PCBID2 ? ? ? IOMUX_PAD(0x504, 0x128, 3, 0x0, ? 0,
> PAD_CTL_PUS_100K_UP)
>>+
>
> Seems a bit wasteful to redefine the IOMUX definitions. Couldn't you
> just do something like this?
>
> static struct pad_desc mx51efikamx_board_id[] = {
> ? ? ? ?MX51_PAD_NANDF_CS0__GPIO_3_16,
> ? ? ? ?MX51_PAD_NANDF_CS1__GPIO_3_17,
> ? ? ? ?MX51_PAD_NANDF_RB3__GPIO_3_11
> }
>
>
>> static struct pad_desc mx51efikamx_pads[] = {
>> ? ? ? /* UART1 */
>> ? ? ? MX51_PAD_UART1_RXD__UART1_RXD,
>> ? ? ? MX51_PAD_UART1_TXD__UART1_TXD,
>> ? ? ? MX51_PAD_UART1_RTS__UART1_RTS,
>> ? ? ? MX51_PAD_UART1_CTS__UART1_CTS,
>>+
>>+ ? ? ?/* board id */
>>+ ? ? ?MX51_PAD_PCBID0,
>>+ ? ? ?MX51_PAD_PCBID1,
>>+ ? ? ?MX51_PAD_PCBID2,
>> };
>>
>> /* Serial ports */
>>@@ -92,10 +106,62 @@
>> ? ? ? .flags ?= MXC_EHCI_INTERNAL_PHY,
>> };
>>
>>+/* ? PCBID2 ?PCBID1 PCBID0 ?STATE
>>+ ? ? ?1 ? ? ? 1 ? ? ?1 ? ?ER1:rev1.1
>>+ ? ? ?1 ? ? ? 1 ? ? ?0 ? ?ER2:rev1.2
>>+ ? ? ?1 ? ? ? 0 ? ? ?1 ? ?ER3:rev1.3
>>+ ? ? ?1 ? ? ? 0 ? ? ?0 ? ?ER4:rev1.4
>>+*/
>>+static void __init mx51_efikamx_board_id(void)
>>+{
>>+ ? ? ?int id;
>>+
>>+ ? ? ?/* things are taking time to settle */
>>+ ? ? ?msleep(150);
>>+
>>+ ? ? ?gpio_request(EFIKAMX_PCBID0, "pcbid0");
>>+ ? ? ?gpio_direction_input(EFIKAMX_PCBID0);
>>+ ? ? ?gpio_request(EFIKAMX_PCBID1, "pcbid1");
>>+ ? ? ?gpio_direction_input(EFIKAMX_PCBID1);
>>+ ? ? ?gpio_request(EFIKAMX_PCBID2, "pcbid2");
>>+ ? ? ?gpio_direction_input(EFIKAMX_PCBID2);
>>+
>>+ ? ? ?id = gpio_get_value(EFIKAMX_PCBID0);
>>+ ? ? ?id |= gpio_get_value(EFIKAMX_PCBID1) << 1;
>>+ ? ? ?id |= gpio_get_value(EFIKAMX_PCBID2) << 2;
>>+
>>+ ? ? ?switch (id) {
>>+ ? ? ?case 7:
>>+ ? ? ? ? ? ? ?system_rev = 0x11;
>>+ ? ? ? ? ? ? ?break;
>>+ ? ? ?case 6:
>>+ ? ? ? ? ? ? ?system_rev = 0x12;
>>+ ? ? ? ? ? ? ?break;
>>+ ? ? ?case 5:
>>+ ? ? ? ? ? ? ?system_rev = 0x13;
>>+ ? ? ? ? ? ? ?break;
>>+ ? ? ?case 4:
>>+ ? ? ? ? ? ? ?system_rev = 0x14;
>>+ ? ? ? ? ? ? ?break;
>>+ ? ? ?default:
>>+ ? ? ? ? ? ? ?system_rev = 0x10;
>>+ ? ? ? ? ? ? ?break;
>>+ ? ? ?}
>>+
>>+ ? ? ?if ((system_rev == 0x10)
>>+ ? ? ? ? ? ? ?|| (system_rev == 0x12)
>>+ ? ? ? ? ? ? ?|| (system_rev == 0x14)) {
>>+ ? ? ? ? ? ? ?printk(KERN_WARNING
>>+ ? ? ? ? ? ? ? ? ? ? ?"EfikaMX: Unsupported board revision 1.%u!\n",
>>+ ? ? ? ? ? ? ? ? ? ? ?system_rev & 0xf);
>>+ ? ? ?}
>>+}
>>+
>> static void __init mxc_board_init(void)
>> {
>> ? ? ? mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(mx51efikamx_pads));
>
> ? ? ? ?for(i=0;i < ARRAY_SIZE(mx51efikamx_board_id);i++)
> ? ? ? ? ? ? ? ?mx51efikamx_board_id [i].pad_ctrl = PAD_CTL_PUS_100K_UP;
> ? ? ? ?mxc_iomux_v3_setup_multiple_pads(mx51efikamx_board_id,
>
> ARRAY_SIZE(mx51efikamx_board_id));
>
>>+ ? ? ?mx51_efikamx_board_id();
>> ? ? ? mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
>> ? ? ? mxc_init_imx_uart();
>> }
>>
>>
>>
>>_______________________________________________
>>linux-arm-kernel mailing list
>>linux-arm-kernel at lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> Thanks,
> Dinh
>
>
>
