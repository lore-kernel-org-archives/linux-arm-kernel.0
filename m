From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Oct 2015 18:11:40 +0100
Subject: [PATCH V4 2/3] arm64: support initrd outside kernel linear map
In-Reply-To: <20150908113113.GA20562@leverpostej>
References: <1439830867-14935-1-git-send-email-msalter@redhat.com>
 <1439830867-14935-3-git-send-email-msalter@redhat.com>
 <20150908113113.GA20562@leverpostej>
Message-ID: <20151006171140.GE26433@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 12:31:13PM +0100, Mark Rutland wrote:
> Hi Mark,
> 
> On Mon, Aug 17, 2015 at 06:01:06PM +0100, Mark Salter wrote:
> > The use of mem= could leave part or all of the initrd outside of
> > the kernel linear map. This will lead to an error when unpacking
> > the initrd and a probable failure to boot. This patch catches that
> > situation and relocates the initrd to be fully within the linear
> > map.
> 
> With next-20150908, this patch results in a confusing message at boot when not
> using an initrd:
> 
> Moving initrd from [4080000000-407fffffff] to [9fff49000-9fff48fff]
> 
> I think that can be solved by folding in the diff below.

Mark, it looks like this fell by the wayside.

Do you have any objection to this? I'll promote this to it's own patch
if not.

Mark.

> 
> Thanks,
> Mark.
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 6bab21f..2322479 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -364,6 +364,8 @@ static void __init relocate_initrd(void)
>                 to_free = ram_end - orig_start;
>  
>         size = orig_end - orig_start;
> +       if (!size)
> +               return;
>  
>         /* initrd needs to be relocated completely inside linear mapping */
>         new_start = memblock_find_in_range(0, PFN_PHYS(max_pfn),
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
