From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Feb 2013 15:56:55 +0000
Subject: [PATCH 1/2] arm: mm: Ignore memory banks which are in front of
 the kernel when HIGHMEM is ON
In-Reply-To: <CAHTX3dJXtx5V2SN4Wd7mrnhUzMyK86vT_h_xLOzmQKGo3rcDqQ@mail.gmail.com>
References: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
 <20130213090317.GY17833@n2100.arm.linux.org.uk>
 <CAHTX3dLy=t43+oNXMrsdz1_5AGf6==z=vG7K8V6dSG0tm6U4=g@mail.gmail.com>
 <20130213145208.GC17833@n2100.arm.linux.org.uk>
 <CAHTX3dJXtx5V2SN4Wd7mrnhUzMyK86vT_h_xLOzmQKGo3rcDqQ@mail.gmail.com>
Message-ID: <20130213155654.GD17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 04:52:50PM +0100, Michal Simek wrote:
> This case should probably end up on device-tree rule (+dtc fault).
> Not sure if memory banks should be ordered or not. Rob and Grant any thought?

They _are_ ordered by memblock, because memblock always arranges the
banks in ascending physical address order - and it will merge
contiguous banks together irrespective of what order they appear as.

So you can't do something like bank 0: 0x60000000-0x70000000, bank 1:
0x50000000-0x60000000.  You'll end up with a single memblock entry for
0x50000000-0x70000000.
