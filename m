From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 11:38:54 +0200
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <20140618100411.GL23945@lee--X1>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
 <53A160D1.8000908@ti.com> <20140618100411.GL23945@lee--X1>
Message-ID: <6599289.0ZjjaMbRqj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 11:04:11 Lee Jones wrote:
> > On Tuesday 17 June 2014 04:53 PM, Lee Jones wrote:
> > >>> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> > >>> devices. It has 2 ports which it can use for either; both SATA, both
> > >>> PCIe or one of each in any configuration.
> > >>
> > >> I've asked others who wrote multi-phy PHY providers to model each individual
> > >> PHY as sub-node of the PHY provider. So It's only fair I ask you the same to
> > >> do. So in this case the dt node should look something like:
> > >>
> > >> 	miphy365x_phy: miphy365x at fe382000 {
> > >> 		compatible = "st,miphy365x-phy";
> > >> 		#phy-cells = <2>;
> > >> 		st,syscfg = <&syscfg_rear>;
> > >> 		channel at 0 {
> > >> 			reg =	<0xfe382000 0x100>, <0xfe394000 0x100>;
> > >> 			reg-names = "sata", "pcie";
> > >> 		}
> > >>
> > >> 		channel at 1{
> > >> 			reg =	<0xfe38a000 0x100>, <0xfe804000 0x100>;
> > >> 			reg-names = "sata", "pcie";
> > >> 		}
> > >>
> > >> 	};
> > > 
> > > I'm interested to know why you've taken this approach, as it makes the
> > > code much more complex.  The DT framework goes to the trouble of
> > 
> > It looks to be much closer representation of the hardware in dt. It also
> > enables to have more control of each individual PHYs. For example, we can have
> > something like status="disabled" for channels which is disabled.
> 
> If you wanted to disable the channels in this way, you would either
> have to A) add your own code to parse that property or B) have each
> channel set itself up as platform device and would probe (or not if
> status = "disabled") individually.  If you choose the later option,
> the platform resource would also be populated.

We have of_device_is_available() and for_each_available_child_of_node()
to check for the status property. This doesn't seem much extra overhead.

> > > converting all addresses to to resources so drivers can easily pull
> > > them out using platform_get_resource() and friends.  Pushing the reg
> > 
> > right. Can't we use of_address_to_resource here?
> 
> We could, but that would be an extra layer.  We'd be pulling the
> address, putting it into a resource, then pulling it from the resource
> for use.  If we're going to be pulling addresses out manually, we're
> probably better off using of_get_address().  But again, we're just
> carrying out functionality which is already provided by the
> framework.

there is also of_ioremap().

> > > properties down into a child node means that we have to now iterate
> > > over the sub-nodes and pull them out manually.  This will lead to a
> > 
> > You anyway iterate while creating PHYs based on some constant. Now you have to
> > iterate over the sub-nodes.
> > > pretty messy implementation IMHO.
> 
> This much is true.
> 
> > > Can you point me in the direction of previous implementations where you
> > > have stipulated the same set of constraints please?
> > 
> > ah.. there isn't any. The author of the other multi-phy driver [1] also feels
> > this will just add to the complexity of the driver.
> 
> =:)
> 
> > Maybe we should ask the opinion of others?
> 
> We could.  I'll CC Arnd as he likes this PHY stuff. :)
> 
> > [1] -> http://www.spinics.net/lists/linux-sh/msg32087.html

Having sub-nodes for each individual PHY managed by a controller seems
very reasonable to me. Making them show up as separate platform devices
seems less useful though.

	Arnd
