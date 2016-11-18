From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Nov 2016 10:22:40 +0800
Subject: [PATCH] drm/sun4i: Only count TCON endpoints as valid outputs
In-Reply-To: <20161117190254.d4doghspvz6ma6x2@lukather>
References: <20161116093732.12828-1-wens@csie.org>
 <20161117190254.d4doghspvz6ma6x2@lukather>
Message-ID: <CAGb2v65sorc-Q5c39ZURTAAorvF4ETVW=qj_ue9mUzLei2scJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 3:02 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Nov 16, 2016 at 05:37:31PM +0800, Chen-Yu Tsai wrote:
>> The sun4i DRM driver counts the number of endpoints it found and
>> registers the whole DRM pipeline if any endpoints are found.
>>
>> However, if the TCON and its child endpoints (LCD panels, TV encoder,
>> HDMI encoder, MIPI DSI encoder, etc.) aren't found, that means we
>> don't have any usable CRTCs, and the display pipeline is incomplete
>> and useless.
>
> If some node set as available is not probed, then yes, it does, but
> I'm not really sure how it's a problem. Quite the opposite actually.

Actually the problem occurs when the TCON is _not_ available, but
the other endpoints preceding it are.

>> The whole DRM display pipeline should only be registered and enabled
>> if there are proper outputs available.
>
> Unless I've misunderstood what you're saying, we could have the
> writeback for example that would just need the display engine.

Yeah, I guess that complicates things...

>> The debug message "Queued %d outputs on pipeline %d\n" is also telling.
>>
>> This patch makes the driver only count enabled TCON endpoints. If
>> none are found, the DRM pipeline is not used. This avoids screwing
>> up the simple framebuffer provided by the bootloader in cases where
>> we aren't able to support the display with the DRM subsystem, due
>> to lack of panel or bridge drivers, or just lack of progress.
>
> The framebuffer is removed only at bind time, which means that all the
> drivers have probed already. Lack of progress isn't an issue here,
> since the node simply won't be there, and we wouldn't have it in the
> component lists. And lack of drivers shouldn't be an issue either,
> since in order for bind to be called, all the drivers would have
> gone through their probe.
>
> So I'm not really sure what it fixes.

To recap, on sun6i I had enabled the display engine node by default
in the dtsi, along with the backend and drc. The tcon is disabled
by default, so it doesn't get added to the list of components.
The available components get probed, binded, and simplefb gets
pushed out.

I suppose disabling the display engine by default would be better?
At least simplefb still works.

Regards
ChenYu

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
