From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 10:35:10 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20130930213131.GB10393@obsidianresearch.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130930213131.GB10393@obsidianresearch.com>
Message-ID: <20131001143510.GA3122@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 03:31:31PM -0600, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
> 
> > These clocks should never be gated, since the ethernet interfaces
> > forget the assigned MAC address assigned if their clock source is
> > turned off.
> 
> Hrm, this hack is only needed to support the hack of passing the MAC
> address from the bootloader to the kernel via the ethernet registers.
> 
> If local-mac-address is present in the DT (or fixed up via ATAGS) then
> none of this is needed.
> 
> Boards that have well formed DT's don't need this.
> 
> The major downside to this patch is we never get power savings by
> disabling the 2nd GE. On my boards it is not connected so we always
> want to see it powered down.
> 
> Our bootloader gates the power and turns off the clock, having Linux
> turn the clock back on without knowing how to control the power seems
> like a possible problem.
> 
> I don't have code, but when this was first brought up it was suggested
> to add local-mac-address to the DT nodes if it isn't present in the
> common code and don't mess with the clocks.
> 
> Psudeo code:
> 
> void marvell_dt_ethernet_fixup(void)
> {
>  for_each_compatible_node(np, "marvell,kirkwood-eth-port")
>  {
>    if (of_get_mac_address(np) != NULL)
>       continue;
>    regs = ioremap(of_regs(np->parent,0));
>    address = (readl(regs + MAC_ADDR_HIGH) << 32) | 
>               readl(regs + MAC_ADDR_LOW))
>    iounmap(regs);
>    of_add_property(np, {"local-mac-address" = address});
>  }
> }

Or, could we test for the mac address in the driver's suspend routine
and set the clock's IGNORE_UNUSED accordingly?  That wouldn't cover the
case of the modules being loaded after boot, but it would get us power
savings when we can.

It also has the benefit of being easily discoverable by future users
wondering why the clock isn't gated when attempting to conserve power.

To that end, we could set the bit as Ezequiel has done, and then change
it in the eth driver's probe if there's a mac address in the DT.


thx,

Jason.
