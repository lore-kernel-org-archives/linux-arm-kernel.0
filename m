From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Jan 2015 11:03:44 +0000
Subject: [PATCH boot-wrapper-aarch64 1/4] psci: use MPIDR_INVALID instead
 of -1
In-Reply-To: <1421115304-19580-2-git-send-email-zlim@broadcom.com>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
 <1421115304-19580-2-git-send-email-zlim@broadcom.com>
Message-ID: <20150114110343.GC12069@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 13, 2015 at 02:15:01AM +0000, Zi Shen Lim wrote:
> MPIDR_INVALID was already defined, so use it.

MPIDR_INVALID is meant to be an invalid MPIDR value, rather than an
error code in the case of an invalid MPIDR.

__find_logical_index is meant to return a logical CPU ID, so returning
MPIDR_INVALID isn't quite right.

I'd be happier if we used a separate macro for the logical IDs (e.g.
ID_INVALID).

Thanks,
Mark.

> 
> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
> ---
>  psci.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/psci.S b/psci.S
> index 856095b..234493d 100644
> --- a/psci.S
> +++ b/psci.S
> @@ -126,7 +126,7 @@ psci_cpu_on:
>  	mov	x0, x1
>  
>  	bl	find_logical_id
> -	cmp	x0, #-1
> +	cmp	x0, #MPIDR_INVALID
>  	b.eq	1f
>  
>  	adr	x3, branch_table
> @@ -172,7 +172,7 @@ __find_logical_index:
>  	b 1b
>  2:	mov	x0, x1
>  	ret
> -3:	mov	x0, #-1
> +3:	mov	x0, #MPIDR_INVALID
>  	ret
>  
>  setup_vector:
> @@ -207,7 +207,7 @@ spin:
>  	ldr	x1, =MPIDR_ID_BITS
>  	and	x0, x0, x1
>  	bl	find_logical_id
> -	cmp	x0, #-1
> +	cmp	x0, #MPIDR_INVALID
>  	b.eq	spin_dead
>  
>  	adr	x1, branch_table
> -- 
> 2.1.0
> 
> 
