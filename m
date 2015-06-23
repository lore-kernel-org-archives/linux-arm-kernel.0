From: dave.long@linaro.org (David Long)
Date: Tue, 23 Jun 2015 09:48:19 -0400
Subject: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
In-Reply-To: <1435030328.28070.5.camel@ellerman.id.au>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>		
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>	
 <1434687583.23771.5.camel@ellerman.id.au> <5584234E.2040701@linaro.org>
 <1435030328.28070.5.camel@ellerman.id.au>
Message-ID: <558963A3.4070503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/15 23:32, Michael Ellerman wrote:
> On Fri, 2015-06-19 at 10:12 -0400, David Long wrote:
>> On 06/19/15 00:19, Michael Ellerman wrote:
>>> On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
>>>> From: "David A. Long" <dave.long@linaro.org>
>>>>
>>>> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>>>>    feature and has identical definitions in four different arch ptrace.h
>>>> include files. It seems unlikely that definition would ever need to be
>>>> changed regardless of architecture so lets move it into
>>>> include/linux/ptrace.h.
>>>>
>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>> ---
>>>>    arch/powerpc/kernel/ptrace.c | 5 -----
>>>
>>> Built and booted on powerpc, but is there an easy way to actually test the code
>>> paths in question?
>>>
>>
>> There is an easy way to "smoke test" it on all archiectures that also
>> implement kprobes (which powerpc does).  If I'm understanding the
>> powerpc code correctly (WRT register naming conventions) just do the
>> following:
>>
>> cd /sys/kernel/debug/tracing
>> echo 'p do_fork %gpr0' > kprobe_events
>> echo 1 > events/kprobes/enable
>> ls
>> cat trace
>> echo 0 > events/kprobes/enable
>>
>> Every fork() call done on the system between those two echo commands
>> (hence the "ls") should append a line to the trace file.  For a more
>> exhaustive test one could repeat this sequence for every register in the
>> architecture.
>
> OK, so I went the whole hog and did:
>
> $ echo 'p do_fork %gpr0 %gpr1 %gpr2 %gpr3 %gpr4 %gpr5 %gpr6 %gpr7 %gpr8 %gpr9 %gpr10 %gpr11 %gpr12 %gpr13 %gpr14 %gpr15 %gpr16 %gpr17 %gpr18 %gpr19 %gpr20 %gpr21 %gpr22 %gpr23 %gpr24 %gpr25 %gpr26 %gpr27 %gpr28 %gpr29 %gpr30 %gpr31 %nip %msr %ctr %link %xer %ccr %softe %trap %dar %dsisr' > kprobe_events
>
> And I get:
>
>              bash-2057  [001] d...   535.433941: p_do_fork_0: (do_fork+0x8/0x490) arg1=0xc0000000000094d0 arg2=0xc0000001fbe9be30 arg3=0xc000000001133bb8 arg4=0x1200011 arg5=0x0 arg6=0x0 arg7=0x0 arg8=0x3fff7c885940 arg9=0x1 arg10=0xc0000001fbe9bea0 arg11=0x0 arg12=0xc01 arg13=0xc0000000000094c8 arg14=0xc00000000fdc0480 arg15=0x0 arg16=0x22000000 arg17=0x1016d6e8 arg18=0x0 arg19=0x44000000 arg20=0x0 arg21=0x10037c82208 arg22=0x1017b008 arg23=0x10143d18 arg24=0x10178854 arg25=0x10144f90 arg26=0x10037c821e8 arg27=0x0 arg28=0x0 arg29=0x0 arg30=0x0 arg31=0x809 arg32=0x3ffff788c010 arg33=0xc0000000000a7fe8 arg34=0x8000000000029033 arg35=0xc0000000000094c8 arg36=0xc0000000000094d0 arg37=0x0 arg38=0x42222844 arg39=0x1 arg40=0x700 arg41=0xc0000001fbe9bd50 arg42=0xc0000001fbe9bd30
>
> Which is ugly as hell, but appears unchanged since before your patch.
>

Excellent.  Many thanks.

> I take it it's expected that the names are not decoded in the output?
>

Yes.

> Also I wonder why we choose "gpr" when "r" is the more usual prefix on powerpc.
> I guess we can add new aliases to the table.
>

Yeah I can't answer that, this is just what the preexisting code is 
written to do. I believe you could add aliases to the table, perhaps as 
a step in migrating to supporting only the more common naming.  The 
reverse translation would have to return one or the other though.

-dl
