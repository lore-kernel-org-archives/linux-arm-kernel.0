From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jan 2010 15:54:54 +0000
Subject: [PATCH - 2nd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <201001131730.24535.epeer@tmtservices.co.za>
References: <201001131730.24535.epeer@tmtservices.co.za>
Message-ID: <20100113155454.GC28292@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 05:30:24PM +0200, Edwin Peer wrote:
> Dear Russell,
> 
> Here's another attempt at a patch for the MXM-8x10 development board --
> this time against 
> 2.6.33-rc4. 
> 
> The major difference between this and our previous attempt is that we
> don't do stupid stuff with the USB OHCI platform support any more.
> Aside from the Kconfig and Makefile, this patch doesn't touch any
> existing files now.There are also some minor defconfig changes.

It's always a good idea to include a diffstat - it allows you to spot
easily if you're including files you shouldn't - for example,
Kconfig.orig.

 arch/arm/configs/capc7117_defconfig      | 1525 +++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig                |    5 
 arch/arm/mach-pxa/Kconfig.orig           |  646 +++++++++++++
 arch/arm/mach-pxa/Makefile               |    1 
 arch/arm/mach-pxa/capc7117.c             |  180 +++
 arch/arm/mach-pxa/include/mach/mxm8x10.h |   28 
 arch/arm/mach-pxa/mxm8x10.c              |  842 +++++++++++++++++
 7 files changed, 3227 insertions(+)

> +static struct resource capc7117_ide_resources[] = {
> +	[0] = {
> +	       .start = 0x11000020,
> +	       .end = 0x1100003f,
> +	       .flags = IORESOURCE_MEM,
> +	       },

Why the weird formatting?  We don't align '}' to be on the same column
as '{'.

> +struct platform_device capc7117_ide_device = {
> +	.name = "pata_platform",
> +	.num_resources = ARRAY_SIZE(capc7117_ide_resources),
> +	.resource = capc7117_ide_resources,
> +	.dev = {
> +		.platform_data = &pata_platform_data,
> +		.coherent_dma_mask = ~0,	/* grumble */
> +		},

Ditto.

> +};
> +
> +int capc7117_ide_mach_init(void)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(capc7117_ide_mach_init);

What's this for?

> +
> +static void __init capc7117_ide_init(void)
> +{
> +	pxa3xx_mfp_write(MFP_PIN_GPIO76, 0xa0c0);	/* EXT_IRQ3 */

I'm not sure that pxa3xx_mfp_write is supposed to be used.  Eric?

> +MACHINE_START(CAPC7117,
> +	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
> +    .phys_io = 0x40000000,
> +    .boot_params = 0xa0000100,
> +    .io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
> +    .map_io = pxa_map_io,
> +    .init_irq = pxa3xx_init_irq,
> +    .timer = &pxa_timer,
> +    .init_machine = capc7117_init,

Tabs here please.

> +void __init mxm_8x10_usb_host_init(void)
> +{
> +	pxa3xx_mfp_write(MFP_PIN_GPIO10, 0xa0c0);	/* UTM_CLK */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO49, 0xa0c0);	/* UTM_DATA0 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO50, 0xa0c0);	/* UTM_DATA1 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO51, 0xa0c0);	/* UTM_DATA2 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO52, 0xa0c0);	/* UTM_DATA3 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO53, 0xa0c0);	/* UTM_DATA4 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO54, 0xa0c0);	/* UTM_DATA5 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO55, 0xa0c0);	/* UTM_DATA6 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO56, 0xa0c0);	/* UTM_DATA7 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO58, 0xa0c0);	/* UTM_RXVALID */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO59, 0xa0c0);	/* UTM_RXACTIVE */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO60, 0xa0c0);	/* UTM_RXERROR */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO61, 0xa0c0);	/* UTM_OPMODE0 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO62, 0xa0c0);	/* UTM_OPMODE1 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO71, 0x1c01);	/* USBD_INT */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO73, 0xa0c0);	/* UTM_TXREADY */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO83, 0xa0c0);	/* UTM_TXVALID */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO98, 0xa0c0);	/* UTM_RESET */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO99, 0xa0c0);	/* UTM_XCVR_SELECT */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO100, 0xa0c0);	/* UTM_TERM_SELECT */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO101, 0xa0c0);	/* UTM_SUSPENDM_X */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO102, 0xa0c0);	/* UTM_LINESTATE0 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO103, 0xa0c0);	/* UTM_LINESTATE1 */
> +	pxa3xx_mfp_write(MFP_PIN_GPIO4_2, 0xc0c0);	/* UTM_PULLUP */

I really think you need to look at the tabular setup that platforms
like Zylonite do.  The above won't be very efficient in terms of generated
code.
