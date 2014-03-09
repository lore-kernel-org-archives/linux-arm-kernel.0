From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 9 Mar 2014 23:03:56 +1100
Subject: [PATCH RFC 2/5] dtc: livetree: Add more tree parsing helpers
In-Reply-To: <1392919611-10746-3-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
 <1392919611-10746-3-git-send-email-t.figa@samsung.com>
Message-ID: <20140309120355.GG20356@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 07:06:48PM +0100, Tomasz Figa wrote:
> This patch extends the set of parsing helpers available in dtc with
> string and phandle parsing.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  dtc.h      |  28 ++++++++
>  livetree.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 258 insertions(+)
> 
> diff --git a/dtc.h b/dtc.h
> index e95bed7..9ce9d12 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -163,6 +163,13 @@ struct node {
>  	struct label *labels;
>  };
>  
> +#define MAX_PHANDLE_ARGS 16
> +struct of_phandle_args {
> +	struct node *np;
> +	int args_count;
> +	uint32_t args[MAX_PHANDLE_ARGS];
> +};
> +
>  #define for_each_label_withdel(l0, l) \
>  	for ((l) = (l0); (l); (l) = (l)->next)
>  
> @@ -184,6 +191,11 @@ struct node {
>  	for_each_child_withdel(n, c) \
>  		if (!(c)->deleted)
>  
> +#define for_each_propval_string(p, s)	\
> +	for (s = propval_next_string(p, NULL);		\
> +		s;					\
> +		s = propval_next_string(p, s))
> +
>  void add_label(struct label **labels, char *label);
>  void delete_labels(struct label **labels);
>  
> @@ -208,6 +220,22 @@ void delete_node(struct node *node);
>  const char *get_unitname(struct node *node);
>  struct property *get_property(struct node *node, const char *propname);
>  cell_t propval_cell(struct property *prop);
> +int propval_string_count(struct node *np, struct property *prop);
> +const char *propval_next_string(struct property *prop, const char *cur);
> +int propval_match_string(struct property *prop, const char *string);
> +struct node *propval_parse_phandle(struct node *root,
> +				     struct property *prop, int index);
> +int propval_parse_phandle_with_args(struct node *root,
> +				    struct property *prop,
> +				    const char *cells_name, int index,
> +				    struct of_phandle_args *out_args);
> +int propval_parse_phandle_with_fixed_args(struct node *root,
> +					  struct property *prop, int cell_count,
> +					  int index,
> +					  struct of_phandle_args *out_args);
> +int propval_count_phandle_with_args(struct node *root,
> +				    struct property *prop,
> +				    const char *cells_name);
>  struct property *get_property_by_label(struct node *tree, const char *label,
>  				       struct node **node);
>  struct marker *get_marker_label(struct node *tree, const char *label,
> diff --git a/livetree.c b/livetree.c
> index b61465f..015ed06 100644
> --- a/livetree.c
> +++ b/livetree.c
> @@ -377,6 +377,230 @@ cell_t propval_cell(struct property *prop)
>  	return fdt32_to_cpu(*((cell_t *)prop->val.val));
>  }
>  
> +int propval_string_count(struct node *np, struct property *prop)
> +{
> +	int i = 0;
> +	size_t l = 0, total = 0;
> +	const char *p;
> +
> +	if (!prop)
> +		return -EINVAL;

1) using Unix error codes as return values is a convention which is
not currently used anywhere in dtc.  Introducing it in the middle of
other changes is not a good idea.

2) Surely calling this on a NULL property is a bug in the caller, so
it should be an assert().


> +	if (!prop->val.val)
> +		return -ENODATA;

An empty property is a valid stringlist with 0 entries, so this should
return 0 not an error.

