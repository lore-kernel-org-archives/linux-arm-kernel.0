From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 14 Jul 2013 16:09:20 +0200
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130714T152342-120@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey>
 <loom.20130714T130546-799@post.gmane.org>
 <CAKv+Gu-fUNSZaNMgZekoCX2kOGEFDLKY1yFtKq1=yp9xQN3rOA@mail.gmail.com>
 <loom.20130714T152342-120@post.gmane.org>
Message-ID: <CAKv+Gu8JcQUH6d1mWh+sGcMXU6rPW7yk8P16PgqnF1Zdfn3OkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2013 15:33, Harm Hanemaaijer <fgenfb@yahoo.com> wrote:
> Ard Biesheuvel <ard.biesheuvel <at> linaro.org> writes:
>
>>
>> You will clobber the userland NEON contents of the register file if
>> you don't preserve them properly. Also, kernel preemption (if enabled)
>> may put your task to sleep at any time, and the context switching
>> machinery is totally oblivious of NEON being used in the kernel, so
>> the kernel side will get corrupted as well in this case.
>>
>> I have a patch series pending (i.e., accepted but not pulled yet by
>> Russell) which addresses these issues.
>>
>
> That was what I was afraid of concerning NEON. It must be tricky to solve
> without sacrificing performance, since saving/restoring the entire NEON
> register file would obviously seriously impact context switch performance.
> For memcpy-like applications, basically only four dword registers are
> required (d0-d3) which could possibly be optimized for.
>

Well, the whole lazy preserve/restore mechanism is based on the
premise that preserve/restore is only required when multiple users are
contending for the NEON (or in the SMP case, when a task gets migrated
to another CPU). As we will not be allowing NEON in interrupt context
nor in a preemptible section, the burden of the more costly context
switches should not grow disproportionately, even if tasks may be
contending for the NEON with themselves in a way (userland vs kernel).
However, it also means that a NEON based memcpy() is going to be
problematic, not only for the reasons pointed out by Russell, also
because you will need a fallback to use from interrupt context.

Perhaps for sufficiently large sizes, it makes sense to take the hit
of testing whether NEON is allowable at that particular moment, and
doing the preserve in that case. In the end, the numbers should speak
for themselves: if you manage a considerable speedup in a real-world
case, and no deterioration in others, people are usually quite
receptive.

-- 
Ard.
