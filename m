From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Nov 2018 13:02:57 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Enable I2C DMA
In-Reply-To: <1540071326-27428-1-git-send-email-ykaneko0929@gmail.com>
References: <1540071326-27428-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20181121120252.l433sboqukjpk2ij@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 06:35:26AM +0900, Yoshihiro Kaneko wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch enables I2C DMA.
> 
> NOTE: I2C7 DMA is not supported by R-Car Gen3 Hardware User's Manual
> Rev.0.80E.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Base patch stack:
* renesas-devel-20181121-v4.20-rc3
+ "iommu/ipmmu-vmsa: Hook up r8a77990 DT matching code"
+ "pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and functions"
+ "pinctrl: sh-pfc: r8a77990: Add Audio clock pins, groups and functions"

Config: renesas_defconfig + IPMMU_VMSA

Should we enable IPMMU_VMSA in arm64 defconfig and renesas_defconfig?

Test with base patch stack:
# grep dma /proc/interrupts  | grep -v "0          0"
(no output)
# amixer set "DVC Out" 2%
# play xyz.wav
# grep dma /proc/interrupts  | grep -v "0          0"
(no output)

Test with base patch stack + this patch applied:
# grep dma /proc/interrupts  | grep -v "0          0"
(no output)
# amixer set "DVC Out" 2%
# play xyz.wav
# grep dma /proc/interrupts  | grep -v "0          0"
109:        512          0     GIC-0 352 Level     ec700000.dma-controller:0


Tested-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

I plan to apply this patch for v4.21.
