From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 21 Apr 2014 23:05:00 +0400
Subject: [PATCH 3/9] iommu/ipmmu-vmsa: Define driver-specific page
 directory sizes
In-Reply-To: <1398089589-9181-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1398089589-9181-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <53556BDC.6040705@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/21/2014 06:13 PM, Laurent Pinchart wrote:

> The PTRS_PER_(PGD|PMD|PTE) macros evaluate to different values depending
> on whether LPAE is enabled. The IPMMU driver uses a long descriptor
> format regardless of LPAE, making those macros mismatch the IPMMU
> configuration on non-LPAE systems.

> Replace the macros by driver-specific versions that always evaluate to
> the right value.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 1ae97d8..7c8c21e 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -210,6 +210,10 @@ static LIST_HEAD(ipmmu_devices);
>   #define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
>   #define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
>
> +#define IPMMU_PTRS_PER_PTE		512
> +#define IPMMU_PTRS_PER_PMD		512
> +#define IPMMU_PTRS_PER_PGD		4
> +
[...]
> @@ -487,7 +491,7 @@ static void ipmmu_free_puds(pgd_t *pgd)
>   	unsigned int i;
>
>   	pud = pud_base;
> -	for (i = 0; i < PTRS_PER_PUD; ++i) {
> +	for (i = 0; i < IPMMU_PTRS_PER_PUD; ++i) {

    I don't see where you #define IPMMU_PTRS_PER_PUD...

[...]

WBR, Sergei
