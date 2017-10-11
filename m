From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 11 Oct 2017 21:35:22 +0300
Subject: next: arm64: LTP sendto01 test causes system crash in ilp32 mode
Message-ID: <20171011183522.tm2xxgzbdspjtsax@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all, 

It seems like next-20171009 with ilp32 patches crashes on LTP sendto01 test
in sys_sendto() path, like this:

[  554.034021] [<ffff80003ccd5a58>] 0xffff80003ccd5a58
[  554.034156] [<ffff00000888fd34>] skb_release_all+0x14/0x30
[  554.034288] [<ffff00000888fd64>] __kfree_skb+0x14/0x28
[  554.034409] [<ffff0000088ece6c>] tcp_sendmsg_locked+0x4dc/0xcc8
[  554.034541] [<ffff0000088ed68c>] tcp_sendmsg+0x34/0x58
[  554.034659] [<ffff000008919fd4>] inet_sendmsg+0x2c/0xf8
[  554.034783] [<ffff0000088842e8>] sock_sendmsg+0x18/0x30
[  554.034928] [<ffff0000088861fc>] SyS_sendto+0x84/0xf8

I cannot reproduce it in lp64 mode, and test is passed in ilp32 mode
if I run it alone, even in infinite loop. But in ltplite scenario the
fail is always reproducible.

The brief analisys of dump shows that kernel crashes due to bad value
in ->destructor field of struct sk_buff, when tries to call
skb->destructor() in skb_release_all(). It looks very unusual,
comparing to typical ilp32 ABI bugs, and I suspect that here is generic
issue - maybe some race condition?

Kernel v4.14-rc4 works well. If no ideas, I'll bisect it a bit later.
Ooops log is below. Config is attached, and kernel sources are:
https://github.com/norov/linux/tree/ilp32-20171009

Yury

