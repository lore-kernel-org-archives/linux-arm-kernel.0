From: dianders@chromium.org (Doug Anderson)
Date: Mon, 4 Aug 2014 08:42:51 -0700
Subject: [PATCH v6 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <53DCBC84.8080600@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <53DC4E41.4050200@collabora.co.uk>
 <CAD=FV=V_vXZLMaTMFdgr62=zRXucZA6D3PvS0Mb40he0ShHTfA@mail.gmail.com>
 <53DCBC84.8080600@suse.de>
Message-ID: <CAD=FV=WFNW_5KZvLMk0kK1JQsdWLeo2kCjpQsFuxKNSnOKzfgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Sat, Aug 2, 2014 at 3:25 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 02.08.2014 06:57, schrieb Doug Anderson:
>> On Fri, Aug 1, 2014 at 7:34 PM, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:
>>> On 08/02/2014 02:52 AM, Andreas F?rber wrote:
>>>>
>>>> Based on the preinstalled 3.8 based ChromeOS kernel and previous 3.15
>>>> based attempts by Stephan and me that broke for 3.16, I've prepared a
>>>> device tree for the HP Chromebook 11 aka Google Spring.
>>>>
>>>> v6 renames a node and reverts dp_hpd.
>>>>
>>>> Not yet enabled are trackpad, Wifi and sound.
>>>
>>> I made a comment on patch 05/10 but the rest of the series looks good to me. So
>>> for the remaining patches:
>>>
>>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>
>>> NOTE: I thought that Tomasz Figa gave you his Reviewed-by on v5 for the whole
>>> series as well but I didn't see his tag on the v6 patches.
>>
>> Yes, I thought that too.  I assume he's OK with the small changes you
>> made between v5 and v6.  In the very least his Reviewed-by could be
>> present on the patches that didn't change between the last two revs.
>
> I did add it to the bootargs, GPIO, USB3503 patches. All other patches
> were either split off or slightly changed due to dp_hpd[_gpio], so I
> didn't carry it over.
>
>> Given Javier's review and Tomasz's review and Vincent's comments, I'll
>> probably skip all the work of reviewing the rest of the series unless
>> someone really wants me to.  ;)
>
> Could you maybe give an Rb or Ab for the actual Spring patch to have the
> Cc: updated? :)

Done.


> Note that if there's some problem that can't be resolved by selectively
> dropping patches, I won't be available next week, so you'll either have
> to provide fixups for Kukjin to squash or wait till I've returned.
>
> One thing I've wondered is whether we should put status = "disabled" on
> the dp node with some comment, since it's known not to work as is (but
> better having the data here than leaving it out, I believe).

Don't know about this one.


> Of course if either of you has input on the discussions on the drm
> bridge/panel series V6 [1] for how to enable non-simplefb display and
> iommus, that would be valuable.

I've been letting the graphics folks and Samsung hash out the graphics
patches, so I don't think I'll be much help here.


> [1] http://www.spinics.net/lists/linux-samsung-soc/msg35274.html
>
>
> And when one thing is accomplished, I am always quick to look forward:
>
> I've taken a quick look at sound nodes: According to 3.8 DT, Spring uses
> max98089 whereas Snow has 98091, so different codec driver and still
> lacking DT binding support. I might look into trivially enabling
> sound/soc/codecs/max98089.c through a "maxim,max98089" OF match table
> once this series lands in linux-next. As for the driver, can we reuse
> http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/tree/sound/soc/samsung/snow.c?h=for-next
> with a "google,spring-audio-max98089", or are code changes needed?

I don't know this offhand.


> Both of you mentioned limitations of cros_ec i2c passthrough leading to
> a forked tps65090 driver downstream - I don't think I can be of help
> there, as I guess simply copying a driver will not be an option. ;)
> https://code.google.com/p/chromium/issues/detail?id=391797

Yup, I think this will be real work for someone.  I made a quick
attempt and failed at it and I haven't had time to work on it since
(and don't necessarily expect to have time in the near future)...  I
think it is possible for anyone versed in i2c to figure this out based
on what I already posted and what's in our local tree...


> For the touchpad it seems DT support has landed in the input tree as
> "atmel,maxtouch". Backporting just that patch does not make it work
> though. (Tried the rejected pinctrl approach to be on the safe side.)
> https://code.google.com/p/chromium/issues/detail?id=371114
> https://patchwork.kernel.org/patch/3976801/

This is the same work as needed for pit and pi, I believe.  Perhaps
Javier or Dmitry has this on their todo list?


> I thought the internal xhci would have the webcam on it, but I don't see
> it in lsusb. Does that need some pinctrl or tps65090 regulator? Once
> appearing on a bus, which driver config option will it need?

Perhaps tps65090 FET5?  That looks like what the device tree says in
our local tree.

-Doug
