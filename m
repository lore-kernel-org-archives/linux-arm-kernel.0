From: menghui.lin@mediatek.com (menghui lin)
Date: Wed, 3 Feb 2016 13:39:02 +0800
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <20160202193839.GX4455@sirena.org.uk>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk> <56AA5A5C.9080402@openwrt.org>
 <20160128231306.GD4130@sirena.org.uk>
 <1454061134.10861.14.camel@mtksdaap41>
 <20160129112717.GP4130@sirena.org.uk>
 <1454069479.10861.30.camel@mtksdaap41>
 <20160202193839.GX4455@sirena.org.uk>
Message-ID: <1454477942.31375.32.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-02-02 at 19:38 +0000, Mark Brown wrote:
> On Fri, Jan 29, 2016 at 08:11:19PM +0800, menghui lin wrote:
> > On Fri, 2016-01-29 at 12:27 +0100, Mark Brown wrote:
> 
> > > None of this is answering my question - I know what the current API is,
> > > describing it doesn't tell me about actual users or how they are able to
> > > sensibly use the interface.  Bear in mind that the definitions of the
> > > various modes are all relative and what one device thinks is high usage
> > > may be low usage for another device.
> 
> > Assuming valid_modes_mask and initial_mode are specified, a possible
> > way to modify regulator_set_mode() is to allow mode change only if the
> > regulator is controlled exclusively by a certain consumer or the
> > requested mode provides stronger power capability than current mode.
> > Here I assume that power capability fast > normal > idle > standby.
> 
> How does the driver know if it needs to change the mode (ie, how can it
> tell if the current mode is inadequate) and surely if we can only change
> in one direction this isn't terribly useful?

Hi Mark,

I think the datasheet of buck/ldo could provide information about power
capability of each mode. The driver should adjust regulator mode per its
device's power requirement.

Below are some actual scenarios we have now. I provide them for your
reference. If unfortunately below cases are not the actual users you
ask, please kindly let me know more about your suggestion.
Thank you. :)

case 1:

We have a USB typeC micro-controller, which has two modes - standby and
normal. It requires 1.8V and 3.3V to operate (both powers are always
on). The device stays in standby mode when there is no cable in. When
cable in, we got an interrupt and change device into normal mode.

The standby mode power consumption is quite small, so we would like the
change mode of regulator into STANDBY to save more power. And we change
into NORMAL when we receive cable-in interrupt.

case 2:

About buck regulator for CPU, it usually provides PWM mode, PWM/PFM Auto
mode, PFM mode. I think it could map to FAST, NORMAL, IDLE mode
respectively. Most of time we would use just normal mode. However, we
would change regulator into PWM mode time to time to test buck output
performance on the tested board.
