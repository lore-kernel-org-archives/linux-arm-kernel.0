From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Apr 2014 14:12:01 -0600
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410200153.46669e0c@skate>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
Message-ID: <20140410201201.GA12661@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 08:01:53PM +0200, Thomas Petazzoni wrote:
> > Can you run Neil's patch and see if your system behaves the same?
> > Specifically that the link eventually goes down after
> > mvebu_pcie_set_local_dev_nr ?
> > 
> > I couldn't find any case where the BDF leaks below the TLP layer, and
> > the spec is very clear that the assigned BDF can change at run time,
> > so I don't have an explanation for why the link reset is happening.
> > Do you have a contact at Marvell that might shed some light on that
> > behavior?
> 
> There was a potential explanation about the mvebu-soc-id driver that
> enables the clock and then disables it, before the pci-mvebu driver.
> This is different that what was happening before, where the pci-mvebu
> driver was the only one to enable the clock, which was already enabled
> by the bootloader. So if the clock takes some time to stabilize, the
> introduction of mvebu-soc-id may lead to problems.

Oh, that certainly sounds like a potential problem. Disabling the
clock will certainly cause 'interesting' effects on the PEX, depending
on exactly what it does it could confuse the link partner (trigger a
timeout based retrain?).

Gating the clock without disabling the Phy first does sound like a
bad idea..

Neil, does this do anything for you?

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index f3b325f..e0a032f 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -107,7 +107,7 @@ static int __init mvebu_soc_id_init(void)
        iounmap(pci_base);
 
 res_ioremap:
-       clk_disable_unprepare(clk);
+//     clk_disable_unprepare(clk);
 
 clk_err:
        of_node_put(child);

> But I'm not entirely convinced by this, because in my testing, I saw:
> 
>  * Enable the clock
>  * Values in the PCI configuration space are correct (like
>    vendor/product ID)
>  * mvebu_pcie_set_local_dev_nr()
>  * Values in the PCI configuration space are no longer correct, unless
>    you wait a little bit.

Were you reading the configuation space through the MMIO mapping or
through the configuration indirection?

In any event, turning on the clock should almost certainly be
accompanied by a phy reset sequence to get both link ends on the same
page.

Attached is a rough, untested patch along those lines.

> > That does sound like more mbus troubles.
> 
> Interestingly, the problem occurred when I was plugging a SATA PCIe
> card. And regardless of whether the SATA PCIe card is present or not,
> the MBus mappings for the IGB are exactly the same.

Maybe something wrong with mbus window index 13?

Any change if you use other windows?

--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -299,7 +299,7 @@ static int mvebu_mbus_alloc_window(struct mvebu_mbus_state *mbus,
        int win;
 
        if (remap == MVEBU_MBUS_NO_REMAP) {
-               for (win = mbus->soc->num_remappable_wins;
+               for (win = 0;
                     win < mbus->soc->num_wins; win++)
                        if (mvebu_mbus_window_is_free(mbus, win))
                                return mvebu_mbus_setup_window(mbus, win, base,

Jason
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pex-reset.diff
Type: text/x-diff
Size: 1897 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/e9227692/attachment.bin>
