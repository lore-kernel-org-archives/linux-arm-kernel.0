From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Aug 2014 17:06:19 +0100
Subject: [PATCH v8 01/10] ARM: use _install_special_mapping for sigpage
In-Reply-To: <53DF9491.5040204@mentor.com>
References: <1407003407-31219-1-git-send-email-nathan_lynch@mentor.com>
 <1407003407-31219-2-git-send-email-nathan_lynch@mentor.com>
 <20140804124630.GG15117@arm.com> <53DF86BA.2030207@mentor.com>
 <53DF9491.5040204@mentor.com>
Message-ID: <20140804160619.GK15117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 03:11:29PM +0100, Nathan Lynch wrote:
> On 08/04/2014 08:12 AM, Nathan Lynch wrote:
> > On 08/04/2014 07:46 AM, Will Deacon wrote:
> >> On Sat, Aug 02, 2014 at 07:16:38PM +0100, Nathan Lynch wrote:
> >>> _install_special_mapping allows the VMA to be identifed in
> >>> /proc/pid/maps without the use of arch_vma_name, providing a
> >>> slight net reduction in object size:
> >>>
> >>>   text    data     bss     dec     hex filename
> >>>   2996      96     144    3236     ca4 arch/arm/kernel/process.o (before)
> >>>   2956     104     144    3204     c84 arch/arm/kernel/process.o (after)
> >>>
> >>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> >>> Reviewed-by: Kees Cook <keescook@chromium.org>
> >>> ---
> >>>  arch/arm/kernel/process.c | 24 ++++++++++++++++--------
> >>>  1 file changed, 16 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> >>> index 81ef686a91ca..46fbbb3701a0 100644
> >>> --- a/arch/arm/kernel/process.c
> >>> +++ b/arch/arm/kernel/process.c
> >>> @@ -472,19 +472,23 @@ int in_gate_area_no_mm(unsigned long addr)
> >>>  
> >>>  const char *arch_vma_name(struct vm_area_struct *vma)
> >>>  {
> >>> -	return is_gate_vma(vma) ? "[vectors]" :
> >>> -		(vma->vm_mm && vma->vm_start == vma->vm_mm->context.sigpage) ?
> >>> -		 "[sigpage]" : NULL;
> >>> +	return is_gate_vma(vma) ? "[vectors]" : NULL;
> >>>  }
> >>
> >> Why do you need this function? I just removed it for arm64 and I think x86
> >> has done the same.
> > 
> > I think arch_vma_name is still needed for arm as long as the vectors
> > page is not installed using _install_special_mapping.
> 
> Actually... if we give arm's gate_vma a vm_ops with a ->name() routine
> that returns "[vectors]" we could get rid of arch_vma_name, I think.
> This seems to be what x86_64 does.

To be honest, I forgot about the vectors page, but giving it a name sounds
like a sensible idea.

Will
