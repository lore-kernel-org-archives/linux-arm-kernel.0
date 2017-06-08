From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Thu, 8 Jun 2017 11:22:51 +0800
Subject: [PATCH] [media] mtk-mdp: Fix g_/s_selection capture/compose logic
In-Reply-To: <a8c1da24-d812-7c4d-a05d-34cb90edddf5@linaro.org>
References: <1492057130-1194-1-git-send-email-minghsiu.tsai@mediatek.com>
 <a8c1da24-d812-7c4d-a05d-34cb90edddf5@linaro.org>
Message-ID: <1496892171.22652.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stanimir Varbanov,

I have upload patch v2. 
https://patchwork.kernel.org/patch/9723463/

Could you review it? Thanks


On Thu, 2017-04-27 at 17:42 +0300, Stanimir Varbanov wrote:
> Hi,
> 
> On 04/13/2017 07:18 AM, Minghsiu Tsai wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> > 
> > Experiments show that the:
> >  (1) mtk-mdp uses the _MPLANE form of CAPTURE/OUTPUT
> >  (2) CAPTURE types use CROP targets, and OUTPUT types use COMPOSE targets
> > 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> > 
> > ---
> >  drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> > index 13afe48..8ab7ca0 100644
> > --- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> > +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> > @@ -837,12 +837,12 @@ static int mtk_mdp_m2m_g_selection(struct file *file, void *fh,
> >  	struct mtk_mdp_ctx *ctx = fh_to_ctx(fh);
> >  	bool valid = false;
> >  
> > -	if (s->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
> > -		if (mtk_mdp_is_target_compose(s->target))
> > -			valid = true;
> > -	} else if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
> > +	if (s->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> >  		if (mtk_mdp_is_target_crop(s->target))
> >  			valid = true;
> > +	} else if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		if (mtk_mdp_is_target_compose(s->target))
> > +			valid = true;
> >  	}
> 
> Using MPLANE formats in g/s_selection violates the v4l2 spec. See [1].
> 
> <snip>
> 
