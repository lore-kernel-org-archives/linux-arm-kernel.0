From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 01:33:07 +0200
Subject: [GIT PULL] Integrator/AP PCI DT support
In-Reply-To: <CACRpkdZaTDEu8vUx347k1Y5Pht5Pi_mPJXpDsVtAsSYVT60n_Q@mail.gmail.com>
References: <CACRpkdb8J4+QH36SYavgGWbFWaBZDg5JSYyyJELzL=mSZfMnBw@mail.gmail.com>
 <20130615000922.GG18124@quad.lixom.net>
 <CACRpkdZaTDEu8vUx347k1Y5Pht5Pi_mPJXpDsVtAsSYVT60n_Q@mail.gmail.com>
Message-ID: <201306200133.07315.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 June 2013, Linus Walleij wrote:
> The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:
> 
>   of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-pci-for-arm-soc
> 
> for you to fetch changes up to f55b2b56cd37fa8bcfcb75248c27094eaf09e04c:
> 
>   ARM: integrator: basic PCIv3 device tree support (2013-06-15 22:18:39 +0200)
> 

Pulled into next/soc. Sorry for the delay doing the handover, I just started
with this, and have a huge backlog.

Please send a follow-on patch to fix the spaces window in the ranges
property:

+               ranges = <0x00000000 0 0x61000000 /* config space */
+                       0x61000000 0 0x00100000 /* 16 MiB @ 61000000 */
+                       0x01000000 0 0x60000000 /* I/O space */
+                       0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
+                       0x02000000 0 0x40000000 /* non-prefectable memory */
+                       0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
+                       0x42000000 0 0x50000000 /* prefetchable memory */
+                       0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */

This would not work, you need 0 as the local side address for I/O space
(unlike memory space) instead of 0x60000000. Your code ignores the
I/O space at the moment, but the ranges should be set up to let us
handle it in the future.

For the memory space, you seem to ignore the bus address in the ranges
at the moment. Please fix that too, either by programming 0x40000000/
0x50000000 into V3_LB_MAP0/V3_LB_MAP1, or by changing the ranges
to have 0x00000000/0x10000000 as the local part for non-prefetch/prefetch
memory. Either way is possible, but please make the DT consistent with
the code, ideally by using the information from DT to set up the
windows.

Also, why not just map the I/O space by calling pci_ioremap_io?

	Arnd
