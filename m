From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 Nov 2011 13:23:02 -0800
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2011 at 9:33 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> From: Dima Zavin <dima@android.com>
>
> We can't be holding the mmap_sem while calling flush_cache_user_range
> because the flush can fault. If we fault on a user address, the
> page fault handler will try to take mmap_sem again. Since both places
> acquire the read lock, most of the time it succeeds. However, if another
> thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> between the call to flush_cache_user_range and the fault, the down_read
> in do_page_fault will deadlock.
>
> Also, since we really can't be holding the mmap_sem while calling
> flush_cache_user_range AND vma is actually unused by the flush itself,
> get rid of vma as an argument.

I've spent some time recently debugging lockups exactly because of this issue.

The case I have here is that one Chrome thread will call cacheflush
(v8 jit, most likely -- reason is unimportant), while another happens
to call brk(). The down_write() in sys_brk races with the first
down_read in do_cache_op and the one in do_page_fault.

The stacks of the race are:

[ 1715.420401] exe             D c0441894     0  2950   2849 0x00000000
[ 1715.426896] [<c0441894>] (__schedule+0x768/0x83c) from [<c0441d08>]
(schedule+0x80/0x84)
[ 1715.435081] [<c0441d08>] (schedule+0x80/0x84) from [<c0443a40>]
(__down_read+0xc8/0xe0)
[ 1715.443161] [<c0443a40>] (__down_read+0xc8/0xe0) from [<c04430e8>]
(down_read+0x34/0x3c)
[ 1715.451360] [<c04430e8>] (down_read+0x34/0x3c) from [<c00565cc>]
(do_page_fault+0xd0/0x2e4)
[ 1715.459816] [<c00565cc>] (do_page_fault+0xd0/0x2e4) from
[<c0046174>] (do_DataAbort+0x44/0xa8)
[ 1715.468503] [<c0046174>] (do_DataAbort+0x44/0xa8) from [<c004b96c>]
(__dabt_svc+0x4c/0x60)
[ 1715.476805] Exception stack(0xedbf5ea8 to 0xedbf5ef0)
[ 1715.481902] 5ea0:                   55308000 55400000 00000020
0000001f 00000001 e62fae44
[ 1715.490138] 5ec0: 55308080 55400fef edbf4000 e62fae00 00000000
edbf5fa4 5530a000 edbf5ef0
[ 1715.498359] 5ee0: c005009c c0058f18 80000013 ffffffff
[ 1715.503486] [<c004b96c>] (__dabt_svc+0x4c/0x60) from [<c0058f18>]
(v7_coherent_kern_range+0x1c/0x7c)
[ 1715.512689] [<c0058f18>] (v7_coherent_kern_range+0x1c/0x7c) from
[<c005009c>] (arm_syscall+0x190/0x288)
[ 1715.522173] [<c005009c>] (arm_syscall+0x190/0x288) from
[<c004be00>] (ret_fast_syscall+0x0/0x30)
[ 1715.531009] exe             D c0441894     0  2952   2849 0x00000000
[ 1715.537502] [<c0441894>] (__schedule+0x768/0x83c) from [<c0441d08>]
(schedule+0x80/0x84)
[ 1715.545668] [<c0441d08>] (schedule+0x80/0x84) from [<c0443b1c>]
(__down_write_nested+0xc4/0xdc)
[ 1715.554464] [<c0443b1c>] (__down_write_nested+0xc4/0xdc) from
[<c0443b48>] (__down_write+0x14/0x18)
[ 1715.563609] [<c0443b48>] (__down_write+0x14/0x18) from [<c04430ac>]
(down_write+0x34/0x3c)
[ 1715.571964] [<c04430ac>] (down_write+0x34/0x3c) from [<c01132f8>]
(sys_brk+0x38/0x120)
[ 1715.579990] [<c01132f8>] (sys_brk+0x38/0x120) from [<c004be00>]
(ret_fast_syscall+0x0/0x30)

> Signed-off-by: Dima Zavin <dima@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Olof Johansson <olof@lixom.net>

> Russell, this patch has been around for a while but still no decision
> made, so I'm reposting it. It solves a real bug in the ARM kernels and
> I'd like to be considered for upstream.

Agreed. Russell, please consider picking this up -- the bug is very
real and it sounds like the objection is vague.

An alternative solution could be to iterate over the flushed range and
only flush available pages, but that would add quite a bit of overhead
to this code path.

If needed, I should be able to provide a standalone testcase to
trigger it, but I can reproduce at will just running Chrome as well.


-Olof
