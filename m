From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Aug 2017 14:29:35 +0800
Subject: [linux-sunxi] [PATCH 2/4] drivers: soc: sunxi: fix error
 processing on base address when claiming
In-Reply-To: <94408FC0-D7F8-4050-936E-F350029DAB9F@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-3-icenowy@aosc.io>
 <CAGb2v67F6xUOE9sJsBgpOn2kRoG2S-aoWrtTsjON64o2pzeXjA@mail.gmail.com>
 <94408FC0-D7F8-4050-936E-F350029DAB9F@aosc.io>
Message-ID: <CAGb2v67Mxq+y6mEKQ10y+vod5mxT=0Kz8dMPKC46By2-LO3EAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 2:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?8?18? GMT+08:00 ??2:21:07, Chen-Yu Tsai <wens@csie.org> ??:
>>Hi,
>>
>>On Wed, Aug 9, 2017 at 4:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>> When claiming SRAM, if the base is set to an error, it means that the
>>> SRAM controller has been probed, but failed to remap the controller
>>> memory zone. If the base is zero, thus the SRAM controller should be
>>not
>>> probed at all, and it should return -EPROBE_DEFER. However, currently
>>we
>>> returned -EPROBE_DEFER in the former situation, and ignored the
>>latter
>>> situation (which will lead to the kernel to panic).
>>>
>>> Fix the behavior on abnormal base address processing when claiming.
>>
>>Could you describe how you actually ran into this? The failure seems
>>unlikely for a properly written device tree.
>
> In fact it's possible, as the probe defering used to be broken.
>
> On the A64 situation, the SRAM is referenced by the DE2 CCU driver, which
> will be probed very early -- before SRAM is probed, and the problem happens.

OK. I see it's because the DE block's address if before almost everything
else. I was wondering why we never ran into this before.

Given there are no actual users in the kernel that could trigger this,
I'll queue this for 4.14 instead.

ChenYu
