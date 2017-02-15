From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 16 Feb 2017 04:14:28 +0800
Subject: [xlnx:master 117/322] drivers/gpu/drm/xylon/xylon_crtc.c:224:3:
 error: implicit declaration of function 'drm_vblank_put'
Message-ID: <201702160421.dTSlg7jn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   3b135b44d6c189c52994efe4ca1502cca8382633
commit: 15add85f47f37fde03343fb06bb7240dc61155e6 [117/322] Merge tag 'v4.8' into master
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 15add85f47f37fde03343fb06bb7240dc61155e6
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/xylon/xylon_crtc.c: In function 'xylon_drm_crtc_cancel_page_flip':
>> drivers/gpu/drm/xylon/xylon_crtc.c:223:14: error: 'struct drm_pending_event' has no member named 'destroy'
      event->base.destroy(&event->base);
                 ^
>> drivers/gpu/drm/xylon/xylon_crtc.c:224:3: error: implicit declaration of function 'drm_vblank_put' [-Werror=implicit-function-declaration]
      drm_vblank_put(dev, 0);
      ^~~~~~~~~~~~~~
   drivers/gpu/drm/xylon/xylon_crtc.c: In function 'xylon_drm_crtc_vblank_handler':
>> drivers/gpu/drm/xylon/xylon_crtc.c:339:3: error: implicit declaration of function 'drm_send_vblank_event' [-Werror=implicit-function-declaration]
      drm_send_vblank_event(dev, 0, event);
      ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/drm_vblank_put +224 drivers/gpu/drm/xylon/xylon_crtc.c

