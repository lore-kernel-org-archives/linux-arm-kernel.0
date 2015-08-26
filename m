From: jianhua.ljh@gmail.com (Jianhua Liu)
Date: Wed, 26 Aug 2015 20:02:32 +0800
Subject: [PATCH] arm64: fix bug for reloading FPSIMD state after execve on
 cpu 0.
In-Reply-To: <20150826111205.GD30466@arm.com>
References: <1440556841-17219-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150826111205.GD30466@arm.com>
Message-ID: <CAAgTQPXEMqdcVY0M+YX=HQobos47hEbTzH18ynioM1iwu39aXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NO, kernel thread will not use fpsimd.
kernel threads get scheduled in, per_cpu(fpsimd_last_state) will not be updated.

The following is the condion that bug comes.
1. Process A runa on CPU 0, and does execve syscall.
2. Before execve syscall return to userspace, A gets scheduled out.
3. some kernel threads get scheduled in on CPU 0,
    per_cpu(fpsimd_last_state) will not be updated, still points to
A's fpsimd_state
4. Process A get scheduled in on CPU 0,
        1)process A's fpsimd_state.cpu contains 0,
        2)cpu 0's  fpsimd_last_state per-cpu variable points to
process A 's fpsimd_state,
        These two are the conditions that TIF_FOREIGN_FPSTATE get cleared?

The kernel will not reload the fpsimd context during A returns back to
user space.
But A's fpsimd context is cleared to zero after execve syscall and
must to be reload.


I am not seeing an exact issue in practice.

Janet


On Wed, Aug 26, 2015 at 7:12 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hello,
>
> [adding Ard]
>
> On Wed, Aug 26, 2015 at 03:40:41AM +0100, Chunyan Zhang wrote:
>> From: Janet Liu <janet.liu@spreadtrum.com>
>>
>> If process A is running on CPU 0 and do execve syscall and after sched_exec,
>> dest_cpu is 0, fpsimd_state.cpu is 0. If at the time Process A get scheduled
>> out and after some kernel threads running on CPU 0, process A is back in CPU 0,
>> A's fpsimd_state.cpu is current cpu id "0", and per_cpu(fpsimd_last_state)
>> points A's fpsimd_state, TIF_FOREIGN_FPSTATE will be clear, kernel will not
>> reload the context during it return to userspace. so set the cpu's
>> fpsimd_last_state to NULL to avoid this.
>
> AFAICT, this is only a problem if one of the kernel threads uses the fpsimd
> registers, right? However, kernel_neon_begin_partial clobbers
> fpsimd_last_state, so I'm struggling to see the problem.
>
> Are you seeing an issue in practice?
>
> Will
>
>> Signed-off-by: Janet Liu <janet.liu@spreadtrum.com>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  arch/arm64/kernel/fpsimd.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 44d6f75..ec58d94 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -159,6 +159,7 @@ void fpsimd_flush_thread(void)
>>  {
>>       memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
>>       set_thread_flag(TIF_FOREIGN_FPSTATE);
>> +     this_cpu_write(fpsimd_last_state, NULL);
>>  }
>>
>>  /*
>> --
>> 1.7.9.5
>>
