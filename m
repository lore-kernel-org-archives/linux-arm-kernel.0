From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 30 Jun 2014 08:59:53 -0700
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <20140628152609.GH32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk>
Message-ID: <53B18979.7050206@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2014 08:26 AM, Russell King - ARM Linux wrote:
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
>
> It seems that on ARM, we generate a dso with these symbols:
>
> DYNAMIC SYMBOL TABLE:
> 000001e4 l    d  .eh_frame_hdr	00000000              .eh_frame_hdr
> 00000000 g    DO *ABS*	00000000  LINUX_3.17  LINUX_3.17
> 000003c4 g    DF .text	00000080  LINUX_3.17  __kernel_clock_getres
> 00000444 g    DF .text	0000002c  LINUX_3.17  __kernel_gettimeofday
> 00000298 g    DF .text	0000012c  LINUX_3.17  __kernel_clock_gettime

Sorry, late to the thread.

I think that, if your function signatures match, you should give them 
the same names and versions as for x86 (i.e. LINUX_2.6, 
__vdso_clock_gettime).  Userspace will thank you.

Don't do the weak clock_gettime, etc aliases, though.  That was never a 
good idea to begin with.

--Andy