[  554.026522] Unable to handle kernel read from unreadable memory at virtual address ffff80003ccd5a58
[  554.027005] Mem abort info:
[  554.027124]   Exception class = IABT (current EL), IL = 32 bits
[  554.027292]   SET = 0, FnV = 0
[  554.027378]   EA = 0, S1PTW = 0
[  554.027537] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff000009069000
[  554.027732] [ffff80003ccd5a58] *pgd=000000007eff7003, *pud=000000007eff6003, *pmd=00f800007cc00711
[  554.028128] Internal error: Oops: 8600000e [#1] PREEMPT SMP
[  554.028308] Modules linked in:
[  554.028480] CPU: 1 PID: 6388 Comm: send01 Not tainted 4.14.0-rc4-next-20171009-00025-g6229c950955a #256
[  554.028684] Hardware name: linux,dummy-virt (DT)
[  554.028797] task: ffff80003b6d0e80 task.stack: ffff000009d70000
[  554.028959] PC is at 0xffff80003ccd5a58
[  554.029272] LR is at skb_release_head_state+0x5c/0xf8
[  554.029406] pc : [<ffff80003ccd5a58>] lr : [<ffff00000888fc84>] pstate: 40000145
[  554.029676] sp : ffff000009d73c00
[  554.029806] x29: ffff000009d73c00 x28: ffff800039a86c80 
[  554.030021] x27: ffff800039a86dd8 x26: 00000000fffffff2 
[  554.030139] x25: ffff80003ccd5a00 x24: 0000000000000000 
[  554.030258] x23: ffff000009d73de8 x22: 0000000000000000 
[  554.030375] x21: ffff000009d73df8 x20: 0000000000000000 
[  554.030490] x19: ffff80003ccd5a00 x18: 00000000f7e73df8 
[  554.030606] x17: 00000000f7f40320 x16: ffff000008886178 
[  554.030721] x15: 0000000000000126 x14: 00000000f7fea700 
[  554.030840] x13: 00000000f7e75b8c x12: 00000000f7e7e43c 
[  554.030959] x11: 6f732064696c6176 x10: 0101010101010101 
[  554.031060] x9 : 206d305b1b535341 x8 : 0000000000005555 
[  554.031159] x7 : ffff80003b6d0e80 x6 : ffff80003c0aa910 
[  554.031256] x5 : ffff80003c0aad10 x4 : 0000000000000000 
[  554.031354] x3 : 000000010000f809 x2 : 0000000000000700 
[  554.031452] x1 : ffff80003ccd5a58 x0 : ffff80003ccd5a00 
[  554.031566] Process send01 (pid: 6388, stack limit = 0xffff000009d70000)
[  554.031753] Call trace:
[  554.031870] Exception stack(0xffff000009d73ac0 to 0xffff000009d73c00)
[  554.032064] 3ac0: ffff80003ccd5a00 ffff80003ccd5a58 0000000000000700 000000010000f809
[  554.032224] 3ae0: 0000000000000000 ffff80003c0aad10 ffff80003c0aa910 ffff80003b6d0e80
[  554.032380] 3b00: 0000000000005555 206d305b1b535341 0101010101010101 6f732064696c6176
[  554.032584] 3b20: 00000000f7e7e43c 00000000f7e75b8c 00000000f7fea700 0000000000000126
[  554.032732] 3b40: ffff000008886178 00000000f7f40320 00000000f7e73df8 ffff80003ccd5a00
[  554.032883] 3b60: 0000000000000000 ffff000009d73df8 0000000000000000 ffff000009d73de8
[  554.033066] 3b80: 0000000000000000 ffff80003ccd5a00 00000000fffffff2 ffff800039a86dd8
[  554.033233] 3ba0: ffff800039a86c80 ffff000009d73c00 ffff00000888fc84 ffff000009d73c00
[  554.033386] 3bc0: ffff80003ccd5a58 0000000040000145 ffff0000089a2a64 0000000000000145
[  554.033656] 3be0: 0001000000000000 ffff00000888fd08 ffff000009d73c00 ffff80003ccd5a58
[  554.034021] [<ffff80003ccd5a58>] 0xffff80003ccd5a58
[  554.034156] [<ffff00000888fd34>] skb_release_all+0x14/0x30
[  554.034288] [<ffff00000888fd64>] __kfree_skb+0x14/0x28
[  554.034409] [<ffff0000088ece6c>] tcp_sendmsg_locked+0x4dc/0xcc8
[  554.034541] [<ffff0000088ed68c>] tcp_sendmsg+0x34/0x58
[  554.034659] [<ffff000008919fd4>] inet_sendmsg+0x2c/0xf8
[  554.034783] [<ffff0000088842e8>] sock_sendmsg+0x18/0x30
[  554.034928] [<ffff0000088861fc>] SyS_sendto+0x84/0xf8
[  554.035046] Exception stack(0xffff000009d73ec0 to 0xffff000009d74000)
[  554.035186] 3ec0: 0000000000000004 00000000ffffffff 0000000000000400 0000000000000000
[  554.035334] 3ee0: 0000000000000000 0000000000000000 20203130646e6573 1b20203220202020
[  554.035503] 3f00: 00000000000000ce 206d305b1b535341 0101010101010101 6f732064696c6176
[  554.035657] 3f20: 00000000f7e7e43c 00000000f7e75b8c 00000000f7fea700 0000000000000126
[  554.035825] 3f40: 00000000004240e0 00000000f7f40320 00000000f7e73df8 000000000040e000
[  554.035981] 3f60: 00000000f7feaea0 0000000000424000 0000000000424000 0000000000447000
[  554.036148] 3f80: 0000000000447000 000000000040e000 000000000000002c 000000000040ee28
[  554.036315] 3fa0: 0000000000447450 00000000fffef5b0 0000000000402748 00000000fffef5b0
[  554.036520] 3fc0: 00000000f7f40348 0000000000000000 0000000000000004 00000000000000ce
[  554.036683] 3fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  554.036853] [<ffff0000080837dc>] el0_svc_naked+0x20/0x24
[  554.037052] Code: 00000000 00000000 00000000 00000000 (00000000) 
[  554.037369] ---[ end trace c38823b11ae81586 ]---

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/gzip
Size: 36439 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171011/1fc066d9/attachment-0001.gz>
