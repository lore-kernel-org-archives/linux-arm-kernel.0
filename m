From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 2 May 2017 10:26:18 -0700
Subject: [PATCH] arm64: Fix multiple 'asm-operand-widths' warnings
In-Reply-To: <20170502102718.GA28132@leverpostej>
References: <20170501212622.153720-1-mka@chromium.org>
 <20170502102718.GA28132@leverpostej>
Message-ID: <20170502172618.GX128305@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

El Tue, May 02, 2017 at 11:27:18AM +0100 Mark Rutland ha dit:

> On Mon, May 01, 2017 at 02:26:22PM -0700, Matthias Kaehlcke wrote:
> > clang raises 'asm-operand-widths' warnings in inline assembly code when
> > the size of an operand is < 64 bits and the operand width is unspecified.
> > Most warnings are raised in macros, i.e. the datatype of the operand may
> > vary. Forcing the use of an x register through the 'x' operand modifier
> > would silence the warning however it involves the risk that for operands
> > < 64 bits 'unused' bits may be assigned to 64-bit values (more details at
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503816.html).
> > Instead we cast the operand to 64 bits, which also forces the use of a
> > x register, but without the unexpected behavior.
> > 
> > In gic_write_bpr1() use write_sysreg_s() to write the register. This
> > aligns the functions with others in this header and fixes an
> > 'asm-operand-widths' warning.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm64/include/asm/arch_gicv3.h  | 2 +-
> >  arch/arm64/include/asm/barrier.h     | 2 +-
> >  arch/arm64/include/asm/uaccess.h     | 2 +-
> >  arch/arm64/kernel/armv8_deprecated.c | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> Thanks for putting this together.
> 
> Just to check, are these the only instances that you see clang warning
> about?

Yes, these are the only warnings clang raises in my builds (custom and
defconfig).

> There are a number of other cases where we can see similar problems
> (e.g. passing a u8 value to an smp_store_release() on a u32 variable),
> so we need to fix more than the clang warnings.
> 
> I'm currently attempting a systematic audit of our inline asm to correct
> all instances, looking at:
> 
> 	git grep -e asm \
> 	--and --not -e 'include' \
> 	--and --not -e 'asmlinkage' \
> 	-- arch/arm64
> 
> I hope to have patches shortly, and will keep you informed.

Sounds good!

Thanks

Matthias
