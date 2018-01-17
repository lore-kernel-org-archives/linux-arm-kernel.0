From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Jan 2018 20:32:50 +0000
Subject: per-task stack canaries for arm64
In-Reply-To: <CAGXu5j+cJoc6o8d-hmLFj08r18GhEbKhVNA94LDKM5yqo9CbSQ@mail.gmail.com>
References: <CAKv+Gu_rdDEQeBYabZCOywws96mTWF4F=JEpVNXEW76tAwo1Rw@mail.gmail.com>
 <CAGXu5j+cJoc6o8d-hmLFj08r18GhEbKhVNA94LDKM5yqo9CbSQ@mail.gmail.com>
Message-ID: <CAKv+Gu9vViZUBYJWnGdnewL9h-ahP0Hs8gU+3_QH76ROdQh1yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2018 at 19:10, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jan 17, 2018 at 10:24 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Hi all,
>>
>> This is a followup to a discussion I had with Ramana in San Francisco
>> 5 months ago. Apologies for the tardiness.
>
> Link to prior discussion, just for anyone following along:
> https://lkml.org/lkml/2017/6/27/227
>

Ah yes, I remember now.

We implemented virtually mapped stacks without rearranging the system
registers, and so we still use tpidr_el1 for per-cpu offsets. It does
seem wise to allow for some flexibility in which register to use as
the per-CPU offset, but it doesn't seem likely to me that we'd switch
to a GPR to keep the CPU offset


>> The topic of the discussion was compiler support for per-task stack
>> cookies in the arm64 kernel. From the compiler side, this would simply
>> entail offsetting the address of __stack_chk_guard with value held in
>> tpidr_el1, so we can make it a per-CPU variable.
>
> AIUI, some progress was made on this recently, and is somewhat discussed here:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81490
> and spawned this:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
> which was done for x86 only, and provides both:
>   -mstack-protector-guard-symbol=...
>   -mstack-protector-guard-reg=...
>
> If this could be extended to arm64, I think we'd be in good shape (and
> it could be trivially detected at build time).
>

I'm not entirely sure what the point is of specifying the name of the
symbol on the command line. It is ultimately up to the GCC developers
to decide how much point there is to maintaining parity with x86 here.

>> On the kernel side,
>> we would need fairly straight-forward plumbing to detect the compiler
>> support, and switching to a per-CPU variable when supported. Beyond
>> that, we need to update the per-CPU value at context switch time, and
>> perhaps some handling of the initial state when per-CPU variables are
>> initialized.
>
> Right. My mental list has been:
>
> We'll need to adjust how __stack_chk_guard is defined (and tweak
> boot_init_stack_canary()).
>
> x86 makes the canary updates in arch/x86/entry/entry_*.S as part of
> __switch_to's __switch_to_asm. Looks like arm64 would do it in
> arch/arm64/kernel/entry.S cpu_switch_to?
>

Yes. SP and the value of the per-cpu var should be updated at the same
time, so that is the only place that makes sense.

> x86 does percpu init in arch/x86/kernel/setup_percpu.c. I'm not sure
> where this needs to happen in arm64.
>

I'm not sure if there's more to it than ensuring that the value in the
percpu template section matches the value for the boot CPU, which
should be the case already unless we update it with a random value at
early boot.

>> Ramana indicated at the time that he would be up for adding, e.g.,
>> -fstack-protector-linux-kernel as a command line option, and add the
>> contents of tpidr_el1 to every reference of __stack_chk_guard when
>> set.
>
> I think we want to reuse the command-line names from the x86 options
> above, unless there's a good reason not to?
>

I'm perfectly happy to settle for whatever the GCC developers manage
to agree on, as long as it gives us the ability to use tpidr_el1 as
the offset.

>> Would this be sufficient to implement this from the kernel side? Am I
>> missing anything here? I am missing the cross-arch context entirely,
>> so are there things we should take into account and/or learn from?
>>
>> Comments welcome.
>
> I think it's very close, yes. Thanks for poking at this!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
