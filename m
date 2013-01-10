From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jan 2013 16:57:53 +0000
Subject: [PATCH v4 07/19] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <50EED264.1020709@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-8-git-send-email-robherring2@gmail.com>
 <20130110110205.GC19944@n2100.arm.linux.org.uk> <50EED264.1020709@gmail.com>
Message-ID: <20130110165753.GF19944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 08:38:28AM -0600, Rob Herring wrote:
> On 01/10/2013 05:02 AM, Russell King - ARM Linux wrote:
> > On Thu, Jan 03, 2013 at 11:54:16AM -0600, Rob Herring wrote:
> >> -asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> >> +static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> > 
> > NAK.  No, not "static asmlinkage".
> 
> Okay will remove asmlinkage, but is there an issue with making this static?

No, just for the asmlinkage.  asmlinkage is used to mark functions which
are called from assembly.  Making them static generally means you can't
call them from assembly (unless you have asm() code in the .c file which
does, like our kernel_thread() implementation used to).

Ok, asmlinkage on ARM is a no-op, but it's useful cheap documentation to
mark which C functions get called from assembly.
