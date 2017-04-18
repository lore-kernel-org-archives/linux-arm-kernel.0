From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 18 Apr 2017 13:53:30 +0100
Subject: [PATCH] ARM: V7M: Do not corrupt vector table around
 v7m_invalidate_l1 call
In-Reply-To: <1490861391-35484-1-git-send-email-vladimir.murzin@arm.com>
References: <1490861391-35484-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <827cff66-33df-b1fd-842d-fa98cb69e326@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/17 09:09, Vladimir Murzin wrote:
> We save/restore registers around v7m_invalidate_l1 to address pointed
> by r12, which is vector table, so the first eight entries are
> overwritten with a garbage. We already have stack setup at that stage,
> so use it to save/restore register.
> 
> Fixes: 6a8146f420be ("ARM: 8609/1: V7M: Add support for the Cortex-M7 processor")
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/mm/proc-v7m.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 8dea616..5049777 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -147,10 +147,10 @@ __v7m_setup_cont:
>  
>  	@ Configure caches (if implemented)
>  	teq     r8, #0
> -	stmneia	r12, {r0-r6, lr}	@ v7m_invalidate_l1 touches r0-r6
> +	stmneia	sp, {r0-r6, lr}		@ v7m_invalidate_l1 touches r0-r6
>  	blne	v7m_invalidate_l1
>  	teq     r8, #0			@ re-evalutae condition
> -	ldmneia	r12, {r0-r6, lr}
> +	ldmneia	sp, {r0-r6, lr}
>  
>  	@ Configure the System Control Register to ensure 8-byte stack alignment
>  	@ Note the STKALIGN bit is either RW or RAO.
> 

Ok for patch tracker?

Vladimir
