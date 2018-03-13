From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 16:32:35 +0100
Subject: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
In-Reply-To: <f001134a-987d-2491-a22e-d1d634f7b024@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-4-andre.przywara@arm.com>
 <20180307074516.dbak7ztkua4p7mr5@flea.lan>
 <f001134a-987d-2491-a22e-d1d634f7b024@arm.com>
Message-ID: <20180313153235.zyuelfcmayc6s73z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 02:05:34PM +0000, Andre Przywara wrote:
> Hi Maxime,
> 
> thanks for looking into this and for the Acks!
> 
> On 07/03/18 07:45, Maxime Ripard wrote:
> > On Wed, Mar 07, 2018 at 02:07:17AM +0000, Andre Przywara wrote:
> >> While the PWM IP in the Allwinner H6 SoC is fully compatible to those
> >> used in older SoCs (H3, A64), it features a dedicated reset line which
> >> needs to be de-asserted.
> >> Add support for an optional "resets" DT property in our pwm-sun4i probe
> >> routine, and assert and de-assert the reset line, where needed.
> >> This allows to enable PWM support on the H6.
> > 
> > This isn't optional then. It's mandatory on the H6, and unneeded on
> > everything else. This is what we should have.
> 
> So are you aiming at:
> 	if (of_device_is_compatible(np, "allwinner,sun50i-h6-pwm")) {
> 		... devm_reset_control_get() ...
> 
> I guess this is preferable over coding something based on a new member
> in struct sun4i_pwm_data?

It's basically a long term vs short term debate :)

If we're thinking short term, then yes, sure it would make
sense. However, if we start having more and more SoCs, we'll have a
longer and longer condition.

Since we already have a structure available, I'd still prefer to go
for the structure flag. This is faster (no string comparison), it'll
be easier to extend, and the patch size is pretty much the same.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/deccedfc/attachment-0001.sig>
