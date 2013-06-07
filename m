From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Jun 2013 13:44:30 -0600
Subject: [PATCH 03/14] bus: mvebu-mbus: Introduce device tree binding
In-Reply-To: <201306072110.35856.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072110.35856.arnd@arndb.de>
Message-ID: <20130607194430.GA7854@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 09:10:35PM +0200, Arnd Bergmann wrote:
> On Friday 07 June 2013, Ezequiel Garcia wrote:
> > +       np = of_find_matching_node(NULL, of_mvebu_mbus_ids);
> > +       if (!np) {
> > +               pr_err("could not find a matching SoC family\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       of_id = of_match_node(of_mvebu_mbus_ids, np);
> > +       mbus_state.soc = of_id->data;
> > +
> > +       if (of_address_to_resource(np, 0, &mbuswins_res)) {
> > +               pr_err("cannot get MBUS register address\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (of_address_to_resource(np, 1, &sdramwins_res)) {
> > +               pr_err("cannot get SDRAM register address\n");
> > +               return -EINVAL;
> > +       }
> 
> Just an idea to make this more regular: Since the internal-regs can no longer
> be regarded as a fixed location, we might want to use the same "ranges" property
> mechanism for resolving the internal regs as we use for everything else.
> 
> This would imply that the device node this driver binds to would actually
> end up being a child of the bus itself, which then goes on to modify the
> ranges property of its parent node. Does that make sense?

We have a minimum requirement that the bootloader setup internal regs,
so the minimum required DT bindings is going to be this:

mbus {
  compatible = ...
  ranges = <INTERNAL_REGS_MAP_ID 0xf1000000 0x100000>;
  reg = <0xf1000xxx ...>; // MBUS regs block
  #address/size-cells...

  internal-regs  {
      ranges = <0 INTERNAL_REGS_MAP_ID 0x100000>;
  }
}

ie the ranges should never be empty.

Discovery of the address of the mbus control registers is via the reg
property on its own node (which is untranslated), and all other
internal regs blocks will automatically translate as they are supposed
to (Thomas's work to make internal regs 0xd/0xf1 relies on this, AFAIK)

INTERNAL_REGS_MAP_ID is an invalid target ID value, defined to mean
the internal registers target. 0xFFFFFFFF is a better choice for this
than 0, because 0xFFFFFFFF is never going to be a valid target id, it
is too large.

Jason
