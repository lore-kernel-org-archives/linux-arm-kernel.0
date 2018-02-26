From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 Feb 2018 18:55:49 +0800
Subject: [PATCH] drm/sun4i: link in front-end code if needed
In-Reply-To: <20180226105359.k5a3rz2wow4gweba@flea.lan>
References: <20180223131112.715992-1-arnd@arndb.de>
 <20180226092129.t4uogg2q7jkeolbu@flea.lan>
 <CAK8P3a1w=hLzZLPe1TURPyyu5oxpG8yD0eb_8GrVviUODy0zqQ@mail.gmail.com>
 <20180226105359.k5a3rz2wow4gweba@flea.lan>
Message-ID: <CAGb2v64RKGMMMF+KZdfVq6BgheAYSJYmb=kg_a0hSp153hNT2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 6:53 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, Feb 26, 2018 at 10:31:51AM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 26, 2018 at 10:21 AM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > Hi,
>> >
>> > On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
>> >> When the base sun4i DRM driver is built-in but the back-end is
>> >> a loadable module, we run into a link error:
>> >>
>> >> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
>> >> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_table'
>> >>
>> >> The dependency is a bit tricky, the best workaround I have come up
>> >> with is to use a Makefile hack to to interpret both
>> >> CONFIG_DRM_SUN4I_BACKEND=m and CONFIG_DRM_SUN4I_BACKEND=y
>> >> as a directive to build the front-end the same way as the main module.
>> >>
>> >> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
>> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >> ---
>> >>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
>> >>  1 file changed, 4 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
>> >> index 582607c0c488..db14e023256b 100644
>> >> --- a/drivers/gpu/drm/sun4i/Makefile
>> >> +++ b/drivers/gpu/drm/sun4i/Makefile
>> >> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)             += sun4i-tcon.o
>> >>  obj-$(CONFIG_DRM_SUN4I)              += sun4i_tv.o
>> >>  obj-$(CONFIG_DRM_SUN4I)              += sun6i_drc.o
>> >>
>> >> -obj-$(CONFIG_DRM_SUN4I_BACKEND)      += sun4i-backend.o sun4i-frontend.o
>> >> +obj-$(CONFIG_DRM_SUN4I_BACKEND)      += sun4i-backend.o
>> >> +ifdef CONFIG_DRM_SUN4I_BACKEND
>> >> +obj-$(CONFIG_DRM_SUN4I)              += sun4i-frontend.o
>> >> +endif
>> >
>> > Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
>> > and we would export the symbol?
>>
>> Yes, I think that would work just as well. Something like
>>
>> config DRM_SUN4I_FRONTEND
>>       tristate
>>       default DRM_SUN4I if CONFIG_DRM_SUN4I_BACKEND != n
>>
>> should do the trick.
>
> I had more something like this in mind:
> https://pastebin.com/raw/XydvzAtz

This doesn't solve the issue at hand, which is sun4i-drv (CONFIG_DRM_SUN4I)
requires something in sun4i-backend (CONFIG_DRM_SUN4I_BACKEND), and if
sun4i-drv is built-in, then anything it uses must also be built-in.

ChenYu
