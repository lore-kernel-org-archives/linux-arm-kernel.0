From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 27 Sep 2016 10:42:09 -0400
Subject: [PATCH] drm/sun4i: rgb: Enable panel after controller
In-Reply-To: <20160924201813.GE16901@lukather>
References: <20160921130304.3486-1-net147@gmail.com>
 <20160921210340.GI8719@lukather>
 <CANwerB2pmO7AMqmE9SMR1vFFsY5jMUALGSvtd=AvpU1=_jSHUw@mail.gmail.com>
 <20160923131626.GX8719@lukather>
 <CANwerB1PgaACukEj1jzUY-dQzbf50Em3h47KEsQu3rC3Jej=6Q@mail.gmail.com>
 <20160924201813.GE16901@lukather>
Message-ID: <CAOw6vbKxJeSZYsCwVWYbVosZUK+FfBq1ytrpRUNpbH+kM6Ow6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 4:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Sep 23, 2016 at 11:43:55PM +1000, Jonathan Liu wrote:
>> Hi Maxime,
>>
>> On 23 September 2016 at 23:16, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Thu, Sep 22, 2016 at 08:03:31AM +1000, Jonathan Liu wrote:
>> >> Hi Maxime,
>> >>
>> >> On Thursday, 22 September 2016, Maxime Ripard <maxime.ripard@free-electrons.
>> >> com> wrote:
>> >>
>> >> > On Wed, Sep 21, 2016 at 11:03:04PM +1000, Jonathan Liu wrote:
>> >> > > The panel should be enabled after the controller so that the panel
>> >> > > prepare/enable delays are properly taken into account. Similarly, the
>> >> > > panel should be disabled before the controller so that the panel
>> >> > > unprepare/disable delays are properly taken into account.
>> >> > >
>> >> > > This is useful for avoiding visual glitches.
>> >> >
>> >> > This is not really taking any delays into account, especially since
>> >> > drm_panel_enable and prepare are suppose to block until their
>> >> > operation is complete.
>> >>
>> >>
>> >> drm_panel_prepare turns on power to the LCD using enable-gpios property of
>> >> the panel and then blocks for prepare delay. The prepare delay for panel
>> >> can be set to how long it takes between the time the panel is powered to
>> >> when it is ready to receive images. If backlight property is specified the
>> >> backlight will be off while the panel is powered on.
>> >>
>> >> drm_panel_enable blocks for enable delay and then turns on the backlight.
>> >> The enable delay can be set to how long it takes for panel to start making
>> >> the image visible after receiving the first valid frame. For example if the
>> >> panel starts off as white and the TFT takes some time to initialize to
>> >> black before it shows the image being received.
>> >>
>> >> Refer to drivers/gpu/drm/panel-panel.simple.c for details.
>> >
>> > From drm_panel.h:
>> >
>> > """
>> > * drm_panel_enable - enable a panel
>> > * @panel: DRM panel
>> > *
>> > * Calling this function will cause the panel display drivers to be turned on
>> > * and the backlight to be enabled. Content will be visible on screen after
>> > * this call completes.
>> > """
>> >
>> > """
>> > * drm_panel_prepare - power on a panel
>> > * @panel: DRM panel
>> > *
>> > * Calling this function will enable power and deassert any reset signals to
>> > * the panel. After this has completed it is possible to communicate with any
>> > * integrated circuitry via a command bus.
>> > """
>> >
>> > Those comments clearly says that the caller should not have to deal
>> > with the delays, even more so by just moving calls around and hoping
>> > that the code running in between is adding enough delay for the panel
>> > to behave properly.
>> >
>> > Maxime
>> >
>> > --
>> > Maxime Ripard, Free Electrons
>> > Embedded Linux and Kernel engineering
>> > http://free-electrons.com
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_panel.h#n34
>>
>> In comment for struct drm_panel_funcs:
>> /**
>>  * struct drm_panel_funcs - perform operations on a given panel
>>  * @disable: disable panel (turn off back light, etc.)
>>  * @unprepare: turn off panel
>>  * @prepare: turn on panel and perform set up
>>  * @enable: enable panel (turn on back light, etc.)
>>  * @get_modes: add modes to the connector that the panel is attached to and
>>  * return the number of modes added
>>  * @get_timings: copy display timings into the provided array and return
>>  * the number of display timings available
>>  *
>>  * The .prepare() function is typically called before the display controller
>>  * starts to transmit video data. Panel drivers can use this to turn the panel
>>  * on and wait for it to become ready. If additional configuration is required
>>  * (via a control bus such as I2C, SPI or DSI for example) this is a good time
>>  * to do that.
>>  *
>>  * After the display controller has started transmitting video data, it's safe
>>  * to call the .enable() function. This will typically enable the backlight to
>>  * make the image on screen visible. Some panels require a certain amount of
>>  * time or frames before the image is displayed. This function is responsible
>>  * for taking this into account before enabling the backlight to avoid visual
>>  * glitches.
>>  *
>>  * Before stopping video transmission from the display controller it can be
>>  * necessary to turn off the panel to avoid visual glitches. This is done in
>>  * the .disable() function. Analogously to .enable() this typically involves
>>  * turning off the backlight and waiting for some time to make sure no image
>>  * is visible on the panel. It is then safe for the display controller to
>>  * cease transmission of video data.
>>  *
>>  * To save power when no video data is transmitted, a driver can power down
>>  * the panel. This is the job of the .unprepare() function.
>>  */
>
> It kind of make my point. When drm_panel_enable is called, the content
> is visible, and there's no extra delay needed.
>
> If what you want to fix is that the panel is enabled before the
> controller, hence resulting in garbage on the screen while the
> controller is setup, then your commit log is seriously misleading.
>

This is my interpretation of the patch. In fact, there's nothing that
says a panel must have any delays at all, so bringing up delays in the
commit log is pretty misleading.

That said, it seems like the panel hooks are in the right place after
this patch.

As an aside, it seems like (from the diff, I haven't looked at the
code) the bridge_pre_enable and bridge_post_disable calls are missing,
and the enable/disable calls are in the wrong place.

Sean


> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
