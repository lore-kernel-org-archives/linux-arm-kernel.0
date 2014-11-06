From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 6 Nov 2014 15:08:46 +0000
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141106015642.GA2569@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <20141103194634.GA30366@leverpostej>
 <20141106015642.GA2569@darkstar.nay.redhat.com>
Message-ID: <20141106150846.GE23706@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 01:56:42AM +0000, Dave Young wrote:
> On 11/03/14 at 07:46pm, Mark Rutland wrote:
> > On Fri, Oct 31, 2014 at 07:52:09AM +0000, Dave Young wrote:
> > > Hi Geoff
> > > 
> > > I tested your patches. The macihne is using spin-table cpu enable method
> > > so I tried maxcpus=1 as you suggested.
> > > 
> > > There's below issues for me, thoughts?
> > > 
> > > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> > > to use.
> > 
> > Are you absolutely certain of this?
> > 
> > To use ACPI, you must have booted via EFI, as the only mechanism for
> > finding the ACPI tables is via EFI. If booted via EFI, the stub will
> > have created a stub DTB if there is no provided DTB, to pass the command
> > line and pointers to EFI data structures. This stub DTB should be
> > present in the usual place.
> 
> Mark, I used kexec-tools from Geoff's git tree, it will create dtb from procfs
> maybe I can pass external dtb to kexec-tools. What you mentioned should be true
> though but I have not get idea how to get the dtb which kernel is using for boot
> since it is not unflattened.

Ah, sorry. I see the problem now. For ACPI you don't unflatten the tree,
so there's nothing to expose at in sysfs/procfs.

Somehow we need to unflatten the DTB without exposing it to drivers,
such that it can be exposed to userspace in the usual place but drivers
don't being probing based off of it.

Thanks,
Mark.
