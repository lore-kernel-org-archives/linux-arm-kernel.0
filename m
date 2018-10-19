From: lkp@intel.com (kbuild test robot)
Date: Fri, 19 Oct 2018 16:30:08 +0800
Subject: [PATCH v2 2/2] drm/exynos: decon: Make pixel blend mode
 configurable
In-Reply-To: <20181018093637eucas1p20c846b3959514f8c14a167342d53eba4~eqlNE4PfC1414614146eucas1p2R@eucas1p2.samsung.com>
References: <20181018093637eucas1p20c846b3959514f8c14a167342d53eba4~eqlNE4PfC1414614146eucas1p2R@eucas1p2.samsung.com>
Message-ID: <201810191642.Aho9udjF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-exynos/exynos-drm-next]
[also build test ERROR on v4.19-rc8 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoph-Manszewski/drm-exynos-decon-Make-plane-alpha-configurable/20181019-053544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/exynos/exynos5433_drm_decon.c: In function 'decon_win_set_pixfmt':
>> drivers/gpu/drm/exynos/exynos5433_drm_decon.c:337:3: error: 'pixel_alpha' undeclared (first use in this function); did you mean 'isalpha'?
      pixel_alpha = state->base.pixel_blend_mode;
      ^~~~~~~~~~~
      isalpha
   drivers/gpu/drm/exynos/exynos5433_drm_decon.c:337:3: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/exynos/exynos5433_drm_decon.c:385:3: error: too few arguments to function 'decon_win_set_bldmod'
      decon_win_set_bldmod(ctx, win, alpha);
      ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/exynos/exynos5433_drm_decon.c:298:13: note: declared here
    static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
                ^~~~~~~~~~~~~~~~~~~~

vim +337 drivers/gpu/drm/exynos/exynos5433_drm_decon.c

   326	
   327	static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
   328					 struct drm_framebuffer *fb)
   329	{
   330		struct exynos_drm_plane plane = ctx->planes[win];
   331		struct exynos_drm_plane_state *state =
   332			to_exynos_plane_state(plane.base.state);
   333		unsigned int alpha = state->base.alpha;
   334		unsigned long val;
   335	
   336		if (fb->format->has_alpha)
 > 337			pixel_alpha = state->base.pixel_blend_mode;
   338		else
   339			pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
   340	
   341		val = readl(ctx->addr + DECON_WINCONx(win));
   342		val &= WINCONx_ENWIN_F;
   343	
   344		switch (fb->format->format) {
   345		case DRM_FORMAT_XRGB1555:
   346			val |= WINCONx_BPPMODE_16BPP_I1555;
   347			val |= WINCONx_HAWSWP_F;
   348			val |= WINCONx_BURSTLEN_16WORD;
   349			break;
   350		case DRM_FORMAT_RGB565:
   351			val |= WINCONx_BPPMODE_16BPP_565;
   352			val |= WINCONx_HAWSWP_F;
   353			val |= WINCONx_BURSTLEN_16WORD;
   354			break;
   355		case DRM_FORMAT_XRGB8888:
   356			val |= WINCONx_BPPMODE_24BPP_888;
   357			val |= WINCONx_WSWP_F;
   358			val |= WINCONx_BURSTLEN_16WORD;
   359			break;
   360		case DRM_FORMAT_ARGB8888:
   361		default:
   362			val |= WINCONx_BPPMODE_32BPP_A8888;
   363			val |= WINCONx_WSWP_F;
   364			val |= WINCONx_BURSTLEN_16WORD;
   365			break;
   366		}
   367	
   368		DRM_DEBUG_KMS("cpp = %u\n", fb->format->cpp[0]);
   369	
   370		/*
   371		 * In case of exynos, setting dma-burst to 16Word causes permanent
   372		 * tearing for very small buffers, e.g. cursor buffer. Burst Mode
   373		 * switching which is based on plane size is not recommended as
   374		 * plane size varies a lot towards the end of the screen and rapid
   375		 * movement causes unstable DMA which results into iommu crash/tear.
   376		 */
   377	
   378		if (fb->width < MIN_FB_WIDTH_FOR_16WORD_BURST) {
   379			val &= ~WINCONx_BURSTLEN_MASK;
   380			val |= WINCONx_BURSTLEN_8WORD;
   381		}
   382		decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
   383	
   384		if (win > 0) {
 > 385			decon_win_set_bldmod(ctx, win, alpha);
   386			decon_win_set_bldeq(ctx, win, alpha, pixel_alpha);
   387		}
   388	}
   389	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40238 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181019/a513915c/attachment-0001.gz>
