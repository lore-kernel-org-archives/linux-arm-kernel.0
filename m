From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Mar 2017 17:14:22 +0100
Subject: [PATCHv2,6/7] mm: convert generic code to 5-level paging
In-Reply-To: <20170309142408.2868-7-kirill.shutemov@linux.intel.com>
References: <20170309142408.2868-7-kirill.shutemov@linux.intel.com>
Message-ID: <2565467.lozgIVsiVn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[added arm64 maintainers and arm list to recipients]

Hi,

Am Donnerstag, 9. M?rz 2017, 17:24:07 CET schrieb Kirill A. Shutemov:
> Convert all non-architecture-specific code to 5-level paging.
> 
> It's mostly mechanical adding handling one more page table level in
> places where we deal with pud_t.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

This breaks (at least) arm64 Rockchip platforms it seems.

4.11-rc1 worked just fine, while 4.11-rc2 kills the systems and I've bisected 
it down to this one commit.

As can be seen in the log [0] of the boot, the errors happen really late and 
systemd has nearly reached the login prompt when the systems die with some 
random paging fault (unhandled paging request, unhandled page fault, sometimes 
they just die without any error).

The error itself is pretty random and changes the all the time, but the 
position during boot is always in that area on every machine.

If I revert this one commit, everything works nicely again.


Affected platforms I have:
- rk3368 (8 * Cortex-A53, with a vendor uboot fork from 2014)
- rk3399 (2 * A72 + 4 * A53, recent coreboot from ChromeOS)
ARM64 kernel with ARM64 Debian userland
Config comes from the arm64 "defconfig"

Not affected platforms I have:
- all arm32 Rockchip platforms I have seem to work fine with this patch
  (rk3036, rk3288)
Config comes from "multi_v7_defconfig"


Heiko

[0] https://bpaste.net/show/13f9faf90e13
and attached to this mail
-------------- next part --------------
A non-text attachment was scrubbed...
Name: r88-fail.log
Type: text/x-log
Size: 31152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/ec43681c/attachment-0001.bin>
