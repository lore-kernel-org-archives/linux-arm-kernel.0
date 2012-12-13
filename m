From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 13 Dec 2012 10:54:42 -0700
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <201212131219.39764.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111056.58970.arnd@arndb.de> <20121212165833.6a35a6ec@skate>
 <201212131219.39764.arnd@arndb.de>
Message-ID: <20121213175442.GC14619@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 12:19:39PM +0000, Arnd Bergmann wrote:
 
> Do those ten ports have a shared I/O space window, or does each one
> have its own 64K? 

The smallest mbus routing window size is 64k, and you need to use a
mbus routing window per PEX to decode into IO.

Thomas: Note this complicates my earlier suggestion of just using
config transactions because this is horribly non-conformant, PCIe
requires a much finer granularity for the root port bridge, it would
need some kind of specialness to make the standard Linux resource
allocator work properly.... :|

> Similarly, how is the config space set up: Does each port have its own
> config space with 256 buses, or is there a fixed (or variable) mapping
> of bus numbers to ports?

Each PEX has it's own configuration cycle generation register, and is
completely independent of other PEX's. They could be seperate domains
in Linux, but lets not do that :)

Marvell did not design a root complex for this chip. The PEX is an end
port core with some additional stuff bodged on to handle root port TLP
processing requirements, but none of the other root port and root
complex requirements are met.

Ideally SW could bodge it into a sort of compliant root complex, but
that is looking like some level of core PCI changes would be needed..

By far the easiest thing is to keep them as separate PCI busses and
require DT to manage each one individually, address ranges and
all. :(

Jason
