From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 20:18:35 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <alpine.LFD.2.00.1108211435320.20358@xanadu.home>
References: <20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
Message-ID: <20110821191835.GA19678@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 03:02:25PM -0400, Nicolas Pitre wrote:
> Obviously the way to go is to use a .data variable.
> 
> And it can be referenced from assembly code in a position independent 
> manner:
> 
>         .macro  get_ptr_pic, ptr, symbol
>         b       199f
>         .align
> 198:    .long   .
>         .long   \symbol
> 199:    adr     \ptr, 198b              @ get relative address of 198b
>         ldr     ip, [\ptr]              @ get absolute address of 198b
>         sub     ip, ip, \ptr            @ offset between abs and rel
>         ldr     \ptr, [\ptr, #4]        @ absolute address of \symbol
>         sub     \ptr, \ptr, ip          @ make it relative
>         .endm

And have you checked that you can crap over 'ip' in the early assembly
code?  There are some (small) places where that register is used, which
means you accidentally corrupt that register.

> > This is just getting _idiotic_.  There are times when "no" is the word
> > which has to be used, and this is one of them.
> 
> You are saying "no" to the possibility of getting rid of the zImage 
> decompressor serial output.
>
> And now you're saying "no" to any possibility of keeping it alive in the 
> context of a multi-SOC kernel.

The decompressor has nothing to do with this.

> Are you also saying "no" to the multi-SOC kernel?  If so you'll have to 
> convince many more people than just me.

No, I am saying no to the low level debugging code which *developers*
rely upon working being fucked up and rendered useless - and so requiring
a new implementation to be written - in the name of multi-SoC support.
That is what I'm *strongly* objecting to.

The LL debug code is there *explicitly* so that it can be used to debug
the early kernel assembly and initial part of the kernel bring-up.  It
is *NOT* there for USERS.

The fact that it was tied into earlyprintk *against my better judgement*
and now its wanting to be fucked up so it can't be used for its primary
purpose just goes to prove that my original assertions at the time that
it was used for early printk have been *proven*.

So I'm now saying a very very firm NO to this further creap of it.  I am
not having its utility destroyed.

> But, just like on x86, booting a kernel binary (say, from a packaged 
> distro) on a new machine might not exactly boot satisfactorily.  And 
> this is likely to be the users who notice it first, in which case having 
> functional early serial output might be pretty handy.

Then provide a *proper* early printk implementation which doesn't involve
buggering up assembly whos purpose is to do low level assembly debugging.
