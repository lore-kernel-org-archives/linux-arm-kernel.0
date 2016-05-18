From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 18 May 2016 16:33:21 +0800
Subject: [RFC 2/3] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <CACvgo52qc4E=MAGLoCaUH+GZuyvPexHchZnvuv-fF8P23e_1Uw@mail.gmail.com>
References: <1463053795-55455-1-git-send-email-yt.shen@mediatek.com>
 <1463053795-55455-3-git-send-email-yt.shen@mediatek.com>
 <CACvgo52qc4E=MAGLoCaUH+GZuyvPexHchZnvuv-fF8P23e_1Uw@mail.gmail.com>
Message-ID: <1463560401.8576.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emil,

On Tue, 2016-05-17 at 10:55 +0100, Emil Velikov wrote:
> Hi YT Shen,
> 
> On 12 May 2016 at 12:49,  <yt.shen@mediatek.com> wrote:
> > From: YT Shen <yt.shen@mediatek.com>
> >
> > This patch add support for the Mediatek MT2701 DISP subsystem.
> > There is only one OVL engine in MT2701, and we have shadow
> > register support here.
> >
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   49 ++++++---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   36 +++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   78 +++++++++-----
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  151 ++++++++++++++++++++-------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.h      |    2 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   63 +++++++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   15 +++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   72 +++++++++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    9 ++
> >  drivers/gpu/drm/mediatek/mtk_drm_gem.c      |    4 +
> >  10 files changed, 373 insertions(+), 106 deletions(-)
> >
> This patch does a bit too many things at once imho
>  - Renames existing macros
>  - Factors out helper functions - mtk_crtc_ddp_config and alike.
>  - Introduces *driver_data for existing hardware and uses it
>  - and adds support for the different hardware.
> 
> I'm no expert in the area, but it feels like you want to split things
> roughly as per above.
> A rather serious mali note and some "this should be const" follow
> suggestions inline.
Thanks for your suggestions.  I will split this patch into several small
patches.  They are easier to understand, and easier to review.
> 
> 
> >
> > +static struct mtk_ddp_comp_driver_data mt2701_ovl_driver_data = {
> > +       .ovl = {0x0040, 1 << 12, 0}
> > +};
> > +
> > +static struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
> > +       .ovl = {0x0f40, 0, 1 << 12}
> > +};
> > +
> These two should be const right ?
Yes, they should.
> 
> 
> >
> > +static struct mtk_ddp_comp_driver_data mt2701_rdma_driver_data = {
> > +       .rdma_fifo_pseudo_size = SZ_4K,
> > +};
> > +
> > +static struct mtk_ddp_comp_driver_data mt8173_rdma_driver_data = {
> > +       .rdma_fifo_pseudo_size = SZ_8K,
> > +};
> > +
> Same here.
OK.
> 
> 
> >
> > -#define MUTEX_MOD_DISP_OVL0            BIT(11)
> > -#define MUTEX_MOD_DISP_OVL1            BIT(12)
> > -#define MUTEX_MOD_DISP_RDMA0           BIT(13)
> > -#define MUTEX_MOD_DISP_RDMA1           BIT(14)
> > -#define MUTEX_MOD_DISP_RDMA2           BIT(15)
> > -#define MUTEX_MOD_DISP_WDMA0           BIT(16)
> > -#define MUTEX_MOD_DISP_WDMA1           BIT(17)
> > -#define MUTEX_MOD_DISP_COLOR0          BIT(18)
> > -#define MUTEX_MOD_DISP_COLOR1          BIT(19)
> > -#define MUTEX_MOD_DISP_AAL             BIT(20)
> > -#define MUTEX_MOD_DISP_GAMMA           BIT(21)
> > -#define MUTEX_MOD_DISP_UFOE            BIT(22)
> > -#define MUTEX_MOD_DISP_PWM0            BIT(23)
> > -#define MUTEX_MOD_DISP_PWM1            BIT(24)
> > -#define MUTEX_MOD_DISP_OD              BIT(25)
> > +#define MUTEX_MOD_MT8173_DISP_OVL0             BIT(11)
> > +#define MUTEX_MOD_MT8173_DISP_OVL1             BIT(12)
> > +#define MUTEX_MOD_MT8173_DISP_RDMA0            BIT(13)
> > +#define MUTEX_MOD_MT8173_DISP_RDMA1            BIT(14)
> > +#define MUTEX_MOD_MT8173_DISP_RDMA2            BIT(15)
> > +#define MUTEX_MOD_MT8173_DISP_WDMA0            BIT(16)
> > +#define MUTEX_MOD_MT8173_DISP_WDMA1            BIT(17)
> > +#define MUTEX_MOD_MT8173_DISP_COLOR0           BIT(18)
> > +#define MUTEX_MOD_MT8173_DISP_COLOR1           BIT(19)
> > +#define MUTEX_MOD_MT8173_DISP_AAL              BIT(20)
> > +#define MUTEX_MOD_MT8173_DISP_GAMMA            BIT(21)
> > +#define MUTEX_MOD_MT8173_DISP_UFOE             BIT(22)
> > +#define MUTEX_MOD_MT8173_DISP_PWM0             BIT(23)
> > +#define MUTEX_MOD_MT8173_DISP_PWM1             BIT(24)
> > +#define MUTEX_MOD_MT8173_DISP_OD               BIT(25)
> > +
> > +#define MUTEX_MOD_MT2701_DISP_OVL              BIT(3)
> > +#define MUTEX_MOD_MT2701_DISP_WDMA             BIT(6)
> > +#define MUTEX_MOD_MT2701_DISP_COLOR            BIT(7)
> > +#define MUTEX_MOD_MT2701_DISP_BLS              BIT(9)
> > +#define MUTEX_MOD_MT2701_DISP_RDMA0            BIT(10)
> > +#define MUTEX_MOD_MT2701_DISP_RDMA1            BIT(12)
> >
> Even though the driver not does use a unique prefix/namespace for
> these macros (which it should imho), it's better to keep the hardware
> name/part first. Ideally the rename will be a separate patch.
OK, I will rename the macros and put it in a separate patch.
> 
> 
> > @@ -131,6 +153,32 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> >         [DDP_COMPONENT_WDMA1]   = { MTK_DISP_WDMA,      1, NULL },
> >  };
> >
> > +static struct mtk_ddp_comp_driver_data mt2701_color_driver_data = {
> > +       .color_offset = 0x0f00,
> > +};
> > +
> > +static struct mtk_ddp_comp_driver_data mt8173_color_driver_data = {
> > +       .color_offset = 0x0c00,
> > +};
> > +
> const again ? You can even tweak the *_get_driver_data helpers, to
> return const struct foo*, and resolve the odd warning that the
> compiler will give you.
OK, I will do it in the next version.
> 
> 
> >  struct mtk_ddp_comp {
> >         struct clk *clk;
> >         void __iomem *regs;
> > @@ -82,6 +96,7 @@ struct mtk_ddp_comp {
> >         struct device *larb_dev;
> >         enum mtk_ddp_comp_id id;
> >         const struct mtk_ddp_comp_funcs *funcs;
> > +       struct mtk_ddp_comp_driver_data *data;
> const
OK.
> 
> 
> > +static struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> > +       .main_path = mtk_ddp_main_2701,
> > +       .main_len = ARRAY_SIZE(mtk_ddp_main_2701),
> > +       .ext_path = mtk_ddp_ext_2701,
> > +       .ext_len = ARRAY_SIZE(mtk_ddp_ext_2701),
> > +       .shadow_register = true,
> > +};
> > +
> > +static struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> > +       .main_path = mtk_ddp_main_8173,
> > +       .main_len = ARRAY_SIZE(mtk_ddp_main_8173),
> > +       .ext_path = mtk_ddp_ext_8173,
> > +       .ext_len = ARRAY_SIZE(mtk_ddp_ext_8173),
> > +       .shadow_register = false,
> > +};
> > +
> const
OK.
> 
> 
> > @@ -40,6 +48,7 @@ struct mtk_drm_private {
> >         void __iomem *config_regs;
> >         struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
> >         struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
> > +       struct mtk_mmsys_driver_data *data;
> const ?
Yes.
> 
> 
> > @@ -108,6 +108,10 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
> >         int ret;
> >
> >         args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> > +       /*
> > +       * align to 8 bytes since Mali requires it.
> > +       */
> > +       args->pitch = ALIGN(args->pitch, 8);
> Are you sure we need this, based on the line just above ?
I think bpp stands for bits per pixel, so width * bpp / 8 simply transfer from bits to bytes, which
cannot guarantee align to 8.

I will remove this align part from the patch, this constraint is not from display controller.
Thanks.


> 
> Iirc we had a chat earlier that upstream kernel code should not be
> tailoured for the needs to closed source userspace... seems like the
> comment got removed but the code remained. Philipp Zabel I believe you
> were the person who did the original upstreaming - can we remove this
> hack/workaround and keep it downstream until we have an open-source
> user that requires it ?
> 
> Can we have a MAINTAINERS entry for this driver ?
> 
> Thanks
> Emil
