From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Oct 2016 17:04:57 -0500
Subject: [PATCH v2 2/4] dt-bindings: Add TI SCI PM Domains
In-Reply-To: <20161019203347.17893-3-d-gerlach@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
 <20161019203347.17893-3-d-gerlach@ti.com>
Message-ID: <20161026220457.kvbd4wgtizdbndf3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 03:33:45PM -0500, Dave Gerlach wrote:
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow the TI SCI protocol to
> control device power states.
> 
> Also, provide macros representing each device index as understood
> by TI SCI to be used in the device node power-domain references.
> These are identifiers for the K2G devices managed by the PMMC.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 54 +++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 include/dt-bindings/genpd/k2g.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> new file mode 100644
> index 000000000000..32f38a349656
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -0,0 +1,54 @@
> +Texas Instruments TI-SCI Generic Power Domain
> +---------------------------------------------
> +
> +Some TI SoCs contain a system controller (like the PMMC, etc...) that is
> +responsible for controlling the state of the IPs that are present.
> +Communication between the host processor running an OS and the system
> +controller happens through a protocol known as TI-SCI [1]. This pm domain
> +implementation plugs into the generic pm domain framework and makes use of
> +the TI SCI protocol power on and off each device when needed.
> +
> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +PM Domain Node
> +==============
> +The PM domain node represents the global PM domain managed by the PMMC,
> +which in this case is the single implementation as documented by the generic
> +PM domain bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> +
> +Required Properties:
> +--------------------
> +- compatible: should be "ti,sci-pm-domain"
> +- #power-domain-cells: Must be 0.
> +- ti,sci: Phandle to the TI SCI device to use for managing the devices.
> +
> +Example:
> +--------------------
> +k2g_pds: k2g_pds {
> +        compatible = "ti,sci-pm-domain";
> +        #power-domain-cells = <0>;
> +        ti,sci = <&pmmc>;
> +};

Why not just make the PMMC node be the power-domain provider itself? If 
not that, then make this a child node of it. The same comment applies to 
all the SCI functions, but I guess I've already acked some of them. 

I really don't like reviewing all these TI SCI bindings one by one. Each 
one on its own seems fine, but I don't see the full picture.

Rob
