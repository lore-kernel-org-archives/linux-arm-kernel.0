From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 17:25:31 +0000
Subject: [UPDATED] [PATCH 3/5] arm-cci: Get rid of secure transactions
 for PMU driver
In-Reply-To: <1426585901-19137-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-4-git-send-email-suzuki.poulose@arm.com>
 <1426585901-19137-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150319172531.GB10153@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 09:51:41AM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> A minor change, fixed missplled 'DEPRECATED' in the dev_warn().
> 
> Thanks
> Suzuki
> 
> ----8>----
> Avoid secure transactions while probing the CCI PMU. The
> existing code makes use of the Peripheral ID2 (PID2) register
> to determine the revision of the CCI400, which requires a
> secure transaction. This puts a limitation on the usage of the
> driver on systems running non-secure Linux(e.g, ARM64).
> 
> Updated the device-tree binding for cci pmu node to add the explicit
> revision number for the compatible field.
> 
> The supported strings are :
> 	arm,cci-400-pmu,r0
> 	arm,cci-400-pmu,r1
> 	arm,cci-400-pmu - DEPRECATED. See NOTE below
> 
> NOTE: If the revision is not mentioned, we need to probe the cci revision,
> which could be fatal on a platform running non-secure. We need a reliable way
> to know if we can poke the CCI registers at runtime on ARM32. We depend on
> 'mcpm_is_available()' when it is available. mcpm_is_available() returns true
> only when there is a registered driver for mcpm. Otherwise, we assume that we
> don't have secure access, and skips probing the revision number(ARM64 case).
> 
> The MCPM should figure out if it is safe to access the CCI. Unfortunately
> there isn't a reliable way to indicate the same via dtb. This patch doesn't
> address/change the current situation. It only deals with the CCI-PMU, leaving
> the assumptions about the secure access as it has been, prior to this patch.
> 
> Changes since V2:
>  - Use 'bool' instead of 'int' for platform_has_secure_cci_access().
>    (Suggested-by: Sudeep Holla)
> 
> Cc: devicetree at vger.kernel.org
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cci.txt |    7 +++--
>  arch/arm/include/asm/arm-cci.h                |   42 +++++++++++++++++++++++++
>  arch/arm64/include/asm/arm-cci.h              |   27 ++++++++++++++++
>  drivers/bus/arm-cci.c                         |   17 +++++++++-
>  include/linux/arm-cci.h                       |    2 ++
>  5 files changed, 92 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/asm/arm-cci.h
>  create mode 100644 arch/arm64/include/asm/arm-cci.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
> index f28d82b..0e4b6a7 100644
> --- a/Documentation/devicetree/bindings/arm/cci.txt
> +++ b/Documentation/devicetree/bindings/arm/cci.txt
> @@ -94,8 +94,11 @@ specific to ARM.
>  		- compatible
>  			Usage: required
>  			Value type: <string>
> -			Definition: must be "arm,cci-400-pmu"
> -
> +			Definition: Supported strings are :

I'd prefer we said "Must contain one of:".

> +				 "arm,cci-400-pmu,r0"
> +				 "arm,cci-400-pmu,r1"
> +				 "arm,cci-400-pmu"  - DEPRECATED, permitted only where OS has
> +						      secure acces to CCI registers

Otherwise, the binding change looks fine to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com> [DT binding]
