From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 31 Jul 2012 10:32:06 +0200
Subject: [PATCH 1/3] Move FIMD register headers to include/video/
In-Reply-To: <000701cd6ef5$24315c70$6c941550$%han@samsung.com>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
 <000001cd6e30$da849520$8f8dbf60$%han@samsung.com>
 <CAL1wa8e7Joghf9S=SgbQLJFWcYOrP5uK6qYXsV_N6rX1MVEALg@mail.gmail.com>
 <000a01cd6eb6$2113a050$633ae0f0$%han@samsung.com>
 <032201cd6ee5$ad4a0d50$07de27f0$%szyprowski@samsung.com>
 <000701cd6ef5$24315c70$6c941550$%han@samsung.com>
Message-ID: <033c01cd6ef6$fb514570$f1f3d050$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, July 31, 2012 10:19 AM Jingoo Han wrote:

> On Tuesday, July 31, 2012 3:28 PM Marek Szyprowski wrote:
> >
> > Hello,
> >
> > On Tuesday, July 31, 2012 2:48 AM Jingoo Han wrote:
> >
> > > On Monday, July 30, 2012 8:16 PM, Leela Krishna Amudala wrote:
> > > >
> > > > Hello Jingoo Han,
> > > >
> > > > On Mon, Jul 30, 2012 at 2:23 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > > > > On Monday, July 30, 2012 5:45 PM, Leela Krishna Amudala wrote:
> > > > >>
> > > > >> Moved the contents of regs-fb-v4.h and regs-fb.h from arch side
> > > > >> to include/video/samsung_fimd.h
> > > > >>
> > > > >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > > > >> ---
> > > > >>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
> > > > >>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
> > > > >>  include/video/samsung_fimd.h                    |  533 +++++++++++++++++++++++
> > > > >>  3 files changed, 533 insertions(+), 562 deletions(-)
> > > > >>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> > > > >>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
> > > > >>  create mode 100644 include/video/samsung_fimd.h
> > > > >>
> > > > >> +*/
> > > > >> +
> > > > >> +/*FIMD V8 REG OFFSET */
> > > > >> +#define FIMD_V8_VIDTCON0     (0x20010)
> > > > >> +#define FIMD_V8_VIDTCON1     (0x20014)
> > > > >> +#define FIMD_V8_VIDTCON2     (0x20018)
> > > > >> +#define FIMD_V8_VIDTCON3     (0x2001C)
> > > > >> +#define FIMD_V8_VIDCON1              (0x20004)
> > >
> > >
> > > How about using soc_is_exynos5250()?
> > >
> > > +#define VIDTCON0				(soc_is_exynos5250() ? \
> > > +						(0x20010) : (0x10))
> > >
> > > In this case, the FIMD driver does not need to change.
> > > Also, one binary is available.
> >
> > Please don't mix two methods of runtime detection. FIMD driver (s3c-fb) already
> > has runtime hw detection based on platform device id. Adding such detection for
> > exynos5 to DRM FIMD driver should not be a big issue too.
> 
> Marek,
> Then, do you want use like this?
> 
> #define VIDTCON0				(0x10)
> +#define FIMD_V8_VIDTCON0			(0x20010)
> 
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1924,7 +1924,7 @@ static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
>  static struct s3c_fb_driverdata s3c_fb_data_exynos5 = {
>         .variant = {
>                 .nr_windows     = 5,
> -               .vidtcon        = VIDTCON0,
> +               .vidtcon        = FIMD_V8_VIDTCON0,

Yes, this method looks good imo. Maybe even having something like vidtcon_base in 
variant structure will be enough to cover all VIDTCON0-3 registers.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
