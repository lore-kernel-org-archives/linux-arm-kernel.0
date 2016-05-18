From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 18 May 2016 19:17:08 +0200
Subject: [PATCH 5/5] drm: remove unused dev variables
In-Reply-To: <1463587653-3035181-6-git-send-email-arnd@arndb.de>
References: <1463587653-3035181-1-git-send-email-arnd@arndb.de>
 <1463587653-3035181-6-git-send-email-arnd@arndb.de>
Message-ID: <20160518171708.GJ27098@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 06:07:33PM +0200, Arnd Bergmann wrote:
> After drm_gem_object_lookup() was changed along with all its callers,
> we have several drivers that have unused variables:
> 
> drm/armada/armada_crtc.c: In function 'armada_drm_crtc_cursor_set':
> drm/armada/armada_crtc.c:900:21: error: unused variable 'dev' [-Werror=unused-variable]
> drm/nouveau/nouveau_gem.c: In function 'validate_init':
> drm/nouveau/nouveau_gem.c:371:21: error: unused variable 'dev' [-Werror=unused-variable]
> drm/nouveau/nv50_display.c: In function 'nv50_crtc_cursor_set':
> drm/nouveau/nv50_display.c:1308:21: error: unused variable 'dev' [-Werror=unused-variable]
> drm/radeon/radeon_cs.c: In function 'radeon_cs_parser_relocs':
> drm/radeon/radeon_cs.c:77:21: error: unused variable 'ddev' [-Werror=unused-variable]
> 
> This fixes all the instances I found with ARM randconfig builds so far.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a8ad0bd84f98 ("drm: Remove unused drm_device from drm_gem_object_lookup()")

Merged both fixup patches for the drm_gem_object_lookup change to
drm-misc. Sorry for the mess :(
-Daniel

> ---
>  drivers/gpu/drm/armada/armada_crtc.c   | 1 -
>  drivers/gpu/drm/nouveau/nouveau_gem.c  | 1 -
>  drivers/gpu/drm/nouveau/nv50_display.c | 1 -
>  drivers/gpu/drm/radeon/radeon_cs.c     | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> index a9b7e0f36513..3130aa8bcdd0 100644
> --- a/drivers/gpu/drm/armada/armada_crtc.c
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -897,7 +897,6 @@ static void cursor_update(void *data)
>  static int armada_drm_crtc_cursor_set(struct drm_crtc *crtc,
>  	struct drm_file *file, uint32_t handle, uint32_t w, uint32_t h)
>  {
> -	struct drm_device *dev = crtc->dev;
>  	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>  	struct armada_gem_object *obj = NULL;
>  	int ret;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 445a9e2fb91a..a030e218adf7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -368,7 +368,6 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
>  	      int nr_buffers, struct validate_op *op)
>  {
>  	struct nouveau_cli *cli = nouveau_cli(file_priv);
> -	struct drm_device *dev = chan->drm->dev;
>  	int trycnt = 0;
>  	int ret, i;
>  	struct nouveau_bo *res_bo = NULL;
> diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
> index 47761a92926e..ec2e67eb8980 100644
> --- a/drivers/gpu/drm/nouveau/nv50_display.c
> +++ b/drivers/gpu/drm/nouveau/nv50_display.c
> @@ -1305,7 +1305,6 @@ nv50_crtc_cursor_set(struct drm_crtc *crtc, struct drm_file *file_priv,
>  		     uint32_t handle, uint32_t width, uint32_t height)
>  {
>  	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
> -	struct drm_device *dev = crtc->dev;
>  	struct drm_gem_object *gem = NULL;
>  	struct nouveau_bo *nvbo = NULL;
>  	int ret = 0;
> diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
> index 271652963fa1..510ea371dacc 100644
> --- a/drivers/gpu/drm/radeon/radeon_cs.c
> +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> @@ -74,7 +74,6 @@ static void radeon_cs_buckets_get_list(struct radeon_cs_buckets *b,
>  
>  static int radeon_cs_parser_relocs(struct radeon_cs_parser *p)
>  {
> -	struct drm_device *ddev = p->rdev->ddev;
>  	struct radeon_cs_chunk *chunk;
>  	struct radeon_cs_buckets buckets;
>  	unsigned i;
> -- 
> 2.7.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
