From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 8 May 2018 23:00:50 +0200
Subject: [PATCH] arm: dts: atmel: graph_child_address warning fixes
In-Reply-To: <CAL_JsqLckD9FAS=mOH_gr7PL5xipF2qsGvBi0mRKXPnXn6bEMQ@mail.gmail.com>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508221819.6b70d5c7@bbrezillon>
 <CAL_JsqLckD9FAS=mOH_gr7PL5xipF2qsGvBi0mRKXPnXn6bEMQ@mail.gmail.com>
Message-ID: <20180508230050.3ee22309@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 May 2018 15:41:51 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, May 8, 2018 at 3:18 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Tue,  8 May 2018 08:59:25 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >  
> >> Addresses for graph ports and endpoints are not necessary when
> >> there's only a single child. Fix the following warnings removing
> >> unnecessary addresses on OF graph nodes:
> >>
> >> Warning (graph_child_address): /ahb/apb/hlcdc at f0030000/hlcdc-display-controller: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> >> Warning (graph_child_address): /ahb/apb/hlcdc at f0030000/hlcdc-display-controller/port at 0: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
> >> Warning (graph_child_address): /ahb/apb/isi at f0034000/port: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
> >> Warning (graph_child_address): /panel/port at 0: graph node has single child node 'endpoint at 0', #address-cells/#size-cells are not necessary  
> >
> > Unfortunately that's not going to work, because the driver calls
> > drm_of_find_panel_or_bridge() with a positive port and endpoint,
> > not -1. While we could switch port arg from 0 to -1, that's not that
> > simple for the endpoint arg, because we don't know in advance how many
> > devices will be connected to the RGB/DPI port.  
> 
> 0 and -1 are treated the same way in the graph code.

Oh, you're right, I didn't check the of_graph_parse_endpoint() code.

> 
> Ports should be separate data streams. Can the hlcdc have more than 1
> data stream (I think I checked that)?

Yes, there's only one port.

> If not, then more than 1 port
> will never be needed. Likewise, a panel is pretty much never going to
> have 2 ports (or endpoints).

True.

> The hlcdc could have more than 1 endpoint
> if you have multiple connections, but that's not what's defined. If
> you have an 'endpoint' node, then having #address-cells/#size-cells is
> wrong without a reg prop and unit-address.

The reg and unit-address were present in the endpoint nodes (maybe not
in all dts though). AFAICT, the problem is more that the port only has a
single child, and dtc complains that such nodes should not have a reg
prop.
