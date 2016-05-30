From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 30 May 2016 15:33:52 +0800
Subject: [Question] Crash when cat /dev/kmem in arm/arm64 but not in x86
Message-ID: <574BECE0.9070105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

When cat /dev/kmem in arm/arm64, it will crash, this is caused by "from = 0"
in copy_to_user(void __user *to, const void *from, unsigned long n),
call trace shows below(eg, arm64)

[    9.913370] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    9.914391] pgd = ffff800008345000
[    9.914976] [00000000] *pgd=00000000482bb003, *pud=00000000f69b4003, *pmd=0000000000000000
[    9.918036] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[    9.918683] Modules linked in:
[    9.919413] CPU: 6 PID: 1021 Comm: cat Not tainted 4.6.0+ #80
[    9.920410] Hardware name: linux,dummy-virt (DT)
[    9.921003] task: ffff8000b6448000 ti: ffff8000083b0000 task.ti: ffff8000083b0000
[    9.922356] PC is at __copy_to_user+0x180/0x280
[    9.922847] LR is at read_kmem+0x200/0x220
[    9.923265] pc : [<ffff000008339500>] lr : [<ffff000008473168>] pstate: 20000145
[    9.923988] sp : ffff8000083b3d60
[    9.924670] x29: ffff8000083b3d60 x28: 0000000000001000
[    9.925420] x27: 0000000000001000 x26: ffff8000083b3ec8
[    9.926039] x25: ffff8000083b0000 x24: ffff000008a20638
[    9.926810] x23: 0000000000001000 x22: 0000ffffe4dac550
[    9.927668] x21: 0000000000000000 x20: 0000000000001000
[    9.928771] x19: 0000000000000000 x18: 0000ffffe4dab240
[    9.929494] x17: 0000000000497458 x16: ffff0000081bc098
[    9.930162] x15: ffffffffffffffff x14: ff00000000000000
[    9.930857] x13: ffffffffffffffff x12: 0000000000000038
[    9.931629] x11: 00000000000000c7 x10: 0000000000000006
[    9.932649] x9 : 0000000000000006 x8 : 207a73202c296c6c
[    9.933356] x7 : 756e282020202020 x6 : 0000ffffe4dab550
[    9.934050] x5 : 0000ffffe4dac550 x4 : 0000000000000000
[    9.934801] x3 : 0000000000000000 x2 : 0000000000000f80
[    9.935601] x1 : 0000000000000000 x0 : 0000ffffe4dab550


but in x86, cat /dev/kmem, will just return "Bad address". After check the x86 code,
copy_to_user ->  _copy_to_user(copy_user_64.S, fixup) -> copy_user_handle_tail (will return len > 0),
then the copy_to_user() will return -EFAULT, the fixup_exception will deal with this situation,
so does the arm/arm64 need the same mechanism to deal with it too?

Thanks
Kefeng
