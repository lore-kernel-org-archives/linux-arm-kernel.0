From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jan 2014 17:19:54 +0000
Subject: [PATCH v3 3/7] ARM: do CPU-specific init for Broadcom Brahma15
 cores
In-Reply-To: <1389743333-16741-4-git-send-email-marc.ceeeee@gmail.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <1389743333-16741-4-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <20140115171953.GB28782@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 11:48:49PM +0000, Marc Carino wrote:
> Perform any CPU-specific initialization required on the
> Broadcom Brahma-15 core.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/proc-v7.S |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index bd17819..98ea423 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -193,6 +193,7 @@ __v7_cr7mp_setup:
>  	b	1f
>  __v7_ca7mp_setup:
>  __v7_ca15mp_setup:
> +__v7_b15mp_setup:
>  	mov	r10, #0
>  1:
>  #ifdef CONFIG_SMP
> @@ -494,6 +495,16 @@ __v7_ca15mp_proc_info:
>  	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
>  
>  	/*
> +	 * Broadcom Corporation Brahma-B15 processor.
> +	 */
> +	.type	__v7_b15mp_proc_info, #object
> +__v7_b15mp_proc_info:
> +	.long	0x420f00f0
> +	.long	0xff0ffff0
> +	__v7_proc __v7_b15mp_setup, hwcaps = HWCAP_IDIV

You only need to specify HWCAP_IDIV if you screwed up your idregs (namely
CPUID_EXT_ISAR0). Do you actually need this for your core?

Will
