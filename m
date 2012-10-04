From: robherring2@gmail.com (Rob Herring)
Date: Thu, 04 Oct 2012 18:10:26 -0500
Subject: alignment faults in 3.6
Message-ID: <506E1762.3010601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been scratching my head with a "scheduling while atomic" bug I
started seeing on 3.6. I can easily reproduce this problem when doing a
wget on my system. It ultimately seems to be a combination of factors.
The "scheduling while atomic" bug is triggered in do_alignment which
gets triggered by this code in net/ipv4/af_inet.c, line 1356:

id = ntohl(*(__be32 *)&iph->id);
flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id ^ IP_DF));
id >>= 16;

This code compiles into this using "gcc version 4.6.3 (Ubuntu/Linaro
4.6.3-1ubuntu5)":

c02ac020:       e8920840        ldm     r2, {r6, fp}
c02ac024:       e6bfbf3b        rev     fp, fp
c02ac028:       e6bf6f36        rev     r6, r6
c02ac02c:       e22bc901        eor     ip, fp, #16384  ; 0x4000
c02ac030:       e0266008        eor     r6, r6, r8
c02ac034:       e18c6006        orr     r6, ip, r6

which generates alignment faults on the ldm. These are silent until this
commit is applied:

commit ad72907acd2943304c292ae36960bb66e6dc23c9
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri Sep 7 18:24:10 2012 +0100

    ARM: 7528/1: uaccess: annotate [__]{get,put}_user functions with
might_fault()

    The user access functions may generate a fault, resulting in invocation
    of a handler that may sleep.

    This patch annotates the accessors with might_fault() so that we print a
    warning if they are invoked from atomic context and help lockdep keep
    track of mmap_sem.


I would think the scheduling while atomic messages are harmless in this
case. However, in addition to spewing out BUG messages this commit also
seems to eventually cause a kernel panic in __napi_complete. That panic
seems to go away if I put barrier() between the 2 accesses above which
eliminates the alignment faults. I haven't figured that part out yet.

There's at least a couple of problems here:

This seems like an overly aggressive compiler optimization considering
unaligned accesses are not supported by ldm/stm.

The alignment fault handler should handle kernel address faults atomically.

I need to fix alignment of the network rx buffers if possible.

Rob
