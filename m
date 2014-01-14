From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 15 Jan 2014 00:25:10 +0100
Subject: [Intel-gfx] [PATCH 1/2] drm: share drm_add_fake_info_node
In-Reply-To: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
References: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
Message-ID: <20140114232510.GV4770@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 06:14:06AM -0800, Ben Widawsky wrote:
> Both i915 and Armada had the exact same implementation. For an upcoming
> patch, I'd like to call this function from two different source files in
> i915, and having it available externally helps there too.
> 
> While moving, add 'debugfs_' to the name in order to match the other drm
> debugfs helper functions.
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: intel-gfx at lists.freedesktop.org
> Signed-off-by: Ben Widawsky <ben@bwidawsk.net>

drm_debugfs_create_files in drm_debugfs.c has the almost same code again.
Now the problem here is that the interface is a bit botched up, since all
the users in i915 and armada actaully faile to clean up teh debugfs dentry
if drm_add_fake_info_node.

So I think the right approach is to extrace a new drm_debugfs_create_node
helper which is used by i915, armada and drm_debugfs_create_files. Also I
think it's better to split this up into a drm core patch and then
i915/armada driver patches, for easier merging.
-Daniel

> ---
>  drivers/gpu/drm/armada/armada_debugfs.c | 24 +-----------------------
>  drivers/gpu/drm/drm_debugfs.c           | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/i915/i915_debugfs.c     | 32 +++-----------------------------
>  include/drm/drmP.h                      |  9 +++++++++
>  4 files changed, 37 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
> index 471e456..02f2978 100644
> --- a/drivers/gpu/drm/armada/armada_debugfs.c
> +++ b/drivers/gpu/drm/armada/armada_debugfs.c
> @@ -107,28 +107,6 @@ static struct drm_info_list armada_debugfs_list[] = {
>  };
>  #define ARMADA_DEBUGFS_ENTRIES ARRAY_SIZE(armada_debugfs_list)
>  
> -static int drm_add_fake_info_node(struct drm_minor *minor, struct dentry *ent,
> -	const void *key)
> -{
> -	struct drm_info_node *node;
> -
> -	node = kmalloc(sizeof(struct drm_info_node), GFP_KERNEL);
> -	if (node == NULL) {
> -		debugfs_remove(ent);
> -		return -ENOMEM;
> -	}
> -
> -	node->minor = minor;
> -	node->dent = ent;
> -	node->info_ent = (void *) key;
> -
> -	mutex_lock(&minor->debugfs_lock);
> -	list_add(&node->list, &minor->debugfs_list);
> -	mutex_unlock(&minor->debugfs_lock);
> -
> -	return 0;
> -}
> -
>  static int armada_debugfs_create(struct dentry *root, struct drm_minor *minor,
>  	const char *name, umode_t mode, const struct file_operations *fops)
>  {
> @@ -136,7 +114,7 @@ static int armada_debugfs_create(struct dentry *root, struct drm_minor *minor,
>  
>  	de = debugfs_create_file(name, mode, root, minor->dev, fops);
>  
> -	return drm_add_fake_info_node(minor, de, fops);
> +	return drm_debugfs_add_fake_info_node(minor, de, fops);
>  }
>  
>  int armada_drm_debugfs_init(struct drm_minor *minor)
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index b4b51d4..1edaac0 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -237,5 +237,29 @@ int drm_debugfs_cleanup(struct drm_minor *minor)
>  	return 0;
>  }
>  
> +int drm_debugfs_add_fake_info_node(struct drm_minor *minor,
> +				   struct dentry *ent,
> +				   const void *key)
> +{
> +	struct drm_info_node *node;
> +
> +	node = kmalloc(sizeof(*node), GFP_KERNEL);
> +	if (node == NULL) {
> +		debugfs_remove(ent);
> +		return -ENOMEM;
> +	}
> +
> +	node->minor = minor;
> +	node->dent = ent;
> +	node->info_ent = (void *) key;
> +
> +	mutex_lock(&minor->debugfs_lock);
> +	list_add(&node->list, &minor->debugfs_list);
> +	mutex_unlock(&minor->debugfs_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_debugfs_add_fake_info_node);
> +
>  #endif /* CONFIG_DEBUG_FS */
>  
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 430eb3e..f2ef30c 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -51,32 +51,6 @@ static const char *yesno(int v)
>  	return v ? "yes" : "no";
>  }
>  
> -/* As the drm_debugfs_init() routines are called before dev->dev_private is
> - * allocated we need to hook into the minor for release. */
> -static int
> -drm_add_fake_info_node(struct drm_minor *minor,
> -		       struct dentry *ent,
> -		       const void *key)
> -{
> -	struct drm_info_node *node;
> -
> -	node = kmalloc(sizeof(*node), GFP_KERNEL);
> -	if (node == NULL) {
> -		debugfs_remove(ent);
> -		return -ENOMEM;
> -	}
> -
> -	node->minor = minor;
> -	node->dent = ent;
> -	node->info_ent = (void *) key;
> -
> -	mutex_lock(&minor->debugfs_lock);
> -	list_add(&node->list, &minor->debugfs_list);
> -	mutex_unlock(&minor->debugfs_lock);
> -
> -	return 0;
> -}
> -
>  static int i915_capabilities(struct seq_file *m, void *data)
>  {
>  	struct drm_info_node *node = (struct drm_info_node *) m->private;
> @@ -2148,7 +2122,7 @@ static int i915_pipe_crc_create(struct dentry *root, struct drm_minor *minor,
>  	if (!ent)
>  		return -ENOMEM;
>  
> -	return drm_add_fake_info_node(minor, ent, info);
> +	return drm_debugfs_add_fake_info_node(minor, ent, info);
>  }
>  
>  static const char * const pipe_crc_sources[] = {
> @@ -3164,7 +3138,7 @@ static int i915_forcewake_create(struct dentry *root, struct drm_minor *minor)
>  	if (!ent)
>  		return -ENOMEM;
>  
> -	return drm_add_fake_info_node(minor, ent, &i915_forcewake_fops);
> +	return drm_debugfs_add_fake_info_node(minor, ent, &i915_forcewake_fops);
>  }
>  
>  static int i915_debugfs_create(struct dentry *root,
> @@ -3182,7 +3156,7 @@ static int i915_debugfs_create(struct dentry *root,
>  	if (!ent)
>  		return -ENOMEM;
>  
> -	return drm_add_fake_info_node(minor, ent, fops);
> +	return drm_debugfs_add_fake_info_node(minor, ent, fops);
>  }
>  
>  static const struct drm_info_list i915_debugfs_list[] = {
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 2fe9b5d..5788fb1 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -1471,6 +1471,9 @@ extern int drm_debugfs_create_files(const struct drm_info_list *files,
>  extern int drm_debugfs_remove_files(const struct drm_info_list *files,
>  				    int count, struct drm_minor *minor);
>  extern int drm_debugfs_cleanup(struct drm_minor *minor);
> +extern int drm_debugfs_add_fake_info_node(struct drm_minor *minor,
> +					  struct dentry *ent,
> +					  const void *key);
>  #else
>  static inline int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  				   struct dentry *root)
> @@ -1495,6 +1498,12 @@ static inline int drm_debugfs_cleanup(struct drm_minor *minor)
>  {
>  	return 0;
>  }
> +static int drm_debugfs_add_fake_info_node(struct drm_minor *minor,
> +					  struct dentry *ent,
> +					  const void *key)
> +{
> +	return 0;
> +}
>  #endif
>  
>  				/* Info file support */
> -- 
> 1.8.5.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
