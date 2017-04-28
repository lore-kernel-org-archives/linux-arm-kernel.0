From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 28 Apr 2017 16:24:29 +0300
Subject: arm64: next-20170428 hangs on boot
Message-ID: <20170428132429.c3dlxbmt7iqs2isl@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On QEMU the next-20170428 hangs on boot for me due to kernel panic in 
rtnetlink_init():

void __init rtnetlink_init(void)
{
        if (register_pernet_subsys(&rtnetlink_net_ops))
                panic("rtnetlink_init: cannot initialize rtnetlink\n");

        ...
}

The backtrace is:
#0  arch_counter_get_cntvct () at ./arch/arm64/include/asm/arch_timer.h:160
#1  __delay (cycles=62500) at arch/arm64/lib/delay.c:31
#2  0xffff00000838a430 in __const_udelay (xloops=<optimized out>) at arch/arm64/lib/delay.c:41
#3  0xffff000008165eac in panic (fmt=<optimized out>) at kernel/panic.c:297
#4  0xffff000008b5b9c8 in rtnetlink_init () at net/core/rtnetlink.c:4196
#5  0xffff000008b5be08 in netlink_proto_init () at net/netlink/af_netlink.c:2730
#6  0xffff000008083158 in do_one_initcall (fn=0xffff000008b5bcc4 <netlink_proto_init>) at init/main.c:795
#7  0xffff000008b20d04 in do_initcall_level (level=<optimized out>) at init/main.c:861
#8  do_initcalls () at init/main.c:869
#9  do_basic_setup () at init/main.c:887
#10 kernel_init_freeable () at init/main.c:1039
#11 0xffff000008817bb0 in kernel_init (unused=<optimized out>) at init/main.c:962
#12 0xffff000008082ec0 in ret_from_fork () at arch/arm64/kernel/entry.S:789
Backtrace stopped: previous frame identical to this frame (corrupt stack?) 

next-20170426 is OK though.

Yury
