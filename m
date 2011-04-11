From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Apr 2011 15:39:32 -0400 (EDT)
Subject: [PATCH] increase the use of CONFIG_VECTORS_BASE
In-Reply-To: <20110411170047.GA12509@dandreoli.com>
References: <20110411170047.GA12509@dandreoli.com>
Message-ID: <alpine.LFD.2.00.1104111509590.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Apr 2011, Domenico Andreoli wrote:

> From: Domenico Andreoli <cavokz@gmail.com>
> 
> If CONFIG_VECTORS_BASE is meant to make vectors base address
> configurable, it is not consistently used. At least in arch/arm/mm/mmu.c
> the explicit value 0xffff0000 is still widely used.
> 
> This is an attempt to improve the situation.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

NAK.

Some explanation is in order.

On CPU cores with a MMU, there are only two possibilities for the 
location of the vector page: either address 0, or address 0xffff0000.  
Some CPUs only supports the low vectors i.e. at 0.  Most others allow 
for a selection between either of those addresses using the V bit in the 
control register (see the vectors_high() macro for example).  In those 
cases replacing 0xffff0000 with CONFIG_VECTORS_BASE is the wrong thing 
to do.

Now, because the vector table and associated stubs are quite small, we 
also use the same memory page for other things such as read-only code 
segments made available to user space.  So to simplify things, the 
vector page is _always_ mapped at 0xffff0000, regardless if the CPU 
supports high vectors or not (if it doesn't then another mapping for the 
same page is installed at 0).  So also in this case it is wrong to 
substitute 0xffff0000 with CONFIG_VECTORS_BASE.

Finally, on non-MMU processors, the actual vector table is often in ROM 
and no RAM page can be mapped to the vector address because of course 
there is no MMU.  In this case, all vectors (except for the reset one) 
are usually branching to some arbitrary location in RAM to allow the 
installed software to redirect them.  This is where CONFIG_VECTORS_BASE 
really makes sense as it should be set to the address of the memory area 
that the OS can modify to hook its exception handlers.

So using CONFIG_VECTORS_BASE really depends on the context.  For shared 
code between the MMU and non-MMU cases with access to the vector page, 
then it makes sense to use CONFIG_VECTORS_BASE, and in the MMU case it 
shouldn't be set to anything other than 0xffff0000.


Nicolas
