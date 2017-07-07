From: labath@google.com (Pavel Labath)
Date: Fri, 7 Jul 2017 13:37:53 +0100
Subject: [arm/hw_breakpoint] Detecting that hardware watchpoint support is
 unavailable
Message-ID: <CAJt8pk8f3Z4O=JLB8vSimAbwaAd8AqELKWJzZJF+io13Ziia6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pratyush, Will,

I have an arm(32) chip, which has hardware debug support disabled, as
far as I can tell (DBGDSCR.MDBGen reads as zero even after explicitly
setting in).

The current behavior of the kernel on these chips is to return a
non-zero number for the "number of supported watchpoint resources"
when queried with ptrace and then fail at runtime (ENODEV) when the
tracer attempts to set this breakpoint.

This does not seem like a particularly nice api, and I believe it
would be better to just return zero for the watchpoint count
initially, as we already know that setting the watchpoints will fail.

arch_hw_breakpoint_init() zeroes out the core_num_wrps when it detects
that debug support is not present, however when we return resource
info (ptrace_get_hbp_resource_info), we go through
hw_breakpoint_slots(), which does not read these.

I think having ptrace_get_hbp_resource_info() read core_num_wrps would
be more consistent because that's how we read maximum watchpoint
length (arch_get_max_wp_len), which means we (correctly ?) return 0
when hardware debug is not supported. In fact, that is how I presently
detect that hardware debug is not supported (reading max_wp_len), but
at this moment that seems more like an accident than a deliberate
interface. Having num_wrps, num_brps zeroed out as well would make it
clear that this is how it's intended to be used.

So, what do you think about a patch like that?

regards,
pavel
