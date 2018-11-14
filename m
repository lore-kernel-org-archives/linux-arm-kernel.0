From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Nov 2018 12:21:12 -0800
Subject: ARM builtin perf tests for breakpoint failures
Message-ID: <2433ea10-8bdc-f9bc-8d53-f6bda4018564@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Will,

I have been trying to debug some perf builtin tests on ARM 32-bit and
found that "Breakpoint overflow signal handler" and "Breakpoint overflow
sampling" were failing, but there are a number of reasons for that and
they may fail in seemingly unexpected ways.

My perf binary is built in Thumb2 because that is what the toolchain
produces by default. Going through the rabbit hole, I found the
following failure scenarios.

1) If __test_function()'s addresss has the Thumb bit set, then we set a
breakpoint length (bp_len = sizeof(long)) which makes us fail to
validate the event in hw_breakpoint_arch_parse() and we return -EINVAL
from SYS_perf_event_open(). This is because the offset computed has a
value of 1 (function address is e.g:  0x0004c169), but we requested a
bp_len of 4. The test fails right away.

2) If we correct the test such that if addr & 1 == true then we set
bp_len = 2, then we can see that the test runs to completion, but the
perf breakpoint event count returns 0 and indeed, no SIGIO is ever
delivered. This is presumably because of the alignment_mask value of 0x3
in hw_breakpoint_arch_parse() which would strip the Thumb bit and not
allow matching it when set assign info->address &= ~alignment_mask. We
would indeed not have the HW hit that breakpoint at all.

3) If we keep the fix from 2) and also change the the alignment_mask to
0x2 to preserve the Thumb bit, then we can run into what is described as
4) below.

4) if __test_function()'s address does not have the Thumb bit set (which
surprisingly can happen even if test_function does, go figure), then we
will set a bp_len = 4, and then we are just stuck in an infinite SIGIO
delivery that looks like this:

[pid  1859] perf_event_open(0xbebee790, 0, -1, -1, 0x8 /* PERF_FLAG_???
*/) = 3
[pid  1859] fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC) = 0
[pid  1859] fcntl64(3, F_SETSIG, 0x1d)  = 0
[pid  1859] fcntl64(3, F_SETOWN, 1859)  = 0
[pid  1859] ioctl(3, PERF_EVENT_IOC_RESET, 0) = 0
[pid  1859] ioctl(3, PERF_EVENT_IOC_ENABLE, 0) = 0
[pid  1859] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
[pid  1859] rt_sigreturn()

and on and on, we can't even see gettimeofday() begin called in that case.

This is observable on both 4.9.135 and 4.19 on ARMv7 and ARMv8 CPUs
running in AArch32.

I am not clear how to fix that properly, since there appears to be a
nesting of problems here.

Thanks!
-- 
Florian
