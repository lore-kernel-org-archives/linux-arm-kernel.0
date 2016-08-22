From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Aug 2016 19:09:32 +0100
Subject: [PATCH 3/9] regulator: core: Try full range when adjusting
 regulators to constraints
In-Reply-To: <20160822175205.h76hurjaopnosymc@vip.cybercity.dk>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-4-wens@csie.org>
 <20160822162907.GO22076@sirena.org.uk>
 <20160822175205.h76hurjaopnosymc@vip.cybercity.dk>
Message-ID: <20160822180932.GW22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 07:52:05PM +0200, Rask Ingemann Lambertsen wrote:
> On Mon, Aug 22, 2016 at 05:29:07PM +0100, Mark Brown wrote:

> > This seems like you have buggy constraints, constraints which allow
> > voltages that can't physically be satisfied don't make obvious sense.

> No, it's for cases like this (see the cubietruck4 or a80-optimus dts
> patches):

> 			reg_bldo4: bldo4 {
> 				regulator-min-microvolt = <1080000>;
> 				regulator-max-microvolt = <1320000>;
> 				regulator-name = "vcc12-hsic";
> 			};

> The regulator can do 1100000 uV, 1200000 uV and 1300000 uV, all of which
> are within the constraints, so obviously the constraints can be satisfied,
> yet the regulator core fails do so with a message like this:

Sure, but the constraints also say that you can do 1.32V which the
system is not physically capable of delivering.  That's not a good sign
for the constraints, it suggests that at least the capabilities of the
regulator have not been taken into consideration when setting up the
constraints.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/7f58a619/attachment.sig>
