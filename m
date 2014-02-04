From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 4 Feb 2014 15:49:14 +0100
Subject: [PATCH resend 1/2] arm64: defer reloading a task's FPSIMD state
 to userland resume
In-Reply-To: <20140203163609.GK14112@mudshark.cambridge.arm.com>
References: <1391163196-27619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140203163609.GK14112@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu_cWueDaYsgBOUUQAT3ubyrKZtHc5DogvSS-=TpOrX+aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2014 17:36, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Fri, Jan 31, 2014 at 10:13:15AM +0000, Ard Biesheuvel wrote:
>> If a task gets scheduled out and back in again and nothing has touched
>> its FPSIMD state in the mean time, there is really no reason to reload
>> it from memory. Similarly, repeated calls to kernel_neon_begin() and
>> kernel_neon_end() will preserve and restore the FPSIMD state every time.
>>
>> This patch defers the FPSIMD state restore to the last possible moment,
>> i.e., right before the task re-enters userland. If a task does not enter
>> userland at all (for any reason), the existing FPSIMD state is preserved
>> and may be reused by the owning task if it gets scheduled in again on the
>> same CPU.
>
> The one situation I'm unsure of here is how you deal with the saved fpsimd
> state potentially being updated by a signal handler or a debugger. In this
> case, we probably need to set _TIF_FOREIGN_FPSTATE to force a reload, or are
> you handling this some other way?
>

If I am reading the code correctly, the signal handler is entered
using the normal userland resume path, so I don't think it requires
special treatment.

For the ptrace() case, it should suffice to set the 'last_cpu' field
to (u32)-1 to indicate that the FPSIMD context should be reloaded from
memory regardless of which CPU the debuggee is restarted on.

Regards,
Ard.
