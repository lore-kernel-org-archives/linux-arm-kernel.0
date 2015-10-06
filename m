From: keescook@chromium.org (Kees Cook)
Date: Tue, 6 Oct 2015 10:42:43 -0700
Subject: [PATCH] selftests/seccomp: build on aarch64, document ABI
In-Reply-To: <55F15CF5.3000409@linaro.org>
References: <20150909193025.GA29244@www.outflux.net>
 <55F15CF5.3000409@linaro.org>
Message-ID: <CAGXu5jJ+jgVq=Za1VT+Ydt3a_shkewyudx8qCTw0JNu8vZytgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 3:35 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On 09/10/2015 04:30 AM, Kees Cook wrote:
>>
>> The syscall ABI is inconsistent on aarch64 compat, so at least we should
>> document it in the seccomp_bpf tests.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Can someone with access to native aarch64 double-check this for me? I
>> think we need to change these tests to pass if it's expected, but the
>> compat behavior seems bad. It means compat code will break under an
>> aarch64 kernel, when dealing with syscalls, like through seccomp.
>> ---
>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c
>> b/tools/testing/selftests/seccomp/seccomp_bpf.c
>> index 770f47adf295..866ff42e000d 100644
>> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
>> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
>> @@ -33,6 +33,10 @@
>>   #include <unistd.h>
>>   #include <sys/syscall.h>
>>
>> +#if defined(__aarch64__) && !defined(__NR_poll)
>> +# define __NR_poll 0x49
>> +#endif
>> +
>>   #include "test_harness.h"
>>
>>   #ifndef PR_SET_PTRACER
>> @@ -2124,10 +2128,17 @@ TEST(syscall_restart)
>>         ASSERT_EQ(SIGTRAP, WSTOPSIG(status));
>>         ASSERT_EQ(PTRACE_EVENT_SECCOMP, (status >> 16));
>>         ASSERT_EQ(0, ptrace(PTRACE_GETEVENTMSG, child_pid, NULL, &msg));
>> -       ASSERT_EQ(0x200, msg);
>> +
>> +       /*
>> +        * FIXME:
>> +        * - native ARM does not expose true syscall.
>> +        * - compat ARM on ARM64 does expose true syscall.
>> +        * - native ARM64 hides true syscall even from seccomp.
>
>
> Are you sure about the last line?
> The kernel pushes __NR_compat_restart_syscall to w7 in compat mode, while
> __NR_restart_syscall to x8 in native mode. But it is the only difference,
> as far as I understand, in terms of restarting a system call.
> So the behavior should be basically the same.

I've spent a little more time looking at this, and no, that last
statement is wrong. My current testing shows that seccomp always sees
the "true" syscall, which is what we want (matches all other
architectures).

However, the other two statements continue to appear true: there is a
register visibility difference. During the restart_syscall syscall,
this routine behaves different on native arm and compat arm:

int get_syscall(pid_t tracee)
{
        struct iovec iov;
        struct pt_regs regs;

        iov.iov_base = &regs;
        iov.iov_len = sizeof(regs);
        assert(0 == ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov));

        return regs.ARM_r7;
}

On native ARM, this returns the restarted syscall (in my test case,
nanosleep). On compat ARM, this returns restart_syscall syscall.

Either we should fix native ARM to do what all other architectures do
(show restart_syscall syscall) or we should fix compat ARM to behave
like native ARM.

-Kees

-- 
Kees Cook
Chrome OS Security
