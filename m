From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Mar 2017 19:56:39 +0100
Subject: [PATCH v7 00/13] mmc: Add support to Marvell Xenon SD Host
 Controller
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170330185639.GI7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 05:22:52PM +0200, Gregory CLEMENT wrote:
> - Remove parse of child node mmc-card. Wait for a better solution.

So for mcbin, I have:

&ap_sdhci0 {
        bus-width = <8>;
        marvell,xenon-emmc;
        marvell,xenon-phy-type = "emmc 5.1 phy";
        /*
         * Not stable in HS modes - phy needs "more calibration", so add
         * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
         */
        marvell,xenon-phy-slow-mode;
        no-1-8-v;
        non-removable;
        status = "okay";
        vqmmc-supply = <&v_vddo_h>;

        #address-cells = <1>;
        #size-cells = <0>;
        mmccard: mmccard at 0 {
                compatible = "mmc-card";
                reg = <0>;
        };
};

Does this mean the "mmccard" bit is no longer required - or is it required
for the eMMC to be detected but is no longer supported by the driver?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
