From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Feb 2017 10:58:53 +0000
Subject: [PATCH v3] arm64: Fix kernel panic() in cpu_do_switch_mm() on
 QDF2400
In-Reply-To: <1487887418-20195-1-git-send-email-shankerd@codeaurora.org>
References: <1487887418-20195-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20170224105852.GC20130@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:03:38PM -0600, Shanker Donthineni wrote:
> The commit 38fd94b0275c 'arm64: Work around Falkor erratum 1003' has
> been added to fix the hardware bug but causes a system crash. The
> value of the register x1 which contains 'struct mm_struct *' should
> be preserved inside macro pre_ttbr0_update_workaround.
> 
> Macro pre_ttbr0_update_workaround expects 2nd and 3rd arguments are
> temporary registers. Don't clobber register x1, Otherwise the next
> load operation 'mmid x1 x1' access the invalid address.
> 
> [<ffff0000080989a0>] cpu_do_switch_mm+0x20/0x40
> [<ffff000008b18614>] efi_virtmap_load+0x34/0x40
> [<ffff000008b1812c>] virt_efi_get_next_variable+0x64/0xc8
> [<ffff000008b16204>] efivar_init+0x8c/0x348
> [<ffff0000092b777c>] efisubsys_init+0xd4/0x270
> [<ffff000009270c74>] do_one_initcall+0x80/0x110
> [<ffff000009270ea0>] kernel_init_freeable+0x19c/0x240
> [<ffff000008d8cef0>] kernel_init+0x10/0x100
> [<ffff000008082ec0>] ret_from_fork+0x10/0x50
>  Code: d5033fdf b340bc01 d5182001 d5033fdf (f9416821)
>  ---[ end trace 15247ca922eb6bb7 ]---
>  note: swapper/0[1] exited with preempt_count 2
>  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
>  SMP: stopping secondary CPUs
>  ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
> ---
> v2: include 12 digit commit-id in commit description.
> v3: modified the commit subject to more descriptive.

Thanks for the v3, but I actually already rewrote the commit log when I
applied the patch locally yesterday :)

I'll push out the branch later today once I've hoovered up any other fixes
kicking around.

Will
