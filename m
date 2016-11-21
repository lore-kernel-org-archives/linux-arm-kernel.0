From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Nov 2016 08:36:39 +0100
Subject: [PATCH 1/5] drm/modes: Rewrite the command line parser
In-Reply-To: <CAOw6vbKf3B2DYJA-kpmxa7vLzRcv5LhyVtToPyB2d6-thdt4Ng@mail.gmail.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <cf494b4e9585e720b2640705e3b2102c19d193c2.1476779323.git-series.maxime.ripard@free-electrons.com>
 <CAOw6vbKf3B2DYJA-kpmxa7vLzRcv5LhyVtToPyB2d6-thdt4Ng@mail.gmail.com>
Message-ID: <20161121073639.pjikxfytzms6b6yk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

Thanks for taking the time to review this.

On Wed, Nov 16, 2016 at 12:12:53PM -0500, Sean Paul wrote:
> On Tue, Oct 18, 2016 at 4:29 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Rewrite the command line parser in order to get away from the state machine
> > parsing the video mode lines.
> >
> > Hopefully, this will allow to extend it more easily to support named modes
> > and / or properties set directly on the command line.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/drm_modes.c | 305 +++++++++++++++++++++++--------------
> >  1 file changed, 190 insertions(+), 115 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index 53f07ac7c174..7d5bdca276f2 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -30,6 +30,7 @@
> >   * authorization from the copyright holder(s) and author(s).
> >   */
> >
> > +#include <linux/ctype.h>
> >  #include <linux/list.h>
> >  #include <linux/list_sort.h>
> >  #include <linux/export.h>
> > @@ -1261,6 +1262,131 @@ void drm_mode_connector_list_update(struct drm_connector *connector)
> >  }
> >  EXPORT_SYMBOL(drm_mode_connector_list_update);
> >
> > +static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,
> > +                                     struct drm_cmdline_mode *mode)
> > +{
> > +       if (str[0] != '-')
> > +               return -EINVAL;
> > +
> > +       mode->bpp = simple_strtol(str + 1, end_ptr, 10);
> > +       mode->bpp_specified = true;
> > +
> > +       return 0;
> > +}
> > +
> > +static int drm_mode_parse_cmdline_refresh(const char *str, char **end_ptr,
> > +                                         struct drm_cmdline_mode *mode)
> > +{
> > +       if (str[0] != '@')
> > +               return -EINVAL;
> > +
> > +       mode->refresh = simple_strtol(str + 1, end_ptr, 10);
> > +       mode->refresh_specified = true;
> > +
> > +       return 0;
> > +}
> > +
> > +static int drm_mode_parse_cmdline_extra(const char *str, int length,
> > +                                       struct drm_connector *connector,
> > +                                       struct drm_cmdline_mode *mode)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < length; i++) {
> > +               switch (str[i]) {
> > +               case 'i':
> > +                       mode->interlace = true;
> > +                       break;
> > +               case 'm':
> > +                       mode->margins = true;
> > +                       break;
> > +               case 'D':
> > +                       if (mode->force != DRM_FORCE_UNSPECIFIED)
> > +                               return -EINVAL;
> > +
> > +                       if ((connector->connector_type != DRM_MODE_CONNECTOR_DVII) &&
> > +                           (connector->connector_type != DRM_MODE_CONNECTOR_HDMIB))
> > +                               mode->force = DRM_FORCE_ON;
> > +                       else
> > +                               mode->force = DRM_FORCE_ON_DIGITAL;
> > +                       break;
> > +               case 'd':
> > +                       if (mode->force != DRM_FORCE_UNSPECIFIED)
> > +                               return -EINVAL;
> > +
> > +                       mode->force = DRM_FORCE_OFF;
> > +                       break;
> > +               case 'e':
> > +                       if (mode->force != DRM_FORCE_UNSPECIFIED)
> > +                               return -EINVAL;
> > +
> > +                       mode->force = DRM_FORCE_ON;
> > +                       break;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
> > +                                          bool extras,
> > +                                          struct drm_connector *connector,
> > +                                          struct drm_cmdline_mode *mode)
> > +{
> > +       bool rb = false, cvt = false;
> > +       int xres = 0, yres = 0;
> > +       int remaining, i;
> > +       char *end_ptr;
> > +
> > +       xres = simple_strtol(str, &end_ptr, 10);
> > +
> 
> checkpatch is telling me to use kstrtol instead, as simple_strtol is deprecated
> 
> > +       if (end_ptr[0] != 'x')
> 
> check that end_ptr != NULL? you should probably also check that xres
> isn't an error (ie: -ERANGE or -EINVAL)
> 
> > +               return -EINVAL;
> > +       end_ptr++;
> > +
> > +       yres = simple_strtol(end_ptr, &end_ptr, 10);
> 
> check end_ptr != NULL and yres sane
> 
> > +
> > +       remaining = length - (end_ptr - str);
> > +       if (remaining < 0)
> 
> right, so if end_ptr is NULL here, we'll end up with a huge positive
> value for remaining :)
> 
> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < remaining; i++) {
> > +               switch (end_ptr[i]) {
> > +               case 'M':
> > +                       cvt = true;
> 
> the previous code ensured proper ordering as well as parsing, whereas
> yours will take these in any order (and accepts duplicates). i don't
> think this should cause any issues, but perhaps something to verify.

Yes, I definitely overlooked the order of the parameters (and now I
get why the switch was so convoluted...)

I'll come up with a second version fixing that (and the other comments
you had).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/2a06cc04/attachment.sig>
