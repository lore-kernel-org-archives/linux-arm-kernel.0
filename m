From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 15 Jun 2016 16:36:19 +0100
Subject: [PATCH] ARM: V7M: Add dsb before jumping in handler mode
In-Reply-To: <1465827171-15847-1-git-send-email-alexandre.torgue@st.com>
References: <1465827171-15847-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <576175F3.5080306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/16 15:12, Alexandre TORGUE wrote:
> According to ARM AN321 (section 4.12):
> 
> "If the vector table is in writable memory such as SRAM, either relocated
> by VTOR or a device dependent memory remapping mechanism, then
> architecturally a memory barrier instruction is required after the vector
> table entry is updated, and if the exception is to be activated
> immediately"
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
> 

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 7229d8d..2ddc435 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -104,6 +104,7 @@ __v7m_setup:
>  	badr	r1, 1f
>  	ldr	r5, [r12, #11 * 4]	@ read the SVC vector entry
>  	str	r1, [r12, #11 * 4]	@ write the temporary SVC vector entry
> +	dsb
>  	mov	r6, lr			@ save LR
>  	ldr	sp, =init_thread_union + THREAD_START_SP
>  	cpsie	i
> 
