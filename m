From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Aug 2012 23:05:35 +0530
Subject: [PATCH v6 7/7] ARM: davinci: add support for the am1808 based
 enbw_cmc board
In-Reply-To: <1341492608-20597-1-git-send-email-hs@denx.de>
References: <1341492608-20597-1-git-send-email-hs@denx.de>
Message-ID: <5022A367.1070903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 7/5/2012 6:20 PM, Heiko Schocher wrote:
> - AM1808 based board
> - 64 MiB DDR ram
> - 2 MiB Nor flash
> - 128 MiB NAND flash
> - use internal RTC
> - I2C support
> - hwmon lm75 support
> - UBI/UBIFS support
> - MMC support
> - USB OTG support
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-mtd at lists.infradead.org
> Cc: linux-i2c at vger.kernel.org
> Cc: netdev at vger.kernel.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> ---
> - post this board support with USB support, even though
>   USB is only working with the 10 ms "workaround", posted here:
>   http://comments.gmane.org/gmane.linux.usb.general/54505
>   I see this issue also on the AM1808 TMDXEXP1808L evalboard.
> - MMC and USB are not using OF support yet, ideas how to port
>   this are welcome. I need for USB and MMC boards board
>   specific callbacks, how to solve this with OF support?
> 
> - changes for v2:
>   - changes in the nand node due to comments from Scott Wood:
>     - add "ti,davinci-" prefix
>     - Dashes are preferred to underscores
>     - rename "nandflash" to "nand"
>     - introduce new "ti,davinci" specific properties for setting
>       up ecc_mode, ecc_bits, options and bbt options, instead
>       using linux defines
>   - changes for i2c due to comments from Sylwester Nawrocki:
>     - use "cell-index" instead "id"
>     - OF_DEV_AUXDATA in the machine code, instead pre-define
>       platform device name
>   - add comment from Grant Likely for i2c:
>     - removed "id" resp. "cell-index" completely
>     - fixed documentation
>     - use of_match_ptr()
>     - use devm_kzalloc() for allocating plattform data mem
>     - fixed a whitespace issue
>   - add net comments from Grant Likely:
>     - add prefix "ti,davinci-" to davinci specific property names
>     - remove version property
>     - use compatible name "ti,davinci-dm6460-emac"
>   - add comment from Grant Likely:
>     - rename compatible node
>     - do not use cell-index
>     - CONFIG_OF required for this board
>     TODO:
>     - create a generic board support file, as I got no
>       answer to my ping to grant, maybe this could be done
>       in a second step?
> - changes for v3:
>   - add comments from Sergei Shtylyov:
>     - rename compatible" prop to "ti,cp_intc"
>     - cp_intc_init now used for Interrupt controller init
> - changes for v4:
>   add comment from Nori Sekhar:
>   - rename davinci emac compatible property to "ti,davinci-dm6467-emac"
>   - remove "pinmux-handle" property as discussed here:
>     http://www.spinics.net/lists/arm-kernel/msg175701.html
>     with Nori Sekhar
> 
> - changes for v5:
>   add comments from Grant Likely:
>   - rename compatible" prop to "ti,cp-intc"
> 
> - changes for v6:
>   rework this patch, as patch
>   ARM: davinci: cp_intc: Add OF support for TI interrupt controller
>   was changed from Nori Sekhar on Jul 03, 2012; 9:16pm
>   Changes therefore in this patch:
> 
>   Call of_irq_init() in the generic DT board file and not in the
>   interrupt controller code. See arch/arm/mach-at91/board-dt.c or
>   arch/arm/mach-omap2/board-generic.c for examples.
> 
>   At this point the question raises, if we should rename this
>   board port from arch/arm/mach-davinci/enbw_cmc.c to
>   arch/arm/mach-davinci/board-dt.c ? Also the defconfig to
>   davinci_of_defconfig ... ? The USB and MMC callbacks are
>   currently board specific, but if other boards come in,
>   that could be easily adapted for their needs ...
> 
>  arch/arm/boot/dts/enbw_cmc.dts                  |  183 +++++++++++
>  arch/arm/configs/enbw_cmc_defconfig             |  126 ++++++++
>  arch/arm/mach-davinci/Kconfig                   |    9 +
>  arch/arm/mach-davinci/Makefile                  |    1 +
>  arch/arm/mach-davinci/board-enbw-cmc.c          |  385 +++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
>  6 files changed, 705 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/enbw_cmc.dts
>  create mode 100644 arch/arm/configs/enbw_cmc_defconfig
>  create mode 100644 arch/arm/mach-davinci/board-enbw-cmc.c

With the move to DT, we are not going to add more board specific files
and defconfigs. I am working on adding a generic dt board file for DA850
(similar to what has been done for imx). That file is not going to do
any platform device registrations. If you are OK with it, I will add the
dts file for enbw_cmc board in the patch series I am planning to post.

Things like USB and MMC/SD will need to be converted to DT before they
can be supported on new boards.

Thanks,
Sekhar
