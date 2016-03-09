From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Mar 2016 16:28:22 +0100
Subject: [PATCH 0/4] Add AXP209 GPIO driver
In-Reply-To: <56E0146E.6050102@redhat.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <56E0146E.6050102@redhat.com>
Message-ID: <20160309152822.GQ8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 09, 2016 at 01:17:50PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 09-03-16 11:50, Maxime Ripard wrote:
> >Hi,
> >
> >The axp209 PMIC used in combination to some Allwinner SoCs has a bunch
> >of GPIOs accessible. Some boards use these to control their backlight
> >or a few LEDs.
> 
> Thanks for working on this, but IMHO this cannot go upstream like this,
> the gpio pins on the axp pmics need a pinctrl driver, not a gpio
> driver. I.E. on the axp209 gpio0 and gpio1 can also be used to output
> an additional low-noise ldo (so as a regulator), or as an adc input.

Eventually, yes, it needs both. But they don't even have to be the
same driver, since they provide two different features. The only
reason we have that construct in the pio case is because they share
the same address space, but in the AXP case, the regmap and our mfd
take care of that already.

> I've been working on gsl1680 touchscreen support lately and on at least
> a few a23 tablets, the low-noise ldo is used as AVCC for the touchscreen
> controller.

Yeah, the AXP209 also has an ADC connected to these pins.

> Now these use an axp223 pmic, but nothing is stopping someone from
> doing something similar with an axp209 and I think it would be best
> to support this from day one, rather then hope we can retro-fit this
> later without breaking dts.

I considered that, but I don't see how it would break the DT later. If
someone wants to enable say the ADC, he will of course have to add the
pinctrl driver, and the pinctrl handles, but the old DT will only
reference the gpio driver directly, which would still be something
that would work.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160309/60776cb9/attachment.sig>
