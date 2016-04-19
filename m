From: john@metanate.com (John Keeping)
Date: Tue, 19 Apr 2016 10:06:30 +0100
Subject: [PATCH] drm/rockchip: get rid of rockchip_drm_crtc_mode_config
In-Reply-To: <57159B37.9050806@rock-chips.com>
References: <1460948611-32259-1-git-send-email-mark.yao@rock-chips.com>
 <20160418102538.0ed730ca.john@metanate.com>
 <57159B37.9050806@rock-chips.com>
Message-ID: <20160419100630.06518b63.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Apr 2016 10:43:03 +0800, Mark yao wrote:

> On 2016?04?18? 17:25, John Keeping wrote:
> > On Mon, 18 Apr 2016 11:03:31 +0800, Mark Yao wrote:
> >  
> >> >We need to take care of the vop status when use
> >> >rockchip_drm_crtc_mode_config, if vop is disabled,
> >> >the function would failed, that is terrible.
> >> >
> >> >Save connector type and output mode on drm_display_mode->private_flags
> >> >at encoder mode_fixup, then we can configure the type and mode safely
> >> >on crtc mode_set.  
> > Since Rockchip is atomic, shouldn't this be using atomic_check hooks and
> > a subclassed crtc_state structure?
> >  
> 
> I try to use atomic_check with crtc_state, but it seems not easy,
> there are two value need transmit from connector to vop: connector type 
> and out_mode
> 
> the connector type I think we can loop the atomic state to find the 
> connector type.
> but the out_mode is a custom value, I can't find a generic way to 
> transmit it with atomic state.
> 
> BTW, I think on atomic side, the drm_display_mode is under control by 
> atomic state,
> and the mode->private_flags is not use by drm framework, I found i915 
> and gma500 also use
> mode->private_flags to transmit custom value.
> 
> So I think it's no problem using mode->private_flags.

The documentation for drm_display_mode::private says:

    It shouldn't be used by atomic drivers since they can store any
    additional data by subclassing state structures.

This applies to private_flags as well.

I think this means that we should do something like the patch below
(which isn't even compile tested and doesn't cover implementing
drm_encoder_helper_funcs::atomic_check on all of the encoders):

-- >8 --
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 00d17d71aa4c..9d65fa9188f4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -31,6 +31,14 @@
 struct drm_device;
 struct drm_connector;
 
+struct rockchip_crtc_state {
+	struct drm_crtc_state base;
+	int output_type;
+	int output_mode;
+};
+
+#define to_rockchip_crtc_state(s) container_of(x, struct rockchip_crtc_state, base)
+
 /*
  * Rockchip drm private crtc funcs.
  * @enable_vblank: enable crtc vblank irq.
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a619f120f801..5cdf3123e1eb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1044,13 +1044,34 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
 	drm_crtc_cleanup(crtc);
 }
 
+static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
+{
+	struct rockchip_crtc_state *rockchip_state;
+
+	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	if (!rockchip_state)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &rockchip_state->base);
+	return &rockchip_state->base;
+}
+
+static void vop_crtc_destroy_state(struct drm_crtc *crtc,
+				   struct drm_crtc_state *state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(state);
+
+	__drm_atomic_helper_crtc_destroy_state(crtc, &s->base);
+	kfree(s);
+}
+
 static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = vop_crtc_destroy,
 	.reset = drm_atomic_helper_crtc_reset,
-	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state = vop_crtc_duplicate_state,
+	.atomic_destroy_state = vop_crtc_destroy_state,
 };
 
 static bool vop_win_pending_is_complete(struct vop_win *vop_win)
