From: dyoung@redhat.com (Dave Young)
Date: Tue, 12 May 2015 13:43:04 +0800
Subject: [v2 0/5] arm64: add kdump support
In-Reply-To: <55504956.9020007@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <20150424095312.GD29183@leverpostej> <55504956.9020007@linaro.org>
Message-ID: <20150512054304.GA29874@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 at 03:16pm, AKASHI Takahiro wrote:
> Hi
> 
> Sorry for late response. I was on vacation.
> 
> On 04/24/2015 06:53 PM, Mark Rutland wrote:
> >Hi,
> >
> >On Fri, Apr 24, 2015 at 08:53:03AM +0100, AKASHI Takahiro wrote:
> >>This patch set enables kdump (crash dump kernel) support on arm64 on top of
> >>Geoff's kexec patchset.
> >>
> >>In this version, there are some arm64-specific usage/constraints:
> >>1) "mem=" boot parameter must be specified on crash dump kernel
> >>    if the system starts on uefi.
> >
> >This sounds very painful. Why is this the case, and how do x86 and/or
> >ia64 get around that?
> 
> As Dave (Young) said, x86 uses "memmap=XX" kernel commandline parameters
> to specify usable memory for crash dump kernel.

Originally x86 use memmap=exactmap memmap=XX to specify each section of
memories for 2nd kernel. But later because a lot of reserved type ranges
need to be passed ie. for pci mmconfig, and kernel cmdline buffer is
limited so kexec-tools later switch to passing these in x86 boot params as
E820 memory ranges directly.

> On my arm64 implementation, "linux,usable-memory" property is added
> to device tree blob by kexec-tools for this purpose.
> This is because, when I first implemented kdump on arm64, ppc is the only
> architecture that supports kdump AND utilizes device trees.
> Since kexec-tools as well as the kernel already has this framework,
> I believed that device-tree approach was smarter than a commandline
> parameter.
> 
> However, uefi-based kernel ignores all the memory-related properties
> in a device tree and so this "mem=" workaround was added.

Kdump kernel reuses the memmap info getting from firmware during 1st kernel
boot, I do not think the memmap info can be cooked for crash kernel usable
memory. But it might be a better way to use a special fdt node for crash
kernel memory even for UEFI..

Another way is introducing a similar memmap=, but maybe consider only
system_ram type ranges. For other memory areas still use UEFI memmap.

Thanks
Dave
