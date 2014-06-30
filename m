From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 30 Jun 2014 14:33:26 -0700
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <20140629160751.GQ32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk> <53AEE9B6.7000609@mentor.com>
 <20140628181212.GJ32514@n2100.arm.linux.org.uk> <53AF1B65.5000904@mentor.com>
 <20140628201120.GK32514@n2100.arm.linux.org.uk> <53AF3510.7030707@mentor.com>
 <20140629083415.GL32514@n2100.arm.linux.org.uk> <53B0353D.1080705@mentor.com>
 <20140629160751.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <53B1D7A6.3060604@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2014 09:07 AM, Russell King - ARM Linux wrote:
> On Sun, Jun 29, 2014 at 10:48:13AM -0500, Nathan Lynch wrote:
>> On 06/29/2014 03:34 AM, Russell King - ARM Linux wrote:
>>> On Sat, Jun 28, 2014 at 04:35:12PM -0500, Nathan Lynch wrote:
>>>> That's consistent with my results on iMX6.  The reported 1.00x "speedup"
>>>> for clock-gettime-monotonic etc indicates the VDSO is falling back to
>>>> syscall.
>>>>
>>>> Thanks for testing.
>>>
>>> Here's another issue which cropped up when I ran this patch set through
>>> the autobuilder last night - allnoconfig's now fail with:
>>>
>>> mm/memory.c: In function 'gate_vma_init':
>>> mm/memory.c:3410:22: error: 'FIXADDR_USER_START' undeclared (first use in this function)
>>> mm/memory.c:3411:20: error: 'FIXADDR_USER_END' undeclared (first use in this function)
>>> mm/memory.c: In function 'in_gate_area_no_mm':
>>> mm/memory.c:3432:15: error: 'FIXADDR_USER_START' undeclared (first use in this function)
>>> mm/memory.c:3432:46: error: 'FIXADDR_USER_END' undeclared (first use in this function)
>>> make[2]: *** [mm/memory.o] Error 1
>>
>> arch/arm/include/page.h:
>> #ifdef CONFIG_KUSER_HELPERS
>> #define __HAVE_ARCH_GATE_AREA 1
>> #endif
>>
>> mm/memory.c:
>> #if !defined(__HAVE_ARCH_GATE_AREA)
>>
>> #if defined(AT_SYSINFO_EHDR)
>> static struct vm_area_struct gate_vma;
>>
>> static int __init gate_vma_init(void)
>> {
>> 	gate_vma.vm_mm = NULL;
>> 	gate_vma.vm_start = FIXADDR_USER_START;
>> 	gate_vma.vm_end = FIXADDR_USER_END;
>> ...
>>
>> The vdso patches add an ARM definition for AT_SYSINFO_EHDR.  So when
>> CONFIG_KUSER_HELPERS=n, this code is pulled in now...
>>
>> Not sure what the fix would be right now.  I don't understand why there
>> is this relationship between AT_SYSINFO_EHDR and gate vma code.
> 
> Me neither.  It looks like changing those tests for AT_SYSINFO_EHDR to
> something like __HAVE_GATE_VMA or CONFIG_HAVE_GATE_VMA would be a good
> step, so we can keep this disabled on ARM.  I don't see a need for the
> gate VMA stuff just because we have a vDSO.
> 

The code you're running into is mostly bogus.  I'm planning on resending
a real fix in about five minutes.  I'll see if I can get hpa to pick it
up in a couple days (or to tell me whos tree it should live in).

I'd actually prefer if you rebase on top of it, because otherwise I'll
have to undo whatever hack you add.

--Andy
