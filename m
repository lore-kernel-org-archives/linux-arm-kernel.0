From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 May 2017 11:40:17 +0800
Subject: [linux-sunxi] Re: [PATCH v6 08/13] drm/sun4i: add support for
 Allwinner DE2 mixers
In-Reply-To: <c0b049b4ddc2af2f34059e9c9d659de9@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-9-icenowy@aosc.io>
 <20170504130535.6nokhni5a3uxwy66@lukather>
 <c0b049b4ddc2af2f34059e9c9d659de9@aosc.io>
Message-ID: <CAGb2v64tYm=L9ZY1uKguA8aWJinLvruBQ5+vLMQDJGgwWk_ySA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 5, 2017 at 12:52 AM,  <icenowy@aosc.io> wrote:
> ? 2017-05-04 21:05?Maxime Ripard ???
>>
>> On Thu, May 04, 2017 at 07:48:53PM +0800, Icenowy Zheng wrote:
>>>
>>> Allwinner have a new "Display Engine 2.0" in their new SoCs, which comes
>>> with mixers to do graphic processing and feed data to TCON, like the old
>>> backends and frontends.
>>>
>>> Add support for the mixer on Allwinner V3s SoC; it's the simplest one.
>>>
>>> Currently a lot of functions are still missing -- more investigations
>>> are needed to gain enough information for them.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>> Changes in v6:
>>> - Rebased on wens's multi-pipeline patchset.
>>> Changes in v5:
>>> - Changed some code alignment.
>>> - Request real 32-bit DMA (prepare for 64-bit SoCs).
>>> Changes in v4:
>>> - Killed some dead code according to Jernej.
>>>
>>>  drivers/gpu/drm/sun4i/Kconfig       |  10 +
>>>  drivers/gpu/drm/sun4i/Makefile      |   3 +
>>>  drivers/gpu/drm/sun4i/sun8i_layer.c | 140 +++++++++++++
>>>  drivers/gpu/drm/sun4i/sun8i_layer.h |  36 ++++
>>>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 394
>>> ++++++++++++++++++++++++++++++++++++
>>>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 137 +++++++++++++
>>>  6 files changed, 720 insertions(+)
>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
>>>

[...]

>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>>> b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>>> new file mode 100644
>>> index 000000000000..e216b84d5bb2
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>>> @@ -0,0 +1,394 @@

[...]

>>> +       list_add_tail(&mixer->engine.list, &drv->engine_list);
>>
>>
>> You didn't call INIT_LIST_HEAD on that list.
>
>
> So didn't the sun4i_backend driver...
>
> I think the mixer->engine.list only means an item in the
> engine_list, and the drv->engine_list is initialized in the
> sun4i_drv source code.

I read [1] that if the item is subsequently added to a list,
you could omit the INIT_LIST_HEAD call.

Makes sense, though you have to be sure you aren't doing anything
else with the list element.

ChenYu

[1] https://isis.poly.edu/kulesh/stuff/src/klist/
