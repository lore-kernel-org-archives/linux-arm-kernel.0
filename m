From: amit.virdi@st.com (Amit Virdi)
Date: Wed, 8 May 2013 17:27:04 +0530
Subject: Problem in mounting flat filesystem with Kernel v3.9
Message-ID: <518A3D90.5060901@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

For my MMU-less SoC, I'm facing problems with mounting the filesystem 
with Kernel versions 3.6 onwards.

I'm using a flat cramfs format FS.

This FS works perfectly till Kernel v3.5

However, when I rebase on v3.6 things start breaking. The Kernel doesn't 
boot at all. The processor generated Synchronous Data Abort exception 
because of alignment fault (during read operation). I debugged the code 
and noticed that start_kernel ran successfully till the end. It is the 
execution of rest_init that generates the alignment fault.

Same behavior was observed for v3.7.

With Kernel v3.8 and V3.9, the execution proceeds with probing of all 
the devices. However, here the Kernel couldn't mount the FS and is 
generating panic. The boot logs are:

-- 
<snip>
Creating 4 MTD partitions on "NOR":
0x000000000000-0x000000010000 : "X-loader"
0x000000010000-0x000000040000 : "U-Boot"
0x000000040000-0x000000240000 : "Kernel"
0x000000240000-0x000001000000 : "Root File System"
Warning: unable to open an initial console.
VFS: Cannot open root device "mtdblock3" or unknown-block(31,3): error -14
Please append a correct "root=" boot option; here are the available 
partitions:
1f00              64 mtdblock0  (driver?)
1f01             192 mtdblock1  (driver?)
1f02            2048 mtdblock2  (driver?)
1f03           14080 mtdblock3  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,3)
[<2000c9f8>] (unwind_backtrace+0x0/0xf8) from [<20186f10>] 
(panic+0x8c/0x1d8)
[<20186f10>] (panic+0x8c/0x1d8) from [<201f9d58>] 
(mount_block_root+0x1fc/0x2b8)
[<201f9d58>] (mount_block_root+0x1fc/0x2b8) from [<201fa0c0>] 
(prepare_namespace+0x160/0x1b8)
[<201fa0c0>] (prepare_namespace+0x160/0x1b8) from [<201f9a0c>] 
(kernel_init_freeable+0x168/0x1ac)
[<201f9a0c>] (kernel_init_freeable+0x168/0x1ac) from [<20186398>] 
(kernel_init+0x8/0xe4)
[<20186398>] (kernel_init+0x8/0xe4) from [<20008e98>] 
(ret_from_fork+0x14/0x3c)
-- 

Can anyone suggest what might be wrong here? Due to this filesystem 
mounting problem, I'm stuck with Kernel v3.5.

Regards
Amit Virdi
