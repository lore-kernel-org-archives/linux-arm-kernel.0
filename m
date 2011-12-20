From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Dec 2011 14:15:02 +0000
Subject: [PATCH] ARM: errata: Update the workaround for the 742231
 Cortex-A9 erratum
In-Reply-To: <4EF04956.90006@renesas.com>
References: <4EF04923.50203@renesas.com>
 <4EF04956.90006@renesas.com>
Message-ID: <20111220141501.GB22161@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 08:37:42AM +0000, Shinya Kuribayashi wrote:
> Workaround for the 742231 erratum has been updated, which explains
> that bit #22 is required only for Cortex-A9 MPcore configuration with
> 1 single processor and the ACP present.
> 
> That means, it's not needed for the SMP kernel.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> ---
> 
>  Since #742231 is associated with SMP, it's safe to remove bit #22
>  for now, but I'm concerned that 'MPcore + 1 processor + ACP' case
>  still remains as untreated.  Do we need to support the case?
> 
>  arch/arm/mm/proc-v7.S |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 2c559ac..8f8fced 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -352,7 +352,6 @@ __v7_setup:
>  	teqne	r6, #0x22			@ present in r2p2
>  	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
>  	orreq	r10, r10, #1 << 12		@ set bit #12
> -	orreq	r10, r10, #1 << 22		@ set bit #22
>  	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register

Most A9 configurations I'm aware of are indeed SMP. But maybe you could
add a !CONFIG_SMP around bit 22 setting, just in case there are
platforms using this together with an ACP.

-- 
Catalin
