From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Dec 2013 13:55:36 +0000
Subject: [PATCH 3/6] arm64: dts: Add a devicetree for the ARMv8 4xA53
 4xA57 FVP
In-Reply-To: <1386767606-6391-3-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-3-git-send-email-broonie@kernel.org>
Message-ID: <20131211135536.GC17681@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 01:13:23PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add a dts file for ARMv8 fixed virtual platform which models a
> big.LITTLE configuration for the architecture.  This is based on the
> DT shipped by ARM but has been modified for mainline, removing features
> not present in mainline and updating the CPU bindings for mainline.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/boot/dts/Makefile                |   4 +-
>  arch/arm64/boot/dts/fvp-base-gicv2-psci.dts | 233 ++++++++++++++++++++++++++++
>  2 files changed, 236 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/fvp-base-gicv2-psci.dts
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index c52bdb051f66..2d16cdbe5d47 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,4 +1,6 @@
> -dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
> +dtb-$(CONFIG_ARCH_VEXPRESS) += 	rtsm_ve-aemv8a.dtb \
> +				foundation-v8.dtb \
> +				fvp-base-gicv2-psci.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>  
>  targets += dtbs
> diff --git a/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts b/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts
> new file mode 100644
> index 000000000000..736f546123bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts
> @@ -0,0 +1,233 @@
> +/*
> + * Copyright (c) 2013, ARM Limited. All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * Redistributions of source code must retain the above copyright notice, this
> + * list of conditions and the following disclaimer.
> + *
> + * Redistributions in binary form must reproduce the above copyright notice,
> + * this list of conditions and the following disclaimer in the documentation
> + * and/or other materials provided with the distribution.
> + *
> + * Neither the name of ARM nor the names of its contributors may be used
> + * to endorse or promote products derived from this software without specific
> + * prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/dts-v1/;
> +
> +/memreserve/ 0x80000000 0x00010000;

While we are admittedly missing them elsewhere, it would be nice to have
a comment stating what the memreserve is for. With a proper PSCI
implementation, I don't see why this should be necessary.

> +
> +/ {
> +};
> +
> +/ {
> +	model = "FVP Base";

FVP Base (is as the name implies) a base upon which particular model
instances are built. This name should be clarified (e.g. "FVP Base A57x4
A53x4").

That also applies to the filename.

> +	compatible = "arm,vfp-base", "arm,vexpress";

s/vfp/fvp/

Likewise, it would be nice to have a more specific compatible string
here.

As the FVP is not a vexpress (though it is similar), we should probably
have "arm,fvp-base" as the fallback and drop the "arm,vexpress" entry.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	aliases {
> +		serial0 = &v2m_serial0;
> +		serial1 = &v2m_serial1;
> +		serial2 = &v2m_serial2;
> +		serial3 = &v2m_serial3;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci";
> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;
> +	};

Are these IDs right? One of these IDs is a different width than the
others.

Which firmware/bootloader does this correspond to?

> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		big0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			clock-frequency = <1000000>;

Is clock-frequency used anywhere? Is it a useful thing to have
(regardless of whether ePAPR defines it)?

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 0xff01>,
> +			     <1 14 0xff01>,
> +			     <1 11 0xff01>,
> +			     <1 10 0xff01>;
> +		clock-frequency = <100000000>;

A clock-frequency property in a timer is an indicator that the
bootloader/firmware is broken and should be fixed. Is this actually
necessary, or does the firmware/loader program CNTFRQ correctly on all
CPUs?

> +	};
> +
> +	timer at 2a810000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0 0x2a810000 0x0 0x10000>;
> +			clock-frequency = <100000000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			frame at 2a820000 {
> +				frame-number = <0>;
> +				interrupts = <0 25 4>;
> +				reg = <0x0 0x2a820000 0x0 0x10000>;
> +			};
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0 60 4>,
> +			     <0 61 4>,
> +			     <0 62 4>,
> +			     <0 63 4>;
> +	};

I assume this is just the A57 cores? That should probably be noted for
now. In future we'll need to define the relationship between interrupts
and CPUs, and describe the A53 cores.

Thanks,
Mark.
