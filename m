From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 27 May 2014 12:49:58 +0100
Subject: [PATCH v4 1/5] devicetree: bindings: document Broadcom CPU
 enable method
In-Reply-To: <1400607830-10989-2-git-send-email-elder@linaro.org>
References: <1400607830-10989-1-git-send-email-elder@linaro.org>
 <1400607830-10989-2-git-send-email-elder@linaro.org>
Message-ID: <20140527114958.GC18476@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 06:43:46PM +0100, Alex Elder wrote:
> Broadcom mobile SoCs use a ROM-implemented holding pen for
> controlled boot of secondary cores.  A special register is
> used to communicate to the ROM that a secondary core should
> start executing kernel code.  This enable method is currently
> used for members of the bcm281xx and bcm21664 SoC families.
> 
> The use of an enable method also allows the SMP operation vector to
> be assigned as a result of device tree content for these SoCs.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

This is getting out of control, it is absolutely ghastly. I wonder how
I can manage to keep cpus.txt updated if anyone with a boot method
du jour adds into cpus.txt, and honestly in this specific case it is even
hard to understand why.

Can't it be done with bindings for the relative register address space
(regmap ?) and platform code just calls the registers driver to set-up the
jump address ? It is platform specific code anyway there is no way you
can make this generic.

I really do not see the point in cluttering cpus.txt with this stuff, it
is a platform specific hack, and do not belong in generic bindings in my
opinion.

Thanks,
Lorenzo

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 333f4ae..c6a2411 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -185,6 +185,7 @@ nodes to be present and contain the properties described below.
>  			    "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "brcm,bcm11351-cpu-method"
>  
>  	- cpu-release-addr
>  		Usage: required for systems that have an "enable-method"
> @@ -209,6 +210,17 @@ nodes to be present and contain the properties described below.
>  		Value type: <phandle>
>  		Definition: Specifies the ACC[2] node associated with this CPU.
>  
> +	- secondary-boot-reg
> +		Usage:
> +			Required for systems that have an "enable-method"
> +			property value of "brcm,bcm11351-cpu-method".
> +		Value type: <u32>
> +		Definition:
> +			Specifies the physical address of the register used to
> +			request the ROM holding pen code release a secondary
> +			CPU.  The value written to the register is formed by
> +			encoding the target CPU id into the low bits of the
> +			physical start address it should jump to.
>  
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>  
> -- 
> 1.9.1
> 
> 
