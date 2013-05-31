From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 30 May 2013 23:54:56 -0400 (EDT)
Subject: A bug about system call on ARM
In-Reply-To: <20130530114112.GH7483@mudshark.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D1610991B85B@CNBJMBX05.corpusers.net>
 <CAFLxGvy39xWdZmtiVHP+y=zH1coCVmMuREcmD25wSb=w-VK7Xg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D1610991B85D@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
 <CAFLxGvyy=73dGQqG8W6SXZah7WQZ4gJAeeHXN8opKaOuG-5yUQ@mail.gmail.com>
 <20130529094826.GD13095@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1305302319430.30828@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Will Deacon wrote:

> On Thu, May 30, 2013 at 10:09:49AM +0100, Will Deacon wrote:
> > On Thu, May 30, 2013 at 02:41:42AM +0100, Wang, Yalin wrote:
> > > If you have some patch for this issue,
> > > I can do the test for it .
> > 
> > I'll have a look at cooking something which uses an exception table entry
> > to rewind the PC and retry the system call. That's simpler than directly
> > injecting a user page fault from the system call path.
> 
> Ok, please can you try the following?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index bc5bc0a..855926e 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -361,6 +361,15 @@ ENTRY(vector_swi)
>  	str	r8, [sp, #S_PSR]		@ Save CPSR
>  	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
>  	zero_fp
> +	enable_irq
> +	ct_user_exit
> +
> +#ifdef CONFIG_ALIGNMENT_TRAP
> +	ldr	ip, __cr_alignment
> +	ldr	ip, [ip]
> +	mcr	p15, 0, ip, c1, c0		@ update control register
> +#endif

This is wrong.  you must set up the align bit in the control register 
_before_ enabling IRQs or an IRQ handler might run without alignment 
fixup.

Otherwise the patch looks good to me.


Nicolas
