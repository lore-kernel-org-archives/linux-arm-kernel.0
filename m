From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Sat, 28 Jun 2014 11:13:42 -0500
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <20140628152609.GH32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk>
Message-ID: <53AEE9B6.7000609@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2014 10:26 AM, Russell King - ARM Linux wrote:
> On Sun, Jun 22, 2014 at 10:11:56PM -0500, Nathan Lynch wrote:
>> Place vdso-related user-space code in arch/arm/kernel/vdso/.
>>
>> It is almost completely written in C with some assembly helpers to
>> load the data page address, sample the counter, and fall back to
>> system calls when necessary.
>>
>> If CONFIG_ARM_ARCH_TIMER is not enabled, the vdso cannot service
>> high-resolution clocks and falls back to syscalls.  Low-resolution
>> clocks e.g. CLOCK_REALTIME_COARSE can be serviced regardless.
> 
> Okay, how is this used by userspace?

Primarily it's intended to be transparent to userspace applications;
glibc -- with a patch -- detects the VDSO at startup and binds the
appropriate routines to the VDSO's.

However, even an unpatched glibc makes the VDSO symbols available for
lookup via dlsym, which has been convenient for testing.


> It seems that on ARM, we generate a dso with these symbols:
> 
> DYNAMIC SYMBOL TABLE:
> 000001e4 l    d  .eh_frame_hdr	00000000              .eh_frame_hdr
> 00000000 g    DO *ABS*	00000000  LINUX_3.17  LINUX_3.17
> 000003c4 g    DF .text	00000080  LINUX_3.17  __kernel_clock_getres
> 00000444 g    DF .text	0000002c  LINUX_3.17  __kernel_gettimeofday
> 00000298 g    DF .text	0000012c  LINUX_3.17  __kernel_clock_gettime
> 
> whereas, x86-64 generates this:
> 
> DYNAMIC SYMBOL TABLE:
> ffffffffff700330 l    d  .eh_frame_hdr	0000000000000000              .eh_frame_hdr
> ffffffffff700600  w   DF .text	00000000000002b9  LINUX_2.6   clock_gettime
> 0000000000000000 g    DO *ABS*	0000000000000000  LINUX_2.6   LINUX_2.6
> ffffffffff7008c0 g    DF .text	000000000000015a  LINUX_2.6   __vdso_gettimeofday
> ffffffffff700a40 g    DF .text	000000000000003d  LINUX_2.6   __vdso_getcpu
> ffffffffff7008c0  w   DF .text	000000000000015a  LINUX_2.6   gettimeofday
> ffffffffff700a20  w   DF .text	0000000000000016  LINUX_2.6   time
> ffffffffff700a40  w   DF .text	000000000000003d  LINUX_2.6   getcpu
> ffffffffff700600 g    DF .text	00000000000002b9  LINUX_2.6   __vdso_clock_gettime
> ffffffffff700a20 g    DF .text	0000000000000016  LINUX_2.6   __vdso_time
> 
> hence references to gettimeofday automatically get resolved to the
> vdso version without needing C library updates.

Hmm, I'm not sure.  I had wondered why x86-64's vdso has the aliases
(clock_gettime --> __vdso_clock_gettime).  Most other architectures'
VDSOs don't.


> Or... do we need a glibc update to make use of this?

That is the idea, yes.  You don't have to rebuild applications but glibc
needs to be updated to dispatch its gettimeofday and clock_gettime to
the VDSO.

I'm in the process of refreshing and re-testing that patch.  I posted an
RFC to libc-alpha a few months back:

https://www.sourceware.org/ml/libc-alpha/2014-02/msg00680.html

I should have a new one posted within a couple days.
