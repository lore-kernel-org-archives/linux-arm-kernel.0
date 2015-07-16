From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jul 2015 11:23:26 +0100
Subject: [PATCH 1/2] of: base: Allow more args than MAX_PHANDLE_ARGS if
 required
In-Reply-To: <1437035444-13867-2-git-send-email-joro@8bytes.org>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
 <1437035444-13867-2-git-send-email-joro@8bytes.org>
Message-ID: <20150716102325.GC26390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 09:30:43AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The main use of MAX_PHANDLE_ARGS is to define the number of
> args elements in 'struct of_phandle_args'. This struct is
> often declared on the stack and thus it is impractical to
> increase MAX_PHANDLE_ARGS again and again.
> 
> To handle situations where more than MAX_PHANDLE_ARGS
> elements may appear in a device-tree, introduce functions
> to allocate/free 'struct of_phandle_args' with more than
> MAX_PHANDLE_ARGS elements and provide the new function
> of_parse_phandle_with_var_args(), which can handle those
> variable-size structs.
> 
> This is necessary for the ARM-SMMU driver, where the number
> of mmu-masters can be up to 128.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/of/base.c  | 43 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/of.h |  7 +++++++
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 8b5a187..2b288db 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -54,6 +54,24 @@ DEFINE_MUTEX(of_mutex);
>   */
>  DEFINE_RAW_SPINLOCK(devtree_lock);
>  
> +struct of_phandle_args *of_alloc_phandle_args(int size)
> +{
> +	struct of_phandle_args *args;
> +	int e = max(0, size - MAX_PHANDLE_ARGS);
> +
> +	args =  kzalloc(sizeof(struct of_phandle_args) + e * sizeof(uint32_t),
> +			GFP_KERNEL);

Should you also update args->args_count to reflect the extended array?

That said, extending the fixed-size array member like this feels a bit
fragile. Does GCC not complain about out-of-bounds accesses if you
statically address args->args[MAX_PHANDLE_ARGS]? Admittedly, I can't
think *why* this would be break (things like additional padding will be
harmless), but I'm not intimate with the C standard.

I guess the more worrying possibility is if somebody adds a new member to
the end of of_phandle_args.

Will
