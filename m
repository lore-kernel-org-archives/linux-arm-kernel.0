From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 2 Jan 2012 02:00:36 -0700
Subject: [PATCH 7/9] arm/tegra: emc: device tree bindings
In-Reply-To: <1324599468-12845-8-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-8-git-send-email-olof@lixom.net>
Message-ID: <20120102090036.GM18381@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 04:17:46PM -0800, Olof Johansson wrote:
> Device tree bindings for the EMC tables on tegra.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: devicetree-discuss at lists.ozlabs.org

Okay by me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  .../devicetree/bindings/arm/tegra/emc.txt          |  100 ++++++++++++++++++++
>  arch/arm/boot/dts/tegra20.dtsi                     |    7 ++
>  2 files changed, 107 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/emc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/emc.txt b/Documentation/devicetree/bindings/arm/tegra/emc.txt
> new file mode 100644
> index 0000000..09335f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/emc.txt
> @@ -0,0 +1,100 @@
> +Embedded Memory Controller
> +
> +Properties:
> +- name : Should be emc
> +- #address-cells : Should be 1
> +- #size-cells : Should be 0
> +- compatible : Should contain "nvidia,tegra20-emc".
> +- reg : Offset and length of the register set for the device
> +- nvidia,use-ram-code : If present, the sub-nodes will be addressed
> +  and chosen using the ramcode board selector. If omitted, only one
> +  set of tables can be present and said tables will be used
> +  irrespective of ram-code configuration.
> +
> +Child device nodes describe the memory settings for different configurations and clock rates.
> +
> +Example:
> +
> +	emc at 7000f400 {
> +		#address-cells = < 1 >;
> +		#size-cells = < 0 >;
> +		compatible = "nvidia,tegra20-emc";
> +		reg = <0x7000f4000 0x200>;
> +	}
> +
> +
> +Embedded Memory Controller ram-code table
> +
> +If the emc node has the nvidia,use-ram-code property present, then the
> +next level of nodes below the emc table are used to specify which settings
> +apply for which ram-code settings.
> +
> +If the emc node lacks the nvidia,use-ram-code property, this level is omitted
> +and the tables are stored directly under the emc node (see below).
> +
> +Properties:
> +
> +- name : Should be emc-tables
> +- nvidia,ram-code : the binary representation of the ram-code board strappings
> +  for which this node (and children) are valid.
> +
> +
> +
> +Embedded Memory Controller configuration table
> +
> +This is a table containing the EMC register settings for the various
> +operating speeds of the memory controller. They are always located as
> +subnodes of the emc controller node.
> +
> +There are two ways of specifying which tables to use:
> +
> +* The simplest is if there is just one set of tables in the device tree,
> +  and they will always be used (based on which frequency is used).
> +  This is the preferred method, especially when firmware can fill in
> +  this information based on the specific system information and just
> +  pass it on to the kernel.
> +
> +* The slightly more complex one is when more than one memory configuration
> +  might exist on the system.  The Tegra20 platform handles this during
> +  early boot by selecting one out of possible 4 memory settings based
> +  on a 2-pin "ram code" bootstrap setting on the board. The values of
> +  these strappings can be read through a register in the SoC, and thus
> +  used to select which tables to use.
> +
> +Properties:
> +- name : Should be emc-table
> +- compatible : Should contain "nvidia,tegra20-emc-table".
> +- reg : either an opaque enumerator to tell different tables apart, or
> +  the valid frequency for which the table should be used (in kHz).
> +- clock-frequency : the clock frequency for the EMC at which this
> +  table should be used (in kHz).
> +- nvidia,emc-registers : a 46 word array of EMC registers to be programmed
> +  for operation at the 'clock-frequency' setting.
> +  The order and contents of the registers are:
> +    RC, RFC, RAS, RP, R2W, W2R, R2P, W2P, RD_RCD, WR_RCD, RRD, REXT,
> +    WDV, QUSE, QRST, QSAFE, RDV, REFRESH, BURST_REFRESH_NUM, PDEX2WR,
> +    PDEX2RD, PCHG2PDEN, ACT2PDEN, AR2PDEN, RW2PDEN, TXSR, TCKE, TFAW,
> +    TRPAB, TCLKSTABLE, TCLKSTOP, TREFBW, QUSE_EXTRA, FBIO_CFG6, ODT_WRITE,
> +    ODT_READ, FBIO_CFG5, CFG_DIG_DLL, DLL_XFORM_DQS, DLL_XFORM_QUSE,
> +    ZCAL_REF_CNT, ZCAL_WAIT_CNT, AUTO_CAL_INTERVAL, CFG_CLKTRIM_0,
> +    CFG_CLKTRIM_1, CFG_CLKTRIM_2
> +
> +		emc-table at 166000 {
> +			reg = <166000>;
> +			compatible = "nvidia,tegra20-emc-table";
> +			clock-frequency = < 166000 >;
> +			nvidia,emc-registers = < 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +						 0 0 0 0 >;
> +		};
> +
> +		emc-table at 333000 {
> +			reg = <333000>;
> +			compatible = "nvidia,tegra20-emc-table";
> +			clock-frequency = < 333000 >;
> +			nvidia,emc-registers = < 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +						 0 0 0 0 >;
> +		};
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 3da7afd..c162241 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -120,6 +120,13 @@
>  		interrupts = < 0 91 0x04 >;
>  	};
>  
> +	emc at 7000f400 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "nvidia,tegra20-emc";
> +		reg = <0x7000f400 0x200>;
> +	};
> +
>  	sdhci at c8000000 {
>  		compatible = "nvidia,tegra20-sdhci";
>  		reg = <0xc8000000 0x200>;
> -- 
> 1.7.8.GIT
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
