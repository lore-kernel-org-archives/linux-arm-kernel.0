From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Wed, 28 Jan 2015 22:43:10 +0100
Subject: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
In-Reply-To: <20150126155850.GD28663@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com>
 <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com>
 <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
 <20150123164756.GB7718@atomide.com>
 <CAALWOA9F7UH5ORXdjyHAyekohZdSiE-+enNg5vsxOV5RgfqEdw@mail.gmail.com>
 <20150126155850.GD28663@atomide.com>
Message-ID: <CAALWOA9gSegCofYF-csg_2zdRkz=W5g8UAOqBbrA-NG0-oR1ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2015 at 16:58, Tony Lindgren <tony@atomide.com> wrote:
> See earlier I was assuming copy paste issues from dm814x to dm816x

Ahh, you thought the 816x was 814x-derived... yes I can imagine that
will have led to some confusion.

> I'm pretty sure I verified the that the audio_pll_clk1 is hardwwired
> to 32KiHz by looking at it with a scope on the clkout pin.

Yeah it comes straight from the "rtcdivider" so it'll produce
0.0016384 * devosc.

The global clock structure overview in the TRM (figure 2-6) actually
correctly marks the former-audio-fapll clocks (except audio5 := osc0,
yielding sysclk22 after divider) but you already need to know what the
hell is going on to recognize that.


Oh, on the topic of PRCM, a word of caution: while the cold reset
default of PM_DEFAULT_PWRSTCTRL is 0, performing _any_ write to it
(regardless of value) sets it to 3 (force power-on) until next cold
reset. An unfortunately side-effect I stumbled over is that a
particular bus lockup that can occur in ducati (dual cortex-m3
subsystem) then becomes warm-reset-insensitive.

The statement I got from TI support about the strange behaviour of
this power control register was.. vague:

  In DM814x, complete functionality of PRCM was not used and that
  resulted into such requirements.

  This recommendations was made based on DV test cases with POWERONSTATE
  == ON/0x3.

  We didn?t do any negative testing to see the behaviour in case
  POWERONSTATE != ON/0x3.

  So I can recommend you to test your system without this requirement
  and see if you will have any issues. I think this requirement is not
  needed (POWERONSTATE == ON/0x3), as the DM814x EZSDK (u-boot, linux
  kernel) is working fine without it.



> > The inventory of SecSS on Netra yielded exactly the same list of
> > accelerators and other peripherals as on Centaurus btw. The only
> > changes seem to be in subsystem control stuff.
>
> What are you using to identify the devices? The device revision
> register? Or are there actually some populated interconnect data
> available with device info that could be used for a real scannable
> bus?

You mean the modules? SecSS unfortunately doesn't have an integrated
memory map like the one present in the Sonics S3220 interconnects, so
I just probed it manually while making use of the knowledge I already
had of SecSS on Centaurus.  It helps that I already did quite a bit of
exploration of SecSS on Centaurus, and it turns out to barely differ
from the original one* on Netra. The differences seem to be
permissions-related: the subsystem control module was split into two
separate parts and there was a tiny bit of rearrangement for the
benefit of being able to cover multiple modules with a single firewall
region.

I've updated the SecSS sheet of my memory-map spreadsheet to highlight
the differences.

It's not totally clear what the intentions are of the various default
firewall regions. Region 0 will undoubtedly be highly restricted on
all but GP devices. On centaurus region 5 looks like it'll be
exclusively for the cortex-m3 on devices where it automatically boots
stand-alone from ROM (EMU/HS) instead of waiting to boot into
user-supplied code on request (Test/GP/EMUL/HSL).


*TI's linux driver calls it "NSS" (Netra Security Subsystem) on both
chips, so presumably Netra was the first to have this kind of
subsystem.
