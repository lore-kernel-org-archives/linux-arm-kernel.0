From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 18 Jul 2018 07:17:48 +0000
Subject: [PATCH V2] ARM: STi: warn if scu mapping fails
In-Reply-To: <1531748809-12540-1-git-send-email-hofrat@osadl.org>
References: <1531748809-12540-1-git-send-email-hofrat@osadl.org>
Message-ID: <6cf0542b-cb50-33d4-25eb-51b7e303905d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicholas

On 07/16/2018 03:46 PM, Nicholas Mc Guire wrote:
>   If the device node is not found or the of_iomap() failed, calling
> scu_enable would not be safe and could lead to an undefined system
> state. So warn in both failure paths before returning.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Link: http://lkml.org/lkml/2018/7/16/219
> Fixes: commit 65ebcc115889 ("ARM: sti: Add STiH415 SOC support")
> ---
> 
> V2: replacement of WARN_ON() by a meaningful pr_err as suggested by
>      Patrice CHOTARD <patrice.chotard@st.com>.
> 
> Problem was found by an experimental coccinelle script
> 
> Patch was compile tested with: multi_v7_defconfig (implies
> CONFIG_ARCH_STI=y, CONFIG_SMP=y)
> (with one sparse warning unrelated to the proposed change)
> 
> Patch is against 4.18-rc4 (localversion-next is next-20180716)
> 
>   arch/arm/mach-sti/platsmp.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index 231f19e..530e9a5 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c
> @@ -107,12 +107,22 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>   
>   	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>   
> -	if (np) {
> -		scu_base = of_iomap(np, 0);
> -		scu_enable(scu_base);
> -		of_node_put(np);
> +	if (!np) {
> +		pr_err("SCU not found at %s:%s():%d\n",
> +		       __FILE__, __func__, __LINE__);
> +		return;
>   	}
>   
> +	scu_base = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!scu_base) {
> +		pr_err("SCU remap failed at %s:%s():%d\n",
> +		       __FILE__, __func__, __LINE__);
> +		return;
> +	}
> +
> +	scu_enable(scu_base);
> +
>   	if (max_cpus <= 1)
>   		return;
>   
> 
Acked-by: Patrice Chotard <patrice.chotard@st.com>

Patrice
