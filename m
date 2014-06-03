From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Jun 2014 15:09:38 +0200
Subject: [PATCH 0/5] regulator: Enhance AXP209 DT support
In-Reply-To: <20140528184752.GA22488@sirena.org.uk>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140528184752.GA22488@sirena.org.uk>
Message-ID: <20140603130938.GI27722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 07:47:52PM +0100, Mark Brown wrote:
> On Wed, May 28, 2014 at 07:11:04PM +0200, Maxime Ripard wrote:
> 
> > This patchset modifies the regulator core and axp209 regulator driver
> > to be able to set in each regulators sub-node the supply, that should
> > be possible, given that it's documented as such in the bindings, but
> 
> It is?  We should fix that.

>From Documentation/devicetree/bindings/regulator/regulator.txt:

  - <name>-supply: phandle to the parent supply/regulator node

With the example:

    xyzreg: regulator at 0 {
        regulator-min-microvolt = <1000000>;
        regulator-max-microvolt = <2500000>;
        regulator-always-on;
        vin-supply = <&vin>;
    };

If not right, then it's strongly misleading.

> 
> > is not at the moment, since whenever looking up the supply in the DT,
> > of_get_regulator will always look into the parent's device of_node
> > pointer.
> 
> > This leads to a common pattern accross the regulators to have multiple
> > supply in the main device node, while it would be more intuitive yet
> > follow the documented bindings to look into the regulator sub-nodes
> > first.
> 
> No, we've been round this loop several times before.  This reduces
> consistency in how we map supplies since the user has to work out which
> subnode the supply is associated with and what it's called there instead
> of being able to just look at the schematic and translate the supply
> name into a property name.  It also means you have to map supplies into
> multiple child nodes if the same supply is used in multiple places.

Which might be what your schematics actually show. If you have a
single input pin for each regulator, even if the name changes from one
pin to another, you're still pretty much in this kind of construct.

> The idea is that supplies that happen to be used to supply a regulator
> don't get treated any differently to any other supply and that we do
> that at the physical package level.

In our case, each regulator found in the PMIC has an input of its own,
which is a very similar setup than the one found in a gpio-controlled
regulator for example.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/73276233/attachment.sig>
