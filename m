From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 06 Sep 2015 18:10:00 +0800
Subject: [PATCH v17 1/4] dt-bindings: add document of Rockchip power
 domains
In-Reply-To: <7hr3mgpu57.fsf@linaro.org>
References: <1441184380-13827-1-git-send-email-wxt@rock-chips.com>
 <1441184380-13827-2-git-send-email-wxt@rock-chips.com>
 <7hr3mgpu57.fsf@linaro.org>
Message-ID: <55EC10F8.5090100@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

? 2015?09?03? 02:12, Kevin Hilman ??:
> Caesar Wang <wxt@rock-chips.com> writes:
>
>> This add the necessary binding documentation for the power domains
>> found on Rockchip SoCs.
>>
>> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>
>> ---
>>
>> Changes in v17:
>> - add the decription in detail for RK3288 SoCs.
>>
>> Changes in v16:
>> - remove the pmu node.
>>
>> Changes in v15: None
>> Changes in v14: None
>> Changes in v13: None
>> Changes in v12: None
>> Changes in v11: None
>> Changes in v10: None
>> Changes in v9:
>> - add document decription.
>>
>> Changes in v8:
>> - document go back to v2.
>>
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3:
>> - DT structure has changed.
>>
>> Changes in v2:
>> - move clocks to "optional".
>>
>>   .../bindings/soc/rockchip/power_domain.txt         | 114 +++++++++++++++++++++
>>   1 file changed, 114 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> new file mode 100644
>> index 0000000..4cf6b27
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> @@ -0,0 +1,114 @@
>> +* Rockchip Power Domains
>> +
>> +Rockchip processors include support for multiple power domains which can be
>> +powered up/down by software based on different application scenes to save power.
>> +
>> +Required properties for power domain controller:
>> +- compatible: Should be one of the following.
>> +	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
>> +- #power-domain-cells: Number of cells in a power-domain specifier.
>> +	Should be 1 for multiple PM domains.
>> +- #address-cells: Should be 1.
>> +- #size-cells: Should be 0.
>> +
>> +Required properties for power domain sub nodes:
>> +- reg: index of the power domain, should use macros in:
>> +	"include/dt-bindings/power-domain/rk3288.h" - for RK3288 type power domain.
>> +- clocks (optional): phandles to clocks which need to be enabled while power domain
>> +	switches state.
>> +
>> +Example:
>> +
>> +	power: power-controller {
>> +		compatible = "rockchip,rk3288-power-controller";
>> +		#power-domain-cells = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pd_gpu {
>> +			reg = <RK3288_PD_GPU>;
>> +			clocks = <&cru ACLK_GPU>;
>> +		};
>> +	};
>> +
>> +Node of a device using power domains must have a power-domains property,
>> +containing a phandle to the power device node and an index specifying which
>> +power domain to use.
>> +The index should use macros in:
>> +	"include/dt-bindings/power-domain/rk3288.h" - for rk3288 type power domain.
>> +
>> +Example of the node using power domain:
>> +
>> +	node {
>> +		/* ... */
>> +		power-domains = <&power RK3288_PD_GPU>;
>> +		/* ... */
>> +	};
>> +
>> +Others, all the device clocks being listed in the power-domains itself.
>> +All the device clocks are included in someone domians that need to enable
>> +before you operate them.
>> +
>> +As the chip designs for PM hardware. We need turn on the noc clocks,
>> +if we are operating the "pd_vio" domain to enter the idle status.
>> +
>> +As the following described in detail for every device be included in domains
>> +on RK3288 SoCs.
> IMO, the below isn't really detailed enough, and also, the details
> should be in the .dts file itself, not in the binding doc.
> In particular, it's not obvious from the current series which of the
> clocks are device clocks, and which are other/parent/infrastructure
> clocks needed for the synchronous reset.

Okay, if we add some comments in dts. Says the following example.

What do you think of it?

