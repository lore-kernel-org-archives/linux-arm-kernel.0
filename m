From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 15:15:26 +0000
Subject: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Message-ID: <20150309151526.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:19:43PM -0800, Kees Cook wrote:
> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

I've run this on one of my ARM platforms, and it looks fine.

2a05e000-2a05f000 r-xp 00000000 00:10 7750376    /root/offset2lib/get_offset2lib
2a066000-2a067000 r--p 00000000 00:10 7750376    /root/offset2lib/get_offset2lib
2a067000-2a068000 rw-p 00001000 00:10 7750376    /root/offset2lib/get_offset2lib
b6dfd000-b6ed3000 r-xp 00000000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6ed3000-b6eda000 ---p 000d6000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6eda000-b6edc000 r--p 000d5000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6edc000-b6edd000 rw-p 000d7000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6edd000-b6ee0000 rw-p 00000000 00:00 0
b6ef9000-b6f10000 r-xp 00000000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
b6f13000-b6f17000 rw-p 00000000 00:00 0
b6f17000-b6f18000 r--p 00016000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
b6f18000-b6f19000 rw-p 00017000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
bea3b000-bea5c000 rw-p 00000000 00:00 0          [stack]
bec22000-bec23000 r-xp 00000000 00:00 0          [sigpage]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]

And offset2lib shows a random offset:

Offset2lib (libc): 0xffffffff73261000
Offset2lib (libc): 0xffffffff732ce000
Offset2lib (libc): 0xffffffff731b1000
Offset2lib (libc): 0xffffffff73252000

So, for ARM:

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
