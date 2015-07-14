From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jul 2015 14:09:22 +0100
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <20150714114029.GG16213@arm.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
 <20150713181755.GP2632@arm.com>
 <55A40A50.8080902@caviumnetworks.com>
 <20150714111342.GD13555@e104818-lin.cambridge.arm.com>
 <20150714114029.GG16213@arm.com>
Message-ID: <20150714130922.GE13555@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 12:40:30PM +0100, Will Deacon wrote:
> On Tue, Jul 14, 2015 at 12:13:42PM +0100, Catalin Marinas wrote:
> > BTW, if we do the TLBI deferring to the ASID roll-over event, your
> > flush_context() patch to use local TLBI would no longer work. It is
> > called from __new_context() when allocating a new ASID, so it needs to
> > be broadcast to all the CPUs.
> 
> What we can do instead is:
> 
>  - Keep track of the CPUs on which an mm has been active

We already do this in switch_mm().

>  - Do a local TLBI if only the current CPU is in the list

This would be beneficial independent of the following two items. I think
it's worth doing.

>  - Move to the same ASID allocation algorithm as arch/arm/

This is useful to avoid the IPI on roll-over. With 16-bit ASIDs, I don't
think this is too urgent but, well, the benchmarks may say otherwise.

>  - Change the ASID re-use policy so that we only mark an ASID as free
>    if we succeeded in performing a local TLBI, postponing anything else
>    until rollover
> 
> That should handle the fork() + exec() case nicely, I reckon. I tried
> something similar in the past for arch/arm/, but it didn't make a difference
> on any of the platforms I have access to (where TLBI traffic was cheap).
> 
> It would *really* help if I had some Thunder-X hardware...

I agree. With only 8 CPUs, we don't notice any difference with the above
optimisations.

> > That the munmap case usually. In our tests, we haven't seen large
> > ranges, mostly 1-2 4KB pages (especially with kernbench when median file
> > size fits in 4KB). Maybe the new batching code for x86 could help ARM as
> > well if we implement it. We would still issue TLBIs but it allows us to
> > issue a single DSB at the end.
> 
> Again, I looked at this in the past but it turns out that the DSB ISHST
> needed to publish PTEs tends to sync TLBIs on most cores (even though
> it's not an architectural requirement), so postponing the full DSB to
> the end didn't help on existing microarchitectures.

We could postpone all the TLBI, including the first DSB ISHST. But I
need to look in detail at the recent TLBI batching patches for x86, they
do it to reduce IPIs but we could similarly use them to reduce the total
sync time after broadcast (i.e. DSB for pte, lots of TLBIs, DSB for TLBI
sync).

> Finally, it might be worth dusting off the leaf-only TLBI stuff you
> looked at in the past. It doesn't reduce the message traffic, but I can't
> see it making things worse.

I didn't see a difference but I'll post them to the list.

-- 
Catalin
