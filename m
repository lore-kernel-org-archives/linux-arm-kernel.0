From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Oct 2015 16:37:50 +0100
Subject: [PATCH] ARM64: dts: vexpress: Use a symlink to
 vexpress-v2m-rs1.dtsi from arch=arm
In-Reply-To: <1444046032-31310-1-git-send-email-ian.campbell@citrix.com>
References: <1444046032-31310-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <20151012153750.GE7452@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 12:53:52PM +0100, Ian Campbell wrote:
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
> Previously I attempted to resolve this by creating a shared location
> for such things but we have been unable to come to a consensus on
> where that should be.
> 
> Instead this patch simply replaces the use of ../../ in the dts
> /include/ with a symlink in arch/arm64/boot/dts/arm pointing to the
> file arch/arm/boot/dts.
> 
> Since the split device tree repo will shortly be required to flatten
> symlinks for other reasons this will cause the dtsi file to appear in
> both src/arm and src/arm64 in the split repo, which is an improvement
> on not building for arm64 now.
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
> Cc: Frank Rowand <frank.rowand@sonymobile.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: arm at kernel.org
> Cc: linux-kbuild at vger.kernel.org
> ---
> For more on flattening symlinks see
> http://thread.gmane.org/gmane.linux.kernel.input/45646/focus=45742
> ---
>  arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 2 +-
>  arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi        | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  create mode 120000 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> index 5b1d018..bb3c26d 100644
> --- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> @@ -186,6 +186,6 @@
>  				<0 0 41 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
>  				<0 0 42 &gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>  
> -		/include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"
> +		/include/ "vexpress-v2m-rs1.dtsi"
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi b/arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
> new file mode 120000
> index 0000000..68fd0f8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
> @@ -0,0 +1 @@
> +../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi
> \ No newline at end of file

I was under the impression that there was some reason symlinks of this
fashion were discouraged, but I don't know the details, and I don't have
strong feelings either way.

This solves a problem, and we don't seem to have a better solution. So
to that end:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
