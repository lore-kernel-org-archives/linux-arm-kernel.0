From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 10:43:11 +0100
Subject: Conditionals in dtsi files
In-Reply-To: <5645AE7E.4090003@free.fr>
References: <5645AE7E.4090003@free.fr>
Message-ID: <5151887.Q3EmlRO4WY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 10:33:50 Mason wrote:
> Hello,
> 
> I'm wondering how much C preprocessor syntax one can use in DT files.
> 
> Suppose I have 2 board DTS (both including common.dtsi)
> 
> board_A.dts (1-core), board_B.dts (2-core)
> 
> Can I have in common.dtsi something along these lines:
> 
> 	cpus {
> 		enable-method = "foo,bar";
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		cpu0: cpu at 0 {
> 			compatible = "arm,cortex-a9";
> 			device_type = "cpu";
> 			reg = <0>;
> 		};
> 
> #if CORE_COUNT > 1
> 		cpu1: cpu at 1 {
> 			compatible = "arm,cortex-a9";
> 			device_type = "cpu";
> 			reg = <1>;
> 		};
> #endif
> 	};
> 
> 
> board_A.dts would have
> #define CORE_COUNT 1
> #include "common.dtsi"
> 
> board_B.dts would have
> #define CORE_COUNT 2
> #include "common.dtsi"

I would prefer not using any preprocessor statements other than
#include in .dts files. It's easy enough to have a per-soc
.dtsi file that defines the CPU nodes and goes on to include another
.dtsi file with the common parts that are present on all SoCs.

Have a look at how the armada-*.dtsi files handle this.

	Arnd
