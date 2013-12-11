From: liucy214@gmail.com (Aaron Liu)
Date: Wed, 11 Dec 2013 15:16:11 +0800
Subject: [PATCH] arm64 ptrace.c
In-Reply-To: <20131210111445.GF2338@mudshark.cambridge.arm.com>
References: <CAAXgzBO1TF=_EdkUieuyf1fbUYx9FVWExqGSi3CcUip7eboMAw@mail.gmail.com>
 <20131210111445.GF2338@mudshark.cambridge.arm.com>
Message-ID: <CAAXgzBMC20L9TqjAV_Q=XZpsgczk5isBou2wqs6vfXun6P1Bfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

gdb calls ptrace twice to set watch points and break points as
following. After first ptrace call is completed, second ptrace call
fails with no space error. The first ptrace will reserve 16 watch
points in static LIST_HEAD(bp_task_head)@kernel/events/hw_breakpoint.c
and each entry, ie. struct perf_event, has a member called
attr.bp_type. The bp_type in the entry should be used as indicator for
watch points or break points. You could see
__reserve_bp_slot at kernel/events/hw_breakpoint.c and find it does a
basic check bp_type should be not HW_BREAKPOINT_EMPTY and
HW_BREAKPOINT_INVALID. After the __reserve_bp_slot call, the reserved
slot's bp_type is HW_BREAKPOINT_RW or HW_BREAKPOINT_X. However,
ptrace_hbp_fill_attr_ctrl at arch/arm64/kernel/ptrace.c set the bp_type
to HW_BREAKPOINT_EMPTY if it's disabled. This causes the
find_slot_idx at kernel/event/hw_breakpoint.c to judge the existing
entries as TYPE_INST. So, after first 16 watch points are reserved in
list, the following break points determine no space to reserve, ie.
max 16 break points. The patch only set disable bit even user zeroing
control bits and it could still pass
modify_user_hw_breakpoint at kernel/events/hw_breakpoint.c.

I post the test program that causes gdb error.
It just creates a threads and runs forever.

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

static void* thread_body(void* usr) {
  int c = 0;
  printf("thread running...\n");
  while(1) {
    sleep(1);
    printf("thread count: %d\n", ++c);
  }
  return 0;
}

int main(int argc, const char** argv) {
  pthread_t t;
  void* tr = 0;
  int r = 0;
  r = pthread_create(&t, 0, thread_body, 0);
  if (r) {
    printf("pthread_create failed\n");
    return -1;
  }
  pthread_join(t, &tr);
  return 0;
}

Here is the strace log that gdb debug the program. I discards the
others because the log is too much. If you need full log, please tell
me.

ptrace(PTRACE_GETEVENTMSG, 559, 0, 0x7fe563aba8) = 0
ptrace(PTRACE_SETREGSET, 562, 0x403 /* NT_??? */, [{0x7fe563a970, 264}]) = 0
ptrace(PTRACE_SETREGSET, 562, 0x402 /* NT_??? */, [{0x7fe563a970,
264}]) = -1 ENOSPC (No space left on device)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGTTOU, {SIG_IGN, [TTOU], SA_RESTART}, {SIG_DFL, [TTOU],
SA_RESTART}, 8) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TIOCGPGRP, [559])              = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_START or SNDRV_TIMER_IOCTL_TREAD or TCSETS,
{B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDRV_TIMER_IOCTL_SELECT or TIOCSPGRP, [554]) = 0
rt_sigaction(SIGTTOU, {SIG_DFL, [TTOU], SA_RESTART}, {SIG_IGN, [TTOU],
SA_RESTART}, 8) = 0
fcntl(0, F_GETFL)                       = 0x20002 (flags O_RDWR|0x20000)
fcntl(0, F_SETFL, O_RDWR|0x20000)       = 0
fcntl(0, F_SETFL, O_RDWR|0x20000)       = 0
ioctl(1, TCSBRK, 0x1)                   = 0
write(2, "Unexpected error setting hardwar"..., 49Unexpected error
setting hardware debug registers) = 49
write(2, "\n", 1
)                       = 1

Thank you
Aaron


2013/12/10 Will Deacon <will.deacon@arm.com>:
> On Tue, Dec 10, 2013 at 06:12:24AM +0000, ??? wrote:
>> Hi all,
>
> Hello,
>
>> In these dayes, I use gdb to debug my program on ARM foundation model and
>> fast model with Linux 3.12.0-4.12 from ubuntu.  The gdb reports errors
>> about setting hardware debug register when stepping pthread_create().
>> After investigating gdb 7.6.1 source and Linux 3.12 source, I prepare a
>> patch for arch/arm64/kernel/ptrace.c.  Although the patch could solve gdb
>> error, I am not sure it has no side effects.  May somebody help to give
>> suggestions?  Thank you.
>>
>> Ref. to https://bugs.launchpad.net/gdb-linaro/+bug/1205391
>>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 6777a21..981f961 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -214,9 +214,16 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
>>  {
>>   int err, len, type, disabled = !ctrl.enabled;
>>
>> + /*
>> + * Does not change type and len in disabled case because it will
>> + * break the assertion that only 2 types (TYPE_DATA and TYPE_INST) in
>> + * the event linked list in ./kernel/events/hw_breakpoint.c
>> + */
>>   if (disabled) {
>> - len = 0;
>> - type = HW_BREAKPOINT_EMPTY;
>> + /*
>> + * len = 0;
>> + * type = HW_BREAKPOINT_EMPTY;
>> + */
>>   } else {
>>   err = arch_bp_generic_fields(ctrl, &len, &type);
>>   if (err)
>> @@ -234,10 +241,10 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
>>   default:
>>   return -EINVAL;
>>   }
>> + attr->bp_len = len;
>> + attr->bp_type = type;
>>   }
>>
>> - attr->bp_len = len;
>> - attr->bp_type = type;
>>   attr->disabled = disabled;
>>
>>   return 0;
>
> I don't understand what this achieves. Do you have a better description of
> the problem and/or strace logs showing all the hw_breakpoint ptrace requests
> issued by GDB up until the first failure please?
>
> That should help to figure out what the problem is.
>
> Cheers,
>
> Will
