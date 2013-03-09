From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 09 Mar 2013 21:14:05 +0100
Subject: [PATCH] of: Add missing node iteration stubs for !CONFIG_OF
In-Reply-To: <1362859836-20221-1-git-send-email-tomasz.figa@gmail.com>
References: <1362859836-20221-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <2252604.zGQUfgkj8o@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, please disregard this patch, as I have sent wrong version 
accidentally. I will send correct one right away. Sorry for inconvenience.

Best regards,
Tomasz

On Saturday 09 of March 2013 21:10:36 Tomasz Figa wrote:
> This patch moves several for_each macros out of the #ifdef CONFIG_OF
> block and adds inline stubs for functions used by these macros, compiled
> conditionally when CONFIG_OF is not enabled.
> 
> This eliminates the need to explicitly check for CONFIG_OF in driver
> code using mentioned functions and macros.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  include/linux/of.h | 92
> +++++++++++++++++++++++++++++++++++++----------------- 1 file changed,
> 63 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a0f1292..aca3677 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -167,19 +167,10 @@ static inline const char *of_node_full_name(const
> struct device_node *np)
> 
>  extern struct device_node *of_find_node_by_name(struct device_node
> *from, const char *name);
> -#define for_each_node_by_name(dn, name) \
> -	for (dn = of_find_node_by_name(NULL, name); dn; \
> -	     dn = of_find_node_by_name(dn, name))
>  extern struct device_node *of_find_node_by_type(struct device_node
> *from, const char *type);
> -#define for_each_node_by_type(dn, type) \
> -	for (dn = of_find_node_by_type(NULL, type); dn; \
> -	     dn = of_find_node_by_type(dn, type))
>  extern struct device_node *of_find_compatible_node(struct device_node
> *from, const char *type, const char *compat);
> -#define for_each_compatible_node(dn, type, compatible) \
> -	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
> -	     dn = of_find_compatible_node(dn, type, compatible))
>  extern struct device_node *of_find_matching_node_and_match(
>  	struct device_node *from,
>  	const struct of_device_id *matches,
> @@ -190,12 +181,6 @@ static inline struct device_node
> *of_find_matching_node( {
>  	return of_find_matching_node_and_match(from, matches, NULL);
>  }
> -#define for_each_matching_node(dn, matches) \
> -	for (dn = of_find_matching_node(NULL, matches); dn; \
> -	     dn = of_find_matching_node(dn, matches))
> -#define for_each_matching_node_and_match(dn, matches, match) \
> -	for (dn = of_find_matching_node_and_match(NULL, matches, match); \
> -	     dn; dn = of_find_matching_node_and_match(dn, matches, match))
>  extern struct device_node *of_find_node_by_path(const char *path);
>  extern struct device_node *of_find_node_by_phandle(phandle handle);
>  extern struct device_node *of_get_parent(const struct device_node
> *node); @@ -207,14 +192,6 @@ extern struct device_node
> *of_get_next_available_child(
> 
>  extern struct device_node *of_get_child_by_name(const struct
> device_node *node, const char *name);
> -#define for_each_child_of_node(parent, child) \
> -	for (child = of_get_next_child(parent, NULL); child != NULL; \
> -	     child = of_get_next_child(parent, child))
> -
> -#define for_each_available_child_of_node(parent, child) \
> -	for (child = of_get_next_available_child(parent, NULL); child != 
NULL;
> \ -	     child = of_get_next_available_child(parent, child))
> -
>  static inline int of_get_child_count(const struct device_node *np)
>  {
>  	struct device_node *child;
> @@ -228,10 +205,6 @@ static inline int of_get_child_count(const struct
> device_node *np)
> 
>  extern struct device_node *of_find_node_with_property(
>  	struct device_node *from, const char *prop_name);
> -#define for_each_node_with_property(dn, prop_name) \
> -	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
> -	     dn = of_find_node_with_property(dn, prop_name))
> -
>  extern struct property *of_find_property(const struct device_node *np,
>  					 const char *name,
>  					 int *lenp);
> @@ -353,13 +326,28 @@ static inline struct device_node
> *of_find_node_by_name(struct device_node *from, return NULL;
>  }
> 
> +static inline struct device_node *of_find_node_by_type(struct
> device_node *from, +	const char *type)
> +{
> +	return NULL;
> +}
> +
>  static inline bool of_have_populated_dt(void)
>  {
>  	return false;
>  }
> 
> -#define for_each_child_of_node(parent, child) \
> -	while (0)
> +static inline struct device_node *of_get_next_child(const struct
> device_node *node, +					     struct device_node 
*prev)
> +{
> +	return NULL;
> +}
> +
> +static inline struct device_node *of_get_next_available_child(
> +	const struct device_node *node, struct device_node *prev)
> +{
> +	return NULL;
> +}
> 
>  static inline struct device_node *of_get_child_by_name(
>  					const struct device_node *node,
> @@ -373,6 +361,12 @@ static inline int of_get_child_count(const struct
> device_node *np) return 0;
>  }
> 
> +static inline struct device_node *of_find_node_with_property(
> +	struct device_node *from, const char *prop_name)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_device_is_compatible(const struct device_node
> *device, const char *name)
>  {
> @@ -394,6 +388,21 @@ static inline struct device_node
> *of_find_compatible_node( return NULL;
>  }
> 
> +static inline struct device_node *of_find_matching_node_and_match(
> +	struct device_node *from,
> +	const struct of_device_id *matches,
> +	const struct of_device_id **match)
> +{
> +	return NULL;
> +}
> +
> +static inline struct device_node *of_find_matching_node(
> +	struct device_node *from,
> +	const struct of_device_id *matches)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_property_read_u8_array(const struct device_node
> *np, const char *propname, u8 *out_values, size_t sz)
>  {
> @@ -503,6 +512,31 @@ static inline int of_node_to_nid(struct device_node
> *np) #define of_node_to_nid of_node_to_nid
>  #endif
> 
> +#define for_each_node_by_name(dn, name) \
> +	for (dn = of_find_node_by_name(NULL, name); dn; \
> +	     dn = of_find_node_by_name(dn, name))
> +#define for_each_node_by_type(dn, type) \
> +	for (dn = of_find_node_by_type(NULL, type); dn; \
> +	     dn = of_find_node_by_type(dn, type))
> +#define for_each_compatible_node(dn, type, compatible) \
> +	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
> +	     dn = of_find_compatible_node(dn, type, compatible))
> +#define for_each_matching_node(dn, matches) \
> +	for (dn = of_find_matching_node(NULL, matches); dn; \
> +	     dn = of_find_matching_node(dn, matches))
> +#define for_each_matching_node_and_match(dn, matches, match) \
> +	for (dn = of_find_matching_node_and_match(NULL, matches, match); \
> +	     dn; dn = of_find_matching_node_and_match(dn, matches, match))
> +#define for_each_child_of_node(parent, child) \
> +	for (child = of_get_next_child(parent, NULL); child != NULL; \
> +	     child = of_get_next_child(parent, child))
> +#define for_each_available_child_of_node(parent, child) \
> +	for (child = of_get_next_available_child(parent, NULL); child != 
NULL;
> \ +	     child = of_get_next_available_child(parent, child))
> +#define for_each_node_with_property(dn, prop_name) \
> +	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
> +	     dn = of_find_node_with_property(dn, prop_name))
> +
>  /**
>   * of_property_read_bool - Findfrom a property
>   * @np:		device node from which the property value is to be read.
