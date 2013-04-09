From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 9 Apr 2013 10:03:16 -0600
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130409004253.GA2258@localhost>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365419194-20871-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130408171940.GA8815@obsidianresearch.com>
 <20130409004253.GA2258@localhost>
Message-ID: <20130409160316.GB9663@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 09:42:54PM -0300, Ezequiel Garcia wrote:
> > Just to note on them for future:
> > 
> > > +	child = of_get_next_child(node, NULL);
> > > +	if (!child) {
> > > +		dev_err(dev, "%s has no childs\n", node->full_name);
> > > +		return -EINVAL;
> > > +	}
> > 
> > This isn't really necessary anymore, the ranges of the node itself
> > should be parsed to get the window start/end. The driver should never
> > need to look at the children directly..
> > 
> 
> You mean the above will not be necessary in the *future*,
> once we add mbus DT bindings, right?

No, you could do this now.

Look at your binding:

+               devbus-bootcs at d0010400 {
+                       status = "okay";
+                       ranges = <0 0xf0000000 0x1000000>; /* @addr 0xf000000, size 0x1000000 */

Parse that ranges and you get the base and size of the window.

Then 'ranges' is mandatory and 'ranges' must have a single entry.

No need to look at children at all. You can remove all the child
parsing code, and then the driver is able to handle a wider range of
possible DT uses.

Jason
