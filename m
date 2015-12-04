From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 16:18:10 +0000
Subject: [PATCH v8 1/4] arm64: Store struct task_info in sp_el0
In-Reply-To: <5661A950.7090009@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-2-git-send-email-james.morse@arm.com>
 <20151204132743.GH10123@e104818-lin.cambridge.arm.com>
 <5661A950.7090009@arm.com>
Message-ID: <20151204161810.GN10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 02:55:12PM +0000, James Morse wrote:
> Hi Catalin,
> 
> On 04/12/15 13:27, Catalin Marinas wrote:
> > On Fri, Dec 04, 2015 at 11:02:25AM +0000, James Morse wrote:
> >> --- a/arch/arm64/kernel/entry.S
> >> +++ b/arch/arm64/kernel/entry.S
> > [...]
> >> @@ -599,6 +606,8 @@ ENTRY(cpu_switch_to)
> >>  	ldp	x29, x9, [x8], #16
> >>  	ldr	lr, [x8]
> >>  	mov	sp, x9
> >> +	and	x9, x9, #~(THREAD_SIZE - 1)
> >> +	msr	sp_el0, x9
> >>  	ret
> >>  ENDPROC(cpu_switch_to)
> > 
> > At the beginning of the cpu_switch_to function, could we do
> > "mrs x9, sp_el0" instead to avoid the "and ... ~(THREAD_SIZE-1)"?
> 
> I'm not sure I follow - are you suggesting to store struct thread_info
> in the thread_cpu_context?

I was thinking of context switching sp_el0 as well but see below.

> This would change a ldr to a ldp, and save the 'and', so its definitely
> fewer instructions.

I think we end up with an additional memory access, which is usually
more expensive than arithmetic ops. So just leave it as it is.

-- 
Catalin
