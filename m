From: gerg@linux-m68k.org (Greg Ungerer)
Date: Thu, 12 Oct 2017 16:26:10 +1000
Subject: [2/2] spi: imx: fix use of native chip-selects with devicetree
In-Reply-To: <1507667916.74283.19.camel@impinj.com>
References: <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
 <1507667916.74283.19.camel@impinj.com>
Message-ID: <209bb901-875e-8007-06f8-3ae9698a0e41@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trent,

On 11/10/17 06:38, Trent Piepho wrote:
> On Fri, 2017-03-17 at 15:03 +1000, Greg Ungerer wrote:
>> You can successfully specify native chip-selects if using a platform
>> setup by specifying the cs-gpio as negative offset by 32. And that
>> works correctly. You cannot use the same method in devicetree.
> 
> I came across some spi-imx bugs in an older kernel and in checking the
> latest kernel, found this patch.  It fixed the issue with dt not
> working for older spi imx devices (the imx51+ config function never
> used the platform data 32 offset thing), but fails to address non-dt
> platform data based users of the spi imx driver.
> 
> For instance, include/linux/platform_data/spi-imx.h still refers to the
> offset by 32 for native cs:
> 
>  * @chipselect: Array of chipselects for this master. Numbers >= 0 mean gpio
>  *              pins, numbers < 0 mean internal CSPI chipselects according
>  *              to MXC_SPI_CS(). Normally you want to use gpio based chip
> 
> #define MXC_SPI_CS(no)  ((no) - 32)
> 
> After this patch, for no-DT users, any negative (or rather not a valid
> gpio) value in chipselect will cause the native chipselect
> corresponding to the spi slave's chipselect.  It's no longer possible
> to specify which native cs to use in the spi-imx platform data.  So in
> something like:
> 
> arch/arm/mach-imx/mach-mx31moboard.c-static int moboard_spi1_cs[] = {
> arch/arm/mach-imx/mach-mx31moboard.c:   MXC_SPI_CS(0),
> arch/arm/mach-imx/mach-mx31moboard.c:   MXC_SPI_CS(2),
> arch/arm/mach-imx/mach-mx31moboard.c-};
> 
> The spi device configured to use chip select 1 will no longer use
> native chip select line 2.
> 
> Looking at all in-tree users of spi imx platform data, it appears that
> this board is the only one in which the cs selected does not match the
> array index.  Though there are still several which still use
> MSC_SPI_CS() even though it doesn't really work anymore.

Commit 901f26bce64a ("ARM: imx: set correct chip_select in platform setup") 
fixes this issue. It specifically makes sure that the board setup chip
select is set correctly (so that spi-imx can then use it). It also pads
out the chipselect arrays so that the chip select and indexes match.

Is this not working for you?

Regards
Greg
