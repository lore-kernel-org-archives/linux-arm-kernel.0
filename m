From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jun 2015 18:58:43 +0200
Subject: [PATCH 03/34] pinctrl: mvebu: armada-375: remove non-existing
 NAND re/we pins
In-Reply-To: <1433868446-11028-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150609165843.GB16778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 06:46:55PM +0200, Thomas Petazzoni wrote:
> After updating to a more recent version of the Armada 375, we realized
> that some of the pins documented as having a NAND-related
> functionality in fact did not have such functionality. This commit
> updates the pinctrl driver accordingly.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.15+
> Fixes: ce3ed59dcddd ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375")
> ---
>  .../devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt        | 4 ++--
>  drivers/pinctrl/mvebu/pinctrl-armada-375.c                            | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
> index 7de0cda..bedbe42 100644
> --- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
> @@ -22,8 +22,8 @@ mpp5          5        gpio, dev(ad7), spi0(cs2), spi1(cs2)
>  mpp6          6        gpio, dev(ad0), led(p1), audio(rclk)
>  mpp7          7        gpio, dev(ad1), ptp(clk), led(p2), audio(extclk)
>  mpp8          8        gpio, dev (bootcs), spi0(cs0), spi1(cs0)
> -mpp9          9        gpio, nf(wen), spi0(sck), spi1(sck)
> -mpp10        10        gpio, nf(ren), dram(vttctrl), led(c1)
> +mpp9          9        gpio, spi0(sck), spi1(sck), nand(we)
> +mpp10        10        gpio, dram(vttctrl), led(c1), nand(re)

>From armada-375.dtsi:

                                nand_pins: nand-pins {
                                        marvell,pins = "mpp0", "mpp1", "mpp2",
                                                "mpp3", "mpp4", "mpp5",
                                                "mpp6", "mpp7", "mpp8",
                                                "mpp9", "mpp10", "mpp11",
                                                "mpp12", "mpp13";
                                        marvell,function = "nand";
                                };

Don't you also need to remove mpp9 and mpp10 from here? What does
pinctrl do when you ask for pins which are not a member of the
function?

	Andrew
