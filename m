From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 7 Oct 2015 17:31:51 +0200
Subject: [PATCH 2/6] ARM: s3c24xx: rx1950: Use PWM lookup table
In-Reply-To: <561476FA.4090209@samsung.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
 <1444049237-29878-3-git-send-email-thierry.reding@gmail.com>
 <561476FA.4090209@samsung.com>
Message-ID: <20151007153151.GB1975@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 10:35:54AM +0900, Krzysztof Kozlowski wrote:
> On 05.10.2015 21:47, Thierry Reding wrote:
> > Use a PWM lookup table to provide the PWM to the pwm-backlight device.
> > The driver has a legacy code path that is required only because boards
> > still use the legacy method of requesting PWMs by global ID. Replacing
> > these usages allows that legacy fallback to be removed.
> > 
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  arch/arm/mach-s3c24xx/mach-rx1950.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
> > index 1d35ff375a01..774c982a7b7e 100644
> > --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> > +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> > @@ -375,6 +375,11 @@ static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
> >  
> >  };
> >  
> > +static struct pwm_lookup rx1950_pwm_lookup[] = {
> > +	PWM_LOOKUP("samsung-pwm", 0, "pwm-backlight.0", NULL, 48000,
> 
> Why the dev_id is "pwm-backlight.0"? Created platform device name is
> "pwm-backlight".

"pwm-backlight" is only the base name. The platform bus code will use
the platform_device.id field and append it to the name as .<id> unless
it is -1 in which case it will be skipped. So in the rx1950_backlight
device the .id field isn't initialized at all, so it will be zeroed
out and hence the device name will become "pwm-backlight.0".

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/88988e0e/attachment.sig>
