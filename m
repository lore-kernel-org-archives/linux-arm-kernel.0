From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Jul 2015 09:51:03 -0500
Subject: [PATCH v3] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <1438353109-373-1-git-send-email-ian.campbell@citrix.com>
References: <1438353109-373-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <CAL_JsqK6R8wRS1hLJZxn1xvp2iq=2xoNAiVTghPchAEw7qboYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 9:31 AM, Ian Campbell <ian.campbell@citrix.com> wrote:
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

This statement is no longer true.

> itself is moved into a vendor subdir in this case "arm" (the vendor,
> not the ARCH=).
>
> [0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
>
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Rob Herring <robh+dt@kernel.org>

Other than that, Ack.

I'm assuming this will go thru the arm-soc tree.

Rob

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
>
> v3: Move to kernel/dts.
>     Include new directory in DTC include path as well as cpp path, and
>     therefore switch back to /include/.
>     Update MAINTAINERS
> ---
>  Documentation/devicetree/bindings/arm/vexpress.txt          | 2 +-
>  MAINTAINERS                                                 | 1 +
>  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts                 | 2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts                  | 2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts                     | 2 +-
>  arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts        | 2 +-
>  {arch/arm/boot/dts => kernel/dts/arm}/vexpress-v2m-rs1.dtsi | 0
>  scripts/Makefile.lib                                        | 3 ++-
>  8 files changed, 8 insertions(+), 6 deletions(-)
>  rename {arch/arm/boot/dts => kernel/dts/arm}/vexpress-v2m-rs1.dtsi (100%)
>
> diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
> index 39844cd..b6031d9 100644
> --- a/Documentation/devicetree/bindings/arm/vexpress.txt
> +++ b/Documentation/devicetree/bindings/arm/vexpress.txt
> @@ -223,7 +223,7 @@ Example of a VE tile description (simplified)
>                 /* Active high IRQ 0 is connected to GIC's SPI0 */
>                 interrupt-map = <0 0 0 &gic 0 0 4>;
>
> -               /include/ "vexpress-v2m-rs1.dtsi"
> +               /include/ "arm/vexpress-v2m-rs1.dtsi"
>         };
>  };
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a226416..1941078 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7537,6 +7537,7 @@ S:        Maintained
>  F:     Documentation/devicetree/
>  F:     arch/*/boot/dts/
>  F:     include/dt-bindings/
> +F:     kernel/dts/
>
>  OPEN FIRMWARE AND DEVICE TREE OVERLAYS
>  M:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> index 9420053..b144092 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> @@ -278,6 +278,6 @@
>                                 <0 0 41 &gic 0 41 4>,
>                                 <0 0 42 &gic 0 42 4>;
>
> -               /include/ "vexpress-v2m-rs1.dtsi"
> +               /include/ "arm/vexpress-v2m-rs1.dtsi"
>         };
>  };
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 17f63f7..350f402 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -636,6 +636,6 @@
>                                 <0 0 41 &gic 0 41 4>,
>                                 <0 0 42 &gic 0 42 4>;
>
> -               /include/ "vexpress-v2m-rs1.dtsi"
> +               /include/ "arm/vexpress-v2m-rs1.dtsi"
>         };
>  };
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> index d2709b7..585ced0 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> @@ -248,6 +248,6 @@
>                                 <0 0 41 &gic 0 41 4>,
>                                 <0 0 42 &gic 0 42 4>;
>
> -               /include/ "vexpress-v2m-rs1.dtsi"
> +               /include/ "arm/vexpress-v2m-rs1.dtsi"
>         };
>  };
> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> index 5b1d018..c044804 100644
> --- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> @@ -186,6 +186,6 @@
>                                 <0 0 41 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
>                                 <0 0 42 &gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>
> -               /include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"
> +               /include/ "arm/vexpress-v2m-rs1.dtsi"
>         };
>  };
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/kernel/dts/arm/vexpress-v2m-rs1.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> rename to kernel/dts/arm/vexpress-v2m-rs1.dtsi
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 79e8661..b4d9fb6 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -163,6 +163,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                  -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
>                  -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
>                  -I$(srctree)/drivers/of/testcase-data                   \
> +                -I$(srctree)/kernel/dts                                 \
>                  -undef -D__DTS__
>
>  # Finds the multi-part object the current object will be linked into
> @@ -285,7 +286,7 @@ quiet_cmd_dtc = DTC     $@
>  cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>         $(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
>         $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 \
> -               -i $(dir $<) $(DTC_FLAGS) \
> +               -i $(dir $<) -i $(srctree)/kernel/dts $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) ; \
>         cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> --
> 2.1.4
>
