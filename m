From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 25 Mar 2010 16:47:43 +0100
Subject: PXA3xx internal SRAM
In-Reply-To: <771cded01003250558y6bf9a8b6q7fc969d448faa1df@mail.gmail.com>
References: <20100321124739.GG30801@buzzloop.caiaq.de>
	<63386a3d1003221409j63413b5o7a0515836eaa8b86@mail.gmail.com>
	<771cded01003250558y6bf9a8b6q7fc969d448faa1df@mail.gmail.com>
Message-ID: <63386a3d1003250847n3ac9e1fg5f7873bad6006af@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Haojian]

> 1. TCM may be structured as a Harvard architecture with seprate ITCM
> and DTCM. It may also be structured as a Von Neumann architecture with
> a unified TCM.

Yes and no, in that case you only have ITCM. The ARM hardware
registers have no entry for something like a unified TCM. The ITCM
can always be used for data as well, so to be precise the ITCM is
a Von Neumann arch and the DTCM is a Harvard addition, so the
sum result is a hybrid.

> It's depend on the silicon implementation. It seems
> that current implementation of tcm module is for seprated ITCM & DTCM.

You mean that in PXA3xx it's an ITCM and a DTCM and the thing
called SRAM is actually an ITCM?

> But if it's a unified TCM, we can't copy data into TCM in
> initialization since there's no DTCM.

Yeah that's true... :-/

I think it can easily be fixed with some #if FOO preprocessor
hacking in arch/arm/kernel/vmlinux.ld.S so that symbols marked
with .tcm.data are allocated to the DTCM_OFFSET is not
defined, so you only define ITCM_OFFSET and ITCM_END
for your system.

If you promise to test it, I can make a try at fixing this,
because I have no system to test it on.

> 2. All free memory of ITCM and DTCM are joined into tcm_pool. Does it
> mean that the purpose of all free memory is storing data, not
> instruction?

Dynamic data can be stored in this pool, yes.

> 3. Allocating memory could be from either ITCM or DTCM. If a piece for
> program is copied into allocated memory of DTCM, could instruction of
> this program piece be fetched from DTCM?

No. But a memory heap shall not be executable anyway, the only
scenario where this is applicable is if you want to load code into
[I|D]TCM at runtime, which is not currently supported by the API.
Code is only assigned to (I)TCM locations at compiletime.

> 4. Both ITCM and DTCM is configured as uncached. Is it necessary to
> export API to configure to cached in order to performance?

Both ITCM and DTCM if you have them, are "above" the caches.
The caches don't see them, so they must be uncached.

But don't worry: TCM memory is just as fast as cache, and will
never miss a cache line, that is why it exists :-)

> 5. ARM supports smart cache that switch the functionality between TCM
> and cache. Is it necessary to be supported by TCM module?

It is not necessary and not supported right now, but it would be cool
to have this. In that case we shouldn't free the pages used by the
TCM upload area after kernel init, instead we should keep it as a
backup storage area for TCM when it's used as cache, then switch
this back and forth when TCM is to be used.

Do you have this in your system?

I assume the only practical usage for this would be to disable a
cache and enable its use as TCM when going to sleep for example,
is this what you intend to do with your system?

> 6. In current TCM module,

Its not a module really, its a part of the core arm arch.

> reading co-processor instruction is
> contained. It means that it's closely bind to ARM TCM. In custom SoC,
> internal SRAM is just similar TCM. It doesn't support these
> co-processor instruction of acquiring region and size. What's your
> suggestion on supporting this kind of SoC in TCM module?

The TCM code is used for the TCM that is part of the ARM architecture,
it has no other intended usage.

SRAMs are typically Von Neumann type and not as complicated
as a pair of TCMs.

There are several SRAM solutions already in the kernel I think,
implemented per architecture, but no generic SRAM handler,
sadly :-(

It would be good if SRAM could be handled by a per-machine
vmlinux.ld.S file so that code can be compiled there from simple
C files, a generic include/linux/sram.h file to tag code sections properly
and something generic in the style of the TCM code
to handle the copying of code to SRAM and handling the  residual
memory pool.

Yours,
Linus Walleij
