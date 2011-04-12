From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 12 Apr 2011 10:00:22 +0100
Subject: [PATCH] increase the use of CONFIG_VECTORS_BASE
In-Reply-To: <alpine.LFD.2.00.1104111509590.28032@xanadu.home>
References: <20110411170047.GA12509@dandreoli.com>
	<alpine.LFD.2.00.1104111509590.28032@xanadu.home>
Message-ID: <BANLkTim4VAiVmiTRHb1cj=VGeyyUk5aZ2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 8:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 11 Apr 2011, Domenico Andreoli wrote:
>
>> From: Domenico Andreoli <cavokz@gmail.com>
>>
>> If CONFIG_VECTORS_BASE is meant to make vectors base address
>> configurable, it is not consistently used. At least in arch/arm/mm/mmu.c
>> the explicit value 0xffff0000 is still widely used.
>>
>> This is an attempt to improve the situation.
>>
>> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
>
> NAK.
>
> Some explanation is in order.
>
> On CPU cores with a MMU, there are only two possibilities for the
> location of the vector page: either address 0, or address 0xffff0000.
> Some CPUs only supports the low vectors i.e. at 0. ?Most others allow
> for a selection between either of those addresses using the V bit in the
> control register (see the vectors_high() macro for example). ?In those
> cases replacing 0xffff0000 with CONFIG_VECTORS_BASE is the wrong thing
> to do.
>
> Now, because the vector table and associated stubs are quite small, we
> also use the same memory page for other things such as read-only code
> segments made available to user space. ?So to simplify things, the
> vector page is _always_ mapped at 0xffff0000, regardless if the CPU
> supports high vectors or not (if it doesn't then another mapping for the
> same page is installed at 0). ?So also in this case it is wrong to
> substitute 0xffff0000 with CONFIG_VECTORS_BASE.
>
> Finally, on non-MMU processors, the actual vector table is often in ROM
> and no RAM page can be mapped to the vector address because of course
> there is no MMU. ?In this case, all vectors (except for the reset one)
> are usually branching to some arbitrary location in RAM to allow the
> installed software to redirect them. ?This is where CONFIG_VECTORS_BASE
> really makes sense as it should be set to the address of the memory area
> that the OS can modify to hook its exception handlers.
>
> So using CONFIG_VECTORS_BASE really depends on the context. ?For shared
> code between the MMU and non-MMU cases with access to the vector page,
> then it makes sense to use CONFIG_VECTORS_BASE, and in the MMU case it
> shouldn't be set to anything other than 0xffff0000.
>

Since v6Z (i.e., including arm1176 and all v7-A processors), there is
a cp15 vector base address register for MMU-enabled CPUs, allowing the
vectors to be placed anywhere (32-byte aligned) in the virtual address
space.

This was introduced as part of the v6 security extensions, since the
Secure World needs two vector tables for its own use and therefore a
single default location isn't enough; but as a consequence the Normal
World can move its vector table too.  The high vectors configuration
input to the core only determines the default vectors location at boot
in this case.

Moving the actual vectors could be useful from an address space layout
randomisation point of view.  But unfortunately, although the vectors
themselves could be moved, the rest of the contents of the vectors
page must probably stay where it is -- with no VDSO, userspace code is
riddled with hard-coded references to 0xffff0000 to call the kuser
helpers etc.

Cheers
---Dave
