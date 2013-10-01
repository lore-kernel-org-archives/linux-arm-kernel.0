From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 1 Oct 2013 10:45:56 -0600
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <524ADFAA.40805@gmail.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost> <524AD2F7.4090803@gmail.com>
 <20131001142205.GF2448@localhost> <524ADFAA.40805@gmail.com>
Message-ID: <20131001164556.GA23874@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 04:43:54PM +0200, Sebastian Hesselbarth wrote:

> The local-mac-address property is a placeholder for the real mac
> address. Also, mv643xx_eth calls of_get_mac_address which fails for
> the invalid local-mac-address value of [00 00 00 00 00 00].
> 
> If you manage to setup local-mac-address in your bootloader, everything
> should be fine. 

FWIW, my environment is like this, and it works fine (this is recent,
3.10 didn't work). The driver now properly sets the MAC from the DT.

The driver will also need an update to call of_get_phy_mode and set
the interface properly, and the board files will need update to
specify the phy-mode property. I'm guessing things are working for
most people because the POR value happens to match the board?

> If we have a DT fixup that takes care of the above for non-DT
> bootloaders, everything should be fine.

Exactly, the problem is a broken DT on input to the kernel, the proper
action, IMHO, is to correct the DT in the kernel, so the hacking is
contained. Similar to how pci-fixups.c centralizes fixing of broken
firmware for PCI, and how CONFIG_ARM_ATAG_DTB_COMPAT centralizes it
for ATAG conversion.

BTW, why doesn't CONFIG_ARM_ATAG_DTB_COMPAT fix this? Do the boot
loaders on these systems not pass the mac at all??

> I still prefer Jason's approach and would give it a try on LAKML and
> devtree ML: Backup register contents if of_get_mac_address does not
> contain a valid address, and gate clocks.

FWIW, I would not use the language of 'backup' - this is a fixup
correcting an unsupported input DT.

IMHO, when this code triggers it should also:

printk(KERN_ERROR FW_BUG "local-mac-address is not set");

Jason
