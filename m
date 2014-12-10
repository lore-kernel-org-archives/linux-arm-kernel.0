From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 10 Dec 2014 16:20:30 +0530
Subject: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
In-Reply-To: <1418164072-19087-6-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
Message-ID: <54882576.8020609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> Before this patch, HWMOD requires the existence
> of a struct omap_hwmod_class very early.
Yes, hwmod code looks for omap_hwmod_class entry before registering any hwmod.

With the patch 4/7 omap_hwmod_class gets populated from dt very late after registration of the hwmod.
So all the hwmod which gets class data from dt never gets registered and state is always UNKNOWN.
Mostly making it unusable.
IMO this patch just masks the problem.

In order to register hwmod we need to populate class data very early.
We can populate at the same place as how reg property is being parsed.
Call omap_hwmod_init_sysc() in _init() of the particular hwmod:
The below diff will help:

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..05ecf8a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2415,6 +2415,116 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 	return 0;
 }
 
+static int omap_hwmod_has_sysc_bindings(struct device_node *node)
+{
+	char *properties[] = {
+		"ti,rev_offs",
+		"ti,sysc_offs",
+		"ti,syss_offs",
+		"ti,sysc_flags",
+		"ti,srst_udelay",
+		"ti,idlemodes",
+		"ti,clockact",
+		"ti,sysc_type",
+		NULL
+	};
+	char **tmp = properties;
+
+	while (*tmp) {
+		if (of_property_read_bool(node, *tmp)) {
+			return true;
+		}
+		tmp++;
+	}
+
+	return 0;
+}
+
+static int omap_hwmod_init_sysc(struct device_node *node,
+		struct omap_hwmod *oh, int index)
+{
+	struct omap_hwmod_class *class = oh->class;
+	struct omap_hwmod_class_sysconfig *sysc;
+	int ret;
+	int i;
+	char name[128];
+	const char *tmp = oh->name;
+	u32 prop;
+
+	/* if data isn't provided by DT, skip */
+	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(node))
+		return 0;
+
+	class = kzalloc(sizeof(*class), GFP_KERNEL);
+	if (!class)
+		return -ENOMEM;
+
+	i = 0;
+	while (*tmp) {
+		if (isalpha(*tmp))
+			name[i++] = *tmp;
+		tmp++;
+	}
+	name[i] = '\0';
+
+	class->name = kzalloc(sizeof(name), GFP_KERNEL);
+	if (!class->name)
+		return -ENOMEM;
+	strncpy(class->name, name, sizeof(name) - 1);
+
+	sysc = kzalloc(sizeof(*sysc), GFP_KERNEL);
+	if (!sysc)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_index(node, "ti,rev_offs", index, &prop);
+	if (!ret)
+		sysc->rev_offs = prop;
+
+	ret = of_property_read_u32_index(node, "ti,sysc_offs", index, &prop);
+	if (!ret)
+		sysc->sysc_offs = prop;
+
+	ret = of_property_read_u32_index(node, "ti,syss_offs", index, &prop);
+	if (!ret)
+		sysc->syss_offs = prop;
+
+	ret = of_property_read_u32_index(node, "ti,sysc_flags", index, &prop);
+	if (!ret)
+		sysc->sysc_flags = prop & 0xffff;
+
+	ret = of_property_read_u32_index(node, "ti,srst_udelay", index, &prop);
+	if (!ret)
+		sysc->srst_udelay = prop & 0xff;
+
+	ret = of_property_read_u32_index(node, "ti,idlemodes", index, &prop);
+	if (!ret)
+		sysc->idlemodes = prop & 0xff;
+
+	ret = of_property_read_u32_index(node, "ti,clockact", index, &prop);
+	if (!ret)
+		sysc->clockact = prop & 0xff;
+
+	ret = of_property_read_u32_index(node, "ti,sysc_type", index, &prop);
+	if (ret)
+		prop = 1;
+
+	switch (prop) {
+	case 2:
+		sysc->sysc_fields = &omap_hwmod_sysc_type2;
+		break;
+	case 3:
+		sysc->sysc_fields = &omap_hwmod_sysc_type3;
+		break;
+	case 1:
+	default:
+		sysc->sysc_fields = &omap_hwmod_sysc_type1;
+	}
+	class->sysc = sysc;
+	oh->class = class;
+
+	return 0;
+}
+
 /**
  * _init - initialize internal data for the hwmod @oh
  * @oh: struct omap_hwmod *
@@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		else if (np && index)
 			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
 				oh->name, np->name);
+
+		if (np) {
+			r = omap_hwmod_init_sysc(np, oh, 0);
+			if (r)
+				pr_warn("omap_hwmod: %s missing sysc dt data\n", oh->name);
+		}
 	}
 
 	if (oh->class->sysc) {
@@ -2673,8 +2789,7 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
  * already has been registered by the same name; -EINVAL if the
  * omap_hwmod is in the wrong state, if @oh is NULL, if the
  * omap_hwmod's class field is NULL; if the omap_hwmod is missing a
- * name, or if the omap_hwmod's class is missing a name; or 0 upon
- * success.
+ * name, or 0 upon success.
  *
  * XXX The data should be copied into bootmem, so the original data
  * should be marked __initdata and freed after init.  This would allow
@@ -2684,8 +2799,7 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
  */
 static int __init _register(struct omap_hwmod *oh)
 {
-	if (!oh || !oh->name || !oh->class || !oh->class->name ||
-	    (oh->_state != _HWMOD_STATE_UNKNOWN))
+	if (!oh || !oh->name || oh->_state != _HWMOD_STATE_UNKNOWN)
 		return -EINVAL;
 
 	pr_debug("omap_hwmod: %s: registering\n", oh->name);

Thanks and regards,
Lokesh


 It just
> so happens that we're moving that data to DeviceTree
> in a follow-up commit so we need to allow the
> registration of HWMODs with a valid omap_hwmod_class
> pointer.
> 
> When the device is built from DT, we will allocate and
> populate struct omap_hwmod_class based on DT data.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index cbb908d..2355764 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -504,6 +504,9 @@ static int _set_dmadisable(struct omap_hwmod *oh)
>  	u32 v;
>  	u32 dmadisable_mask;
>  
> +	if (!oh->class)
> +		return -EINVAL;
> +
>  	if (!oh->class->sysc ||
>  	    !(oh->class->sysc->sysc_flags & SYSC_HAS_DMADISABLE))
>  		return -EINVAL;
> @@ -1843,7 +1846,7 @@ static int _ocp_softreset(struct omap_hwmod *oh)
>  	int c = 0;
>  	int ret = 0;
>  
> -	if (!oh->class->sysc ||
> +	if (!oh->class || !oh->class->sysc ||
>  	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
>  		return -ENOENT;
>  
> @@ -1937,12 +1940,13 @@ static int _reset(struct omap_hwmod *oh)
>  
>  	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
>  
> -	if (oh->class->reset) {
> +	if (oh->class && oh->class->reset) {
>  		r = oh->class->reset(oh);
>  	} else {
>  		if (oh->rst_lines_cnt > 0) {
> -			for (i = 0; i < oh->rst_lines_cnt; i++)
> +			for (i = 0; i < oh->rst_lines_cnt; i++) {
>  				_assert_hardreset(oh, oh->rst_lines[i].name);
> +			}
>  			return 0;
>  		} else {
>  			r = _ocp_softreset(oh);
> @@ -1958,7 +1962,7 @@ static int _reset(struct omap_hwmod *oh)
>  	 * softreset.  The _enable() function should be split to avoid
>  	 * the rewrite of the OCP_SYSCONFIG register.
>  	 */
> -	if (oh->class->sysc) {
> +	if (oh->class && oh->class->sysc) {
>  		_update_sysc_cache(oh);
>  		_enable_sysc(oh);
>  	}
> @@ -2036,7 +2040,7 @@ static int _omap4_get_context_lost(struct omap_hwmod *oh)
>   */
>  static int _enable_preprogram(struct omap_hwmod *oh)
>  {
> -	if (!oh->class->enable_preprogram)
> +	if (!oh->class || !oh->class->enable_preprogram)
>  		return 0;
>  
>  	return oh->class->enable_preprogram(oh);
> @@ -2145,7 +2149,7 @@ static int _enable(struct omap_hwmod *oh)
>  		oh->_state = _HWMOD_STATE_ENABLED;
>  
>  		/* Access the sysconfig only if the target is ready */
> -		if (oh->class->sysc) {
> +		if (oh->class && oh->class->sysc) {
>  			if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
>  				_update_sysc_cache(oh);
>  			_enable_sysc(oh);
> @@ -2186,7 +2190,7 @@ static int _idle(struct omap_hwmod *oh)
>  	if (_are_all_hardreset_lines_asserted(oh))
>  		return 0;
>  
> -	if (oh->class->sysc)
> +	if (oh->class && oh->class->sysc)
>  		_idle_sysc(oh);
>  	_del_initiator_dep(oh, mpu_oh);
>  
> @@ -2244,7 +2248,7 @@ static int _shutdown(struct omap_hwmod *oh)
>  
>  	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
>  
> -	if (oh->class->pre_shutdown) {
> +	if (oh->class && oh->class->pre_shutdown) {
>  		prev_state = oh->_state;
>  		if (oh->_state == _HWMOD_STATE_IDLE)
>  			_enable(oh);
> @@ -2256,7 +2260,7 @@ static int _shutdown(struct omap_hwmod *oh)
>  		}
>  	}
>  
> -	if (oh->class->sysc) {
> +	if (oh->class && oh->class->sysc) {
>  		if (oh->_state == _HWMOD_STATE_IDLE)
>  			_enable(oh);
>  		_shutdown_sysc(oh);
> @@ -2451,7 +2455,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
>  				oh->name, np->name);
>  	}
>  
> -	if (oh->class->sysc) {
> +	if (oh->class && oh->class->sysc) {
>  		r = _init_mpu_rt_base(oh, NULL, index, np);
>  		if (r < 0) {
>  			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
> @@ -2684,8 +2688,7 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
>   */
>  static int __init _register(struct omap_hwmod *oh)
>  {
> -	if (!oh || !oh->name || !oh->class || !oh->class->name ||
> -	    (oh->_state != _HWMOD_STATE_UNKNOWN))
> +	if (!oh || !oh->name || (oh->_state != _HWMOD_STATE_UNKNOWN))
>  		return -EINVAL;
>  
>  	pr_debug("omap_hwmod: %s: registering\n", oh->name);
> @@ -3942,6 +3945,9 @@ int omap_hwmod_for_each_by_class(const char *classname,
>  		 __func__, classname);
>  
>  	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
> +		if (!temp_oh->class)
> +			continue;
> +
>  		if (!strcmp(temp_oh->class->name, classname)) {
>  			pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
>  				 __func__, temp_oh->name);
> 
