From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 29 Sep 2014 10:49:51 -0700
Subject: [PATCH] arm64: ptrace: hw_break_set take into account hardware
 breakpoints number
In-Reply-To: <20140929101626.GE20303@arm.com>
References: <1411977842-16515-1-git-send-email-victor.kamensky@linaro.org>
 <1411977842-16515-2-git-send-email-victor.kamensky@linaro.org>
 <20140929101626.GE20303@arm.com>
Message-ID: <CAA3XUr3B0XKrVaXgTR2G43B67YNV3q1wKsuXvMFsBaME4oXUYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 29 September 2014 03:16, Will Deacon <will.deacon@arm.com> wrote:
> Hi Victor,
>
> On Mon, Sep 29, 2014 at 09:04:02AM +0100, Victor Kamensky wrote:
>> hw_break_set function that performs ptrace_regset for hardware
>> breakpoints and watchpoints needs to take into account actual
>> number of hardware breakpoints and watchpoints available in CPU.
>>
>> Current code iterates over all 16 entries of 'struct user_hwdebug_state'
>> and tries to reserve hardware breakpoint for each index, which fails
>> if CPU supports less than 16 hardware breakpoints. One manifestation of
>> the issue is that gdb fails to debug multithreaded user land application
>> and exits with 'Unexpected error setting hardware debug registers'
>> error - ptrace system call for hardware breakpoints regset fails with
>> ENOSPC.
>
> When does this happen? hw_break_set is driven by userspace, so if GDB is
> asking for more registers than we actually have, then this is a GDB bug and
> the kernel is doing the right thing.
>
> Have you reproduced this with the latest version of GDB?

Thank you for the reply. Just checked latest version of GDB, indeed it
does not have my original issue. It turns out my gdb is based on some
old linaro gdb version that unconditionally passes sizeof(user_hwdebug_state)
as iov.len to PTRACE_SETREGSET with note type NT_ARM_HW_BREAK.
Latest gdb adjusts iov.len based on available number of hardware breakpoints.
I should have checked latest gdb before posting this. Naturally previously
suggested patch is withdrawn.

Question is there any place where variable payload nature of
PTRACE_SETREGSET with note type NT_ARM_HW_BREAK and
NT_ARM_HW_WATCH documented? I've tried kernel Documentation
directory, aarch64 abi document, http://infocenter.arm.com search, none
of them mention NT_ARM_HW_BREAK. Just curious is there any place
for that sort of information to look in the future. If answer that it is
documented by existing kernel/gdb code :), please feel free to ignore
this question.

Thanks,
Victor

> Will
