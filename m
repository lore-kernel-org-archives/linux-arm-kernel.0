From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 03 Jun 2015 09:20:44 +0200
Subject: [linux-sunxi] Re: [PATCH 1/3] phy: sun4i-usb: Add support for
 sun8i A23/A33
In-Reply-To: <CAGb2v65NYoKcFn5kKtKoHs2vvWroMeecH2qtjH=MtnafuwdxCw@mail.gmail.com>
References: <1433248152-13753-1-git-send-email-wens@csie.org>
 <1433248152-13753-2-git-send-email-wens@csie.org>
 <556E00CA.2000309@redhat.com>
 <CAGb2v65NYoKcFn5kKtKoHs2vvWroMeecH2qtjH=MtnafuwdxCw@mail.gmail.com>
Message-ID: <556EAACC.3030808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03-06-15 03:49, Chen-Yu Tsai wrote:
> Hi,
>
> On Wed, Jun 3, 2015 at 3:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 06/02/2015 02:29 PM, Chen-Yu Tsai wrote:
>>>
>>> A23/A33 have separate reset lines for each PHY, like on sun6i,
>>> but only 2 PHYs instead of 3. Add a new compatible for this.
>>>
>>> There is also an HSIC PHY, but no hardware that uses it exists.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>
>>
>> Heh, I've pretty much written the exact same patch (not that
>> it was much work):
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/bc062354f5e0ec75047859d7c2ee3fa04594d29c
>>
>> Note though that:
>>
>> 1) In order to get the disconnect threshold correct you also need:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/f7dabee14450cd93e6d0b01f4b6ab065a55955e3
>>
>> 2) This will only work properly for the A23 not for the A33 on the A33 the
>> phyctl reg
>> sits at a different offset, see:
>>
>> https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/usb/host/sunxi_hci.c#L49
>>
>> So I've written a separate patch (on top of the a23 one, to add control for
>> the A33 phy:
>> https://github.com/jwrdegoede/linux-sunxi/commit/b4536a92ede3187450b0f1c27c11c1f80fc66fc8
>
> Interesting... It seems to just work without the above 2 one my A33.
> Disconnect seems fine as well, though I've not done any stress testing.
>
> Since you have much more experience with USB than I do, I leave this
> to you.

TBH I'm just duplicating what allwinner is doing here, so I'm not that much
of an expert either. As for why things are working fine for you, likely the
phy default settings are good enough in most cases. It could even be that
the allwinner kernel code is wrong (although I remember having seen
the same exceptions for A33 in the bootloader code), and that my version
of the code is actually relying on the defaults being good enough.

In the end it boils down to just trusting that the allwinner code is
doing the right thing.

>> Note I also have patches to add support for the musb on sun6i (no sram
>> controller for the
>> otg sram, needs reset controller poking) this also works for the a23, and a
>> separate patch
>> for the a33 which needs some special handling again.
>
> Yes, I've seen them in your sunxi-wip branch.
>
>> So how to move forward with this? I believe that it is best if I finish my
>> work on this
>> and post a series to Felipe and Kishon to apply on top of the 2 still
>> outstanding
>> phy-sun4i-usb / musb-sunxi patches.
>
> IIRC those will not make 4.2.

Right.

>> As for the dts patches, those I plan to bundle with the dts patches I
>> already have
>> pending for otg support for sunxi in general.
>>
>> Does that work for you ?
>
> Yes. Thanks! I'll pick the patches from your branch to test,
> or just wait until you post them.

Ok.

REgards,

Hans

>
>
> Regards
> ChenYu
>
