From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 6 Feb 2013 07:54:32 -0300
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <511168BE.1000803@free-electrons.com>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5111331F.7090900@free-electrons.com>
 <511168BE.1000803@free-electrons.com>
Message-ID: <20130206105431.GA21764@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Tue, Feb 05, 2013 at 09:17:02PM +0100, Gregory CLEMENT wrote:
> On 02/05/2013 05:28 PM, Gregory CLEMENT wrote:
> > Hi Ezequiel,
> > 
> > On 02/05/2013 12:24 PM, Ezequiel Garcia wrote:
> >> This patch adds an SPI master device node for Armada XP-GP board.
> >> This master node is an SPI flash controller 'n25q128a13'.
> >>
> >> Since there is no 'partitions' node declared, one full sized
> >> partition named as the device will be created.
> >>
> >> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> >> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> Cc: Lior Amsalem <alior@marvell.com>
> >> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >> ---
> >> This patch depends on:
> >>
> >>  1. Gregory's patch for Armada XP GP board:
> >>       arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
> >>
> >>  2. My previous patch for SPI on Armada 370/XP:
> >>       arm: mvebu: Add support for SPI controller in Armada 370/XP
> >>
> >> And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
> >>
> >>  arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
> >>  1 files changed, 12 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
> >> index 3eea531..1c8afe2 100644
> >> --- a/arch/arm/boot/dts/armada-xp-gp.dts
> >> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
> >> @@ -97,5 +97,17 @@
> >>  			phy = <&phy3>;
> >>  			phy-mode = "rgmii-id";
> >>  		};
> >> +
> >> +		spi0: spi at d0010600 {
> >> +			status = "okay";
> >> +
> >> +			spi-flash at 0 {
> >> +				#address-cells = <1>;
> >> +				#size-cells = <1>;
> >> +				compatible = "n25q128a13";
> >> +				reg = <0>; /* Chip select 0 */
> >> +				spi-max-frequency = <108000000>;
> 
> I had a remark about it, according to the datasheet, 108MHz is the
> maximum frequency for the all the instructions but the READ
> instruction. For the READ the maximum frequency is 54MHz. So I wonder
> if we shouldn't use 54000000 here.
> 

Mmm... nice catch.

The mtd driver for the spi flash (m25p80) will use FAST_READ opcode
if CONFIG_M25PXX_USE_FAST_READ is selected, and this option
is selected by default.
However we cannot count on this option being selected, of course.

On the other side, after some testing with spi-max-frequency = 50 MHz
and also with spi-max-frequency = 108 MHz I'm seeing the flash often
(not always) stalls when trying to read the full device through dd:

/ # dd if=/dev/mtd0ro of=/dev/null

This happens regardless of CONFIG_M25PXX_USE_FAST_READ, and regardless
of spi-max-frequency = 50 MHz or 54 MHz or 108 MHz.

Note that setting 108 MHz is useless in our case, because there's
an upper limit of 62.5 MHz set by the core clock of the SoC.

Using a read block size of 1M, the read completes OK -- always:

/ # dd if=/dev/mtd0 of=/dev/null bs=1M
16+0 records in
16+0 records out
16777216 bytes (16.0MB) copied, 27.306048 seconds, 600.0KB/s

Moreover, when the read completes, the achieved bandwidth
is the same for 40, 50, 54, or 108 MHz.

If we set spi-max-frequency to 27 MHz (108 MHz / 4), it looks like the stalling
disappear and the read always completes OK, at almost half the speed:

/ # dd if=/dev/mtd0ro of=/dev/null
32768+0 records in
32768+0 records out
16777216 bytes (16.0MB) copied, 49.005122 seconds, 334.3KB/s

So according to this analysis, we whould set 27 MHz as the max
frequency, based on nothing but in these tests.

I'm not sure the stalling is due to the clocking or due to
some driver bug (I don't like the tricks pulled by the busy loop
in orion_spi_wait_till_ready() but probably this is completely unrelated).

Adding some SPI people in Cc, hoping they can shed a light on this.

What do you think?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
