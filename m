From: msalter@redhat.com (Mark Salter)
Date: Fri, 22 Jun 2018 11:19:24 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <a59fa0f8-4123-bcd9-670a-8885d34f37ed@arm.com>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
 <0cbc68d5-9a8f-1734-4eea-d1f037927137@infradead.org>
 <cb5aa4ee12422ecc5f6530f3a74bcfa553b42c80.camel@redhat.com>
 <a59fa0f8-4123-bcd9-670a-8885d34f37ed@arm.com>
Message-ID: <0be5ce017286a4ec494e0f0969bb10126b8501ce.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-06-19 at 11:21 +0100, James Morse wrote:
> Hi Mark,
> 
> On 18/06/18 23:18, Mark Salter wrote:
> > On Mon, 2018-06-18 at 11:04 -0700, Geoff Levand wrote:
> > > Thanks for all the comments, but my lack of access to an m400 platform, and
> > > my lack of knowledge about the m400 limits what I can comment on and what I
> > > can do.  
> > 
> > I can take another look at this on an m400 here.
> 
> Thanks!
> 
> 
> > I don't believe it is a
> > memory access to physical space with nothing attached to it.
> 
> That is what the CPER records are describing though.

Yes.

> 
> 
> > I seem to recall
> > an errata with xgene-1 where such accesses cause the cpu to halt. But I could
> > be misremembering that. I have no trouble believing the firmware ras code was
> > untested. It is probably some boilerplate code built in before ras was supported
> > in kernel.
> 
> It would be interesting to know which GHES this error is being found in, and
> whether the Error Status Block points anywhere (or at an empty block) when Linux
> is started from UEFI.
> 
> If there is something in the Error Status Block out of UEFI, then this must be
> something triggered by UEFI, or a bug that can be fixed by UEFI clearing out the
> CPER records.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1285107
> suggests redhat can rebuild the UEFI firmware for this box.
> 
> 
> If there is nothing in the Error Status Block when Linux is started, surely
> Linux is doing something to cause this to happen. I'd like to find out what, as
> its probably a software bug.
> 
> 
> (The case where disabling HEST would be the right thing to do is if there is a
> bogus GHES->GAS entry in GHES.0, the access to which causes GHES.1 to be
> populated with 'Access to an address not mapped to any component', which we find
> next. If this is the case it would be better to check GHES entries against the
> UEFI memory map to check this is memory, and it was reserved.)
> 
> 
> > But the problem occurs early enough in boot where there can't be
> > that many things that would cause a problem on m400 and not mustang so I'll
> > look again.
> 
> Playing spot the difference in the dmesg, I'd check for smoke coming out of:
> > acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> > xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
> > pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22

I've eliminated these by building a kernel with minimalized config and hacks (ACPI
requires PCI, so I added code to prevent the root complexe from being probed). I
also eliminated all the xgene-specific devices from the config (network, sata,
etc). Still hit the ghes panic.

I'm going to hack something to get to the ghes info earlier in boot and
check the things you mention above wrt Error Status Block and GHES.0.


> 
> If the firmware description of the GIC is wrong in someway, disabling KVM may be
> worth testing too.
> 
> 
> Thanks,
> 
> James
