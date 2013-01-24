From: robdclark@gmail.com (Rob Clark)
Date: Thu, 24 Jan 2013 08:40:11 -0600
Subject: [PATCH 4/4] drm/tilcdc: add support for LCD panels (v4)
In-Reply-To: <20130124130856.GC31306@phenom.ffwll.local>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-5-git-send-email-robdclark@gmail.com>
 <20130124130856.GC31306@phenom.ffwll.local>
Message-ID: <CAF6AEGtnaGJ9Ch2YX1yunKsH+ZDqWuUiz74PTBJyvr2mgSo_1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 7:08 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Jan 22, 2013 at 04:36:25PM -0600, Rob Clark wrote:
>> Add an output panel driver for LCD panels.  Tested with LCD3 cape on
>> beaglebone.
>>
>> v1: original
>> v2: s/of_find_node_by_name()/of_get_child_by_name()/ from Pantelis
>>     Antoniou
>> v3: add backlight support
>> v4: rebase to latest of video timing helpers
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>
> So given that I'm utterly lacking clue about all things of (which seems to
> be where all the magic in this patch lies) I'm just gonna ask a few funny
> questions.
>
> [cut]
>
>> +static int panel_connector_get_modes(struct drm_connector *connector)
>> +{
>> +     struct drm_device *dev = connector->dev;
>> +     struct panel_connector *panel_connector = to_panel_connector(connector);
>> +     struct display_timings *timings = panel_connector->mod->timings;
>> +     int i;
>> +
>> +     for (i = 0; i < timings->num_timings; i++) {
>> +             struct drm_display_mode *mode = drm_mode_create(dev);
>> +             struct videomode vm;
>> +
>> +             if (videomode_from_timing(timings, &vm, i))
>> +                     break;
>> +
>> +             drm_display_mode_from_videomode(&vm, mode);
>
> Why do we need to jump through the intermediate videomode thing here? Is
> that a deficiency of the of/videomode stuff?

there is a helper that cut through the intermediate videomode
structure, although it assumed you are doing that at the point where
you still have the 'struct device_node *' (in the probe code) which
didn't really fit well for how I had structured things.  So I just
skipped it.  I guess I could have gone straight to array of
drm_display_mode in the probe call, and then copied them here in
get_modes() but this just seemed a bit easier.

> [cut]
>
>> +     ret |= of_property_read_u32(info_np, "ac-bias", &info->ac_bias);
>> +     ret |= of_property_read_u32(info_np, "ac-bias-intrpt", &info->ac_bias_intrpt);
>> +     ret |= of_property_read_u32(info_np, "dma-burst-sz", &info->dma_burst_sz);
>> +     ret |= of_property_read_u32(info_np, "bpp", &info->bpp);
>> +     ret |= of_property_read_u32(info_np, "fdd", &info->fdd);
>> +     ret |= of_property_read_u32(info_np, "sync-edge", &info->sync_edge);
>> +     ret |= of_property_read_u32(info_np, "sync-ctrl", &info->sync_ctrl);
>> +     ret |= of_property_read_u32(info_np, "raster-order", &info->raster_order);
>> +     ret |= of_property_read_u32(info_np, "fifo-th", &info->fifo_th);
>
> Shouldn't these values all be documented somewhere in the devictree docs?
> Or are they somewhat standardized?

Yeah, I guess I need to add DT docs..  I didn't realize this earlier.

BR,
-R
