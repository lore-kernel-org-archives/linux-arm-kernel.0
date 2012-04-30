From: jcm@redhat.com (Jon Masters)
Date: Mon, 30 Apr 2012 14:55:32 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls
In-Reply-To: <20120430100746.GA11080@mudshark.cambridge.arm.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
Message-ID: <4F9EE024.8000906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2012 06:07 AM, Will Deacon wrote:
> Hi Jon,
> 
> On Sun, Apr 29, 2012 at 07:38:24AM +0100, Jon Masters wrote:
>> The audit subsystem builds upon ptrace to record system calls. This is done
>> in a couple of places (on return from fork into a new task, on exit from
>> the SWI vector), using calls to syscall_trace. The latter function abuses
>> the userspace intra-procedure scratch register (regs->ARM_ip, aka r12),
>> and intends to restore it prior to return to userspace. Unfortunately,
>> there are cases where we will return to userspace without restoring.
>>
>> If we are in fact not ptracing but are merely auditing calls, we will
>> happily trash the content of ip but will exit to userspace without
>> restoring the value. It just so happens that GLIBC uses ip as a
>> storage for the TLS thread pointer info, and bad things result.
> 
> Ouch, that's pretty horrible. We should have spotted this when we were
> fixing the build breakage introduced by the audit stuff. Looking more
> closely, does this code work even with your patch? It looks like we use the
> saved ip to infer syscall entry, rather than why. On top of that, I think
> the polarity is back-to-front.

Yea, so like I said (I think?) elsewhere, I've not tested to see that
audit works in anger yet. It was a case of dealing with the register
corruption issue (which has - to use a British phase - taken me around
the houses finding it) first, then wanting to figure out what's left.

But I'll look over your patch and do some poking. Now that we know where
this problem is, I think the priority is for me to test this patch from
you (took the day off, but I'll give it a test tonight) to make sure
nothing blows up, then schedule some time for audit to make sure it's
actually doing anything useful. I'll email you later today. Still
leaning toward recommending nobody actually turn on audit on ARM systems
until we know that it doesn't do anything else that's terrible.

Jon.
