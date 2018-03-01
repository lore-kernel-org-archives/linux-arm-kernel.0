From: alex.shi@linaro.org (Alex Shi)
Date: Thu, 1 Mar 2018 19:46:57 +0800
Subject: boot hang on meltdown backporting -- urgent
Message-ID: <30b47155-2dcd-45db-b47a-95bf6b8d4dbb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magus & Geert,

When I do backport meltdown fix to LTS 4.9, a boot hang happens(RCU
stall) with defconfig+CONFIG_RANDOMIZE_BASE=y on your board:
r8a7795-salvator-x
The bug at https://kernelci.org/boot/id/5a96f3dd59b5146590b3a4d5/

The backporting git tree is
https://git.linaro.org/kernel/linux-linaro-stable.git/commit/?id=791778ab06292219a9ed09d3bf025badb8f02b48

Due to recent kernelci issue, a possible fix can not be tested now:

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 8d50b28..198f231 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -906,6 +906,7 @@ __ni_sys_trace:
        tramp_map_kernel        x30
 #ifdef CONFIG_RANDOMIZE_BASE
        adr     x30, tramp_vectors + PAGE_SIZE
+       isb
        ldr     x30, [x30]
 #else
        ldr     x30, =vectors

Would you like to help me test above patch? which is included
in the latest branch
https://git.linaro.org/kernel/linux-linaro-stable.git  v4.9-metldown

If it still causes boot hang, could you like to do a bisect to the buggy
commit? This is the only issue on the way to merge this patchset to LTS.


Thanks a lot!
Alex
