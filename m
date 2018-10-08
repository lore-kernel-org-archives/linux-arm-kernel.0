From: dave.stevenson@raspberrypi.org (Dave Stevenson)
Date: Mon, 8 Oct 2018 17:51:56 +0100
Subject: [PATCH] staging: bcm2835-camera: remove extraneous setting of
 dev->colourfx.enable
In-Reply-To: <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
References: <20181008145012.31312-1-colin.king@canonical.com>
 <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
Message-ID: <CAAoAYcO=qp7yb7392B_6wks2j2TaoxYXHtQPyH0kMkFMi+JW-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Stefan.

Thanks for forwarding as the linux-rpi-kernel list hasn't sent it to me as yet.

On Mon, 8 Oct 2018 at 16:48, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Colin,
>
> Am 08.10.2018 um 16:50 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently dev->colourfx.enable is being set twice, hence the first
> > occurrance is redundant and can be removed, so remove it. This minor
> > issue was introduced by commit 7b3ad5abf027 ("staging: Import the
> > BCM2835 MMAL-based V4L2 camera driver.").
> >
> > Detected by CoverityScan CID#1419711 ("Unused value")
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/staging/vc04_services/bcm2835-camera/controls.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > index a2c55cb2192a..99831dd4365d 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > @@ -588,7 +588,6 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
> >
> >       control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
> >
> > -     dev->colourfx.enable = (ctrl->val & 0xff00) >> 8;
> >       dev->colourfx.enable = ctrl->val & 0xff;
> >
> >       ret = vchiq_mmal_port_parameter_set(dev->instance, control,
>
> as long as the current behavior is correct, i'm okay with this patch.
> But the byte masking looks suspicious, so i hope Dave can clarify that.

It's writing to the wrong structure member.
The function is used on the V4L2 control V4L2_CID_COLORFX_CBCR, which
is defined as:
V4L2_CID_COLORFX_CBCR (integer)
Determines the Cb and Cr coefficients for V4L2_COLORFX_SET_CBCR color
effect. Bits [7:0] of the supplied 32 bit value are interpreted as Cr
component, bits [15:8] as Cb component and bits [31:16] must be zero.

ctrl->val should therefore be setting dev->colourfx.u and
dev->colourfx.v with those masks. dev->colourfx.enable field should
have been set when going through ctrl_set_image_effect for contol
V4L2_CID_COLORFX set to V4L2_COLORFX_SET_CBCR.

I've confirmed with qv4l2 that that is what is wrong. That's only been
lurking there for almost 5 years - shows how often these weirder
effects get used.
I don't mind whether Colin's patch gets merged and then fixed up, or
drop Colin's patch and apply the correct logic via a new patch.

  Dave