I'm no sure if we should add these comments in dts.
It looks like it's always awkward. We can explain in the binding doc, 
maybe for better reading.
             /*
              * Note: 'ACLK_GPU' is the GPU clock,
              * and on the ACLK_GPU_NIU (NOC).
              */
             pd_gpu {
                 reg = <RK3288_PD_GPU>;
                 clocks = <&cru ACLK_GPU>;
             };

             /*
              * Note: The following 3 are HEVC(H.265) clocks,
              * and on the ACLK_HEVC_NIU (NOC).
              */
             pd_hevc {
                 reg = <RK3288_PD_HEVC>;
                 clocks = <&cru ACLK_HEVC>,
                 <&cru SCLK_HEVC_CABAC>,
                 <&cru SCLK_HEVC_CORE>;
             };

             /*
              * Note: ACLK_VCODEC/HCLK_VCODEC are VCODEC
              * (video endecoder & decoder) clocks that on the
              * ACLK_VCODEC_NIU and HCLK_VCODEC_NIU (NOC).
               */
             pd_video {
                 reg = <RK3288_PD_VIDEO>;
                 clocks = <&cru ACLK_VCODEC>,
                 <&cru HCLK_VCODEC>;
             };

             /*
              * Note: Although SCLK_* are the working clocks
              * of device without including on the NOC, needed for
              * synchronous reset.
              *
              * ACLK_IEP/ACLK_VIP/ACLK_VOP0 are on ACLK_VIO0_NIU (NOC).
              * ACLK_ISP/ACLK_VOP1 are on ACLK_VIO1_NIU (NOC).
               * ACLK_RGA is on ACLK_RGA_NIU (NOC).
              * The others are on HCLK_VIO_NIU (NOC).
              *
              * *_IEP are the Image Enhancement Processos (IEP) clocks.
              * *_ISP are the Image Signal Processing (ISP) clocks.
              * *_RGA are the RGA clocks.
              * *_VOP* are the Visual Output Processor(VOP) clocks.
              * *_EDP* are the EDP clocks.
              * *_LVDS_* are the LVDS clocks.
              * *_HDMI are the HDMI clocks.
              * *_MIPI_* are the MIPI clocks.
              */
             pd_vio {
                 reg = <RK3288_PD_VIO>;
                 clocks = <&cru ACLK_IEP>,
                 <&cru ACLK_ISP>,
                 <&cru ACLK_RGA>,
                 <&cru ACLK_VIP>,
                 <&cru ACLK_VOP0>,
                 <&cru ACLK_VOP1>,
                 <&cru DCLK_VOP0>,
                 <&cru DCLK_VOP1>,
                 <&cru HCLK_IEP>,
                 <&cru HCLK_ISP>,
                 <&cru HCLK_RGA>,
                 <&cru HCLK_VIP>,
                 <&cru HCLK_VOP0>,
                 <&cru HCLK_VOP1>,
                 <&cru PCLK_EDP_CTRL>,
                 <&cru PCLK_HDMI_CTRL>,
                 <&cru PCLK_LVDS_PHY>,
                 <&cru PCLK_MIPI_CSI>,
                 <&cru PCLK_MIPI_DSI0>,
                 <&cru PCLK_MIPI_DSI1>,
                 <&cru SCLK_EDP_24M>,
                 <&cru SCLK_EDP>,
                 <&cru SCLK_ISP_JPE>,
                 <&cru SCLK_ISP>,
                 <&cru SCLK_RGA>;
             };


---
Thanks,
Caesar
> Kevin
>
>> +	/* GPU's ACLK_GPU on the ACLK_GPU_NIU */
>> +	pd_gpu {
>> +		reg = <RK3288_PD_GPU>;
>> +		clocks = <&cru ACLK_GPU>;
>> +	};
>> +
>> +	/* HEVC AXI clocks */
>> +	pd_hevc {
>> +		reg = <RK3288_PD_HEVC>;
>> +		clocks = <&cru ACLK_HEVC>,
>> +		<&cru SCLK_HEVC_CABAC>,
>> +		<&cru SCLK_HEVC_CORE>,
>> +		<&cru HCLK_HEVC>;
>> +	};
>> +
>> +	/*
>> +	 * RGA, VOP, MIPI, LVDS, EDP..., says the ACLK* on the ACLK_VIO_NIU,
>> +	 * others are on the HCLK_VIO_NIU.
>> +	 */
>> +	pd_vio {
>> +		reg = <RK3288_PD_VIO>;
>> +		clocks = <&cru ACLK_IEP>,
>> +		<&cru ACLK_ISP>,
>> +		<&cru ACLK_RGA>,
>> +		<&cru ACLK_VIP>,
>> +		<&cru ACLK_VOP0>,
>> +		<&cru ACLK_VOP1>,
>> +		<&cru DCLK_VOP0>,
>> +		<&cru DCLK_VOP1>,
>> +		<&cru HCLK_IEP>,
>> +		<&cru HCLK_ISP>,
>> +		<&cru HCLK_RGA>,
>> +		<&cru HCLK_VIP>,
>> +		<&cru HCLK_VOP0>,
>> +		<&cru HCLK_VOP1>,
>> +		<&cru PCLK_EDP_CTRL>,
>> +		<&cru PCLK_HDMI_CTRL>,
>> +		<&cru PCLK_LVDS_PHY>,
>> +		<&cru PCLK_MIPI_CSI>,
>> +		<&cru PCLK_MIPI_DSI0>,
>> +		<&cru PCLK_MIPI_DSI1>,
>> +		<&cru SCLK_EDP_24M>,
>> +		<&cru SCLK_EDP>,
>> +		<&cru SCLK_ISP_JPE>,
>> +		<&cru SCLK_ISP>,
>> +		<&cru SCLK_RGA>;
>> +	};
>> +
>> +	/*
>> +	 * Video's ACLK_VCODEC on the ACLK_VCODEC_NIU, Video's HCLK_VCODEC,
>> +	 * on the HCLK_VCODEC_NIU.
>> +	 */
>> +	pd_video {
>> +		reg = <RK3288_PD_VIDEO>;
>> +		clocks = <&cru ACLK_VCODEC>,
>> +		<&cru HCLK_VCODEC>;
>> +	};
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
