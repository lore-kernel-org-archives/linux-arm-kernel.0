From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 5 Jan 2010 06:26:54 +0800
Subject: [PATCH 06/11] arm-dt: postpone machine detection until setup_arch
	with CONFIG_ARM_DEVTREE
In-Reply-To: <4B421903.4050200@simtec.co.uk>
References: <1261479296.247430.731563214048.6.gpush@pororo>
	<4B421903.4050200@simtec.co.uk>
Message-ID: <201001050926.54286.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> > When we're using CONFIG_ARM_DEVTREE, we need to postpone machine
> > detection until later in setup_arch. Because ARM_DEVTREE depends on
> > !DEBUG_LL, we don't need the mdesc this early anyway.
> >
> > We'll add support for ARM_DEVTREE && DEBUG_LL later.
> 
> Why not add a specific machine type for 'this is device tree' and
> then these routines don't even need to #ifdef. It would especially
> be good as it allows dt and non-dt machines to coexist in the same
> kernel together.

Mainly because this doesn't gain us much; the machine_desc that is discovered 
from this new machine type would not have the correct data (phys_io & 
io_pg_offset) required for early setup (used for DEBUG_LL).

We could conditionally skip the detection if we see a DT machine type, but 
then we'd need to add similar checks for all the paths where the machine_desc 
is used.

However, my goal is indeed to allow DT and non-DT machines to coexist as much 
as possible, this patch is more a temporary workaround while I figure out how 
to handle the DEBUG_LL stuff nicely for DT cases.

Cheers,


Jeremy
