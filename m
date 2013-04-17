From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 17 Apr 2013 17:52:01 -0500
Subject: [PATCH] ARM: mach-imx6q: Remove code for setting up cko clock
In-Reply-To: <CAKGA1bnMUBhXdsfOsBOm2T2VA=FHDWHthbPcXqA7eHX1DPJvkw@mail.gmail.com>
References: <1366224182-29285-1-git-send-email-festevam@gmail.com>
 <20130417195744.GX1906@pengutronix.de>
 <CAKGA1bnMUBhXdsfOsBOm2T2VA=FHDWHthbPcXqA7eHX1DPJvkw@mail.gmail.com>
Message-ID: <CAKGA1bk7Eek4h8_6HAerOthB7Bh80U4gC181qevr496ooXTk1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending to LAKML in plaintext (Google ARGH..), apologies for anyone
receiving it twice..

--
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.

On Wed, Apr 17, 2013 at 5:29 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> On Wed, Apr 17, 2013 at 2:57 PM, Sascha Hauer <s.hauer@pengutronix.de>
> wrote:
>>
>> On Wed, Apr 17, 2013 at 03:43:02PM -0300, Fabio Estevam wrote:
>> > From: Fabio Estevam <fabio.estevam@freescale.com>
>> >
>> > Let the bootloader setup the cko clock that drives the audio codec.
>> >
>>
>> I really don't like such stuff. Where is documented what's expected from
>> the bootloader?
>
>
> Schematics for the board - and basically a flat-out recommendation that all
> clocks that need to be set to something other than power-on defaults need to
> be set to their expected parents and rates at bootloader time even if
> they're not used by the bootloader, unless they can be confirmed totally
> unused (in which case, they needn't even be in the device tree and Linux
> will just never know they even exist).
>
> This is a fact of life.. I don't see why Linux should end up with a bunch of
> board-specific hacks to work around broken bootloaders when we're talking
> about DT-supported boards. In this case, probably everyone has to go get a
> new U-Boot anyway to even boot a kernel that would show this problem (no
> Freescale board ever shipped before 2012 with a dt-capable U-Boot, so unless
> you're using DTB_APPEND..).
>
>> Which versions of which bootloader do implement this?
>>
>> The code you remove is not particularly nice, but just removing it is no
>> solution to the problem.
>>
>>
>> > This simplifies a lot the code and when a new board needs to add audio
>> > support,
>> > it will not have to add all this amount of code again.
>>
>> It shouldn't be necessary to duplicate the code for each board.
>
>
>
> But it usually is - even if there is a generic "set up clko" routine where
> you pass a parent and a desired rate, a bunch of boards will end up calling
> it, and in the end it's basically a workaround for the fact that the
> bootloader did NOT set this up (when it should!)
>
> For an audio codec, this rate is basically nearly always fixed (and where it
> isn't.. it's up to the codec driver to set_rate on it's specified clock when
> it needs to). Since it isn't possible to dictate clock frequency in the
> device tree right now, and I at least would prefer that we didn't store "yet
> to be configured, please assure this" kind of directives in device tree, the
> bootloader is the best place.
>
> There's similar code in MX5 platforms right now which reparents the USB PHY
> clock to one that can actually can generate desired rates for USB PHYs
> (which is coordinated with some other code which sets the USB PHY rate
> inside the PHY). In any case here, all MX5 chips boot with an "impossible"
> USB PHY configuration (there is no clock parent that can give it that rate,
> it must be changed), and it is not possible to use the default parent to
> generate two of the other rates either. This is a bootloader thing for sure.
> Linux should not be working around this. There's also code that sets parents
> for eSDHC controllers; this is global code run on every board, and only
> works because every board designer - so far - didn't bother to do something
> different (as it stands, the eSDHC gets a reaaaally weird rate because of
> it, and it is surprising nobody noticed..)
>
> Even if we had such directives in DT, 99.9% of it would be reproduction of
> clock setting code in bootloader being dumped into the device tree and
> re-set by Linux yet again. That can cause glitches which can cause devices
> like codecs to basically go into indeterminate states (and some of these
> devices simply don't have resets, so they stay in those states unless
> powered off and on again, and sometimes the regulators aren't configurable -
> all this is in the schematics for the board if they're available).
>
> When your Linux kernel warns (and it should warn in each driver that detects
> a weirdo clock scenario that can detect it) that you may need a new
> bootloader, then updating the bootloader is necessary. For boards where the
> developers don't like you to update the bootloader, well.. ours are a couple
> of those, and to be honest, I will happily ship firmware updates when
> there's some platform support for our board, which I've still not gotten
> round to doing yet (busy...)
>
> The usual scenario here is that there was a lazy port of BSP code to
> mainline U-Boot and you're running that instead of the BSP version
> (*ahemlinarocough*), someone coded bootloader support but assumed Linux will
> just set it up (*ahemfreescalecough*) or someone hacked up support for a
> board which has no public schematics (GK802/Richtechie MT-500A comes to
> mind) and no open-sourced board support (which is illegal by any means in
> the aforementioned case) - basically fixable (Linaro usually recommends
> using a Linaro U-Boot for example), fixable (someone may need to align board
> support mainline U-Boot and mainline Linux at some point), and no reason to
> ever bother with criminals - respectively.
>
> What we're discussing here is basically "it used to work and now Fabio broke
> Linux" - actually, Fabio is removing an egregious hack that should never
> have been there in the first place, Linux works fine ("as always"), and the
> bootloader is broken.. it would never have passed QA for consumer
> electronics. Since these are developer boards, we can be forgiving up to a
> point...
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
>
