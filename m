From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jul 2015 12:40:30 +0100
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <20150714111342.GD13555@e104818-lin.cambridge.arm.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
 <20150713181755.GP2632@arm.com>
 <55A40A50.8080902@caviumnetworks.com>
 <20150714111342.GD13555@e104818-lin.cambridge.arm.com>
Message-ID: <20150714114029.GG16213@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 12:13:42PM +0100, Catalin Marinas wrote:
> BTW, if we do the TLBI deferring to the ASID roll-over event, your
> flush_context() patch to use local TLBI would no longer work. It is
> called from __new_context() when allocating a new ASID, so it needs to
> be broadcast to all the CPUs.

What we can do instead is:

 - Keep track of the CPUs on which an mm has been active
 - Do a local TLBI if only the current CPU is in the list
 - Move to the same ASID allocation algorithm as arch/arm/
 - Change the ASID re-use policy so that we only mark an ASID as free
   if we succeeded in performing a local TLBI, postponing anything else
   until rollover

That should handle the fork() + exec() case nicely, I reckon. I tried
something similar in the past for arch/arm/, but it didn't make a difference
on any of the platforms I have access to (where TLBI traffic was cheap).

It would *really* help if I had some Thunder-X hardware...

> That the munmap case usually. In our tests, we haven't seen large
> ranges, mostly 1-2 4KB pages (especially with kernbench when median file
> size fits in 4KB). Maybe the new batching code for x86 could help ARM as
> well if we implement it. We would still issue TLBIs but it allows us to
> issue a single DSB at the end.

Again, I looked at this in the past but it turns out that the DSB ISHST
needed to publish PTEs tends to sync TLBIs on most cores (even though
it's not an architectural requirement), so postponing the full DSB to
the end didn't help on existing microarchitectures.

Finally, it might be worth dusting off the leaf-only TLBI stuff you
looked at in the past. It doesn't reduce the message traffic, but I can't
see it making things worse.

Will
