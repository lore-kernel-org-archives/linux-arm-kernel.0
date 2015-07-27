From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jul 2015 11:41:40 +0100
Subject: [PATCH v2] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <1437993343-9542-1-git-send-email-ian.campbell@citrix.com>
References: <1437993343-9542-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <20150727104140.GC9169@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 27, 2015 at 11:35:43AM +0100, Ian Campbell wrote:
> Commit 9ccd608070b6 "arm64: dts: add device tree for ARM SMM-A53x2 on
> LogicTile Express 20MG" added a new dts file to arch/arm64 which
> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
> .dtsi supplied by arch/arm.
> 
> Unfortunately this causes some issues for the split device tree
> repository[0], since things get moved around there. In that context
> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
> 
> The sharing of the .dtsi is legitimate since the baseboard is the same
> for various vexpress systems whatever processor they use.
> 
> Rather than using ../../ tricks to pickup .dtsi files from another
> arch this patch creates a new directory include/dt-dtsi as a
> home for such cross-arch .dtsi files, arranges for it to be in the
> include path when the .dts files are processed by cpp and switches the
> .dts files to use cpp #include instead of /include/. The dtsi file
> itself is moved into a vendor subdir in this case "arm" (the vendor,
> not the ARCH=).
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>

I'm happy with the general idea, and having a separate directory for
dtsis, with vendor subdirs makes sense to me. So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kbuild at vger.kernel.org
> ---
> v2: Move to include/dt-dtsi and introduce a per-vendor subdirectory.
> ---
>  Documentation/devicetree/bindings/arm/vexpress.txt               | 4 ++--
>  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts                      | 2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts                       | 2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts                          | 2 +-
>  arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts             | 2 +-
>  {arch/arm/boot/dts => include/dt-dtsi/arm}/vexpress-v2m-rs1.dtsi | 0
>  scripts/Makefile.lib                                             | 1 +
>  7 files changed, 7 insertions(+), 6 deletions(-)
>  rename {arch/arm/boot/dts => include/dt-dtsi/arm}/vexpress-v2m-rs1.dtsi (100%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
> index 39844cd..dccf570 100644
> --- a/Documentation/devicetree/bindings/arm/vexpress.txt
> +++ b/Documentation/devicetree/bindings/arm/vexpress.txt
> @@ -7,7 +7,7 @@ peripherals. Processor and RAM "live" on the tiles.
>  
>  The motherboard and each core tile should be described by a separate
>  Device Tree source file, with the tile's description including
> -the motherboard file using a /include/ directive. As the motherboard
> +the motherboard file using a #include directive. As the motherboard
>  can be initialized in one of two different configurations ("memory
>  maps"), care must be taken to include the correct one.
>  
> @@ -223,7 +223,7 @@ Example of a VE tile description (simplified)
>  		/* Active high IRQ 0 is connected to GIC's SPI0 */
>  		interrupt-map = <0 0 0 &gic 0 0 4>;
>  
> -		/include/ "vexpress-v2m-rs1.dtsi"
> +		#include <arm/vexpress-v2m-rs1.dtsi>
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> index 9420053..7ea7054 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> @@ -278,6 +278,6 @@
>  				<0 0 41 &gic 0 41 4>,
>  				<0 0 42 &gic 0 42 4>;
>  
> -		/include/ "vexpress-v2m-rs1.dtsi"
> +		#include <arm/vexpress-v2m-rs1.dtsi>
>  	};
>  };
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 17f63f7..afe997a4 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -636,6 +636,6 @@
>  				<0 0 41 &gic 0 41 4>,
>  				<0 0 42 &gic 0 42 4>;
>  
> -		/include/ "vexpress-v2m-rs1.dtsi"
> +		#include <arm/vexpress-v2m-rs1.dtsi>
>  	};
>  };
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> index d2709b7..498181c 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> @@ -248,6 +248,6 @@
>  				<0 0 41 &gic 0 41 4>,
>  				<0 0 42 &gic 0 42 4>;
>  
> -		/include/ "vexpress-v2m-rs1.dtsi"
> +		#include <arm/vexpress-v2m-rs1.dtsi>
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> index 5b1d018..b86c5a8 100644
> --- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> @@ -186,6 +186,6 @@
>  				<0 0 41 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
>  				<0 0 42 &gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>  
> -		/include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"
> +		#include <arm/vexpress-v2m-rs1.dtsi>
>  	};
>  };
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/include/dt-dtsi/arm/vexpress-v2m-rs1.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> rename to include/dt-dtsi/arm/vexpress-v2m-rs1.dtsi
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 79e8661..0d948d4 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -163,6 +163,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>  		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
>  		 -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
>  		 -I$(srctree)/drivers/of/testcase-data                   \
> +		 -I$(srctree)/include/dt-dtsi                            \
>  		 -undef -D__DTS__
>  
>  # Finds the multi-part object the current object will be linked into
> -- 
> 2.1.4
> 
