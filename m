From: dave.long@linaro.org (David Long)
Date: Fri, 19 Jun 2015 10:12:30 -0400
Subject: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
In-Reply-To: <1434687583.23771.5.camel@ellerman.id.au>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>	
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
 <1434687583.23771.5.camel@ellerman.id.au>
Message-ID: <5584234E.2040701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/15 00:19, Michael Ellerman wrote:
> On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>>   feature and has identical definitions in four different arch ptrace.h
>> include files. It seems unlikely that definition would ever need to be
>> changed regardless of architecture so lets move it into
>> include/linux/ptrace.h.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/powerpc/kernel/ptrace.c | 5 -----
>
> Built and booted on powerpc, but is there an easy way to actually test the code
> paths in question?
>

There is an easy way to "smoke test" it on all archiectures that also 
implement kprobes (which powerpc does).  If I'm understanding the 
powerpc code correctly (WRT register naming conventions) just do the 
following:

cd /sys/kernel/debug/tracing
echo 'p do_fork %gpr0' > kprobe_events
echo 1 > events/kprobes/enable
ls
cat trace
echo 0 > events/kprobes/enable

Every fork() call done on the system between those two echo commands 
(hence the "ls") should append a line to the trace file.  For a more 
exhaustive test one could repeat this sequence for every register in the 
architecture.

This should work the same on all architectures supporting kprobes.  You 
just have to use the appropriate register names for your architecture 
after the "%".

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers
>
>

Thanks,
-dl
