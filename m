From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Apr 2014 20:53:42 +0100
Subject: [PATCH V2] arm64: Fix PSCI part of booting.txt
In-Reply-To: <1397763592.30572.56.camel@smoke>
References: <1397758623.30572.53.camel@smoke> <1397763592.30572.56.camel@smoke>
Message-ID: <20140417195342.GD24195@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 08:39:52PM +0100, Geoff Levand wrote:
> Correct the PSCI booting text to reflect the requirements
> of the PSCI spec.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> v2: Change to mention online CPUs only.
> 
>  Documentation/arm64/booting.txt | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt
> b/Documentation/arm64/booting.txt
> index beb754e..e5b9c81 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -167,13 +167,12 @@ following manner:
>    value, so CPUs must convert the read value to their native endianness
>    before jumping to it.
>  
> -- CPUs with a "psci" enable method should remain outside of
> -  the kernel (i.e. outside of the regions of memory described to the
> -  kernel in the memory node, or in a reserved area of memory described
> -  to the kernel by a /memreserve/ region in the device tree).  The
> -  kernel will issue CPU_ON calls as described in ARM document number
> ARM
> -  DEN 0022A ("Power State Coordination Interface System Software on ARM
> -  processors") to bring CPUs into the kernel.
> +- CPUs with a "psci" enable method should use the PSCI CPU control
> +  functions described in ARM document number ARM DEN 0022A or newer
> +  ("Power State Coordination Interface System Software on ARM
> +  processors").  The boot loader must power off any of these CPUs that
> +  have been brought online using the PSCI CPU_OFF function.  The kernel
> +  will issue CPU_ON calls to bring CPUs into the kernel.

Can we not just say that the bootloader must ensure these CPUs are in
the OFF state? That covers those onlined then offlined by the bootloader
and any others (which we don't currently define the state of).

Mark.
