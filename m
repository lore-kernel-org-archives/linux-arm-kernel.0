From: msalter@redhat.com (Mark Salter)
Date: Tue, 26 Jun 2018 16:20:26 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <950b3034-08a8-38b9-b8f9-514d3e2519fa@arm.com>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
 <0cbc68d5-9a8f-1734-4eea-d1f037927137@infradead.org>
 <cb5aa4ee12422ecc5f6530f3a74bcfa553b42c80.camel@redhat.com>
 <a59fa0f8-4123-bcd9-670a-8885d34f37ed@arm.com>
 <0be5ce017286a4ec494e0f0969bb10126b8501ce.camel@redhat.com>
 <bd5fc825573c3394b80365ad2dc47bde7b22044a.camel@gmail.com>
 <950b3034-08a8-38b9-b8f9-514d3e2519fa@arm.com>
Message-ID: <257bbf8d90669921cede5b2e7555b9523311b795.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-06-26 at 15:51 +0100, James Morse wrote:
> Hi Mark,
> 
> Thanks for shed-ing some light on what is going on here!
> 
> On 25/06/18 16:34, Mark Salter wrote:
> > On Fri, 2018-06-22 at 11:19 -0400, Mark Salter wrote:
> > > I'm going to hack something to get to the ghes info earlier in boot and
> > > check the things you mention above wrt Error Status Block and GHES.0.
> > 
> > So I had to end up instrumenting the EFI stub to see where the error came
> > from. At the start of the stub, there is no GHES.2 error. The error first
> > shows up after the stub's call to ExitBootServices returns.
> 
> What's the notification type of GHES.2? I'm guessing POLLed or some kind of IRQ.

SCI

Here's the HEST entry:

[028h 0040   2]                Subtable Type : 0009 [Generic Hardware Error Source]
[02Ah 0042   2]                    Source Id : 0002
[02Ch 0044   2]            Related Source Id : FFFF
[02Eh 0046   1]                     Reserved : 00
[02Fh 0047   1]                      Enabled : 01
[030h 0048   4]       Records To Preallocate : 00000001
[034h 0052   4]      Max Sections Per Record : 00000001
[038h 0056   4]          Max Raw Data Length : 00000AEC

[03Ch 0060  12]         Error Status Address : [Generic Address Structure]
[03Ch 0060   1]                     Space ID : 00 [SystemMemory]
[03Dh 0061   1]                    Bit Width : 40
[03Eh 0062   1]                   Bit Offset : 00
[03Fh 0063   1]         Encoded Access Width : 04 [QWord Access:64]
[040h 0064   8]                      Address : 0000004FF7E9F0E0

There are 9 others all identical except for Source ID and address.

> These systems don't have EL3, so the CPU must continue running while something
> external generates the CPER records. The records being visible is the last point
> the faulty-access could have been made, with the window of time depending on how
> fast this external-thing receives and processes the error.

There's a System Control Processor (slimpro) on the SoC which can interact with
the CPU in various ways and which has access to memory and other hw.

> 
> 
> > So it looks
> > like the firmware itself is causing the error. There's still a chance that
> > the stub is doing something wrong with the memory map passed to the
> > firmware, so I'll try to eliminate that as well.
> 
> adding delay loops will help prove the EFIStub is innocent.

Didn't change anything.

> 
> Are there any optional drivers being loaded by UEFI? (can you remove any USB
> mass storage drives for instance).

The only storage is pci based. There is a USB port but doesn't look like
anything is attached to it. I don't have physical access to it. It is one on
many moonshot cartridges in a chassis several hundred miles away.

> 
> Are redhat able to rebuild UEFI on these systems? (Can it be fixed?)

No.

> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1285107 is about the m400
> description of the GIC, comments 15 and 16 show a UEFI patch to something other
> than the upstream platforms tree[0], and new firmware being tested.
> (although this may be wishful thinking)

HPe would respond to bug reports until m400 reached EOL. They have been pretty
clear that no more firmware updates will be done.

> 
> It looks like quirking this based on the DMI platform name and UEFI version will
> be what we need. We could discard anything in the error status block areas at
> ghes_probe() time based on this quirk, but we may have missed other problems
> during boot, giving a false sense of security.
> 
> 
> Thanks,
> 
> James
> 
> 
> [0] Might be wrong, but this is where I look:
> https://github.com/tianocore/edk2-platforms.git
