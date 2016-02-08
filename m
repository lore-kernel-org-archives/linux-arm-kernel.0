From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Feb 2016 11:46:49 +0000
Subject: [PATCH] arm64: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
References: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160208114649.GB13498@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 05, 2016 at 03:50:18PM -0800, Yang Shi wrote:
> To enable UBSAN on arm64, ARCH_HAS_UBSAN_SANITIZE_ALL need to be selected.
> 
> Basic kernel bootup test is passed on arm64 with CONFIG_UBSAN_SANITIZE_ALL
> enabled.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8cc6228..1c29e20 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -14,6 +14,7 @@ config ARM64
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
>  	select ARM_GIC

I gave this a go, and I got a couple of splats (included below) when
booting an Ubuntu 14.04 arm64 rootfs. I'm using Linato 15.08 GCC 5.1 to
compile an arm64 defconfig, and I see the issue with v4.5-rc2 and
v4.5-rc3.

I will dig into that and file a report shortl, unless someone has
already reported the same issue.

Did you see any failures in your testing? For reference, which kernel
version, compiler, and config were you using?

This patch itself looks good, so FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

[    3.804750] ================================================================================
[    3.813176] UBSAN: Undefined behaviour in fs/ext4/mballoc.c:2612:15
[    3.819431] shift exponent 4294967295 is too large for 32-bit type 'int'
[    3.826121] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc2+ #48
[    3.832463] Hardware name: AMD Overdrive/Supercharger/Default string, BIOS ROD0085E 11/23/2015
[    3.841060] Call trace:
[    3.843499] [<ffffffc00008d7b8>] dump_backtrace+0x0/0x298
[    3.848887] [<ffffffc00008da64>] show_stack+0x14/0x20
[    3.853929] [<ffffffc00056e0f0>] dump_stack+0xe0/0x178
[    3.859056] [<ffffffc0005b734c>] ubsan_epilogue+0x14/0x50
[    3.864444] [<ffffffc0005b7748>] __ubsan_handle_shift_out_of_bounds+0xe0/0x138
[    3.871655] [<ffffffc0003e1734>] ext4_mb_init+0x84c/0x920
[    3.877043] [<ffffffc0003ba294>] ext4_fill_super+0x2eac/0x4958
[    3.882866] [<ffffffc0002c1008>] mount_bdev+0x180/0x1e8
[    3.888079] [<ffffffc0003adf8c>] ext4_mount+0x14/0x20
[    3.893118] [<ffffffc0002c23f4>] mount_fs+0x44/0x1c8
[    3.898073] [<ffffffc0002ed9c0>] vfs_kern_mount+0x50/0x1a8
[    3.903547] [<ffffffc0002f3d90>] do_mount+0x240/0x1478
[    3.908673] [<ffffffc0002f54d0>] SyS_mount+0x90/0xf8
[    3.913627] [<ffffffc000eb2750>] mount_block_root+0x22c/0x3c4
[    3.919361] [<ffffffc000eb2a08>] mount_root+0x120/0x138
[    3.924574] [<ffffffc000eb2b5c>] prepare_namespace+0x13c/0x184
[    3.930396] [<ffffffc000eb21bc>] kernel_init_freeable+0x390/0x3b4
[    3.936479] [<ffffffc000bb4a78>] kernel_init+0x10/0xe0
[    3.941606] [<ffffffc000086cd0>] ret_from_fork+0x10/0x40
[    3.946905] ================================================================================

[    5.566166] ================================================================================
[    5.574596] UBSAN: Undefined behaviour in fs/ext4/mballoc.c:1274:11
[    5.580851] shift exponent -1 is negative
[    5.584851] CPU: 4 PID: 1028 Comm: mount Not tainted 4.5.0-rc2+ #48
[    5.591105] Hardware name: AMD Overdrive/Supercharger/Default string, BIOS ROD0085E 11/23/2015
[    5.599702] Call trace:
[    5.602142] [<ffffffc00008d7b8>] dump_backtrace+0x0/0x298
[    5.607530] [<ffffffc00008da64>] show_stack+0x14/0x20
[    5.612572] [<ffffffc00056e0f0>] dump_stack+0xe0/0x178
[    5.617700] [<ffffffc0005b734c>] ubsan_epilogue+0x14/0x50
[    5.623088] [<ffffffc0005b7748>] __ubsan_handle_shift_out_of_bounds+0xe0/0x138
[    5.630300] [<ffffffc0003d2a04>] mb_find_order_for_block+0x154/0x1b0
[    5.636641] [<ffffffc0003d2b2c>] mb_find_extent+0xcc/0x548
[    5.642116] [<ffffffc0003de6a8>] ext4_mb_complex_scan_group+0xe8/0x4e8
[    5.648632] [<ffffffc0003ded7c>] ext4_mb_regular_allocator+0x2d4/0x648
[    5.655148] [<ffffffc0003e2b4c>] ext4_mb_new_blocks+0x344/0x7e0
[    5.661056] [<ffffffc0003cbf54>] ext4_ext_map_blocks+0x684/0xf68
[    5.667052] [<ffffffc000393664>] ext4_map_blocks+0x12c/0x500
[    5.672699] [<ffffffc000398df4>] ext4_writepages+0x47c/0xe38
[    5.678348] [<ffffffc00020da20>] do_writepages+0x48/0xc8
[    5.683649] [<ffffffc0001f9100>] __filemap_fdatawrite_range+0x70/0xe8
[    5.690078] [<ffffffc0001f91b0>] filemap_flush+0x18/0x20
[    5.695378] [<ffffffc000394b64>] ext4_alloc_da_blocks+0x3c/0x78
[    5.701285] [<ffffffc0003ac1c8>] ext4_rename+0x690/0xe38
[    5.706585] [<ffffffc0003ac98c>] ext4_rename2+0x1c/0x40
[    5.711800] [<ffffffc0002d0510>] vfs_rename+0x2c0/0xa90
[    5.717013] [<ffffffc0002d661c>] SyS_renameat2+0x464/0x5c0
[    5.722486] [<ffffffc0002d6788>] SyS_renameat+0x10/0x18
[    5.727700] [<ffffffc000086d30>] el0_svc_naked+0x24/0x28
[    5.732998] ================================================================================
