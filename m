From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 7 Jun 2018 14:21:52 +0200
Subject: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
References: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
 <1527768879-88161-2-git-send-email-xiexiuqi@huawei.com>
 <20180606154516.GL6631@arm.com>
 <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
 <20180607105514.GA13139@dhcp22.suse.cz>
 <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
Message-ID: <20180607122152.GP32433@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07-06-18 19:55:53, Hanjun Guo wrote:
> On 2018/6/7 18:55, Michal Hocko wrote:
[...]
> > I am not sure I have the full context but pci_acpi_scan_root calls
> > kzalloc_node(sizeof(*info), GFP_KERNEL, node)
> > and that should fall back to whatever node that is online. Offline node
> > shouldn't keep any pages behind. So there must be something else going
> > on here and the patch is not the right way to handle it. What does
> > faddr2line __alloc_pages_nodemask+0xf0 tells on this kernel?
> 
> The whole context is:
> 
> The system is booted with a NUMA node has no memory attaching to it
> (memory-less NUMA node), also with NR_CPUS less than CPUs presented
> in MADT, so CPUs on this memory-less node are not brought up, and
> this NUMA node will not be online (but SRAT presents this NUMA node);
> 
> Devices attaching to this NUMA node such as PCI host bridge still
> return the valid NUMA node via _PXM, but actually that valid NUMA node
> is not online which lead to this issue.

But we should have other numa nodes on the zonelists so the allocator
should fall back to other node. If the zonelist is not intiailized
properly, though, then this can indeed show up as a problem. Knowing
which exact place has blown up would help get a better picture...

-- 
Michal Hocko
SUSE Labs
