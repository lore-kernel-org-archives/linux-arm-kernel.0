From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 13 Jul 2015 11:58:24 -0700
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <20150713181755.GP2632@arm.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
 <20150713181755.GP2632@arm.com>
Message-ID: <55A40A50.8080902@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 11:17 AM, Will Deacon wrote:
> On Sat, Jul 11, 2015 at 09:25:23PM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Most broadcast TLB invalidations are unnecessary.  So when
>> invalidating for a given mm/vma target the only the needed CPUs via
>> and IPI.
>>
>> For global TLB invalidations, also use IPI.
>>
>> Tested on Cavium ThunderX.
>>
>> This change reduces 'time make -j48' on kernel from 139s to 116s (83%
>> as long).
>
> Any idea *why* you're seeing such an improvement? Some older kernels had
> a bug where we'd try to flush a negative (i.e. huge) range by page, so it
> would be nice to rule that out. I assume these measurements are using
> mainline?

I have an untested multi-part theory:

1) Most of the invalidations in the kernel build will be for a mm that 
was only used on a single CPU (the current CPU), so IPIs are for the 
most part not needed.  We win by not having to synchronize across all 
CPUs waiting for the DSB to complete.  I think most of it occurs at 
process exit.  Q: why do anything at process exit?  The use of ASIDs 
should make TLB invalidations at process death unnecessary.

2) By simplifying the VA range invalidations to just a single ASID based 
invalidation, we are issuing many fewer TLBI broadcasts.  The overhead 
of refilling the local TLB with still needed mappings may be lower than 
the overhead of all those TLBI operations.

>
> Having TLBI responsible for that amount of a kernel build doesn't feel
> right to me and doesn't line-up with the profiles I'm used to seeing.

I don't have enough information to comment on this at the moment.

>
> You have 16-bit ASIDs, right?

Correct.  This means we aren't doing the rollover work very often, and 
that it is therefore not a significant source of system overhead.


>
> Will
>
