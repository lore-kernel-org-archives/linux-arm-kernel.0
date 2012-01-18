From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jan 2012 10:33:16 +0000
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
References: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
Message-ID: <20120118103315.GB20028@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 09:52:25AM +0000, bill4carson at gmail.com wrote:
> From: Bill Carson <bill4carson@gmail.com>
> 
> If we are only about to clear a hardware pte entry, then pte makeup code is
> unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.
> 
> Signed-off-by: Bill Carson <bill4carson@gmail.com>
> ---
>  arch/arm/mm/proc-macros.S    |   10 +++++-----
>  arch/arm/mm/proc-v7-2level.S |   10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 2d8ff3a..11288b3 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -138,6 +138,10 @@
>  	.macro	armv6_set_pte_ext pfx
>  	str	r1, [r0], #2048			@ linux version
>  
> +	tst	r1, #L_PTE_YOUNG
> +	tstne	r1, #L_PTE_PRESENT
> +	moveq	r3, #0
> +	moveq	set_pte

As Uwe said, "beq" here and you could use numerical labels like "1f".

-- 
Catalin
