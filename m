From: jackp@codeaurora.org (Jack Pham)
Date: Tue, 16 Sep 2014 11:15:43 -0700
Subject: [Patch v9 1/3] usb: dwc3: qcom: Add device tree binding
In-Reply-To: <1410550088-8754-2-git-send-email-agross@codeaurora.org>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-2-git-send-email-agross@codeaurora.org>
Message-ID: <20140916181543.GA19101@usblab-sd-06.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Fri, Sep 12, 2014 at 02:28:06PM -0500, Andy Gross wrote:
> +Example device nodes:
> +
> +		hs_phy: phy at 100f8800 {
> +			compatible = "qcom,dwc3-hs-usb-phy";
> +			reg = <0x100f8800 0x30>;

Just wanted to point out that in our downstream code, the glue
device/driver, i.e. "qcom,dwc3", does claim an entire register region
that encompasses the same registers used by these PHYs. I noticed you're
not adding a reg resource to the glue node below in this patchset. In
order to allow multiple devices to use the overlapping regions, we avoid
calling devm_ioremap_resource() and instead call devm_ioremap_nocache()
directly which bypasses the request_mem_region() call, which I don't
think is an entirely correct thing to do.

On the other hand I'm trying to think of use cases on our other SOCs
(MSM8974, APQ8084) where the glue actually would need access to the same
or adjacent IO registers that couldn't just be handled directly by these
PHY drivers. Should we accommodate for the potential of overlapping
regions or should we just hold the line here and maybe only expose with
finer granularity the registers that will actually be needed by the PHYs
& glue respectively?

> +			clocks = <&gcc USB30_0_UTMI_CLK>;
> +			clock-names = "ref";
> +			#phy-cells = <0>;
> +
> +			status = "ok";
> +		};
> +
> +		ss_phy: phy at 100f8830 {
> +			compatible = "qcom,dwc3-ss-usb-phy";
> +			reg = <0x100f8830 0x30>;
> +			clocks = <&gcc USB30_0_MASTER_CLK>;
> +			clock-names = "ref";
> +			#phy-cells = <0>;
> +
> +			status = "ok";
> +		};
> +
> +		usb3_0: usb30 at 0 {
> +			compatible = "qcom,dwc3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			clocks = <&gcc USB30_0_MASTER_CLK>;
> +			clock-names = "core";
> +
> +			ranges;
> +
> +			status = "ok";
> +
> +			dwc3 at 10000000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x10000000 0xcd00>;
> +				interrupts = <0 205 0x4>;
> +				phys = <&hs_phy>, <&ss_phy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				tx-fifo-resize;
> +				dr_mode = "host";
> +			};
> +		};
> +

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
