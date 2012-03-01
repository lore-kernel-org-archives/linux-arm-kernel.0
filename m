From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Mar 2012 10:12:58 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall
 number to the hypervisor
In-Reply-To: <1330526664.4270.128.camel@zakaz.uk.xensource.com>
References: <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <20120227180355.GB2023@linaro.org>
 <1330371219.10008.34.camel@dagon.hellion.org.uk>
 <20120228102040.GB2063@linaro.org>
 <1330426133.31269.70.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.00.1202281149210.23091@kaball-desktop>
 <20120229093436.GA2077@linaro.org>
 <1330509362.4270.20.camel@zakaz.uk.xensource.com>
 <20120229125826.GC2077@linaro.org>
 <1330526664.4270.128.camel@zakaz.uk.xensource.com>
Message-ID: <20120301101258.GC7363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 02:44:24PM +0000, Ian Campbell wrote:
> > If you need a specific register, this means that you must set up that
> > register explicitly inside the asm if you want a guarantee that the
> > code will work:
> > 
> > 	asm volatile (
> > 		"movw	r12, %[hvc_num]\n\t"
> 
> Is gcc (or gas?) smart enough to optimise this away if it turns out that
> %[hvc_num] == r12?

No, and it won't do, because %[hvc_num] is specified in these operands:

> > 		...
> > 		"hvc	#0"
> > 		:: [hvc_num] "i" (NUMBER) : "r12"

to be an integer, not a register.

> How are system calls implemented on the userspace side? I confess I
> don't know what the ARM syscall ABI looks like -- is it all registers or
> is some of it on the stack? It sounds like the solution ought to be
> pretty similar though.

All registers.  We have a few which take a pointer to an in memory array,
but those are for some old multiplexed syscalls.
