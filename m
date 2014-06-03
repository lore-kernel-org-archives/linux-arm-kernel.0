From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jun 2014 14:56:30 +0100
Subject: [PATCH 0/5] regulator: Enhance AXP209 DT support
In-Reply-To: <20140603130938.GI27722@lukather>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140528184752.GA22488@sirena.org.uk>
 <20140603130938.GI27722@lukather>
Message-ID: <20140603135630.GC31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:09:38PM +0200, Maxime Ripard wrote:
> On Wed, May 28, 2014 at 07:47:52PM +0100, Mark Brown wrote:
> > On Wed, May 28, 2014 at 07:11:04PM +0200, Maxime Ripard wrote:

> > > This patchset modifies the regulator core and axp209 regulator driver
> > > to be able to set in each regulators sub-node the supply, that should
> > > be possible, given that it's documented as such in the bindings, but

> > It is?  We should fix that.

> From Documentation/devicetree/bindings/regulator/regulator.txt:

>   - <name>-supply: phandle to the parent supply/regulator node

> With the example:
> 
>     xyzreg: regulator at 0 {
>         regulator-min-microvolt = <1000000>;
>         regulator-max-microvolt = <2500000>;
>         regulator-always-on;
>         vin-supply = <&vin>;
>     };

> If not right, then it's strongly misleading.

That's misleading, the supplies are for the bit of silicon not some
subfunction on it.

> > No, we've been round this loop several times before.  This reduces
> > consistency in how we map supplies since the user has to work out which
> > subnode the supply is associated with and what it's called there instead
> > of being able to just look at the schematic and translate the supply
> > name into a property name.  It also means you have to map supplies into
> > multiple child nodes if the same supply is used in multiple places.

> Which might be what your schematics actually show. If you have a
> single input pin for each regulator, even if the name changes from one
> pin to another, you're still pretty much in this kind of construct.

That's very common, but I do expect that the supplies are all uniquely
named on the silicon so not a big deal and bear in mind that this is
not just about consistency between PMICs but also about consistency
between PMICs and other devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/6dbe7192/attachment-0001.sig>
