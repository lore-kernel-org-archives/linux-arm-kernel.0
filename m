From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 17:06:39 +0000
Subject: [PATCH 3/9] ARM: smp: avoid using bitmasks and locks for IPIs,
	use hardware instead
In-Reply-To: <E1PI3Jw-00029e-Kh@rmk-PC.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
	<E1PI3Jw-00029e-Kh@rmk-PC.arm.linux.org.uk>
Message-ID: <1290013599.2351.60.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-15 at 17:58 +0000, Russell King - ARM Linux wrote:
> Avoid using bitmasks and locks in the percpu area for IPIs, and instead
> use individual software generated interrupts to identify the reason for
> the IPI.  This avoids the problems of having spinlocks in the percpu
> area.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/smp.c |   87 ++++++++++++++----------------------------------
>  1 files changed, 26 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 7a236db..78d55c6 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
[...]
>  enum ipi_msg_type {
> -       IPI_TIMER,
> +       IPI_TIMER = 2,
>         IPI_RESCHEDULE,
>         IPI_CALL_FUNC,
>         IPI_CALL_FUNC_SINGLE,

Maybe a comment here on why this starts at 2. People may wonder in the
future.

-- 
Catalin
