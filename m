From: dianders@chromium.org (Doug Anderson)
Date: Mon, 28 Nov 2016 12:32:35 -0800
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <9c783843-d0e4-92ef-d156-6826e38d9fa8@free.fr>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
 <485a747c-47e3-bc0e-093a-4ec9ab719987@laposte.net>
 <CAD=FV=XrJHFbpbhsJZAEE-HLMe47Ov=BgvHw8ZtfCazzT75pKQ@mail.gmail.com>
 <9c783843-d0e4-92ef-d156-6826e38d9fa8@free.fr>
Message-ID: <CAD=FV=XH8_K2OAwmDKrOD=eq_VevG01UK8=cEOmTbkZ11+Z+zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 28, 2016 at 11:32 AM, Mason <slash.tmp@free.fr> wrote:
> On 28/11/2016 18:46, Doug Anderson wrote:
>
>> As argued in my original patch the field "corecfg_baseclkfreq" is
>> documented in the generic Arasan document
>> <https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf>
>> and thus is unlikely to be Rockchip specific.
>
> I downloaded the data sheet, which doesn't mention registers,
> but "pins" and "signals". Does that mean it is up to every
> platform to decide how to group these wires into individual
> registers?

As I understand it: yes.  ...but remember that I'm not arasan nor even
Rockchip and I don't have any access to that they provide their IP
licensees.

That's why I structured my config the way it did.  It means that no
matter how a licensee stuffs these configs into their register map we
can support it.  Every configuration is individually described by a
register offset, width, and mask.  Technically the width _ought_ to be
the same for all users, so I guess you could try to optimize that out.
...but it doesn't hurt the way it is.


> corecfg_baseclkfreq[7:0]
> Base Clock Frequency for SD Clock.
> This is the frequency of the xin_clk.
>
> How can 8 bits encode a frequency?
> Is there an implicit LUT? Is it a MHz count?

Use the source.  :)

 * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin.

It also turns out to match the SDHCI spec "Base Clock Frequency for SD
Clock".  See below.

---

It actually turns out that both of the "corecfg" bits we're setting
right now for Rockchip are a bit on the silly side.  All they do is
get mirrored out the other end in the "caps" register.  I found that
out from folks at Rockchip much later after I wrote my patch.

So, for instance, setting corecfg_clockmultiplier (I'm told) does
nothing more than control the bits read here:

  (caps[1] & SDHCI_CLOCK_MUL_MASK) >> SDHCI_CLOCK_MUL_SHIFT;

I can certainly see that they are mirrored, but I have to just take it
on faith that it does nothing else.

>>> w(grf + 0xf02c, 0x00ff0011)
>>> hex((r(sdhci + 0x44) & 0x00ff0000) >> 16)
'0x11L'


...and similar for the speed:

>>> w(grf + 0xf000, 0xff009700)
>>> hex((r(sdhci + 0x40) & 0x0000ff00) >> 8)
'0x97L'


-Doug
