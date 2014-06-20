From: ccross@android.com (Colin Cross)
Date: Fri, 20 Jun 2014 14:24:11 -0700
Subject: [PATCH] ARM64: implement TASK_SIZE_OF
In-Reply-To: <20140620082520.GC25104@arm.com>
References: <1403122209-26352-1-git-send-email-ccross@android.com>
 <20140620082520.GC25104@arm.com>
Message-ID: <CAMbhsRTX6QeJVbzzQ6ds5=QhJE64mMWPoF5e=_f3uB24XtUKTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 1:25 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Colin,
>
> On Wed, Jun 18, 2014 at 09:10:09PM +0100, Colin Cross wrote:
>> include/linux/sched.h implements TASK_SIZE_OF as TASK_SIZE if it
>> is not set by the architecture headers.  TASK_SIZE uses the
>> current task to determine the size of the virtual address space.
>> On a 64-bit kernel this will cause reading /proc/pid/pagemap of a
>> 64-bit process from a 32-bit process to return EOF when it reads
>> past 0xffffffff.
>>
>> Implement TASK_SIZE_OF exactly the same as TASK_SIZE with
>> test_tsk_thread_flag instead of test_thread_flag.
>
> Looks sane to me.
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> I take it you're being bitten by this in real software, hence the CC stable
> tag?
>
> Will

Yes, it causes memory statistics produced by Android's procrank tool
to be completely wrong.  It applies cleanly to at least 3.10.44,
3.12.22, and 3.14.8.
