From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 9 Apr 2014 10:20:40 -0600
Subject: [PATCH v2] bus: mvebu-mbus: Avoid setting an undefined window size
In-Reply-To: <20140409061128.GC16465@1wt.eu>
References: <1397000654-10849-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140409061128.GC16465@1wt.eu>
Message-ID: <20140409162040.GA19743@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 08:11:29AM +0200, Willy Tarreau wrote:

> OK I just got it by adding two printk() in pci-mvebu.c. Both functions
> mvebu_pcie_handle_iobase_change() and mvebu_pcie_handle_membase_change()
> do pass a size which is in fact a mask (size - 1) and not the real size.
> So the mbus is fed with an incorrect size which is off by one :

Yes, that is right. I tested my patch here and didn't see any problem,
but I realize now that the mbus code is bailing early due to this:

kernel: mvebu_mbus: cannot add window '4:e8', conflicts with another window

Which I've never got around to fixing.. (whole other story there)

Your patch looks fine, and it obviously needs to be sequenced before
mine. (Thomas/Jason C: how do you want to do this?)

Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

> From de000611015c7490a07ced6e36bfffbfdd136832 Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Wed, 9 Apr 2014 08:05:09 +0200
> Subject: pci: mvebu: fix off-by-one in the computed size of the mbus windows
> 
> mvebu_pcie_handle_membase_change() and mvebu_pcie_handle_iobase_change()
> compute a window size which is in fact a mask. This size is fed to
> mvebu_mbus_add_window_by_id() which itself subtracts 1 to get the
> mask. So clearly the two functions above are wrong.

Mask isn't the right word, maybe:

mvebu_pcie_handle_membase_change() and
mvebu_pcie_handle_iobase_change() do not correctly compute the window
size. PCI uses an inclusive start/end address pair, which requires a
+1 when converting to size.

This only worked because a bug in the mbus driver allowed it to
silently accept and round up bogus sizes.

Fix this by adding one to the computed size.

Regards,
Jason
