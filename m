From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 6 Apr 2016 01:44:12 +0300
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64 - LTP results
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160405224412.GA18300@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are about 20 failing tests of 782 in lite scenario.
float_bessel 
float_exp_log
float_iperb
float_power
float_trigo
pipeio_1         
pipeio_3         
pipeio_5         
pipeio_8         
abort01          
clone02          
kill11           
mmap16           
open12           
pause01
rename11         
rmdir02          
umount2_01       
umount2_02       
umount2_03       
utime06          
mtest06          

The list is rough because some tests fail not every time.

Tests abort01 and kill11 fail for lp64 too, so maybe there's
a reason unrelated to ilp32 itself.

float_xxx tests fail because they call unwind() from signal context,
and GCC for ilp32 has problem with it, as Andrew told.

pipeio_x tests are very unstable and may fail randomly. I strongly
suspect race conditions, as they all work like a charm if pinned to
single CPU with taskset. Probably, race is the reason of clone02 too.
Though I'm not sure, is the race in kernel, glibc or test itself.

But I know for sure that pause01 fails due to test design:
	if (setitimer(ITIMER_REAL, &it, NULL)) // For 1000us
		tst_brkm(TBROK | TERRNO, NULL, "setitimer() failed");

	TEST(pause());

As setitimer() and pause() calls are not atomic, alarm may come before pause()
is called, and be silently dropped by the handler. Next pause() call hangs
test forever. I already reported to LTP list.

open12, rename11, rmdir02, mmap16, mtest06 - all call mkfs tool, and it returns
error code. I didn't investigate it much yet.

umount02_x, utime06 - cannot reproduce out of scenario, even run it in infinite
loop - they work fine.

Full test log is attached.

Yury
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ltplite.tar.gz
Type: application/gzip
Size: 57919 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160406/aa4e3840/attachment-0001.gz>
