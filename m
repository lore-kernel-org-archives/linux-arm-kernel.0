From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 20 Sep 2016 20:12:14 -0500
Subject: [RFC 3/4] arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P)
 support
In-Reply-To: <1467938467-21607-4-git-send-email-jmcnicol@redhat.com>
References: <1467938467-21607-1-git-send-email-jmcnicol@redhat.com>
 <1467938467-21607-4-git-send-email-jmcnicol@redhat.com>
Message-ID: <20160921011214.GF5431@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 05:41:06PM -0700, Jeremy McNicoll wrote:
> From: Bastian K?cher <mail@kchr.de>
> 
> Initial device tree support for Qualcomm MSM8994 SoC and
> Huawei Angler / Google Nexus 6P support.
> 
> The device tree and the angler_defconfig are based on the
> device tree from the Google 3.10 kernel tree.
> 
> The device can be booted into the initrd with only one CPU running.
> 
> Signed-off-by: Bastian K?cher <mail@kchr.de>
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  arch/arm64/Kconfig.platforms                       |  13 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/huawei/Makefile                |   5 +
>  .../boot/dts/huawei/msm8994-angler-rev-101.dts     |  41 ++

There is nothing to warrant having huawei have their own directory unless they
are making their own SOC.

>  arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |  38 ++
>  arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi         |  31 +
>  arch/arm64/boot/dts/qcom/msm8994.dtsi              | 237 ++++++++
>  arch/arm64/configs/angler_defconfig                | 666 +++++++++++++++++++++

We don't need to add defconfigs.  We just need to turn on the options in the
main defconfig.

Also, when you do have defconfigs, please separate those changes into a separate
patch.

>  8 files changed, 1032 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/huawei/Makefile
>  create mode 100644 arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994.dtsi
>  create mode 100644 arch/arm64/configs/angler_defconfig
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 515e669..f253f60d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -98,6 +98,19 @@ config MACH_LGE
>  	help
>  	  This enables support for the LGE Nexus 5X - BullHead MSM8992.
>  
> +config ARCH_MSM8994
> +	bool "Qualcomm MSM8994"
> +	depends on ARCH_QCOM
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  This enables support for the Qualcomm MSM8994
> +
> +config MACH_HUAWEI
> +	bool "Huawei Angler (MSM8994)"
> +	depends on ARCH_QCOM
> +	help
> +	  This enables support for the Huawei Nexus 6P - Angler MSM8994.

Remove both of these.  We aren't adding more ARCHs or machs.


> +
>  config ARCH_ROCKCHIP
>  	bool "Rockchip Platforms"
>  	select ARCH_HAS_RESET_CONTROLLER
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index bde90fb..d199f8b 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -9,6 +9,7 @@ dts-dirs += cavium
>  dts-dirs += exynos
>  dts-dirs += freescale
>  dts-dirs += hisilicon
> +dts-dirs += huawei
>  dts-dirs += marvell
>  dts-dirs += mediatek
>  dts-dirs += nvidia
> diff --git a/arch/arm64/boot/dts/huawei/Makefile b/arch/arm64/boot/dts/huawei/Makefile
> new file mode 100644
> index 0000000..4b31ff4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/huawei/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_MACH_HUAWEI) += msm8994-angler-rev-101.dtb
> +
> +always          := $(dtb-y)
> +subdir-y        := $(dts-dirs)
> +clean-files     := *.dtb
> diff --git a/arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts b/arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts
> new file mode 100644
> index 0000000..07a71d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts
> @@ -0,0 +1,41 @@
> +/* Copyright (c) 2015, Huawei Inc. All rights reserved.
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include "../qcom/msm8994-v2.0.dtsi"
> +
> +/ {
> +	model = "HUAWEI MSM8994 ANGLER rev-1.01";
> +	compatible = "qcom,msm8994";
> +	qcom,board-id= <8026 0>;
> +};
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	soc {
> +		serial at f991e000 {
> +			status = "okay";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp1_uart2_default>;
> +			pinctrl-1 = <&blsp1_uart2_sleep>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
> new file mode 100644
> index 0000000..0e4eea0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +&msmgpio {
> +	blsp1_uart2_default: blsp1_uart2_default {
> +		pinmux {
> +			function = "blsp_uart2";
> +			pins = "gpio4", "gpio5";
> +		};
> +		pinconf {
> +			pins = "gpio4", "gpio5";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart2_sleep: blsp1_uart2_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio4", "gpio5";
> +		};
> +		pinconf {
> +			pins = "gpio4", "gpio5";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi b/arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
> new file mode 100644
> index 0000000..8fc4c41f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
> @@ -0,0 +1,31 @@
> +/* Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/*
> + * As a general rule, only version-specific property overrides should be placed
> + * inside this file. Device definitions should be placed inside the msm8994.dtsi
> + * file.
> + */
> +
> +#include "msm8994.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM 8994v2.0";
> +	compatible = "qcom,msm8994";
> +	qcom,msm-id = <207 0x20000>;

Drop the msm-id

