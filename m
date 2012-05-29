From: bill4carson@gmail.com (bill4carson)
Date: Tue, 29 May 2012 13:28:11 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <20120511085150.GA17453@mudshark.cambridge.arm.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
Message-ID: <4FC45E6B.2070202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?05?11? 16:51, Will Deacon wrote:
> Bill,
>
> On Wed, May 09, 2012 at 10:11:05AM +0100, bill4carson wrote:
>> I'm using ARM11 MPCore on linux-2.6.34, unfortunately I have random
>> panic/segment fault with task migration. I noticed a patch set
>> [ARM11 MPCore: preemption/task migration cache coherency fixups] to fix
>> such issues in here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069851.html
>>
>> It seems there is no follow ups, is there official patch to fix such
>> issues?
>
> Let's be honest: you haven't given us a lot to go on here. Perhaps you could
> answer the following?
>
> (1) Do you experience the same issues with a more recent kernel?
> (2) If you apply the patches linked to above, does it fix your problem?
> (3) If you can reproduce on current mainline, do you have a testcase?
> (4) Does disabling CONFIG_PREEMPT make the problem disappear?
>
> That should provide us with some information about the problem.
>



Based on the limitation of CP15 of ARM11 MPCore:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dai0228a/index.html

The ARM11 MPCore SCU does not handle coherency consequences of CP15 
cache operations like clean and invalidate. If these operations are 
performed on one CPU, they do not affect the state of a cache line on a 
different CPU.  This can result in unexpected behavior if, say, a line 
is cleaned/invalidated but a subsequent access hits a stale copy in 
another CPU?s L1 through snooping the ?coherency domain?.

Kernel option CONFIG_DMA_CACHE_RWFO was introduced to fix it. details 
see arch/arm/mm/cache-v6.S:
...
#ifdef CONFIG_DMA_CACHE_RWFO
         ldr     r2, [r0]                        @ read for ownership
         str     r2, [r0]                        @ write for ownership
#endif
...

I think:
1) The similar protection was not added on data cache handlers like 
v6_coherent_kern_range and v6_flush_kern_cache_all.


Here I modified v6_coherent_kern_range as:
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -170,6 +170,10 @@ ENDPROC(v6_coherent_kern_range)
  ENTRY(v6_flush_kern_dcache_area)
         add     r1, r0, r1
  1:
+#ifdef CONFIG_SMP
+       ldr     r2, [r0]                        @ read for ownership
+       str     r2, [r0]                        @ write for ownership
+#endif /* CONFIG_SMP */
  #ifdef HARVARD_CACHE
         mcr     p15, 0, r0, c7, c14, 1          @ clean & invalidate D line
  #else

But I have no idea on how to accomplish the v6_flush_kern_cache_all, 
maybe IPI is needed?

Any opinions?

And, with this little patch above, a strange issue on my side did 
*disappeared*. The issue is when enable task migration, some strange 
error may occurred like Segmentation fault and:

*** glibc detected *** cat: munmap_chunk(): invalid pointer: 0xbeaa0f13 ***

[10870.314465] Unhandled fault: alignment exception (0x821) at 0xebfffee6
[10870.315347] Unhandled fault: alignment exception (0x821) at 0xebfffee6
[10870.354917] Unhandled fault: alignment exception (0x821) at 0xebfffee6

cat: invalid number 'cat'
cat: invalid number 'cat'
cat: invalid number 'cat'
cat: invalid number 'cat'

cat: ????: No such file or directory
cat: ????: No such file or directory

cat: can't open ' ?*?D?_?f?o?|???????????': No such file or directory
cat: applet not found

cat: (null): Invalid argument

cat: (null): Bad address
cat: (null): Bad address

cat: o??o??: No such file or directory
cat: applet not found
cat: ??????: No such file or directory

cat: unknown user /busybox

cat: ??????: No such file or directory
cat: applet not found

cat: ???$???: Bad address
cat: ???
???: Bad address
cat: ??
??: Bad address

[13758.255564] Alignment trap: not handling instruction e1a00001 at
[<00033e38>]
[13758.256459] Alignment trap: not handling instruction e1a00001 at
[<00033e38>]
[13758.256522] Unhandled fault: alignment exception (0x811) at 0x0019f1aa
[13758.319272] Alignment trap: not handling instruction e1a00001 at
[<00033e38>]
[13758.340860] Unhandled fault: alignment exception (0x811) at 0x0019f1aa
[13758.361612] Unhandled fault: alignment exception (0x811) at 0x0019f1aa




-- 
Love each day!

--bill
