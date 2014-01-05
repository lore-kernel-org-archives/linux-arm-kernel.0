From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 5 Jan 2014 16:40:23 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <201401051525.52459.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de>
Message-ID: <20140105154023.GA2048@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static int __init mvebu_soc_id_init(void)
> > +{
> > +	struct device_node *np;
> > +	int ret = 0;
> > +
> > +	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
> > +	if (np) {
> > +		void __iomem *pci_base;
> > +		struct clk *clk;
> > +		/*
> > +		 * ID and revision are available from any port, so we
> > +		 * just pick the first one
> > +		 */
> > +		struct device_node *child = of_get_next_child(np, NULL);
> 
> I guess all this will fail if for some reason the PCIe node is not
> present on machines that don't use PCIe.

Hi Arnd

That would be rather odd. These nodes are in the top level SoC dtsi
file. When they are not used, they have status = "disabled" and are in
the dtb blob with this state.

The only reason i can think of them not being present at all is if
somebody adds an optimizer to dtc which removed disabled nodes. What
does the device tree spec say about that? Are we relying on undefined
dtc behavior?

    Thanks
	Andrew
