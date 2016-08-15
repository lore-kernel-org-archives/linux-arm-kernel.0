From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2016 10:17:54 +0100
Subject: [PATCH v4 2/3] arm64: vdso: constify vm_special_mapping used for
 aarch32 vectors page
In-Reply-To: <1471243546-3090-3-git-send-email-jszhang@marvell.com>
References: <1471243546-3090-1-git-send-email-jszhang@marvell.com>
 <1471243546-3090-3-git-send-email-jszhang@marvell.com>
Message-ID: <20160815091754.GC1426@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 02:45:45PM +0800, Jisheng Zhang wrote:
> The vm_special_mapping spec which is used for aarch32 vectors page is
> never modified, so mark it as const.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

I see that this is never deliberately modified before being passed to
_install_special_mapping, which takes it as a const pointer. So this looks good
to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index e320e8f..10ad8ab 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -88,7 +88,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
>  {
>  	struct mm_struct *mm = current->mm;
>  	unsigned long addr = AARCH32_VECTORS_BASE;
> -	static struct vm_special_mapping spec = {
> +	static const struct vm_special_mapping spec = {
>  		.name	= "[vectors]",
>  		.pages	= vectors_page,
>  
> -- 
> 2.8.1
> 
