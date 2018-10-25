From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 25 Oct 2018 11:11:22 -0700
Subject: [PATCH] dmaengine: xilinx_dma: Remove __aligned attribute on
 zynqmp_dma_desc_ll
In-Reply-To: <20181025180525.28378-1-natechancellor@gmail.com>
References: <20181025180525.28378-1-natechancellor@gmail.com>
Message-ID: <CAKwvOdn6juo_gfbEBmL2hanOuwbth2gE6bv9_O3AjWsM-WmsWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 11:06 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> ignored, place it after "struct" to apply attribute to type declaration
> [-Wignored-attributes]
> }; __aligned(64)
>    ^
> ./include/linux/compiler_types.h:200:38: note: expanded from macro
> '__aligned'
> #define __aligned(x)            __attribute__((aligned(x)))
>                                                ^
> 1 warning generated.
>
> As Nick pointed out in the previous version of this patch, the author
> likely intended for this struct to be 8-byte (64-bit) aligned, not
> 64-byte, which is the default. Remove the hanging __aligned attribute.

Here was the v1 discussion, for reference.
https://lkml.org/lkml/2018/9/12/4

Thanks for sending the update Nathan.  One thing I recommend doing is
including the version in the [PATCH] subject line, ie. [PATCH v2].
`git format-patch` can do this automatically for you, ex.
$ git format-patch -v2 HEAD~

>
> Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Then below this line, you can include the notes about v1 -> v2
changes. (interdiff notes to the reviewers that get discarded from the
commit message).  I think I've seen you use the versioning before, so
sorry if I'm restating something you already know.

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index c74a88b65039..73de6a6179fc 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
>         u32 ctrl;
>         u64 nxtdscraddr;
>         u64 rsvd;
> -}; __aligned(64)
> +};
>
>  /**
>   * struct zynqmp_dma_desc_sw - Per Transaction structure
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
