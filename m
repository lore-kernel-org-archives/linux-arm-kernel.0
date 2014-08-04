From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Aug 2014 13:46:30 +0100
Subject: [PATCH v8 01/10] ARM: use _install_special_mapping for sigpage
In-Reply-To: <1407003407-31219-2-git-send-email-nathan_lynch@mentor.com>
References: <1407003407-31219-1-git-send-email-nathan_lynch@mentor.com>
 <1407003407-31219-2-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140804124630.GG15117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 07:16:38PM +0100, Nathan Lynch wrote:
> _install_special_mapping allows the VMA to be identifed in
> /proc/pid/maps without the use of arch_vma_name, providing a
> slight net reduction in object size:
> 
>   text    data     bss     dec     hex filename
>   2996      96     144    3236     ca4 arch/arm/kernel/process.o (before)
>   2956     104     144    3204     c84 arch/arm/kernel/process.o (after)
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/kernel/process.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 81ef686a91ca..46fbbb3701a0 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -472,19 +472,23 @@ int in_gate_area_no_mm(unsigned long addr)
>  
>  const char *arch_vma_name(struct vm_area_struct *vma)
>  {
> -	return is_gate_vma(vma) ? "[vectors]" :
> -		(vma->vm_mm && vma->vm_start == vma->vm_mm->context.sigpage) ?
> -		 "[sigpage]" : NULL;
> +	return is_gate_vma(vma) ? "[vectors]" : NULL;
>  }

Why do you need this function? I just removed it for arm64 and I think x86
has done the same.

Will
