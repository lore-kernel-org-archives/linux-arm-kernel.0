From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 10 Dec 2015 11:11:26 +0800
Subject: [PATCH 0/2] arm64: Non-racy PTE setting in the presence of HW
 AF/DBM
In-Reply-To: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
References: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <CACVXFVPaAUWMPgrinF7pO1h6Lwx8e64ijCkEs3aMYsN99ez8Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 1:26 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> This series addresses a potentially racy default implementation of
> ptep_set_access_flags() when hardware update of the access or dirty
> states is enabled. The first patch is some clean-up in set_pte_at() to
> improve the information reporting and replace BUG with WARN. The second
> patch contains the arm64-specific ptep_set_access_flags()
> implementation.
>
> Possible racy scenarios are described in patch 2. I think this series
> could be simplified on the following assumptions:
>
> a) if the CPUs do not support HW AF/DBM or it is disabled, no other
>    agent in the system will perform such updates
>
> b) if one CPU supports HW AF/DBM, all of them must do (don't mix such
>    features)
>
> Point (a) means that the current code works fine and BUG_ON() is not
> necessary.
>
> Point (b) however requires a ptep_set_access_flags() similar to the x86
> one, i.e. only do the setting if (changed && dirty), otherwise let the
> hardware handle the updates.
>
> Anyway, while patch 2 is still debatable, I'd like to merge the first
> patch in 4.4 to avoid an unnecessary BUG_ON on hardware that doesn't
> even do DBM.
>
> Catalin
>
>
> Catalin Marinas (2):
>   arm64: Improve error reporting on set_pte_at() checks
>   arm64: Implement ptep_set_access_flags() for hardware AF/DBM
>
>  arch/arm64/include/asm/pgtable.h | 16 ++++++++---
>  arch/arm64/mm/fault.c            | 57 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 4 deletions(-)
>

With the two patches, looks no BUG is triggered any more, and just
with the following warning:

[   98.303645] set_pte_at: racy access flag clearing: 00e80040db000b51
-> 00e80040db000b50
[   98.303660] ------------[ cut here ]------------
[   98.303666] WARNING: at ./arch/arm64/include/asm/pgtable.h:282
[   98.303669] Modules linked in:

[   98.303679] CPU: 2 PID: 2445 Comm: stress-ng-minco Tainted: G
 W       4.4.0-rc3-next-20151203+ #65
[   98.303683] Hardware name: AppliedMicro Mustang/Mustang, BIOS 2.0.0
Oct 23 2015
[   98.303686] task: ffffffc7c0caad00 ti: ffffffc7c0d10000 task.ti:
ffffffc7c0d10000
[   98.303696] PC is at pmdp_invalidate+0x104/0x11c
[   98.303700] LR is at pmdp_invalidate+0x104/0x11c
[   98.303703] pc : [<ffffffc0001e2de4>] lr : [<ffffffc0001e2de4>]
pstate: 80000145
[   98.303705] sp : ffffffc7c0d13720
[   98.303708] x29: ffffffc7c0d13720 x28: 0000000000000ff8
[   98.303713] x27: ffffffc445c1a000 x26: 0000000000000001
[   98.303718] x25: ffffffc7c01e8000 x24: ffffffc000d43000
[   98.303722] x23: ffffffc7c01e8000 x22: 00e80040db000b50
[   98.303727] x21: 0000000036e00000 x20: ffffffc7ccecadb0
[   98.303731] x19: 00e80040db000b51 x18: 0000000000000000
[   98.303735] x17: 0000007f410bf260 x16: ffffffc000140eb4
[   98.303740] x15: 003223715c000000 x14: 3038653030203e2d
[   98.303744] x13: 2031356230303062 x12: 6430343030386530
[   98.303749] x11: 30203a676e697261 x10: 656c632067616c66
[   98.303753] x9 : 00000000000001ad x8 : ffffffc7c0d13470
[   98.303758] x7 : ffffffc7c0caad00 x6 : ffffffc000115424
[   98.303762] x5 : 0000000000000000 x4 : ffffffc000c54000
[   98.303766] x3 : 0000000000000000 x2 : ffffffc7c0d10000
[   98.303771] x1 : 0000000000000000 x0 : 000000000000004b

[   98.303778] ---[ end trace a4326fc4ab084b3e ]---
[   98.303780] Call trace:
[   98.306219] [<ffffffc0001e2de4>] pmdp_invalidate+0x104/0x11c
[   98.306227] [<ffffffc000202844>] __split_huge_pmd_locked+0x2b8/0x718
[   98.306232] [<ffffffc000208b54>] split_huge_page_to_list+0x734/0x99c
[   98.306236] [<ffffffc0001e67d0>] add_to_swap+0xf4/0x138
[   98.306241] [<ffffffc0001b5794>] shrink_page_list+0x3a8/0xe3c
[   98.306245] [<ffffffc0001b6974>] shrink_inactive_list+0x228/0x538
[   98.306249] [<ffffffc0001b748c>] shrink_lruvec+0x484/0x590
[   98.306253] [<ffffffc0001b7600>] shrink_zone+0x68/0x19c
[   98.306256] [<ffffffc0001b79f4>] try_to_free_pages+0x2c0/0x6f8
[   98.306263] [<ffffffc0001a8c84>] __alloc_pages_nodemask+0x558/0xa4c
[   98.306267] [<ffffffc0001a930c>] __get_free_pages+0x1c/0x50
[   98.306271] [<ffffffc0001d4394>] SyS_mincore+0x80/0x218
[   98.306276] [<ffffffc000085cb0>] el0_svc_naked+0x24/0x28


-- 
Ming Lei
