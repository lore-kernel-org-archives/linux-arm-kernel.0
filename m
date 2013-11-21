From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 21 Nov 2013 12:43:28 +0000
Subject: [PATCHv5 1/9] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <1384853593-32202-2-git-send-email-hdoyu@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com> <
 1384853593-32202-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20131121124328.46BC1C40A2C@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013 11:33:05 +0200, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> The following pattern of code is tempting:
> 
>   for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>

That's a very minimal commit message. Can you elaborate please.

> ---
> v5:
> New patch for v5.
> ---
>  include/linux/of.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 276c546..131fef5 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -613,6 +613,9 @@ static inline int of_property_read_u32(const struct device_node *np,
>  		s;						\
>  		s = of_prop_next_string(prop, s))
>  
> +#define of_property_for_each_phandle_with_args(np, list, cells, i, args) \
> +	for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
> +

That works, but pretty darn inefficient. We need an iterator version of
of_parse_phandle_with_args() to loop over all the entries.

>  #if defined(CONFIG_PROC_FS) && defined(CONFIG_PROC_DEVICETREE)
>  extern void proc_device_tree_add_node(struct device_node *, struct proc_dir_entry *);
>  extern void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop);
> -- 
> 1.8.1.5
> 
