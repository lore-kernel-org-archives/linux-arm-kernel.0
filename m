From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 04:07:49 +0100
Subject: [PATCHv3 4/4] arm: dts: Add support for SD/MMC on SOCFPGA
In-Reply-To: <1386197576-3825-5-git-send-email-dinguyen@altera.com>
References: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
 <1386197576-3825-5-git-send-email-dinguyen@altera.com>
Message-ID: <201312050407.50385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013, dinguyen at altera.com wrote:

> +
> +* compatible: should be
> +        - "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +          specific extensions.
> +
> +* samsung,dw-mshc-sdr-timing: See exynos-dw-mshc.txt for more information about
> +	this property.
> +
> +Example:
> +	dwmmc0 at ff704000 {
> +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> +		reg = <0xff704000 0x1000>;
> +		interrupts = <0 139 4>;
> +		fifo-depth = <0x400>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&l4_mp_clk>, <&sdmmc_clk>, <&sysmgr_sdr_mmc>;
> +		clock-names = "biu", "ciu", "sysmgr-sdr-mmc";

You add a "sysmgr-sdr-mmc" clock here without documenting it. I think what you
actually mean here is

> +		clocks = <&l4_mp_clk>, <&sysmgr_sdr_mmc>;
> +		clock-names = "biu", "ciu";

i.e. the <&sysmgr_sdr_mmc> clock is actually your "ciu". If I understand your
code correctly, the dw-mshc has exactly two clock inputs, biu and ciu, and
you use sysmgr to provide ciu. The driver code already contains logic to
set the rate of the ciu clock, and you just need to hook into that.

	Arnd
