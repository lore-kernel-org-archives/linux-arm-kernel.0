From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 6 Feb 2013 12:32:07 -0300
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130206105431.GA21764@localhost>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5111331F.7090900@free-electrons.com>
 <511168BE.1000803@free-electrons.com>
 <20130206105431.GA21764@localhost>
Message-ID: <20130206153206.GA4618@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Adding mtd in Cc)

On Wed, Feb 06, 2013 at 07:54:31AM -0300, Ezequiel Garcia wrote:
> Hi Gregory,
> 
> On Tue, Feb 05, 2013 at 09:17:02PM +0100, Gregory CLEMENT wrote:
> > On 02/05/2013 05:28 PM, Gregory CLEMENT wrote:
> > > Hi Ezequiel,
> > > 
> > > On 02/05/2013 12:24 PM, Ezequiel Garcia wrote:
> > >> This patch adds an SPI master device node for Armada XP-GP board.
> > >> This master node is an SPI flash controller 'n25q128a13'.
> > >>
> > >> Since there is no 'partitions' node declared, one full sized
> > >> partition named as the device will be created.
> > >>
> > >> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > >> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > >> Cc: Lior Amsalem <alior@marvell.com>
> > >> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > >> ---
> > >> This patch depends on:
> > >>
> > >>  1. Gregory's patch for Armada XP GP board:
> > >>       arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
> > >>
> > >>  2. My previous patch for SPI on Armada 370/XP:
> > >>       arm: mvebu: Add support for SPI controller in Armada 370/XP
> > >>
> > >> And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
> > >>
> > >>  arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
> > >>  1 files changed, 12 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
> > >> index 3eea531..1c8afe2 100644
> > >> --- a/arch/arm/boot/dts/armada-xp-gp.dts
> > >> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
> > >> @@ -97,5 +97,17 @@
> > >>  			phy = <&phy3>;
> > >>  			phy-mode = "rgmii-id";
> > >>  		};
> > >> +
> > >> +		spi0: spi at d0010600 {
> > >> +			status = "okay";
> > >> +
> > >> +			spi-flash at 0 {
> > >> +				#address-cells = <1>;
> > >> +				#size-cells = <1>;
> > >> +				compatible = "n25q128a13";
> > >> +				reg = <0>; /* Chip select 0 */
> > >> +				spi-max-frequency = <108000000>;
> > 
> > I had a remark about it, according to the datasheet, 108MHz is the
> > maximum frequency for the all the instructions but the READ
> > instruction. For the READ the maximum frequency is 54MHz. So I wonder
> > if we shouldn't use 54000000 here.
> > 
> 
> Mmm... nice catch.
> 
> The mtd driver for the spi flash (m25p80) will use FAST_READ opcode
> if CONFIG_M25PXX_USE_FAST_READ is selected, and this option
> is selected by default.
> However we cannot count on this option being selected, of course.
> 
> On the other side, after some testing with spi-max-frequency = 50 MHz
> and also with spi-max-frequency = 108 MHz I'm seeing the flash often
> (not always) stalls when trying to read the full device through dd:
> 
> / # dd if=/dev/mtd0ro of=/dev/null
> 

FWIW, using CONFIG_DETECT_HUNG_TASK we can see the hung happens inside spi_sync().
It seems the completion handler is never called,
though I still don't understand under what circumstances that can happen.

dd              D c02d79c8     0   964    961 0x00000000
[<c02d79c8>] (__schedule+0x1c8/0x504) from [<c02d61d0>] (schedule_timeout+0x158/0x200)
[<c02d61d0>] (schedule_timeout+0x158/0x200) from [<c02d7504>] (wait_for_common+0xe0/0x194)
[<c02d7504>] (wait_for_common+0xe0/0x194) from [<c0215b44>] (spi_sync+0x74/0x90)
[<c0215b44>] (spi_sync+0x74/0x90) from [<c0214c80>] (m25p80_read+0x100/0x17c)
[<c0214c80>] (m25p80_read+0x100/0x17c) from [<c020edac>] (mtd_read+0x8c/0xc0)
[<c020edac>] (mtd_read+0x8c/0xc0) from [<c021404c>] (mtdchar_read+0xe0/0x224)
[<c021404c>] (mtdchar_read+0xe0/0x224) from [<c00c757c>] (vfs_read+0xa4/0x148)
[<c00c757c>] (vfs_read+0xa4/0x148) from [<c00c7664>] (sys_read+0x44/0x78)
[<c00c7664>] (sys_read+0x44/0x78) from [<c000ede0>] (ret_fast_syscall+0x0/0x30)

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
