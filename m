From: msalter@redhat.com (Mark Salter)
Date: Fri, 29 Jun 2018 09:05:30 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <d1ed8486-077b-6360-9c98-03aff5051762@arm.com>
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
 <257bbf8d90669921cede5b2e7555b9523311b795.camel@redhat.com>
 <d1ed8486-077b-6360-9c98-03aff5051762@arm.com>
Message-ID: <f09927a6ab2f951bf24c02846e603a987663e5bb.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-28 at 11:06 +0100, James Morse wrote:
> Hi Mark,
> 
> On 26/06/18 21:20, Mark Salter wrote:
> > On Tue, 2018-06-26 at 15:51 +0100, James Morse wrote:
> > > On 25/06/18 16:34, Mark Salter wrote:
> > > > On Fri, 2018-06-22 at 11:19 -0400, Mark Salter wrote:
> > > > > I'm going to hack something to get to the ghes info earlier in boot and
> > > > > check the things you mention above wrt Error Status Block and GHES.0.
> > > > 
> > > > So I had to end up instrumenting the EFI stub to see where the error came
> > > > from. At the start of the stub, there is no GHES.2 error. The error first
> > > > shows up after the stub's call to ExitBootServices returns.
> > > 
> > > What's the notification type of GHES.2? I'm guessing POLLed or some kind of IRQ.
> > > These systems don't have EL3, so the CPU must continue running while something
> > > external generates the CPER records. The records being visible is the last point
> > > the faulty-access could have been made, with the window of time depending on how
> > > fast this external-thing receives and processes the error.
> > 
> > There's a System Control Processor (slimpro) on the SoC which can interact with
> > the CPU in various ways and which has access to memory and other hw.
> 
> Thanks, saves me guessing!
> 
> 
> > > > So it looks
> > > > like the firmware itself is causing the error. There's still a chance that
> > > > the stub is doing something wrong with the memory map passed to the
> > > > firmware, so I'll try to eliminate that as well.
> > > 
> > > adding delay loops will help prove the EFIStub is innocent.
> > 
> > Didn't change anything.
> 

Just closing the loop on this...

> Okay, so just to clarify, a delay before ExitBootServices doesn't cause the
> error to show up before ExitBootServices, so the error hasn't occurred prior to
> this point.

Correct. I have never seen the error before ExitBootServices.

> And a delay after ExitBootServices allows us to see the error before we exit
> into head.S. (this rules out a bug in head.S)
> The delays should be long enough to tell us this slimpro isn't generating the
> error records N seconds after reset.

No delay needed after ExitBootServices. The error would be there right after the
call returns back to stub.


> 
> Given this I agree we should disable_hest based on the DMI platform name and the
> UEFI version number. (it may be earlier firmware didn't have this bug).
> 
> 
> I don't have anything to test this on, so I've picked the DMI strings out the
> demsg output on that bugzilla entry. Any chance you could give it a test?
> 
> 
> > > Are redhat able to rebuild UEFI on these systems? (Can it be fixed?)
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1285107 is about the m400
> > > description of the GIC, comments 15 and 16 show a UEFI patch to something other
> > > than the upstream platforms tree[0], and new firmware being tested.
> > > (although this may be wishful thinking)
> > 
> > HPe would respond to bug reports until m400 reached EOL. They have been pretty
> > clear that no more firmware updates will be done.
> 
> Thanks, it was a bit murky from that ticket...
> 
> 
> Thanks for doing this!
> 
> James
