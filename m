From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 18 Sep 2015 16:35:46 +0800
Subject: [PATCH 6/7] arm64: Make the kernel page dump utility aware of
 the CONT bit
In-Reply-To: <1442430186-9083-7-git-send-email-jeremy.linton@arm.com>
References: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
 <1442430186-9083-7-git-send-email-jeremy.linton@arm.com>
Message-ID: <20150918083546.GA30972@free64-pc.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 02:03:05PM -0500, Jeremy Linton wrote:
> The kernel page dump utility needs to be aware of the CONT bit before
> it will break up pages ranges for display.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/mm/dump.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index f3d6221..5a22a11 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -67,6 +67,12 @@ static struct addr_marker address_markers[] = {
>  	{ -1,			NULL },
>  };
>  
> +/*
> + * The page dumper groups page table entries of the same type into a single
> + * description. It uses pg_state to track the range information while
> + * iterating over the pte entries. When the continuity is broken it then
> + * dumps out a description of the range.
> + */
>  struct pg_state {
>  	struct seq_file *seq;
>  	const struct addr_marker *marker;
> @@ -114,6 +120,16 @@ static const struct prot_bits pte_bits[] = {
>  		.set	= "NG",
>  		.clear	= "  ",
>  	}, {
> +		.mask	= PTE_CONT,
> +		.val	= PTE_CONT,
> +		.set	= "CON",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_TABLE_BIT,
> +		.val	= PTE_TABLE_BIT,
> +		.set	= "   ",
> +		.clear	= "BLK",
I think the PTE_TABLE_BIT should be not here. Since PTE_TABLE_BIT is in bit 1,
it should be placed before the PTE_USER which is in bit 6.

thanks
Huang Shijie
