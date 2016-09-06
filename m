From: wladislav.wiebe@nokia.com (Wiebe, Wladislav (Nokia - DE/Ulm))
Date: Tue, 6 Sep 2016 15:07:44 +0000
Subject: [PATCH] ARM: module: suppress misleading allocation failure warning
Message-ID: <HE1PR07MB1483029049CF1F5663C96404FAF90@HE1PR07MB1483.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in case __vmalloc_node_range fails to allocate memory inside
of MODULES_VADDR <-> MODULES_END range, it suggests
to increase vmalloc size, like reported below:
..
[   41.526591] vmap allocation for size 65536 failed: use vmalloc=<size> to increase size.
[   41.526597] vmalloc: allocation failure: 58712 bytes
[   41.526602] systemd-udevd: page allocation failure: order:0, mode:0xd0
[   41.526610] CPU: 2 PID: 2782 Comm: systemd-udevd Tainted: G           O xxx #1
[   41.526628] [<c0413615>] (unwind_backtrace) from [<c04106d9>] (show_stack+0x11/0x14)
[   41.526640] [<c04106d9>] (show_stack) from [<c0765745>] (dump_stack+0x7f/0xa2)
[   41.526651] [<c0765745>] (dump_stack) from [<c049fcb1>] (warn_alloc_failed+0x85/0xbc)
[   41.526664] [<c049fcb1>] (warn_alloc_failed) from [<c04c1f49>] (__vmalloc_node_range+0xed/0x188)
[   41.526673] [<c04c1f49>] (__vmalloc_node_range) from [<c0410ea7>] (module_alloc+0x47/0x8c)
[   41.526684] [<c0410ea7>] (module_alloc) from [<c046755b>] (module_alloc_update_bounds+0xf/0x64)
[   41.526692] [<c046755b>] (module_alloc_update_bounds) from [<c0467fd7>] (load_module+0xa27/0x19b4)
[   41.526700] [<c0467fd7>] (load_module) from [<c0469089>] (SyS_finit_module+0x59/0x84)
[   41.526709] [<c0469089>] (SyS_finit_module) from [<c040d8c1>] (ret_fast_syscall+0x1/0x64)
..

This is obviously wrong, as increasing vmalloc size will not
help in this case. We should suppress the warning and keep
it only reporting in PLT case, where it afterwards really tries to
allocate module memory in the VMALLOC space.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
Tested-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
There might a more advanced solution possible, like to pass
an additional flag to the allocator for indicating that there
is a call from module_alloc and handle the allocation failure message
differently. But I am not sure if such a solution would
be to oversized for this purpose, as modprobe should fail in
case allocation fails for the module.

 arch/arm/kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4f14b5c..724447b 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -41,8 +41,8 @@
 void *module_alloc(unsigned long size)
 {
 	void *p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
-				__builtin_return_address(0));
+				GFP_KERNEL | __GFP_NOWARN, PAGE_KERNEL_EXEC, 0,
+				NUMA_NO_NODE, __builtin_return_address(0));
 	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
 		return p;
 	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
-- 
1.7.12.4
