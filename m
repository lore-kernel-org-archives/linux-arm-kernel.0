From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Dec 2011 16:44:40 +0000
Subject: [Android-virt] [Embeddedxen-devel] [Xen-devel] [ANNOUNCE] Xen
 port to Cortex-A15 / ARMv7 with virt extensions
In-Reply-To: <20111201160241.GH27394@arm.com>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <201112011542.19377.arnd@arndb.de> <20111201160241.GH27394@arm.com>
Message-ID: <201112011644.41101.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 December 2011, Catalin Marinas wrote:
> On Thu, Dec 01, 2011 at 03:42:19PM +0000, Arnd Bergmann wrote:
> > On Thursday 01 December 2011, Catalin Marinas wrote:
> > How do you deal with signed integer arguments passed into SVC or HVC from
> > a caller? If I understand the architecture correctly, the upper
> > halves of the argument register end up zero-padded, while the callee
> > expects sign-extension.
> 
> If you treat it as an "int" (32-bit) and function prototype defined
> accordingly, then the generated code only accesses it as a W (rather
> than X) register and the top 32-bit part is ignored (no need for
> sign-extension). If it is defined as a "long" in the 32-bit world, then
> it indeed needs explicit conversion given the different sizes for long
> (for example sys_lseek, the second argument is a 'long' and we do
> explicit sign extension in the wrapper).

Ok, so it's actually different from most other 64 bit architectures, which
normally operate on 64-bit registers and expect the caller to do the
correct sign-extension.

Doing the sign-extension for long arguments then falls into the same
category as long long and unsigned long long arguments, which also need
a wrapper, as you mentioned. Strictly speaking, we only need to do it
for those where the long argument has a meaning outside of the 0..2^31
range, e.g. io_submit can only take small positive numbers although
the type is 'long'.

What about unsigned long and pointer? Can we always rely on the upper
half of the register to be zero-filled when we get an exception from 32
bit into 64 bit state, or do we also have to zero-extend those?

	Arnd