e8c87b41 Davor Joja   2014-03-24  217  	unsigned long flags;
e8c87b41 Davor Joja   2014-03-24  218  
e8c87b41 Davor Joja   2014-03-24  219  	spin_lock_irqsave(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  220  	event = crtc->event;
e8c87b41 Davor Joja   2014-03-24  221  	if (event && (event->base.file_priv == file)) {
e8c87b41 Davor Joja   2014-03-24  222  		crtc->event = NULL;
e8c87b41 Davor Joja   2014-03-24 @223  		event->base.destroy(&event->base);
e8c87b41 Davor Joja   2014-03-24 @224  		drm_vblank_put(dev, 0);
e8c87b41 Davor Joja   2014-03-24  225  	}
e8c87b41 Davor Joja   2014-03-24  226  	spin_unlock_irqrestore(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  227  }
e8c87b41 Davor Joja   2014-03-24  228  
e8c87b41 Davor Joja   2014-03-24  229  static int xylon_drm_crtc_page_flip(struct drm_crtc *base_crtc,
e8c87b41 Davor Joja   2014-03-24  230  				    struct drm_framebuffer *fb,
e8c87b41 Davor Joja   2014-03-24  231  				    struct drm_pending_vblank_event *event,
e8c87b41 Davor Joja   2014-03-24  232  				    u32 page_flip_flags)
e8c87b41 Davor Joja   2014-03-24  233  {
e8c87b41 Davor Joja   2014-03-24  234  	struct drm_device *dev = base_crtc->dev;
e8c87b41 Davor Joja   2014-03-24  235  	struct xylon_drm_crtc *crtc = to_xylon_crtc(base_crtc);
e8c87b41 Davor Joja   2014-03-24  236  	unsigned long flags;
e8c87b41 Davor Joja   2014-03-24  237  	int ret;
e8c87b41 Davor Joja   2014-03-24  238  
e8c87b41 Davor Joja   2014-03-24  239  	spin_lock_irqsave(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  240  	if (crtc->event != NULL) {
e8c87b41 Davor Joja   2014-03-24  241  		spin_unlock_irqrestore(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  242  		return -EBUSY;
e8c87b41 Davor Joja   2014-03-24  243  	}
e8c87b41 Davor Joja   2014-03-24  244  	spin_unlock_irqrestore(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  245  
0c49ff42 Davor Joja   2014-11-18  246  	ret = xylon_drm_plane_fb_set(base_crtc->primary, fb,
e8c87b41 Davor Joja   2014-03-24  247  				     0, 0,
e8c87b41 Davor Joja   2014-03-24  248  				     base_crtc->hwmode.hdisplay,
e8c87b41 Davor Joja   2014-03-24  249  				     base_crtc->hwmode.vdisplay,
e8c87b41 Davor Joja   2014-03-24  250  				     base_crtc->x, base_crtc->y,
e8c87b41 Davor Joja   2014-03-24  251  				     base_crtc->hwmode.hdisplay,
e8c87b41 Davor Joja   2014-03-24  252  				     base_crtc->hwmode.vdisplay);
e8c87b41 Davor Joja   2014-03-24  253  	if (ret) {
e8c87b41 Davor Joja   2014-03-24  254  		DRM_ERROR("failed mode set plane\n");
e8c87b41 Davor Joja   2014-03-24  255  		return ret;
e8c87b41 Davor Joja   2014-03-24  256  	}
e8c87b41 Davor Joja   2014-03-24  257  
0c49ff42 Davor Joja   2014-11-18  258  	xylon_drm_plane_commit(base_crtc->primary);
e8c87b41 Davor Joja   2014-03-24  259  
b2f5a183 Davor Joja   2014-09-15  260  	base_crtc->primary->fb = fb;
e8c87b41 Davor Joja   2014-03-24  261  
e8c87b41 Davor Joja   2014-03-24  262  	if (event) {
e8c87b41 Davor Joja   2014-03-24  263  		event->pipe = 0;
15add85f Michal Simek 2017-01-24  264  		drm_crtc_vblank_get(0);
e8c87b41 Davor Joja   2014-03-24  265  		spin_lock_irqsave(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  266  		crtc->event = event;
e8c87b41 Davor Joja   2014-03-24  267  		spin_unlock_irqrestore(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  268  	}
e8c87b41 Davor Joja   2014-03-24  269  
e8c87b41 Davor Joja   2014-03-24  270  	return 0;
e8c87b41 Davor Joja   2014-03-24  271  }
e8c87b41 Davor Joja   2014-03-24  272  
e8c87b41 Davor Joja   2014-03-24  273  static int xylon_drm_crtc_set_property(struct drm_crtc *base_crtc,
e8c87b41 Davor Joja   2014-03-24  274  				       struct drm_property *property,
e99d4bb3 Davor Joja   2014-06-23  275  				       u64 value)
e8c87b41 Davor Joja   2014-03-24  276  {
e8c87b41 Davor Joja   2014-03-24  277  	struct xylon_drm_crtc *crtc = to_xylon_crtc(base_crtc);
e99d4bb3 Davor Joja   2014-06-23  278  	struct xylon_drm_crtc_properties *props = &crtc->properties;
e8c87b41 Davor Joja   2014-03-24  279  	struct xylon_drm_plane_op op;
e99d4bb3 Davor Joja   2014-06-23  280  	u32 val = (u32)value;
cb225630 Davor Joja   2014-07-11  281  	s64 x = -1;
cb225630 Davor Joja   2014-07-11  282  	s64 y = -1;
e99d4bb3 Davor Joja   2014-06-23  283  
e99d4bb3 Davor Joja   2014-06-23  284  	if (property == props->bg_color) {
e99d4bb3 Davor Joja   2014-06-23  285  		op.id = XYLON_DRM_PLANE_OP_ID_BACKGROUND_COLOR;
e99d4bb3 Davor Joja   2014-06-23  286  		op.param = val;
e99d4bb3 Davor Joja   2014-06-23  287  	} else if (property == props->layer_update) {
e99d4bb3 Davor Joja   2014-06-23  288  		xylon_cvc_ctrl(crtc->cvc, LOGICVC_LAYER_UPDATE,
e99d4bb3 Davor Joja   2014-06-23  289  			       (bool)val);
e99d4bb3 Davor Joja   2014-06-23  290  	} else if (property == props->pixel_data_polarity) {
e99d4bb3 Davor Joja   2014-06-23  291  		xylon_cvc_ctrl(crtc->cvc, LOGICVC_PIXEL_DATA_INVERT,
e99d4bb3 Davor Joja   2014-06-23  292  			       (bool)val);
e99d4bb3 Davor Joja   2014-06-23  293  	} else if (property == props->pixel_data_trigger) {
e99d4bb3 Davor Joja   2014-06-23  294  		xylon_cvc_ctrl(crtc->cvc, LOGICVC_PIXEL_DATA_TRIGGER_INVERT,
e99d4bb3 Davor Joja   2014-06-23  295  			       (bool)val);
e8c87b41 Davor Joja   2014-03-24  296  	} else {
e8c87b41 Davor Joja   2014-03-24  297  		return -EINVAL;
e8c87b41 Davor Joja   2014-03-24  298  	}
e8c87b41 Davor Joja   2014-03-24  299  
cb225630 Davor Joja   2014-07-11  300  	if (x > -1 && y > -1) {
0c49ff42 Davor Joja   2014-11-18  301  		if (xylon_drm_plane_fb_set(base_crtc->primary,
b2f5a183 Davor Joja   2014-09-15  302  					   base_crtc->primary->fb,
cb225630 Davor Joja   2014-07-11  303  					   (u32)x, (u32)y,
cb225630 Davor Joja   2014-07-11  304  					   base_crtc->hwmode.hdisplay - x,
cb225630 Davor Joja   2014-07-11  305  					   base_crtc->hwmode.vdisplay - y,
cb225630 Davor Joja   2014-07-11  306  					   base_crtc->x, base_crtc->y,
cb225630 Davor Joja   2014-07-11  307  					   base_crtc->hwmode.hdisplay - x,
cb225630 Davor Joja   2014-07-11  308  					   base_crtc->hwmode.vdisplay - y))
cb225630 Davor Joja   2014-07-11  309  			DRM_ERROR("failed set position\n");
cb225630 Davor Joja   2014-07-11  310  		else
0c49ff42 Davor Joja   2014-11-18  311  			xylon_drm_plane_commit(base_crtc->primary);
cb225630 Davor Joja   2014-07-11  312  	} else {
0c49ff42 Davor Joja   2014-11-18  313  		xylon_drm_plane_op(base_crtc->primary, &op);
cb225630 Davor Joja   2014-07-11  314  	}
e8c87b41 Davor Joja   2014-03-24  315  
e8c87b41 Davor Joja   2014-03-24  316  	return 0;
e8c87b41 Davor Joja   2014-03-24  317  }
e8c87b41 Davor Joja   2014-03-24  318  
e8c87b41 Davor Joja   2014-03-24  319  static struct drm_crtc_funcs xylon_drm_crtc_funcs = {
e8c87b41 Davor Joja   2014-03-24  320  	.destroy = xylon_drm_crtc_destroy,
e8c87b41 Davor Joja   2014-03-24  321  	.set_config = drm_crtc_helper_set_config,
e8c87b41 Davor Joja   2014-03-24  322  	.page_flip = xylon_drm_crtc_page_flip,
e8c87b41 Davor Joja   2014-03-24  323  	.set_property = xylon_drm_crtc_set_property,
e8c87b41 Davor Joja   2014-03-24  324  };
e8c87b41 Davor Joja   2014-03-24  325  
e8c87b41 Davor Joja   2014-03-24  326  static void xylon_drm_crtc_vblank_handler(struct drm_crtc *base_crtc)
e8c87b41 Davor Joja   2014-03-24  327  {
e8c87b41 Davor Joja   2014-03-24  328  	struct drm_device *dev = base_crtc->dev;
e8c87b41 Davor Joja   2014-03-24  329  	struct drm_pending_vblank_event *event;
e8c87b41 Davor Joja   2014-03-24  330  	struct xylon_drm_crtc *crtc = to_xylon_crtc(base_crtc);
e8c87b41 Davor Joja   2014-03-24  331  	unsigned long flags;
e8c87b41 Davor Joja   2014-03-24  332  
e8c87b41 Davor Joja   2014-03-24  333  	drm_handle_vblank(dev, 0);
e8c87b41 Davor Joja   2014-03-24  334  
e8c87b41 Davor Joja   2014-03-24  335  	spin_lock_irqsave(&dev->event_lock, flags);
e8c87b41 Davor Joja   2014-03-24  336  	event = crtc->event;
e8c87b41 Davor Joja   2014-03-24  337  	crtc->event = NULL;
e8c87b41 Davor Joja   2014-03-24  338  	if (event) {
e8c87b41 Davor Joja   2014-03-24 @339  		drm_send_vblank_event(dev, 0, event);
e8c87b41 Davor Joja   2014-03-24  340  		drm_vblank_put(dev, 0);
e8c87b41 Davor Joja   2014-03-24  341  	}
e8c87b41 Davor Joja   2014-03-24  342  	spin_unlock_irqrestore(&dev->event_lock, flags);

:::::: The code at line 224 was first introduced by commit
:::::: e8c87b415c98ef5f5ceecbe62cc53f956cd9cd94 gpu: drm: xylon: Add a crtc support

:::::: TO: Davor Joja <davorjoja@logicbricks.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55703 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/b45ff483/attachment-0001.gz>
