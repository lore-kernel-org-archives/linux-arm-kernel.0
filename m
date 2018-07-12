From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2018 12:06:28 +0100
Subject: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
In-Reply-To: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
Message-ID: <20180712110628.GA16043@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 05:18:28PM +0800, Shunyong Yang wrote:
> As PPTT spec doesn't define the physical package id,
> find_acpi_cpu_topology_package() will return offset of the node with
> Physical package field set when querying physical package id. So, it
> returns 162(0xA2) in following example.
> 
> [0A2h 0162   1]                Subtable Type : 00 [Processor Hierarchy
> Node]
> [0A3h 0163   1]                       Length : 1C
> [0A4h 0164   2]                     Reserved : 0000
> [0A6h 0166   4]        Flags (decoded below) : 00000003
>                             Physical package : 1
>                      ACPI Processor ID valid : 1
> [0AAh 0170   4]                       Parent : 00000000
> [0AEh 0174   4]            ACPI Processor ID : 00001000
> [0B2h 0178   4]      Private Resource Number : 00000002
> [0B6h 0182   4]             Private Resource : 0000006C
> [0BAh 0186   4]             Private Resource : 00000084
> 
> So, when "cat physical_package" in /sys/devices/system/cpu/cpu0/topology/,
> it will output 162(0xA2). And if some items are added before the node
> above, the output will change to other value.
> 
> This patch maps the node offset to a logic package id. It maps the first
> node offset to 0, the second to 1, and so on.
> 
> Then, it will not output a big value, such as 162 above. And it will
> not change when some nodes(Physical package not set) are added.
> 
> And as long as the nodes with Physical package field set in PPTT keeps
> the real hardware order, the logic id can map to hardware package id to
> some extent.
> 
> Hope to get feedback from you.

I'm assuming this is no longer needed now that we have queued the series
from Sudeep?

Will
