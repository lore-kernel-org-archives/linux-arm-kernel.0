From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Apr 2014 19:37:30 +0100
Subject: [PATCH] arm64: Fix PSCI part of booting.txt
In-Reply-To: <1397758623.30572.53.camel@smoke>
References: <1397758623.30572.53.camel@smoke>
Message-ID: <20140417183730.GB24195@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Thu, Apr 17, 2014 at 07:17:03PM +0100, Geoff Levand wrote:
> Correct the PSCI booting text to match the requirements
> of the PSCI spec.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Will,
> 
> Based on the PSCI doc (DEN 0022B.b), to use CPU_ON the
> cpu can only be powered down with CPU_OFF, and it seems
> from the doc that the code that calls CPU_OFF could be
> anywhere in memory, since once the CPU_OFF call is made
> the cpu is powered off and never executes any more 
> instructions from memory.  CPU_ON is given an
> entry_point_address parameter, which would be specific
> to the code calling CPU_ON.
> 
> Did I misunderstand something, or should we change this
> text as below?

The current wording is my fault and is an artifact of working on the
bootwrapper, where CPUs which are off from the perspective of the PSCI
state machine are actually spinning within the PSCI implementation.

This admittedly is an implementation detail that does not matter to the
kernel, and in a real implementation I would certainly not expect the
CPUs to be spinning in a non-secure pen.

> 
> -Geoff
> 
>  Documentation/arm64/booting.txt | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index beb754e..8f9074f 100644
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
> -  kernel will issue CPU_ON calls as described in ARM document number ARM
> -  DEN 0022A ("Power State Coordination Interface System Software on ARM
> -  processors") to bring CPUs into the kernel.
> +- CPUs with a "psci" enable method should use the PSCI CPU control
> +  functions described in ARM document number ARM DEN 0022A or newer
> +  ("Power State Coordination Interface System Software on ARM
> +  processors").  The boot loader must power off these CPU's using the

Nit: s/CPU's/CPUs/

> +  PSCI CPU_OFF function.  The kernel will issue CPU_ON calls to bring
> +  CPUs into the kernel.

As the bootloader might never bring those secondaries online, it would
be better to state that those secondaries are in OFF state from the
perspective of the PSCI state machine.

Otherwise, this looks fine to me.

Cheers,
Mark.
