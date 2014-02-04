From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 4 Feb 2014 19:48:54 +0100
Subject: [PATCH resend 1/2] arm64: defer reloading a task's FPSIMD state
 to userland resume
In-Reply-To: <20140204172737.GD664@mudshark.cambridge.arm.com>
References: <1391163196-27619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140203163609.GK14112@mudshark.cambridge.arm.com>
 <CAKv+Gu_cWueDaYsgBOUUQAT3ubyrKZtHc5DogvSS-=TpOrX+aQ@mail.gmail.com>
 <20140204172737.GD664@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu_2TPT6SKPAW_nPi7RmLLD_D=HG2EhDX_yXgTLXrBRzxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2014 18:27, Will Deacon <will.deacon@arm.com> wrote:
> Hello,
>
> On Tue, Feb 04, 2014 at 02:49:14PM +0000, Ard Biesheuvel wrote:
>> On 3 February 2014 17:36, Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Jan 31, 2014 at 10:13:15AM +0000, Ard Biesheuvel wrote:
>> >> If a task gets scheduled out and back in again and nothing has touched
>> >> its FPSIMD state in the mean time, there is really no reason to reload
>> >> it from memory. Similarly, repeated calls to kernel_neon_begin() and
>> >> kernel_neon_end() will preserve and restore the FPSIMD state every time.
>> >>
>> >> This patch defers the FPSIMD state restore to the last possible moment,
>> >> i.e., right before the task re-enters userland. If a task does not enter
>> >> userland at all (for any reason), the existing FPSIMD state is preserved
>> >> and may be reused by the owning task if it gets scheduled in again on the
>> >> same CPU.
>> >
>> > The one situation I'm unsure of here is how you deal with the saved fpsimd
>> > state potentially being updated by a signal handler or a debugger. In this
>> > case, we probably need to set _TIF_FOREIGN_FPSTATE to force a reload, or are
>> > you handling this some other way?
>> >
>>
>> If I am reading the code correctly, the signal handler is entered
>> using the normal userland resume path, so I don't think it requires
>> special treatment.
>
> It was the exiting of the signal handler that I was worried about, where it
> may have modified the interrupted programs fpsimd state on the stack.
>

Ah, ok, I see what you mean.

I will update the patch so
(a) it only saves the state if _TIF_FOREIGN_FPSTATE is cleared (so we
don't overwrite the task's saved state inadvertently), and
(b) it sets _TIF_FOREIGN_FPSTATE instead of performing the restore
upon return from the signal handler.

>> For the ptrace() case, it should suffice to set the 'last_cpu' field
>> to (u32)-1 to indicate that the FPSIMD context should be reloaded from
>> memory regardless of which CPU the debuggee is restarted on.
>
> Something like that sounds right, but it needs adding/testing.
>

OK, I will add the above and do some more testing.

Cheers,
Ard.