> +
> +};
> +
> +/* Clock driver overrides */
> +&clock_gcc {
> +	compatible = "qcom,gcc-8994v2";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> new file mode 100644
> index 0000000..c95cb73
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -0,0 +1,237 @@
> +/* Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/memreserve/ 0x00000000 0x00001000;
> +/memreserve/ 0xac1c0000 0x00001000;

So the 0x00000000 is totally bogus.  And the 0xac1c0000 needs to move to a
reserved area lower in the dts.

> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8994.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM 8994";
> +	compatible = "qcom,msm8994";
> +	qcom,msm-id = <207 0x0>;
> +	qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;

kill the ids 

> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +			};
> +		};
> +
> +		CPU0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0>;
> +			next-level-cache = <&L2_0>;
> +			// The currents(uA) correspond to the frequencies in the
> +			// frequency table.
> +			current = < 24140 //384000 kHZ
> +				    27200 //460800 kHZ
> +				    32300 //600000 kHZ
> +				    36940 //672000 kHz
> +				    41570 //768000 kHZ
> +				    49870 //864000 kHZ
> +				    57840 //960000 kHZ
> +				    79800 //1248000 kHZ
> +				    88810 //1344000 kHZ
> +				    102400 //1478400 kHZ
> +				    110900>; //1555200 kHZ
> +			L2_0: l2-cache {
> +			      compatible = "cache";
> +			      cache-level = <2>;
> +			};
> +		};
> +	};
> +
> +	soc: soc { };
> +
> +	memory {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0 0 0 0>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

Move that reserve down here and make it no-map.

> +
> +		smem_mem: smem_region at 0x6a00000 {
> +			reg = <0x0 0x6a00000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&soc {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0 0 0 0xffffffff>;
> +	compatible = "simple-bus";
> +
> +	intc: interrupt-controller at f9000000 {
> +		compatible = "qcom,msm-qgic2";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = <0xf9000000 0x1000>,
> +			  <0xf9002000 0x1000>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 2 0xff08>,
> +			     <1 3 0xff08>,
> +			     <1 4 0xff08>,
> +			     <1 1 0xff08>;
> +		clock-frequency = <19200000>;
> +	};
> +
> +	timer at f9020000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		compatible = "arm,armv7-timer-mem";
> +		reg = <0xf9020000 0x1000>;
> +		clock-frequency = <19200000>;
> +
> +		frame at f9021000 {
> +			frame-number = <0>;
> +			interrupts = <0 9 0x4>,
> +				     <0 8 0x4>;
> +			reg = <0xf9021000 0x1000>,
> +			      <0xf9022000 0x1000>;
> +		};
> +
> +		frame at f9023000 {
> +			frame-number = <1>;
> +			interrupts = <0 10 0x4>;
> +			reg = <0xf9023000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		frame at f9024000 {
> +			frame-number = <2>;
> +			interrupts = <0 11 0x4>;
> +			reg = <0xf9024000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		frame at f9025000 {
> +			frame-number = <3>;
> +			interrupts = <0 12 0x4>;
> +			reg = <0xf9025000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		frame at f9026000 {
> +			frame-number = <4>;
> +			interrupts = <0 13 0x4>;
> +			reg = <0xf9026000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		frame at f9027000 {
> +			frame-number = <5>;
> +			interrupts = <0 14 0x4>;
> +			reg = <0xf9027000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		frame at f9028000 {
> +			frame-number = <6>;
> +			interrupts = <0 15 0x4>;
> +			reg = <0xf9028000 0x1000>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	restart at fc4ab000 {
> +		compatible = "qcom,pshold";
> +		reg = <0xfc4ab000 0x4>;
> +	};
> +
> +	msmgpio: pinctrl at fd510000 {
> +		compatible = "qcom,msm8994-pinctrl", "qcom,msm8974-pinctrl";
> +		reg = <0xfd510000 0x4000>;
> +		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	blsp1_uart2: serial at f991e000 {
> +		compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +		reg = <0xf991e000 0x1000>;
> +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +		clock-names = "core", "iface";
> +		clocks = <&clock_gcc GCC_BLSP1_UART2_APPS_CLK>,
> +			 <&clock_gcc GCC_BLSP1_AHB_CLK>;
> +	};
> +
> +	clocks {
> +		xo_board: xo_board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +
> +		sleep_clk: sleep_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +	};
> +
> +	tcsr_mutex_regs: syscon at fd484000 {
> +		compatible = "syscon";
> +		reg = <0xfd484000 0x2000>;
> +	};
> +
> +	tcsr_mutex: hwlock {
> +		compatible = "qcom,tcsr-mutex";
> +		syscon = <&tcsr_mutex_regs 0 0x80>;
> +		#hwlock-cells = <1>;
> +	};
> +
> +	qcom,smem at 6a00000 {
> +		compatible = "qcom,smem";
> +
> +		memory-region = <&smem_mem>;
> +
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
> +	clock_gcc: qcom,gcc at fc400000 {
> +		compatible = "qcom,gcc-8994";
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +		#power-domain-cells = <1>;
> +		reg = <0xfc400000 0x2000>;
> +	};
> +
> +};
> +
> +#include "msm8994-pins.dtsi"
> diff --git a/arch/arm64/configs/angler_defconfig b/arch/arm64/configs/angler_defconfig
> new file mode 100644
> index 0000000..00cf192
> --- /dev/null
> +++ b/arch/arm64/configs/angler_defconfig
> @@ -0,0 +1,666 @@
> +CONFIG_AUDIT=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IRQ_TIME_ACCOUNTING=y
> +CONFIG_RCU_FAST_NO_HZ=y
> +CONFIG_LOG_BUF_SHIFT=20
> +CONFIG_CGROUPS=y
> +CONFIG_CGROUP_DEBUG=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_RESOURCE_COUNTERS=y
> +CONFIG_CGROUP_SCHED=y
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_RT_GROUP_SCHED=y
> +CONFIG_SCHED_HMP=y
> +CONFIG_NAMESPACES=y
> +# CONFIG_UTS_NS is not set
> +# CONFIG_PID_NS is not set
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_PANIC_TIMEOUT=5
> +CONFIG_KALLSYMS_ALL=y
> +# CONFIG_PCI_QUIRKS is not set
> +CONFIG_EMBEDDED=y
> +# CONFIG_SLUB_DEBUG is not set
> +CONFIG_PROFILING=y
> +CONFIG_PARTITION_ADVANCED=y
> +CONFIG_ARCH_MSM=y
> +CONFIG_ARCH_MSM8994=y
> +CONFIG_ARCH_MSM8994_V1_TLBI_WA=y
> +CONFIG_PCI_MSM=y
> +CONFIG_ARM64_A57_ERRATA_832075=y
> +CONFIG_SMP=y
> +CONFIG_SCHED_MC=y
> +CONFIG_ARCH_WANTS_CTXSW_LOGGING=y
> +CONFIG_PREEMPT=y
> +CONFIG_ARMV7_COMPAT=y
> +CONFIG_BALANCE_ANON_FILE_RECLAIM=y
> +CONFIG_ZSMALLOC=y
> +CONFIG_SECCOMP=y
> +CONFIG_BUILD_ARM64_APPENDED_DTB_IMAGE=y
> +# CONFIG_COREDUMP is not set
> +CONFIG_COMPAT=y
> +CONFIG_PM_AUTOSLEEP=y
> +CONFIG_PM_WAKELOCKS=y
> +CONFIG_PM_WAKELOCKS_LIMIT=0
> +CONFIG_PM_RUNTIME=y
> +CONFIG_SUSPEND_TIME=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_INTERACTIVE=y
> +CONFIG_CPU_BOOST=y
> +CONFIG_CPU_IDLE=y
> +CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=y
> +# CONFIG_CPU_IDLE_GOV_LADDER is not set
> +# CONFIG_CPU_IDLE_GOV_MENU is not set
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_XFRM_USER=y
> +CONFIG_XFRM_STATISTICS=y
> +CONFIG_NET_KEY=y
> +CONFIG_INET=y
> +CONFIG_IP_ADVANCED_ROUTER=y
> +CONFIG_IP_MULTIPLE_TABLES=y
> +CONFIG_IP_ROUTE_VERBOSE=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_INET_AH=y
> +CONFIG_INET_ESP=y
> +CONFIG_INET_IPCOMP=y
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_LRO is not set
> +CONFIG_IPV6_PRIVACY=y
> +CONFIG_IPV6_ROUTER_PREF=y
> +CONFIG_IPV6_ROUTE_INFO=y
> +CONFIG_IPV6_OPTIMISTIC_DAD=y
> +CONFIG_INET6_AH=y
> +CONFIG_INET6_ESP=y
> +CONFIG_INET6_IPCOMP=y
> +CONFIG_IPV6_MIP6=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_IPV6_SUBTREES=y
> +CONFIG_NETFILTER=y
> +CONFIG_NF_CONNTRACK=y
> +CONFIG_NF_CONNTRACK_EVENTS=y
> +CONFIG_NF_CT_PROTO_DCCP=y
> +CONFIG_NF_CT_PROTO_SCTP=y
> +CONFIG_NF_CT_PROTO_UDPLITE=y
> +CONFIG_NF_CONNTRACK_AMANDA=y
> +CONFIG_NF_CONNTRACK_FTP=y
> +CONFIG_NF_CONNTRACK_H323=y
> +CONFIG_NF_CONNTRACK_IRC=y
> +CONFIG_NF_CONNTRACK_NETBIOS_NS=y
> +CONFIG_NF_CONNTRACK_PPTP=y
> +CONFIG_NF_CONNTRACK_SANE=y
> +CONFIG_NF_CONNTRACK_SIP=y
> +CONFIG_NF_CONNTRACK_TFTP=y
> +CONFIG_NF_CT_NETLINK=y
> +CONFIG_NETFILTER_TPROXY=y
> +CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
> +CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
> +CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
> +CONFIG_NETFILTER_XT_TARGET_HARDIDLETIMER=y
> +CONFIG_NETFILTER_XT_TARGET_LOG=y
> +CONFIG_NETFILTER_XT_TARGET_MARK=y
> +CONFIG_NETFILTER_XT_TARGET_NFLOG=y
> +CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
> +CONFIG_NETFILTER_XT_TARGET_NOTRACK=y
> +CONFIG_NETFILTER_XT_TARGET_TEE=y
> +CONFIG_NETFILTER_XT_TARGET_TPROXY=y
> +CONFIG_NETFILTER_XT_TARGET_TRACE=y
> +CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
> +CONFIG_NETFILTER_XT_MATCH_COMMENT=y
> +CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
> +CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
> +CONFIG_NETFILTER_XT_MATCH_DSCP=y
> +CONFIG_NETFILTER_XT_MATCH_ESP=y
> +CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
> +CONFIG_NETFILTER_XT_MATCH_HELPER=y
> +CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
> +CONFIG_NETFILTER_XT_MATCH_LENGTH=y
> +CONFIG_NETFILTER_XT_MATCH_LIMIT=y
> +CONFIG_NETFILTER_XT_MATCH_MAC=y
> +CONFIG_NETFILTER_XT_MATCH_MARK=y
> +CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
> +CONFIG_NETFILTER_XT_MATCH_POLICY=y
> +CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
> +CONFIG_NETFILTER_XT_MATCH_QTAGUID=y
> +CONFIG_NETFILTER_XT_MATCH_QUOTA=y
> +CONFIG_NETFILTER_XT_MATCH_QUOTA2=y
> +CONFIG_NETFILTER_XT_MATCH_QUOTA2_LOG=y
> +CONFIG_NETFILTER_XT_MATCH_SOCKET=y
> +CONFIG_NETFILTER_XT_MATCH_STATE=y
> +CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
> +CONFIG_NETFILTER_XT_MATCH_STRING=y
> +CONFIG_NETFILTER_XT_MATCH_TIME=y
> +CONFIG_NETFILTER_XT_MATCH_U32=y
> +CONFIG_NF_CONNTRACK_IPV4=y
> +CONFIG_IP_NF_IPTABLES=y
> +CONFIG_IP_NF_MATCH_AH=y
> +CONFIG_IP_NF_MATCH_ECN=y
> +CONFIG_IP_NF_MATCH_TTL=y
> +CONFIG_IP_NF_FILTER=y
> +CONFIG_IP_NF_TARGET_REJECT=y
> +CONFIG_IP_NF_TARGET_REJECT_SKERR=y
> +CONFIG_NF_NAT_IPV4=y
> +CONFIG_IP_NF_TARGET_MASQUERADE=y
> +CONFIG_IP_NF_TARGET_NETMAP=y
> +CONFIG_IP_NF_TARGET_REDIRECT=y
> +CONFIG_IP_NF_MANGLE=y
> +CONFIG_IP_NF_RAW=y
> +CONFIG_IP_NF_SECURITY=y
> +CONFIG_IP_NF_ARPTABLES=y
> +CONFIG_IP_NF_ARPFILTER=y
> +CONFIG_IP_NF_ARP_MANGLE=y
> +CONFIG_NF_CONNTRACK_IPV6=y
> +CONFIG_IP6_NF_IPTABLES=y
> +CONFIG_IP6_NF_FILTER=y
> +CONFIG_IP6_NF_TARGET_REJECT=y
> +CONFIG_IP6_NF_TARGET_REJECT_SKERR=y
> +CONFIG_IP6_NF_MANGLE=y
> +CONFIG_IP6_NF_RAW=y
> +CONFIG_BRIDGE_NF_EBTABLES=y
> +CONFIG_BRIDGE_EBT_BROUTE=y
> +CONFIG_L2TP=y
> +CONFIG_L2TP_DEBUGFS=y
> +CONFIG_L2TP_V3=y
> +CONFIG_L2TP_IP=y
> +CONFIG_L2TP_ETH=y
> +CONFIG_BRIDGE=y
> +CONFIG_NET_SCHED=y
> +CONFIG_NET_SCH_HTB=y
> +CONFIG_NET_SCH_PRIO=y
> +CONFIG_NET_CLS_FW=y
> +CONFIG_NET_CLS_U32=y
> +CONFIG_CLS_U32_MARK=y
> +CONFIG_NET_CLS_FLOW=y
> +CONFIG_NET_EMATCH=y
> +CONFIG_NET_EMATCH_CMP=y
> +CONFIG_NET_EMATCH_NBYTE=y
> +CONFIG_NET_EMATCH_U32=y
> +CONFIG_NET_EMATCH_META=y
> +CONFIG_NET_EMATCH_TEXT=y
> +CONFIG_NET_CLS_ACT=y
> +CONFIG_RMNET_DATA=y
> +CONFIG_RMNET_DATA_FC=y
> +CONFIG_RMNET_DATA_DEBUG_PKT=y
> +CONFIG_SOCKEV_NLMCAST=y
> +CONFIG_BT=y
> +CONFIG_BT_RFCOMM=y
> +CONFIG_BT_RFCOMM_TTY=y
> +CONFIG_BT_BNEP=y
> +CONFIG_BT_BNEP_MC_FILTER=y
> +CONFIG_BT_BNEP_PROTO_FILTER=y
> +CONFIG_BT_HIDP=y
> +CONFIG_MSM_BT_BLUESLEEP=y
> +CONFIG_CFG80211=y
> +CONFIG_CFG80211_INTERNAL_REGDB=y
> +CONFIG_RFKILL=y
> +CONFIG_NFC=y
> +CONFIG_NFC_PN548=y
> +CONFIG_IPC_ROUTER=y
> +CONFIG_IPC_ROUTER_SECURITY=y
> +CONFIG_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=32
> +CONFIG_ARM_CCI=y
> +CONFIG_ZRAM=y
> +CONFIG_ZRAM_LZ4_COMPRESS=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_UID_STAT=y
> +CONFIG_QSEECOM=y
> +CONFIG_TI_DRV2667=y
> +CONFIG_UID_CPUTIME=y
> +CONFIG_WIFI_SAR=y
> +CONFIG_SCSI=y
> +CONFIG_SCSI_TGT=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_CHR_DEV_SG=y
> +CONFIG_SCSI_MULTI_LUN=y
> +CONFIG_SCSI_CONSTANTS=y
> +CONFIG_SCSI_LOGGING=y
> +CONFIG_SCSI_SCAN_ASYNC=y
> +# CONFIG_SCSI_LOWLEVEL is not set
> +CONFIG_MD=y
> +CONFIG_BLK_DEV_DM=y
> +CONFIG_DM_CRYPT=y
> +CONFIG_DM_REQ_CRYPT=y
> +CONFIG_DM_VERITY=y
> +CONFIG_NETDEVICES=y
> +CONFIG_DUMMY=y
> +CONFIG_TUN=y
> +# CONFIG_ETHERNET is not set
> +CONFIG_PPP=y
> +CONFIG_PPP_BSDCOMP=y
> +CONFIG_PPP_DEFLATE=y
> +CONFIG_PPP_FILTER=y
> +CONFIG_PPP_MPPE=y
> +CONFIG_PPP_MULTILINK=y
> +CONFIG_PPPOE=y
> +CONFIG_PPPOL2TP=y
> +CONFIG_PPPOLAC=y
> +CONFIG_PPPOPNS=y
> +CONFIG_PPP_ASYNC=y
> +CONFIG_PPP_SYNC_TTY=y
> +CONFIG_USB_KAWETH=y
> +CONFIG_USB_PEGASUS=y
> +CONFIG_USB_RTL8150=y
> +CONFIG_USB_RTL8152=y
> +CONFIG_USB_USBNET=y
> +# CONFIG_USB_NET_CDC_NCM is not set
> +# CONFIG_USB_NET_NET1080 is not set
> +# CONFIG_USB_NET_CDC_SUBSET is not set
> +# CONFIG_USB_NET_ZAURUS is not set
> +CONFIG_CLD_LL_CORE=y
> +CONFIG_BCMDHD=y
> +CONFIG_BCMDHD_PCIE=y
> +CONFIG_BCM4358=y
> +CONFIG_BCMDHD_FW_PATH="/vendor/firmware/fw_bcmdhd.bin"
> +CONFIG_DHD_USE_STATIC_BUF=y
> +CONFIG_DHD_USE_SCHED_SCAN=y
> +CONFIG_DHD_OF_SUPPORT=y
> +# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> +CONFIG_INPUT_EVDEV=y
> +# CONFIG_KEYBOARD_ATKBD is not set
> +CONFIG_KEYBOARD_GPIO=y
> +# CONFIG_INPUT_MOUSE is not set
> +CONFIG_INPUT_JOYSTICK=y
> +CONFIG_JOYSTICK_XPAD=y
> +CONFIG_JOYSTICK_XPAD_FF=y
> +CONFIG_JOYSTICK_XPAD_LEDS=y
> +CONFIG_INPUT_TABLET=y
> +CONFIG_TABLET_USB_ACECAD=y
> +CONFIG_TABLET_USB_AIPTEK=y
> +CONFIG_TABLET_USB_GTCO=y
> +CONFIG_TABLET_USB_HANWANG=y
> +CONFIG_TABLET_USB_KBTAB=y
> +CONFIG_TABLET_USB_WACOM=y
> +CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_DEVICETREE_SUPPORT=y
> +# CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_PROXIMITY is not set
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_BINARY_FW_UPGRADE=y
> +CONFIG_TOUCHSCREEN_HUAWEI_CYTTSP4_RECOVERY_FW_UPDATE=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_MANUAL_TTCONFIG_UPGRADE=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_USE_FW_BIN_FILE=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_DEVICE_ACCESS=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_LOADER=y
> +CONFIG_TOUCHSCREEN_CYPRESS_CYTTSP4_DEBUG_MODULE=y
> +CONFIG_TOUCHSCREEN_GEN_VKEYS=y
> +CONFIG_SECURE_TOUCH=y
> +CONFIG_TOUCHSCREEN_HUAWEI_SYNAPTICS_DSX_v25=y
> +CONFIG_TOUCHSCREEN_SYNAPTICS_DSX25=y
> +CONFIG_TOUCHSCREEN_SYNAPTICS_DSX25_CORE=y
> +CONFIG_TOUCHSCREEN_SYNAPTICS_DSX25_RMI_DEV=y
> +CONFIG_TOUCHSCREEN_SYNAPTICS_DSX25_FW_UPDATE=y
> +CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_KEYCHORD=y
> +CONFIG_INPUT_UINPUT=y
> +CONFIG_INPUT_GPIO=y
> +CONFIG_LASER_STMVL6180=y
> +CONFIG_RF_DETECT=y
> +# CONFIG_SERIO is not set
> +CONFIG_FINGERPRINT_FPC=y
> +# CONFIG_VT is not set
> +# CONFIG_LEGACY_PTYS is not set
> +# CONFIG_DEVMEM is not set
> +# CONFIG_DEVKMEM is not set
> +CONFIG_SERIAL_MSM_HS=y
> +CONFIG_SERIAL_MSM_HSL=y
> +CONFIG_SERIAL_MSM_HSL_CONSOLE=y
> +CONFIG_SERIAL_MSM_SMD=y
> +CONFIG_HW_RANDOM_MSM=y
> +CONFIG_MSM_SMD_PKT=y
> +CONFIG_MSM_ADSPRPC=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MSM_V2=y
> +CONFIG_SLIMBUS_MSM_NGD=y
> +CONFIG_SPI=y
> +CONFIG_SPI_CONTEXTHUB=y
> +CONFIG_SPI_QUP=y
> +CONFIG_SPMI=y
> +CONFIG_SPMI_MSM_PMIC_ARB=y
> +CONFIG_MSM_QPNP_INT=y
> +CONFIG_USE_PINCTRL_IRQ=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_QPNP_PIN=y
> +CONFIG_SMB349_DUAL_CHARGER=y
> +CONFIG_SMB1351_USB_CHARGER=y
> +CONFIG_QPNP_SMBCHARGER=y
> +CONFIG_QPNP_FG=y
> +CONFIG_BATTERY_BCL=y
> +CONFIG_MSM_BCL_CTL=y
> +CONFIG_MSM_BCL_PERIPHERAL_CTL=y
> +CONFIG_POWER_RESET_MSM=y
> +CONFIG_MSM_DLOAD_MODE=y
> +CONFIG_MSM_PM=y
> +CONFIG_APSS_CORE_EA=y
> +CONFIG_SENSORS_EPM_ADC=y
> +CONFIG_SENSORS_QPNP_ADC_VOLTAGE=y
> +CONFIG_THERMAL=y
> +CONFIG_THERMAL_TSENS8974=y
> +CONFIG_LIMITS_MONITOR=y
> +CONFIG_LIMITS_LITE_HW=y
> +CONFIG_THERMAL_MONITOR=y
> +CONFIG_THERMAL_QPNP=y
> +CONFIG_THERMAL_QPNP_ADC_TM=y
> +CONFIG_WCD9330_CODEC=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_PROXY_CONSUMER=y
> +CONFIG_REGULATOR_MEM_ACC=y
> +CONFIG_REGULATOR_TPS65132=y
> +CONFIG_REGULATOR_STUB=y
> +CONFIG_REGULATOR_RPM_SMD=y
> +CONFIG_REGULATOR_QPNP=y
> +CONFIG_REGULATOR_QPNP_LABIBB=y
> +CONFIG_REGULATOR_SPM=y
> +CONFIG_REGULATOR_CPR=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_RADIO_SUPPORT=y
> +CONFIG_MEDIA_CONTROLLER=y
> +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> +CONFIG_VIDEOBUF2_MSM_MEM=y
> +CONFIG_MEDIA_USB_SUPPORT=y
> +CONFIG_USB_VIDEO_CLASS=y
> +# CONFIG_USB_GSPCA is not set
> +CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_MSMB_CAMERA=y
> +CONFIG_MSM_CAMERA_SENSOR=y
> +CONFIG_MSM_CPP=y
> +CONFIG_MSM_CCI=y
> +CONFIG_MSM_CSI30_HEADER=y
> +CONFIG_MSM_CSIPHY=y
> +CONFIG_MSM_CSID=y
> +CONFIG_MSM_EEPROM=y
> +CONFIG_MSM_ISPIF=y
> +CONFIG_HI256=y
> +CONFIG_MT9M114=y
> +CONFIG_MSM_V4L2_VIDEO_OVERLAY_DEVICE=y
> +CONFIG_MSMB_JPEG=y
> +CONFIG_MSM_FD=y
> +CONFIG_MSM_VIDC_V4L2=y
> +CONFIG_TSPP=y
> +# CONFIG_RADIO_ADAPTERS is not set
> +# CONFIG_VGA_ARB is not set
> +CONFIG_MSM_KGSL=y
> +CONFIG_KGSL_PER_PROCESS_PAGE_TABLE=y
> +CONFIG_FB=y
> +CONFIG_FB_MSM=y
> +CONFIG_FB_MSM_MDSS=y
> +CONFIG_FB_MSM_MDSS_WRITEBACK=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_MPU401=y
> +# CONFIG_SND_PCI is not set
> +# CONFIG_SND_SPI is not set
> +CONFIG_SND_USB_AUDIO=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_MSM8994=y
> +CONFIG_SND_SOC_MAX98925=y
> +CONFIG_HID_BATTERY_STRENGTH=y
> +CONFIG_HIDRAW=y
> +CONFIG_UHID=y
> +CONFIG_HID_A4TECH=y
> +CONFIG_HID_APPLE=y
> +CONFIG_HID_BELKIN=y
> +CONFIG_HID_CHERRY=y
> +CONFIG_HID_CHICONY=y
> +CONFIG_HID_PRODIKEYS=y
> +CONFIG_HID_CYPRESS=y
> +CONFIG_HID_ELECOM=y
> +CONFIG_HID_EZKEY=y
> +CONFIG_HID_HOLTEK=y
> +CONFIG_HOLTEK_FF=y
> +CONFIG_HID_KEYTOUCH=y
> +CONFIG_HID_KYE=y
> +CONFIG_HID_UCLOGIC=y
> +CONFIG_HID_WALTOP=y
> +CONFIG_HID_GYRATION=y
> +CONFIG_HID_ICADE=y
> +CONFIG_HID_KENSINGTON=y
> +CONFIG_HID_LCPOWER=y
> +CONFIG_HID_LENOVO_TPKBD=y
> +CONFIG_HID_LOGITECH=y
> +CONFIG_HID_LOGITECH_DJ=y
> +CONFIG_LOGITECH_FF=y
> +CONFIG_LOGIRUMBLEPAD2_FF=y
> +CONFIG_LOGIG940_FF=y
> +CONFIG_HID_MAGICMOUSE=y
> +CONFIG_HID_MICROSOFT=y
> +CONFIG_HID_MONTEREY=y
> +CONFIG_HID_MULTITOUCH=y
> +CONFIG_HID_NTRIG=y
> +CONFIG_HID_ORTEK=y
> +CONFIG_HID_PANTHERLORD=y
> +CONFIG_PANTHERLORD_FF=y
> +CONFIG_HID_PRIMAX=y
> +CONFIG_HID_PS3REMOTE=y
> +CONFIG_HID_ROCCAT=y
> +CONFIG_HID_SAITEK=y
> +CONFIG_HID_SAMSUNG=y
> +CONFIG_HID_SONY=y
> +CONFIG_HID_SPEEDLINK=y
> +CONFIG_HID_STEELSERIES=y
> +CONFIG_HID_SUNPLUS=y
> +CONFIG_HID_SMARTJOYPLUS=y
> +CONFIG_SMARTJOYPLUS_FF=y
> +CONFIG_HID_TOPSEED=y
> +CONFIG_HID_THINGM=y
> +CONFIG_HID_THRUSTMASTER=y
> +CONFIG_THRUSTMASTER_FF=y
> +CONFIG_HID_WACOM=y
> +CONFIG_HID_WIIMOTE=y
> +CONFIG_HID_ZEROPLUS=y
> +CONFIG_ZEROPLUS_FF=y
> +CONFIG_HID_SENSOR_HUB=y
> +CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_EHSET=y
> +CONFIG_USB_EHCI_MSM=y
> +CONFIG_USB_ACM=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_SERIAL=y
> +CONFIG_USB_SERIAL_GENERIC=y
> +CONFIG_USB_SERIAL_FTDI_SIO=y
> +CONFIG_USB_SERIAL_PL2303=y
> +CONFIG_USB_EMI62=y
> +CONFIG_USB_EMI26=y
> +CONFIG_USB_EHSET_TEST_FIXTURE=y
> +CONFIG_USB_PHY=y
> +CONFIG_USB_MSM_SSPHY_QMP=y
> +CONFIG_MSM_QUSB_PHY=y
> +CONFIG_DUAL_ROLE_USB_INTF=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DEBUG_FILES=y
> +CONFIG_USB_GADGET_DEBUG_FS=y
> +CONFIG_USB_CI13XXX_MSM=y
> +CONFIG_USB_DWC3_MSM=y
> +CONFIG_USB_G_ANDROID=y
> +CONFIG_TYPEC=y
> +CONFIG_TUSB320_TYPEC=y
> +CONFIG_MMC=y
> +CONFIG_MMC_PERF_PROFILING=y
> +CONFIG_MMC_UNSAFE_RESUME=y
> +CONFIG_MMC_CLKGATE=y
> +CONFIG_MMC_PARANOID_SD_INIT=y
> +CONFIG_MMC_BLOCK_MINORS=32
> +CONFIG_MMC_TEST=y
> +CONFIG_MMC_BLOCK_TEST=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_LEDS_QPNP=y
> +CONFIG_LEDS_QPNP_FLASH=y
> +CONFIG_LEDS_QPNP_WLED=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> +CONFIG_SWITCH=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_QPNP=y
> +CONFIG_DMADEVICES=y
> +CONFIG_QCOM_SPS_DMA=y
> +CONFIG_UIO=y
> +CONFIG_UIO_MSM_SHAREDMEM=y
> +CONFIG_STAGING=y
> +CONFIG_ANDROID=y
> +CONFIG_ANDROID_BINDER_IPC=y
> +CONFIG_ASHMEM=y
> +CONFIG_ANDROID_LOGGER=y
> +CONFIG_ANDROID_LOW_MEMORY_KILLER=y
> +CONFIG_ANDROID_INTF_ALARM_DEV=y
> +CONFIG_ONESHOT_SYNC=y
> +CONFIG_ION=y
> +CONFIG_ION_MSM=y
> +CONFIG_ALLOC_BUFFERS_IN_4K_CHUNKS=y
> +# CONFIG_NET_VENDOR_SILICOM is not set
> +CONFIG_SPS=y
> +CONFIG_USB_BAM=y
> +CONFIG_SPS_SUPPORT_NDP_BAM=y
> +CONFIG_QPNP_POWER_ON=y
> +CONFIG_QPNP_REVID=y
> +CONFIG_QPNP_COINCELL=y
> +CONFIG_QPNP_USB_DETECT=y
> +CONFIG_IPA=y
> +CONFIG_RMNET_IPA=y
> +CONFIG_MSM_AVTIMER=y
> +CONFIG_PFT=y
> +CONFIG_MSM_BUS_SCALING=y
> +CONFIG_MSM_BUSPM_DEV=y
> +CONFIG_BUS_TOPOLOGY_ADHOC=y
> +CONFIG_DEBUG_BUS_VOTER=y
> +CONFIG_QPNP_HAPTIC=y
> +CONFIG_MSM_MDSS_PLL=y
> +CONFIG_REMOTE_SPINLOCK_MSM=y
> +CONFIG_MSM_IOMMU_V1=y
> +CONFIG_MSM_IOMMU_VBIF_CHECK=y
> +CONFIG_IOMMU_FORCE_4K_MAPPINGS=y
> +CONFIG_DEVFREQ_SPDM=y
> +CONFIG_PWM=y
> +CONFIG_PWM_QPNP=y
> +CONFIG_SENSORS_SSC=y
> +CONFIG_GENERIC_PHY=y
> +CONFIG_CP_ACCESS64=y
> +CONFIG_MSM_EVENT_TIMER=y
> +CONFIG_MSM_IPC_ROUTER_SMD_XPRT=y
> +CONFIG_MSM_QMI_INTERFACE=y
> +CONFIG_MSM_SMD_DEBUG=y
> +CONFIG_MSM_RPM_RBCPR_STATS_V2_LOG=y
> +CONFIG_MSM_RPM_LOG=y
> +CONFIG_MSM_RPM_STATS_LOG=y
> +CONFIG_MSM_RUN_QUEUE_STATS=y
> +CONFIG_MSM_SMEM_LOGGING=y
> +CONFIG_MSM_SMP2P=y
> +CONFIG_MSM_SMP2P_TEST=y
> +CONFIG_MSM_SPM=y
> +CONFIG_MSM_L2_SPM=y
> +CONFIG_MSM_ADSP_LOADER=y
> +CONFIG_MSM_MEMORY_DUMP_V2=y
> +CONFIG_MSM_DEBUG_LAR_UNLOCK=y
> +CONFIG_MSM_DDR_HEALTH=y
> +CONFIG_MSM_COMMON_LOG=y
> +CONFIG_MSM_WATCHDOG_V2=y
> +CONFIG_MSM_FORCE_WDOG_BITE_ON_PANIC=y
> +CONFIG_MSM_HVC=y
> +CONFIG_MSM_SUBSYSTEM_RESTART=y
> +CONFIG_MSM_SYSMON_COMM=y
> +CONFIG_MSM_PIL=y
> +CONFIG_MSM_PIL_SSR_GENERIC=y
> +CONFIG_MSM_PIL_MSS_QDSP6V5=y
> +CONFIG_MSM_OCMEM=y
> +CONFIG_MSM_OCMEM_LOCAL_POWER_CTRL=y
> +CONFIG_MSM_OCMEM_DEBUG=y
> +CONFIG_MSM_BOOT_STATS=y
> +CONFIG_MSM_SCM=y
> +CONFIG_MSM_XPU_ERR_FATAL=y
> +CONFIG_MSM_CPUSS_DUMP=y
> +CONFIG_MSM_SHARED_HEAP_ACCESS=y
> +CONFIG_MSM_SYSTEM_HEALTH_MONITOR=y
> +CONFIG_QCOM_EARLY_RANDOM=y
> +CONFIG_MSM_PERFORMANCE=y
> +CONFIG_QCOM_NPA_DUMP=y
> +CONFIG_MSM_TZ_LOG=y
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_EXT4_FS_ENCRYPTION=y
> +CONFIG_FUSE_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_PSTORE=y
> +CONFIG_PSTORE_CONSOLE=y
> +CONFIG_PSTORE_PMSG=y
> +CONFIG_PSTORE_RAM=y
> +# CONFIG_NETWORK_FILESYSTEMS is not set
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ASCII=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_UTF8=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_PAGE_OWNER=y
> +# CONFIG_SYSRQ_SCHED_DEBUG is not set
> +CONFIG_SCHEDSTATS=y
> +CONFIG_TIMER_STATS=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_RCU_CPU_STALL_INFO=y
> +CONFIG_RCU_TRACE=y
> +CONFIG_IPC_LOGGING=y
> +CONFIG_BLK_DEV_IO_TRACE=y
> +CONFIG_DYNAMIC_DEBUG=y
> +CONFIG_OOPS_LOG_BUFFER=y
> +CONFIG_LOG_BUF_MAGIC=y
> +CONFIG_OOPS_LOG_BUF_SHIFT=17
> +CONFIG_PANIC_ON_DATA_CORRUPTION=y
> +CONFIG_ARM64_PTDUMP=y
> +CONFIG_PID_IN_CONTEXTIDR=y
> +CONFIG_SECURITY=y
> +CONFIG_SECURITY_NETWORK=y
> +CONFIG_LSM_MMAP_MIN_ADDR=4096
> +CONFIG_SECURITY_SELINUX=y
> +CONFIG_CRYPTO_NULL=y
> +CONFIG_CRYPTO_XCBC=y
> +CONFIG_CRYPTO_MD4=y
> +CONFIG_CRYPTO_TWOFISH=y
> +CONFIG_CRYPTO_DEV_QCRYPTO=y
> +CONFIG_CRYPTO_DEV_QCE=y
> +CONFIG_CRYPTO_DEV_QCEDEV=y
> +CONFIG_CRYPTO_DEV_QCOM_ICE=y
> +CONFIG_ASYMMETRIC_KEY_TYPE=y
> +CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> +CONFIG_PUBLIC_KEY_ALGO_RSA=y
> +CONFIG_X509_CERTIFICATE_PARSER=y
> +CONFIG_ARM64_CRYPTO=y
> +CONFIG_CRYPTO_SHA1_ARM64_CE=y
> +CONFIG_CRYPTO_SHA2_ARM64_CE=y
> +CONFIG_CRYPTO_GHASH_ARM64_CE=y
> +CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
> +CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
> +CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
> +CONFIG_QMI_ENCDEC=y
> +CONFIG_STRICT_MEMORY_RWX=y
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_ARCH_QCOM=y
> +CONFIG_QCOM_SMD_RPM=y
> +CONFIG_QCOM_SMEM=y
> +CONFIG_QCOM_SMD=y
> +CONFIG_HWSPINLOCK_QCOM=y
> +CONFIG_QCOM_PM=y
> +CONFIG_SERIAL_MSM=y
> +CONFIG_SERIAL_MSM_CONSOLE=y
> +CONFIG_PINCTRL_MSM8X74=y
> +CONFIG_COMMON_CLK_QCOM=y
> +CONFIG_MSM_GCC_8994=y
> +CONFIG_MACH_HUAWEI=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DMA_CMA=y
> -- 
> 2.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
