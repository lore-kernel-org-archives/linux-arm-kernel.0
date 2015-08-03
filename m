From: frowand.list@gmail.com (Frank Rowand)
Date: Mon, 03 Aug 2015 09:47:42 -0700
Subject: [PATCH v5] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <1438618000-1091-1-git-send-email-ian.campbell@citrix.com>
References: <1438618000-1091-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <55BF9B2E.1060206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/3/2015 9:06 AM, Ian Campbell wrote:
> Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
> LogicTile Express 20MG") added a new dts file to arch/arm64 which
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
> arch this patch creates a new directory kernel/dts as a home for such
> cross-arch .dtsi files and arranges for it to be in the include path
> for both dtc and cpp. The dtsi file itself is moved into a vendor
> subdir in this case "arm" (the vendor, not the ARCH=).
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
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
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> v2: Move to include/dt-dtsi and introduce a per-vendor subdirectory.
> 
> v3: Move to kernel/dts.
>     Include new directory in DTC include path as well as cpp path, and
>     therefore switch back to /include/.
>     Update MAINTAINERS
> 
> v4: Change path in changelog too.
>     Add ()s to title of 9ccd608070b6.
> 
> v5: Remove stale reference to switching from /include/ to #include.
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

Reviewed-by: Frank Rowand <frank.rowand@sonymobile.com>
