From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jan 2013 20:30:55 +0000
Subject: [PATCH v4 07/19] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <20130110165753.GF19944@n2100.arm.linux.org.uk>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <50EED264.1020709@gmail.com> <20130110165753.GF19944@n2100.arm.linux.org.uk>
Message-ID: <201301102030.55736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013, Russell King - ARM Linux wrote:
> On Thu, Jan 10, 2013 at 08:38:28AM -0600, Rob Herring wrote:
> > On 01/10/2013 05:02 AM, Russell King - ARM Linux wrote:
> > > On Thu, Jan 03, 2013 at 11:54:16AM -0600, Rob Herring wrote:
> > >> -asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> > >> +static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> > > 
> > > NAK.  No, not "static asmlinkage".
> > 
> > Okay will remove asmlinkage, but is there an issue with making this static?
> 
> No, just for the asmlinkage.  asmlinkage is used to mark functions which
> are called from assembly.  Making them static generally means you can't
> call them from assembly (unless you have asm() code in the .c file which
> does, like our kernel_thread() implementation used to).
> 
> Ok, asmlinkage on ARM is a no-op, but it's useful cheap documentation to
> mark which C functions get called from assembly.

But with patches 6 and 12, we just pass the function pointer into
set_handle_irq(), which allows us to make the function itself
static, but it will still get called from assembly through that
function pointer, which matches the definition of asmlinkage
as far as I can tell.

	Arnd
