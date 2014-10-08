From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Oct 2014 14:13:37 +0200
Subject: [PATCH] pwm-backlight: Turn off pwm backlight in probe
In-Reply-To: <001601cfe2dc$6e964ca0$4bc2e5e0$%han@samsung.com>
References: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
 <20141007083548.GD24254@ulmo>
 <001601cfe2dc$6e964ca0$4bc2e5e0$%han@samsung.com>
Message-ID: <20141008121334.GA7357@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 06:44:19PM +0900, Jingoo Han wrote:
> On Tuesday, October 07, 2014 5:36 PM, Thierry Reding wrote:
> > On Mon, Oct 06, 2014 at 09:22:44PM +0200, Markus Pargmann wrote:
> > > The backlight will be enabled by the panel again if it is used. So we
> > > can save the default brightness and disable the pwm backlight when
> > > probing.
> > >
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > index 336b83be7e2d..b4f433a6f106 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > >  		data->dft_brightness = data->max_brightness;
> > >  	}
> > >
> > > -	bl->props.brightness = data->dft_brightness;
> > > +	bl->props.brightness = 0;
> > >  	backlight_update_status(bl);
> > >
> > > +	bl->props.brightness = data->dft_brightness;
> > > +
> > >  	platform_set_drvdata(pdev, bl);
> > >  	return 0;
> > >
> > 
> > It would be nice if it was that easy. But we can't do this, because it
> > will regress for users of this driver that don't use a panel or DRM. If
> > the PWM backlight driver is used for example in conjunction with a plain
> > fbdev driver it isn't necessarily hooked up with anything and won't be
> > enabled automatically. That's really bad if fbdev is the only output you
> > have since you'd have to blindly type the commands to enable the
> > backlight. Furthermore disabling backlight isn't always what you want to
> > do. For example if the bootloader already turned it on and you hand over
> > from bootloader to kernel in a seamless way, then you absolutely want to
> > keep backlight on all the time.
> > 
> > See also[0] for a different proposal to solve the same problem. Back at
> > the time that received only a very few replies, but it would be nice if
> > Lee and Bryan could look at it again and see if we can come up with some
> > way to deal with this situation.
> 
> (+cc Ajay Kumar)
> 
> As I said earlier, I agree with this proposal.

I'm not sure which proposal exactly. I originally proposed adding a
backlight-boot-off property, but that received some pushback from DT
people because it isn't strictly hardware information but configuration
data.

Perhaps a better solution would be to default to not touching the
backlight status on probe at all. But we can't do that for non-DT
because of backwards-compatibility. For DT it seems like all users have
some form of DRM/KMS driver too, so I'd expect them to turn it off when
appropriate.

Should we just go and make that change (no changing backlight state for
DT) and see if anybody complains? If so, I'll gladly prepare a patch to
do just that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/a4de6db4/attachment.sig>
