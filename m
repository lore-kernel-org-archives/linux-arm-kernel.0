From: pza@pengutronix.de (Philipp Zabel)
Date: Tue, 23 Dec 2014 13:01:37 +0100
Subject: [PATCH v6 3/3] of: Add of_graph_get_port_by_id function
In-Reply-To: <54994D88.3000009@samsung.com>
References: <1419261091-29888-1-git-send-email-p.zabel@pengutronix.de>
 <1419261091-29888-4-git-send-email-p.zabel@pengutronix.de>
 <54994D88.3000009@samsung.com>
Message-ID: <20141223120137.GA26129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On Tue, Dec 23, 2014 at 12:10:00PM +0100, Andrzej Hajda wrote:
[...]
> >  /**
> > + * of_graph_get_port_by_id() - get the port matching a given id
> > + * @parent: pointer to the parent device node
> 
> Here you have 'parent' and 'node' in the code.
[...]
> Maybe I miss something but it does not handle optional 'ports' node.

You missed nothing, thank you for the comments! I'll fix both issues
like this:

struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
{
	struct device_node *node, *port;

	node = of_get_child_by_name(parent, "ports");
	if (node)
		parent = node;

	for_each_child_of_node(parent, port) {
		u32 port_id = 0;

		if (of_node_cmp(port->name, "port") != 0)
			continue;
		of_property_read_u32(port, "reg", &port_id);
		if (id == port_id)
			break;
	}

	of_node_put(node);

	return port;
}

regards
Philipp
