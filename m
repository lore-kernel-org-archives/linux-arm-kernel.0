From: james.morse@arm.com (James Morse)
Date: Tue, 26 Jun 2018 15:51:32 +0100
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <bd5fc825573c3394b80365ad2dc47bde7b22044a.camel@gmail.com>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
 <0cbc68d5-9a8f-1734-4eea-d1f037927137@infradead.org>
 <cb5aa4ee12422ecc5f6530f3a74bcfa553b42c80.camel@redhat.com>
 <a59fa0f8-4123-bcd9-670a-8885d34f37ed@arm.com>
 <0be5ce017286a4ec494e0f0969bb10126b8501ce.camel@redhat.com>
 <bd5fc825573c3394b80365ad2dc47bde7b22044a.camel@gmail.com>
Message-ID: <950b3034-08a8-38b9-b8f9-514d3e2519fa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for shed-ing some light on what is going on here!

On 25/06/18 16:34, Mark Salter wrote:
> On Fri, 2018-06-22 at 11:19 -0400, Mark Salter wrote:
>> I'm going to hack something to get to the ghes info earlier in boot and
>> check the things you mention above wrt Error Status Block and GHES.0.
> 
> So I had to end up instrumenting the EFI stub to see where the error came
> from. At the start of the stub, there is no GHES.2 error. The error first
> shows up after the stub's call to ExitBootServices returns.

What's the notification type of GHES.2? I'm guessing POLLed or some kind of IRQ.

These systems don't have EL3, so the CPU must continue running while something
external generates the CPER records. The records being visible is the last point
the faulty-access could have been made, with the window of time depending on how
fast this external-thing receives and processes the error.


> So it looks
> like the firmware itself is causing the error. There's still a chance that
> the stub is doing something wrong with the memory map passed to the
> firmware, so I'll try to eliminate that as well.

adding delay loops will help prove the EFIStub is innocent.

Are there any optional drivers being loaded by UEFI? (can you remove any USB
mass storage drives for instance).

Are redhat able to rebuild UEFI on these systems? (Can it be fixed?)

https://bugzilla.redhat.com/show_bug.cgi?id=1285107 is about the m400
description of the GIC, comments 15 and 16 show a UEFI patch to something other
than the upstream platforms tree[0], and new firmware being tested.
(although this may be wishful thinking)

It looks like quirking this based on the DMI platform name and UEFI version will
be what we need. We could discard anything in the error status block areas at
ghes_probe() time based on this quirk, but we may have missed other problems
during boot, giving a false sense of security.


Thanks,

James


[0] Might be wrong, but this is where I look:
https://github.com/tianocore/edk2-platforms.git
