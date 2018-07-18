From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Jul 2018 05:02:19 +0800
Subject: [PATCH v2] drm/sun4i: sun4i: Introduce a quirk for lowest plane
 alpha support
In-Reply-To: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
References: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
Message-ID: <201807190447.oi0SxKqP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on v4.18-rc5 next-20180718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Kocialkowski/drm-sun4i-sun4i-Introduce-a-quirk-for-lowest-plane-alpha-support/20180719-030611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_atomic_check':
>> drivers/gpu/drm/sun4i/sun4i_backend.c:560:13: error: 'struct sun4i_backend' has no member named 'quirks'
     if (backend->quirks->supports_lowest_plane_alpha)
                ^~
   drivers/gpu/drm/sun4i/sun4i_backend.c:569:14: error: 'struct sun4i_backend' has no member named 'quirks'
     if (!backend->quirks->supports_lowest_plane_alpha &&
                 ^~

vim +560 drivers/gpu/drm/sun4i/sun4i_backend.c

   463	
   464	static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
   465					      struct drm_crtc_state *crtc_state)
   466	{
   467		struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] = { 0 };
   468		struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
   469		struct drm_atomic_state *state = crtc_state->state;
   470		struct drm_device *drm = state->dev;
   471		struct drm_plane *plane;
   472		unsigned int num_planes = 0;
   473		unsigned int num_alpha_planes = 0;
   474		unsigned int num_frontend_planes = 0;
   475		unsigned int num_alpha_planes_max = 1;
   476		unsigned int num_yuv_planes = 0;
   477		unsigned int current_pipe = 0;
   478		unsigned int i;
   479	
   480		DRM_DEBUG_DRIVER("Starting checking our planes\n");
   481	
   482		if (!crtc_state->planes_changed)
   483			return 0;
   484	
   485		drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
   486			struct drm_plane_state *plane_state =
   487				drm_atomic_get_plane_state(state, plane);
   488			struct sun4i_layer_state *layer_state =
   489				state_to_sun4i_layer_state(plane_state);
   490			struct drm_framebuffer *fb = plane_state->fb;
   491			struct drm_format_name_buf format_name;
   492	
   493			if (sun4i_backend_plane_uses_frontend(plane_state)) {
   494				DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
   495						 plane->index);
   496	
   497				layer_state->uses_frontend = true;
   498				num_frontend_planes++;
   499			} else {
   500				layer_state->uses_frontend = false;
   501			}
   502	
   503			DRM_DEBUG_DRIVER("Plane FB format is %s\n",
   504					 drm_get_format_name(fb->format->format,
   505							     &format_name));
   506			if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
   507				num_alpha_planes++;
   508	
   509			if (sun4i_backend_format_is_yuv(fb->format->format)) {
   510				DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
   511				num_yuv_planes++;
   512			}
   513	
   514			DRM_DEBUG_DRIVER("Plane zpos is %d\n",
   515					 plane_state->normalized_zpos);
   516	
   517			/* Sort our planes by Zpos */
   518			plane_states[plane_state->normalized_zpos] = plane_state;
   519	
   520			num_planes++;
   521		}
   522	
   523		/* All our planes were disabled, bail out */
   524		if (!num_planes)
   525			return 0;
   526	
   527		/*
   528		 * The hardware is a bit unusual here.
   529		 *
   530		 * Even though it supports 4 layers, it does the composition
   531		 * in two separate steps.
   532		 *
   533		 * The first one is assigning a layer to one of its two
   534		 * pipes. If more that 1 layer is assigned to the same pipe,
   535		 * and if pixels overlaps, the pipe will take the pixel from
   536		 * the layer with the highest priority.
   537		 *
   538		 * The second step is the actual alpha blending, that takes
   539		 * the two pipes as input, and uses the potential alpha
   540		 * component to do the transparency between the two.
   541		 *
   542		 * This two-step scenario makes us unable to guarantee a
   543		 * robust alpha blending between the 4 layers in all
   544		 * situations, since this means that we need to have one layer
   545		 * with alpha at the lowest position of our two pipes.
   546		 *
   547		 * However, we cannot even do that on every platform, since the
   548		 * hardware has a bug where the lowest plane of the lowest pipe
   549		 * (pipe 0, priority 0), if it has any alpha, will discard the
   550		 * pixel data entirely and just display the pixels in the
   551		 * background color (black by default).
   552		 *
   553		 * This means that on the affected platforms, we effectively
   554		 * have only three valid configurations with alpha, all of them
   555		 * with the alpha being on pipe1 with the lowest position, which
   556		 * can be 1, 2 or 3 depending on the number of planes and their zpos.
   557		 */
   558	
   559		/* For platforms that are not affected by the issue described above. */
 > 560		if (backend->quirks->supports_lowest_plane_alpha)
   561			num_alpha_planes_max++;
   562	
   563		if (num_alpha_planes > num_alpha_planes_max) {
   564			DRM_DEBUG_DRIVER("Too many planes with alpha, rejecting...\n");
   565			return -EINVAL;
   566		}
   567	
   568		/* We can't have an alpha plane at the lowest position */
   569		if (!backend->quirks->supports_lowest_plane_alpha &&
   570		    (plane_states[0]->fb->format->has_alpha ||
   571		    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE)))
   572			return -EINVAL;
   573	
   574		for (i = 1; i < num_planes; i++) {
   575			struct drm_plane_state *p_state = plane_states[i];
   576			struct drm_framebuffer *fb = p_state->fb;
   577			struct sun4i_layer_state *s_state = state_to_sun4i_layer_state(p_state);
   578	
   579			/*
   580			 * The only alpha position is the lowest plane of the
   581			 * second pipe.
   582			 */
   583			if (fb->format->has_alpha || (p_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
   584				current_pipe++;
   585	
   586			s_state->pipe = current_pipe;
   587		}
   588	
   589		/* We can only have a single YUV plane at a time */
   590		if (num_yuv_planes > SUN4I_BACKEND_NUM_YUV_PLANES) {
   591			DRM_DEBUG_DRIVER("Too many planes with YUV, rejecting...\n");
   592			return -EINVAL;
   593		}
   594	
   595		if (num_frontend_planes > SUN4I_BACKEND_NUM_FRONTEND_LAYERS) {
   596			DRM_DEBUG_DRIVER("Too many planes going through the frontend, rejecting\n");
   597			return -EINVAL;
   598		}
   599	
   600		DRM_DEBUG_DRIVER("State valid with %u planes, %u alpha, %u video, %u YUV\n",
   601				 num_planes, num_alpha_planes, num_frontend_planes,
   602				 num_yuv_planes);
   603	
   604		return 0;
   605	}
   606	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66067 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/81deaa7e/attachment-0001.gz>