> +	if (strnlen(prop->val.val, prop->val.len) >= prop->val.len)
> +		return -EILSEQ;
> +
> +	p = prop->val.val;
> +
> +	for (i = 0; total < prop->val.len; total += l, p += l, i++)
> +		l = strlen(p) + 1;
> +
> +	return i;
> +}
> +
> +const char *propval_next_string(struct property *prop, const char *cur)
> +{
> +	const char *curv = cur;
> +
> +	if (!prop)
> +		return NULL;
> +
> +	if (!cur)
> +		return prop->val.val;
> +
> +	curv += strlen(cur) + 1;
> +	if (curv >= prop->val.val + prop->val.len)
> +		return NULL;
> +
> +	return curv;
> +}
> +
> +int propval_match_string(struct property *prop, const char *string)
> +{
> +	size_t l;
> +	int i;
> +	const char *p, *end;
> +
> +	if (!prop)
> +		return -EINVAL;
> +	if (!prop->val.val)
> +		return -ENODATA;
> +
> +	p = prop->val.val;
> +	end = p + prop->val.len;
> +
> +	for (i = 0; p < end; i++, p += l) {
> +		l = strlen(p) + 1;
> +		if (p + l > end)
> +			return -EILSEQ;
> +		if (strcmp(string, p) == 0)
> +			return i; /* Found it; return index */
> +	}
> +	return -ENODATA;
> +}
> +
> +static int parse_phandle_with_args(struct node *root,
> +					struct property *prop,
> +					const char *cells_name,
> +					int cell_count, int index,
> +					struct of_phandle_args *out_args)
> +{
> +	const cell_t *list, *list_end;
> +	int rc = 0, size, cur_index = 0;
> +	uint32_t count = 0;
> +	struct node *node = NULL;
> +	cell_t phandle;
> +
> +	/* Retrieve the phandle list property */
> +	size = prop->val.len;
> +	list = (const cell_t *)prop->val.val;
> +	if (!list)
> +		return -ENOENT;
> +	list_end = list + size / sizeof(*list);
> +
> +	/* Loop over the phandles until all the requested entry is found */
> +	while (list < list_end) {
> +		rc = -EINVAL;
> +		count = 0;
> +
> +		/*
> +		 * If phandle is 0, then it is an empty entry with no
> +		 * arguments.  Skip forward to the next entry.
> +		 */
> +		phandle = fdt32_to_cpu(*list++);
> +		if (phandle) {

Using continue would avoid extraneous indentation and make this easier
to read.

> +			/*
> +			 * Find the provider node and parse the #*-cells
> +			 * property to determine the argument length.
> +			 *
> +			 * This is not needed if the cell count is hard-coded
> +			 * (i.e. cells_name not set, but cell_count is set),
> +			 * except when we're going to return the found node
> +			 * below.
> +			 */
> +			if (cells_name || cur_index == index) {
> +				node = get_node_by_phandle(root, phandle);
> +				if (!node) {
> +					pr_err("could not find phandle %u\n",
> +						phandle);
> +					goto err;
> +				}
> +			}
> +
> +			if (cells_name) {
> +				struct property *cells_prop;
> +
> +				cells_prop = get_property(node, cells_name);
> +				if (!cells_prop) {
> +					pr_err("could not get %s for %s\n",
> +						cells_name,
> +						node->fullpath);
> +					goto err;
> +				}
> +
> +				count = propval_cell(cells_prop);
> +			} else {
> +				count = cell_count;
> +			}
> +
> +			/*
> +			 * Make sure that the arguments actually fit in the
> +			 * remaining property data length
> +			 */
> +			if (list + count > list_end) {
> +				pr_err("arguments longer than property\n");
> +				goto err;
> +			}
> +		}
> +
> +		/*
> +		 * All of the error cases above bail out of the loop, so at
> +		 * this point, the parsing is successful. If the requested
> +		 * index matches, then fill the out_args structure and return,
> +		 * or return -ENOENT for an empty entry.
> +		 */
> +		rc = -ENOENT;
> +		if (cur_index == index) {
> +			if (!phandle)
> +				goto err;
> +
> +			if (out_args) {
> +				int i;
> +				if (count > MAX_PHANDLE_ARGS) {
> +					pr_warn("argument count higher than MAX_PHANDLE_ARGS\n");
> +					count = MAX_PHANDLE_ARGS;

That's more than a warn.  If you've run out of space here that pretty
much has to be a fatal error.

> +				}
> +				out_args->np = node;
> +				out_args->args_count = count;
> +				for (i = 0; i < count; i++)
> +					out_args->args[i] = fdt32_to_cpu(*list++);
> +			}
> +
> +			/* Found it! return success */
> +			return 0;
> +		}
> +
> +		node = NULL;
> +		list += count;
> +		cur_index++;
> +	}
> +
> +	/*
> +	 * Unlock node before returning result; will be one of:

Hrm... looks like a comment suffering from copy/paste without updating
for the new context.


> +	 * -ENOENT : index is for empty phandle
> +	 * -EINVAL : parsing error on data
> +	 * [1..n]  : Number of phandle (count mode; when index = -1)
> +	 */
> +	rc = index < 0 ? cur_index : -ENOENT;
> + err:
> +	return rc;
> +}
> +
> +struct node *propval_parse_phandle(struct node *root,
> +				     struct property *prop, int index)
> +{
> +	struct of_phandle_args args;
> +
> +	if (index < 0)
> +		return NULL;

Again, this is a bug in the caller; should be an assert().

> +
> +	if (parse_phandle_with_args(root, prop, NULL, 0,
> +					 index, &args))
> +		return NULL;
> +
> +	return args.np;
> +}
> +
> +int propval_parse_phandle_with_args(struct node *root,
> +				    struct property *prop,
> +				    const char *cells_name, int index,
> +				    struct of_phandle_args *out_args)
> +{
> +	if (index < 0)
> +		return -EINVAL;
> +	return parse_phandle_with_args(root, prop, cells_name, 0,
> +						index, out_args);
> +}
> +
> +int propval_parse_phandle_with_fixed_args(struct node *root,
> +					  struct property *prop, int cell_count,
> +					  int index,
> +					  struct of_phandle_args *out_args)
> +{
> +	if (index < 0)
> +		return -EINVAL;
> +	return parse_phandle_with_args(root, prop, NULL, cell_count,
> +					   index, out_args);
> +}
> +
> +int propval_count_phandle_with_args(struct node *root,
> +				    struct property *prop,
> +				    const char *cells_name)
> +{
> +	return parse_phandle_with_args(root, prop, cells_name, 0, -1,
> +						NULL);
> +}
> +
>  struct property *get_property_by_label(struct node *tree, const char *label,
>  				       struct node **node)
>  {
> @@ -456,6 +680,12 @@ struct node *get_node_by_path(struct node *tree, const char *path)
>  	while (path[0] == '/')
>  		path++;
>  
> +	if (!(*path)) {
> +		if (tree->deleted)
> +			return NULL;
> +		return tree;
> +	}

This change needs a justification.

>  	p = strchr(path, '/');
>  
>  	for_each_child(tree, child) {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/089cd3f7/attachment-0001.sig>
