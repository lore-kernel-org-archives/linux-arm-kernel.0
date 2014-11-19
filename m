From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 19 Nov 2014 07:35:36 -0800
Subject: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify DT
 params
In-Reply-To: <1416383379.30131.14.camel@mm-sol.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
 <1416300621.30131.6.camel@mm-sol.com>
 <995406b8e0244c63a3ef8e58314e81f6@BL2FFO11FD037.protection.gbl>
 <1416383379.30131.14.camel@mm-sol.com>
Message-ID: <84517404cda34124930ec838a639f538@BL2FFO11FD030.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On Wed, 2014-11-19 at 09:49AM +0200, Ivan T. Ivanov wrote:
> 
> On Tue, 2014-11-18 at 09:25 -0800, S?ren Brinkmann wrote:
> > On Tue, 2014-11-18 at 10:50AM +0200, Ivan T. Ivanov wrote:
> > > 
> > > On Tue, 2014-11-11 at 15:53 +0100, Linus Walleij wrote:
> > > > On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
> > > > brinkmann at xilinx.com> wrote:
> > > > 
> > > > > Additionally to the generic DT parameters, allow drivers to 
> > > > > provide driver-specific DT parameters to be used with the 
> > > > > generic parser infrastructure.
> > > > > 
> > > > > Signed-off-by: Soren Brinkmann brinkmann at xilinx.com>
> > > > 
> > > > I like the looks of this, but the patch description is a bit 
> > > > terse. I'd like it to describe some of the refactorings being 
> > > > done
> > > > to the intrinsics, because I have a hard time following the 
> > > > patch.
> > > > 
> > > > First please rebase onto the "devel" branch in the pin control 
> > > > tree, and notice that drivers/pinctrl/qcom/pinctrl-spmi-gpio.c 
> > > > which is merged there is actually doing this already:
> > > > 
> > > > 
> > > >         for_each_child_of_node(np_config, np) {
> > > >                 ret = pinconf_generic_dt_subnode_to_map(pctldev, 
> > > > np, map,
> > > >                                                         &reserv, 
> > > > nmaps, type);
> > > >                 if (ret)
> > > >                         break;
> > > > 
> > > >                 ret = pmic_gpio_dt_subnode_to_map(pctldev, np, 
> > > > map, &reserv,
> > > >                                                   nmaps, type);
> > > >                 if (ret)
> > > >                         break;
> > > >         }
> > > > 
> > > > So it should be patched to illustrate the point of this code.
> > > > 
> > > 
> > > I like the idea, but have issues with implementations :-).
> > >  
> > > It is supposed that additional parameters are not generic,
> > > otherwise they will be part of enum pin_config_param, right?
> > > 
> > > Probably it will be better if clients could pass array with
> > > driver specific dt bindings to pinconf_generic_dt_node_to_map()?
> > 
> > My idea was to hide that API from the driver. You just pass those 
> > parameters as part of the struct pctldev and the parser - whether 
> > this generic one or anything else - would do the right thing. I 
> > don't think calling the parser from the driver is the right approach.
> 
> Drivers already know about dt_node_to_map(). My proposal will make
> drivers, which register non-standard bindings, little bit simpler.

And I think this is not the best solution. Those drivers essentially
still do the DT parsing themselves, just call some common helpers. I
think that should be well separated. The pinctrl driver just assembles
some data structure that has the information regarding custom properties
and the core handles the rest. I find the approach I have in the zynq
driver - which does it that way - more elegant. The only reference to
the core parser there is the function pointer to the generic node to map
function. And even that could probably disappear in the long term when
everything migrates to using the core parser and generic bindings.

Also, why does it make the driver simpler? In my zynq driver I only have
those mentioned data structs and nothing in regards of parsing the DT.
With drivers calling the parser you duplicate exactly that all over the
place in each driver. More code, more duplication. And I don't see where
things become simpler. The core becomes a little more complex, but well,
that's why it gets consolidated there, right?

	Thanks,
	S?ren
