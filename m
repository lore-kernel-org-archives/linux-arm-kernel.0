From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 11:33:16 +0200
Subject: [PATCH 3/4] arm: sunxi: Add AXP20X_ADC
In-Reply-To: <1dd83dbc-ebd2-3f40-d42c-c14a934d3535@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
 <20170721162005.18892-3-maxime.ripard@free-electrons.com>
 <CAGb2v64tx6M1CJSKr_wgD4LM+-ER+Yqpj-hUftptj41PVhbBBA@mail.gmail.com>
 <be7d4295-8759-f57e-a600-358c7344251c@free-electrons.com>
 <20170724081013.uyfaetzkj5iz7uhj@flea>
 <1dd83dbc-ebd2-3f40-d42c-c14a934d3535@free-electrons.com>
Message-ID: <20170724093316.zejftqcdccgokttm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 10:41:05AM +0200, Quentin Schulz wrote:
> Hi Maxime,
> 
> On 24/07/2017 10:10, Maxime Ripard wrote:
> > On Mon, Jul 24, 2017 at 08:43:56AM +0200, Quentin Schulz wrote:
> >> Hi all,
> >>
> >> I've been Cc'ed by Chen-Yu I think, thanks for the heads-up.
> >>
> >> On 22/07/2017 04:19, Chen-Yu Tsai wrote:
> >>> On Sat, Jul 22, 2017 at 12:20 AM, Maxime Ripard
> >>> <maxime.ripard@free-electrons.com> wrote:
> >>>> The APX20X_POWER option, that is a dependency of the USB controllers
> >>>> depends on IIO and AXP20X_ADC. Add it so that we can get a working USB
> >>>> back.
> >>>
> >>> The statement is only half true. AXP20X_POWER can fall back to reading
> >>> the ADC registers directly if AXP20X_ADC is not enabled.
> >>
> >> For any PMIC using "x-powers,axp202-usb-power-supply" compatible, that
> >> is true, the others imperatively use IIO channels as there was no prior
> >> support to this driver.
> >>
> >> The switch between reading IIO channels or directly reading the
> >> registers is done at probe by checking IS_ENABLED(AXP20X_ADC)
> >> (IS_ENABLED returns 1 when Kconfig is set to y or m). The goal was to
> >> not break the existing system when users would update to a newer kernel
> >> (as they may not have selected AXP20X_ADC).
> >>
> >> Since there is no hard dependency between AXP20X_ADC and AXP20X_POWER, I
> >> think we may have a problem when AXP20X_ADC is built as a module. Then
> >> AXP20X_POWER probing is deferred since it waits for the IIO channels.
> >> Also, if you do a modprobe on AXP20X_POWER it'll not probe AXP20X_ADC
> >> because the dependency is not declared. I don't know if there is a way
> >> to declare this dependency programatically only when AXP20X_ADC is built
> >> as a module?
> >>
> >>> Is there a plan
> >>> to remove this feature?
> >>>
> >>
> >> As said above (and in the commit log[1]), I added the condition for
> >> backward compatibility so anyone could still use AXP20X_POWER without
> >> the ADC, but maybe that is irrelevant?
> > 
> > The only compatibility we care about is the DT one. We don't care
> > about config options.
> > 
> 
> ACK.
> 
> >> This could solve a bit of the "complexity" of the driver, now that
> >> we know we want to enforce AXP20X_ADC to be built with
> >> AXP20X_POWER. I'm obviously okay to remove this feature if my point
> >> of backward compatibility is irrelevant.
> >>
> >> But now, we still have the problem that AXP20X_ADC is not needed for
> >> AXP20X_POWER for AXP22X (and those that don't have voltage/current
> >> sensing). We don't really need to force AXP20X_ADC to be built when the
> >> user want AXP20X_POWER.
> >>
> >> 1) We force AXP20X_ADC to be built whenever AXP20X_POWER is built, even
> >> for PMICs that don't have any voltage/current sensing. This way, we can
> >> enforce the dependency in Kconfig and everything's easy,
> > 
> > That's backward. The dependency is from AXP20X_POWER to
> > AXP20X_ADC. That's it, we should express it as such.
> > 
> 
> You want AXP20X_POWER to depends on AXP20X_ADC (AXP20X_ADC built when
> AXP20X_POWER is built, which is what I said). We agree on the same thing
> here.

Not really, or at least it's not what it sounded like. "Forcing
AXP20X_ADC to be built whenever AXP20X_POWER is built" is a select
dependency, not a depends on.

Anyway... it's great to know that we were both thinking to add a
depends on.

> >> 2) We programmatically set the dependency between AXP20X_ADC and
> >> AXP20X_POWER depending on the compatible used (AXP20X set the
> >> dependency, not AXP22X).
> > 
> > Why not just adding a depends on?
> > 
> 
> Because there is no dependency for AXP22X PMICs' USB power supply driver
> on AXP20X_ADC. AXP22X PMICs do not receive any information from the ADC.

You won't be able to deal with all cases properly...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/f3f736d5/attachment-0001.sig>
