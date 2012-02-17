From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2012 13:12:47 +0000
Subject: [PATCH 2/2] ARM: dma-mapping: fix leak in consistent_init
In-Reply-To: <1329484195-26361-1-git-send-email-ajeet.yadav.77@gmail.com>
References: <1329484195-26361-1-git-send-email-ajeet.yadav.77@gmail.com>
Message-ID: <20120217131247.GN27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 06:39:55PM +0530, Ajeet Yadav wrote:
> Although the error in this case is unlikely, but logically
> if error occurs then we leak memory.
> 
> Signed-off-by: Ajeet Yadav <ajeet.yadav.77@gmail.com>
> ---
>  arch/arm/mm/dma-mapping.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 04bfa76..b8cf062 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -161,7 +161,6 @@ static struct arm_vmregion_head consistent_head = {
>   */
>  static int __init consistent_init(void)
>  {
> -	int ret = 0;
>  	pgd_t *pgd;
>  	pud_t *pud;
>  	pmd_t *pmd;
> @@ -171,7 +170,7 @@ static int __init consistent_init(void)
>  	unsigned long num_ptes = (CONSISTENT_END - base) >> PMD_SHIFT;
>  
>  	consistent_pte = kmalloc(num_ptes * sizeof(pte_t *), GFP_KERNEL);
> -	if (!consistent_pte) {
> +	if (unlikely(!consistent_pte)) {

Please get rid of these unlikelys.  This really isn't a performance
critical path.
