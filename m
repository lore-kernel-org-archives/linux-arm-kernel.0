From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 22 Apr 2016 15:28:39 +0200
Subject: [PATCH 09/11] arm64: tegra: Add DFLL clock node on Jetson TX1
In-Reply-To: <1461321071-6431-10-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-10-git-send-email-pchiu@nvidia.com>
Message-ID: <20160422132839.GO9047@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 06:31:09PM +0800, Penny Chiu wrote:
> Add DFLL clock device-tree node for Tegra210 DFLL IP block.
> 
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 16 ++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 15 +++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> index 9d02db2..5cf07f2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> @@ -43,6 +43,22 @@
>  		};
>  	};
>  
> +	dfll: clock at 70110000 {
> +		status = "okay";
> +
> +		reg = <0x0 0x70110000 0x0 0x400>;
> +		vdd-cpu-supply = <&cpu_ovr_reg>;
> +		nvidia,pwm-to-pmic;
> +		nvidia,init-uv = <1000000>;
> +		nvidia,align-step-uv = <19200>; /* 19.2mv */
> +		nvidia,sample-rate = <25000>;
> +		nvidia,droop-ctrl = <0x00000f00>;
> +		nvidia,force-mode = <1>;
> +		nvidia,cf = <6>;
> +		nvidia,ci = <0>;
> +		nvidia,cg = <2>;
> +	};
> +
>  	pwm_dfll: pwm at 70110000 {
>  		compatible = "nvidia,tegra210-dfll-pwm";
>  		reg = <0x0 0x70110000 0x0 0x400>;

This isn't good. We're effectively sharing the same I/O memory between
two devices. Let's avoid that if possible.

It would seem to me that this DFLL PWM device isn't really a proper PWM
controller in the sense supported by the PWM framework. As such it might
be easier to have the nvidia,tegra210-dfll compatible device expose a
regulator directly rather than go via a "fake" PWM device and a
PWM-based regulator on top of that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/e2956c1f/attachment-0001.sig>
