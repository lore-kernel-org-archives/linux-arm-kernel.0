From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 08 Mar 2012 22:15:06 -0700
Subject: [PATCH 05/11] tps6586x: Add device-tree support
In-Reply-To: <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
 <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120309051506.761B63E090F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Mar 2012 16:15:46 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> * Mark Brown wrote:
> > On Thu, Mar 08, 2012 at 03:51:25PM +0100, Thierry Reding wrote:
> > 
> > > +- gpio-controller: mark the device as a GPIO controller
> > > +- regulators: list of regulators provided by this controller, must be in the
> > > +  following order:
> > > +    SM0, SM1, SM2, LDO0, LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO8, LDO9
> > 
> > This ordering requirement is fairly sad, if there are unused regulators
> > they still need to be listed even though...

It's worse than that; the DT provides absolutely no guarantees about the
ordering of either child nodes or properties.

> > 
> > > +			sm0_reg: sm0 {
> > > +				regulator-min-microvolt = < 725000>;
> > > +				regulator-max-microvolt = <1500000>;
> > > +				regulator-boot-on;
> > > +				regulator-always-on;
> > > +			};
> > > +
> > > +			sm1_reg: sm1 {
> > 
> > ...they all seem to be explicitly named in the device tree so presumably
> > there's enough information in there for the driver to pick any set of
> > regulators in any order.  This would be much nicer to use.
> 
> I don't like it much either. The only reason that requirement exists is
> because it makes the assignment of the regulator ID (as defined in the
> include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
> look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?
> 
> Then the only requirement would be that the names match.

Yes, please look up id via name.  Alternately you can give each child node
a 'reg' property and put #address-cells = <1>; #size-cells = <0>; in the
parent (assuming the regulator number is a documented attribute of the
hardware and not just a convenient linux construct).

g.
