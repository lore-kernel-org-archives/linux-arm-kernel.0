From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sun, 04 Oct 2009 21:25:16 +0200
Subject: [PATCH] FCSE: pid life cycle.
In-Reply-To: <20091004190223.GH1378@ucw.cz>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<20091004190223.GH1378@ucw.cz>
Message-ID: <4AC8F69C.8030205@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> On Thu 2009-10-01 23:34:11, Gilles Chanteperdrix wrote:
>> Add a pid member to the mm_context_t structure, allocate this pid in
>> the init_new_context, free it in the destroy_context, switch it in
>> switch_mm.
>>
>> A bitfield is maintained to know what pids are currently in use.
>>
>> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
>> Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> ...
>> --- /dev/null
>> +++ b/arch/arm/include/asm/fcse.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * Filename:    arch/arm/include/asm/fcse.h
>> + * Description: ARM Process ID (PID) includes for Fast Address Space Switching
>> + *              (FASS) in ARM Linux.
>> + * Created:     14/10/2001
>> + * Changes:     19/02/2002 - Macros added.
>> + *              03/08/2007 - Adapted to kernel 2.6.21 (ssm)
>> + *              Feb 2008   - Simplified a bit (rco)
> 
> We normally avoid changelogs in sources.

Ok. Will remove that, it was inherited.

> 
>> +/* Sets the CPU's PID Register */
>> +static inline void fcse_pid_set(unsigned long pid)
>> +{
>> +	__asm__ __volatile__ ("mcr p15, 0, %0, c13, c0, 0"
>> +			      : /* */: "r" (pid) : "memory");
>> +}
> 
> Calling this 'pid' is extremely confusing. PID already means process
> id...

Guess what, it also means "process id" in the FCSE case, and it is the
name it has in the documentation, I always find a good idea to name the
hardware registers as per documentation. I guess the original intent was
to put the real process id into the hardware register, but that is not
really possible with Linux. So, I guess we can call it fcse_pid.

In any case, I will keep all modifications for a second post once I had
sufficient review (namely, I am expecting Russell's review, since he is
the one who will accept or reject the patch in the end).

-- 
					    Gilles.
