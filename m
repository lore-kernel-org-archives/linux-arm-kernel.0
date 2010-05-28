From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:35:46 +0100
Subject: [PATCH 05/15] ARM: S5P6442: Change to using
	s3c_gpio_cfgpin_range()
In-Reply-To: <AANLkTilPCk0NqJ7od6ZBorqPrlG0xCjdPaim1Q3WwZMH@mail.gmail.com>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
	<1275026212-27510-6-git-send-email-ben-linux@fluff.org>
	<AANLkTilPCk0NqJ7od6ZBorqPrlG0xCjdPaim1Q3WwZMH@mail.gmail.com>
Message-ID: <20100528063546.GV4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 03:24:02PM +0900, Kyungmin Park wrote:
> Hi,
> 
> Looks good but I'm afraid it's more difficult to find pin
> configuration from typo.

I'm not sure if that's really so much of a problem.
 
> On Fri, May 28, 2010 at 2:56 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
> > use the recently introduced s3c_gpio_cfgpin_range().
> >
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > ---
> > ?arch/arm/mach-s5p6442/dev-audio.c | ? 30 ++++++++++--------------------
> > ?arch/arm/mach-s5p6442/dev-spi.c ? | ? ?4 +---
> > ?2 files changed, 11 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
> > index cb801e1..0e57caf 100644
> > --- a/arch/arm/mach-s5p6442/dev-audio.c
> > +++ b/arch/arm/mach-s5p6442/dev-audio.c
> > @@ -21,22 +21,16 @@
> >
> > ?static int s5p6442_cfg_i2s(struct platform_device *pdev)
> > ?{
> > + ? ? ? unsigned int base;
> > +
> > ? ? ? ?/* configure GPIO for i2s port */
> > ? ? ? ?switch (pdev->id) {
> > ? ? ? ?case 1:
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(0), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(1), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(2), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(2));
> > + ? ? ? ? ? ? ? base = S5P6442_GPC1(0);
> > ? ? ? ? ? ? ? ?break;
> >
> > ? ? ? ?case -1:
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(2));
> > + ? ? ? ? ? ? ? base = S5P6442_GPC0(0);
> > ? ? ? ? ? ? ? ?break;
> >
> > ? ? ? ?default:
> > @@ -44,6 +38,7 @@ static int s5p6442_cfg_i2s(struct platform_device *pdev)
> > ? ? ? ? ? ? ? ?return -EINVAL;
> > ? ? ? ?}
> >
> > + ? ? ? s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
> > ? ? ? ?return 0;
> > ?}
> >
> > @@ -111,21 +106,15 @@ struct platform_device s5p6442_device_iis1 = {
> >
> > ?static int s5p6442_pcm_cfg_gpio(struct platform_device *pdev)
> > ?{
> > + ? ? ? unsigned int base;
> > +
> > ? ? ? ?switch (pdev->id) {
> > ? ? ? ?case 0:
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(3));
> > + ? ? ? ? ? ? ? base = S5P6442_GPC0(0);
> > ? ? ? ? ? ? ? ?break;
> >
> > ? ? ? ?case 1:
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(0), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(1), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(2), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(3));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(3));
> > + ? ? ? ? ? ? ? base = S5P6442_GPC1(0);
> > ? ? ? ? ? ? ? ?break;
> >
> > ? ? ? ?default:
> > @@ -133,6 +122,7 @@ static int s5p6442_pcm_cfg_gpio(struct platform_device *pdev)
> > ? ? ? ? ? ? ? ?return -EINVAL;
> > ? ? ? ?}
> >
> > + ? ? ? s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
> > ? ? ? ?return 0;
> > ?}
> >
> > diff --git a/arch/arm/mach-s5p6442/dev-spi.c b/arch/arm/mach-s5p6442/dev-spi.c
> > index 3019952..1c5c170 100644
> > --- a/arch/arm/mach-s5p6442/dev-spi.c
> > +++ b/arch/arm/mach-s5p6442/dev-spi.c
> > @@ -37,9 +37,7 @@ static int s5p6442_spi_cfg_gpio(struct platform_device *pdev)
> > ?{
> > ? ? ? ?switch (pdev->id) {
> > ? ? ? ?case 0:
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPB(0), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPB(2), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6442_GPB(3), S3C_GPIO_SFN(2));
> > + ? ? ? ? ? ? ? s3c_gpio_cfgpin_range(S5P6442_GPB(0), 4, S3C_GPIO_SFN(2));
> 
> Where's the GPB(1)???

you're right, this is an invalid change. will back it out.
 
> Thank you,
> Kyungmin Park
> 
> > ? ? ? ? ? ? ? ?s3c_gpio_setpull(S5P6442_GPB(0), S3C_GPIO_PULL_UP);
> > ? ? ? ? ? ? ? ?s3c_gpio_setpull(S5P6442_GPB(2), S3C_GPIO_PULL_UP);
> > ? ? ? ? ? ? ? ?s3c_gpio_setpull(S5P6442_GPB(3), S3C_GPIO_PULL_UP);
> > --
> > 1.6.3.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> >

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
