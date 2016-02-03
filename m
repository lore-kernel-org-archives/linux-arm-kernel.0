From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Feb 2016 12:29:52 +0000
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1454477942.31375.32.camel@mtksdaap41>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
 <56AA5A5C.9080402@openwrt.org>
 <20160128231306.GD4130@sirena.org.uk>
 <1454061134.10861.14.camel@mtksdaap41>
 <20160129112717.GP4130@sirena.org.uk>
 <1454069479.10861.30.camel@mtksdaap41>
 <20160202193839.GX4455@sirena.org.uk>
 <1454477942.31375.32.camel@mtksdaap41>
Message-ID: <20160203122952.GF4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 01:39:02PM +0800, menghui lin wrote:
> On Tue, 2016-02-02 at 19:38 +0000, Mark Brown wrote:

> > How does the driver know if it needs to change the mode (ie, how can it
> > tell if the current mode is inadequate) and surely if we can only change
> > in one direction this isn't terribly useful?

> I think the datasheet of buck/ldo could provide information about power
> capability of each mode. The driver should adjust regulator mode per its
> device's power requirement.

That's of no help for a consumer driver which doesn't know what
regulator is supplying it.

> case 1:

> We have a USB typeC micro-controller, which has two modes - standby and
> normal. It requires 1.8V and 3.3V to operate (both powers are always
> on). The device stays in standby mode when there is no cable in. When
> cable in, we got an interrupt and change device into normal mode.

> The standby mode power consumption is quite small, so we would like the
> change mode of regulator into STANDBY to save more power. And we change
> into NORMAL when we receive cable-in interrupt.

This seems like something that we ought to be doing via runtime PM
anyway which should be going through the suspend mode bindings, though
that would need some plumbing in.

> case 2:

> About buck regulator for CPU, it usually provides PWM mode, PWM/PFM Auto
> mode, PFM mode. I think it could map to FAST, NORMAL, IDLE mode
> respectively. Most of time we would use just normal mode. However, we
> would change regulator into PWM mode time to time to test buck output
> performance on the tested board.

That's a test use that doesn't seem a good fit for upstream at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/fa4e9220/attachment-0001.sig>
