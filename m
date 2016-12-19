From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 19 Dec 2016 17:59:54 +0800
Subject: [bug report v4.8] fs/locks.c: kernel oops during posix lock
 stress test
In-Reply-To: <CACVXFVMA4mKCUt9gnwbdYVMqSTk-H+LX7dQiAxz_FqwKPQ1X9Q@mail.gmail.com>
References: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
 <1480340400.2606.10.camel@poochiereds.net>
 <CACVXFVMA4mKCUt9gnwbdYVMqSTk-H+LX7dQiAxz_FqwKPQ1X9Q@mail.gmail.com>
Message-ID: <CACVXFVOP8ox24R-Zwn6brNhHrh-q8F_7mQn_jx++L+BnwT7Bag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 8, 2016 at 11:57 PM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> On Mon, Nov 28, 2016 at 9:40 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
>> On Mon, 2016-11-28 at 11:10 +0800, Ming Lei wrote:
>>> Hi Guys,
>>>
>>> When I run stress-ng via the following steps on one ARM64 dual
>>> socket system(Cavium Thunder), the kernel oops[1] can often be
>>> triggered after running the stress test for several hours(sometimes
>>> it may take longer):
>>>
>>> - git clone git://kernel.ubuntu.com/cking/stress-ng.git
>>> - apply the attachment patch which just makes the posix file
>>> lock stress test more aggressive
>>> - run the test via '~/git/stress-ng$./stress-ng --lockf 128 --aggressive'
>>>
>>>
>>> From the oops log, looks one garbage file_lock node is got
>>> from the linked list of 'ctx->flc_posix' when the issue happens.
>>>
>>> BTW, the issue isn't observed on single socket Cavium Thunder yet,
>>> and the same issue can be seen on Ubuntu Xenial(v4.4 based kernel)
>>> too.
>>>
>>> Thanks,
>>> Ming
>>>
>>
>> Some questions just for clarification:
>>
>> - I assume this is being run on a local fs of some sort? ext4 or xfs or
>> something?
>>
>> - have you seen this on any other arch, besides ARM?
>>
>> The file locking code does do some lockless checking to see whether the
>> i_flctx is even present and whether the list is empty in
>> locks_remove_posix. It's possible we have some barrier problems there,
>
> I have used ebpf trace to see what is going on when 'stress-ng --lockf'
> is running, and almost all exported symbols in fs/locks.c are covered.
>
> Except for locks_alloc/locks_free/locks_copy/locks_init, the only observable
> symbols are fcntl_setlk, vfs_lock_file and locks_remove_posix, but
> locks_remove_posix() is just run at the begining and ending of the
> test.
>
> So seems not related with locks_remove_posix().
>
> Then looks only fcntl_setlk() is running from different contexts
> during the test,
> but in this path, the 'ctx->flc_lock' is always held when operating the list.
> That said it is very strange to see the list corrupted even though it is
> protected by the lock.

After some analysis on traces collected recently, there are a few discoveries:

1) the spinlock scenario(ctx->flc_lock) is correct

2) the kernel oops(file lock corruption) always happens in the
task of stress-ng-lockf's child, which isn't affected by
sched_setaffinity(), and the process of stress-ng-lockf is schedued
from one CPU to another one from another socket at random according to
sched_setaffinity() called
from stress-ng main task.

Thanks,
Ming
