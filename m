From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 Oct 2015 18:32:56 +0100
Subject: [PATCH 4/6] regulator: core: Propagate voltage changes to supply
 regulators
In-Reply-To: <1443621946-8712-5-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20151002173256.GZ12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 04:05:44PM +0200, Sascha Hauer wrote:

> A new min_dropout_uv field is added to struct regulator_desc. Regulators
> can specify the minimun dropout voltage they need for proper function
> here. Now when the voltage is changed on a regulator the regulator core
> makes sure that

Can we have this interface addition as a separate patch please?  Makes
it easier to add to other devices.  I could've sworn I'd already done
that bit but obviously never got the patch mailed out.

One change I think we need here is only doing the propagation if either
the device lacks a set_voltage() operation (in which case it's just a
switch passing through the parent voltage) or we have a dropout voltage,
otherwise we'll try to set the exact voltage the regulator is supposed
to output and that'll most likely end in tears.  Otherwise this is
making sense to me.

> Calculating the optimum voltage for the supply regulator is a bit tricky
> since the simple approach of just adding the desired minimum voltage and
> the minimum dropout is not enough. It may happen that the current
> regulator does not support the desired minimum voltage, but only a
> higher one. This means we have to figure out the lowest voltage
> supported by the regulator that is higher than the minimum desired
> voltage. The regulator_get_voltage_floor introduced with this patch does
> exactly that.

Yeah, split out the calcuate and the set.

Thanks for working on this!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/12bef68a/attachment.sig>
