From: huziji@marvell.com (Hu Ziji)
Date: Fri, 31 Mar 2017 10:09:58 +0800
Subject: [PATCH v7 00/13] mmc: Add support to Marvell Xenon SD Host
 Controller
In-Reply-To: <20170330185639.GI7909@n2100.armlinux.org.uk>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
 <20170330185639.GI7909@n2100.armlinux.org.uk>
Message-ID: <8ebf11c8-f8e0-e4bb-ed70-f8c2e68aa787@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 2017/3/31 2:56, Russell King - ARM Linux wrote:
> ----------------------------------------------------------------------
> On Thu, Mar 30, 2017 at 05:22:52PM +0200, Gregory CLEMENT wrote:
>> - Remove parse of child node mmc-card. Wait for a better solution.
> 
> So for mcbin, I have:
> 
> &ap_sdhci0 {
>         bus-width = <8>;
>         marvell,xenon-emmc;
>         marvell,xenon-phy-type = "emmc 5.1 phy";
>         /*
>          * Not stable in HS modes - phy needs "more calibration", so add
>          * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
>          */
>         marvell,xenon-phy-slow-mode;
>         no-1-8-v;
>         non-removable;
>         status = "okay";
>         vqmmc-supply = <&v_vddo_h>;
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
>         mmccard: mmccard at 0 {
>                 compatible = "mmc-card";
>                 reg = <0>;
>         };
> };
> 
> Does this mean the "mmccard" bit is no longer required - or is it required
> for the eMMC to be detected but is no longer supported by the driver?
> 

	Based on the implementation in this release, "mmccard" is no longer required.

	More details:
	eMMC Vqmmc in Xenon is fixed without a regulator. Thus 1.8V Signaling Enable bit
	in SDHC doesn't work.
	As a result, Xenon driver has to skip sdhci_start_signal_voltage_switch() to avoid
	checking 1.8V signaling enable bit when setting signaling voltage.

	Previously, we use "mmccard" to inform Xenon driver that it is an eMMC card
	and therefore sdhci_start_signal_voltage_switch() is skipped.

	Currently, Xenon driver directly checks if Vqmmc regulator is provided.
	Skip sdhci_start_signal_voltage_switch() if Vqmmc is fixed.
	In my own opinion, it is more direct and clear, than checking eMMC card type. 

	Thank you.

Best regards,
Hu Ziji

> Thanks.
> 
