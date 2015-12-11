From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Dec 2015 18:57:26 -0500 (EST)
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <1941958.3p422lB7Mz@wuerfel>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111216350.26920@knanqh.ubzr>
 <1941958.3p422lB7Mz@wuerfel>
Message-ID: <alpine.LFD.2.20.1512111842280.26920@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Dec 2015, Arnd Bergmann wrote:

> On Friday 11 December 2015 12:22:20 Nicolas Pitre wrote:
> > Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into __aeabi_{u}idiv()
> > 
> > The ARM compiler inserts calls to __aeabi_uidiv() and
> > __aeabi_idiv() when it needs to perform division on signed and
> > unsigned integers. If a processor has support for the udiv and
> > sdiv instructions, the kernel may overwrite the beginning of those
> > functions with those instructions and a "bx lr" to get better
> > performance.
> > 
> > To ensure those functions are aligned to a 32-bit word for easier
> > patching (which might not always be the case in Thumb mode) and the
> > two patched instructions for each case are contained in the same cache
> > line, a 8-byte alignment is enforced when ARM_PATCH_IDIV is configured.
> > 
> > This was heavily inspired by a previous patch by Stephen Boyd.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

> Before you put it in the patch tracker, I think it would be good to
> give Stephen a chance to comment as well, since he did a lot of
> work upfront and this obsoletes his original patch series.

Given he'll get back from vacation only after the new year, I'll put the 
patch in the tracker now so it can go in before the next merge window.  

Stephen's series could still be relevant by extending what is done here, 
and it requires what this patch is doing anyway for those call sites 
that can't be substituted by a div instruction (like conditional 
branches, tail call optimizations, etc.)


Nicolas
