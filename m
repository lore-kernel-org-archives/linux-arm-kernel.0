From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 26 Nov 2010 13:31:15 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101126130010.GO9310@n2100.arm.linux.org.uk>
References: <1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<4CEE6AB1.7090404@ti.com>
	<20101125165048.GA2367@n2100.arm.linux.org.uk>
	<4CEF9B8D.3010106@ti.com>
	<20101126114509.GL9310@n2100.arm.linux.org.uk>
	<20101126122811.GM9310@n2100.arm.linux.org.uk>
	<1290775134.15771.42.camel@e102109-lin.cambridge.arm.com>
	<20101126130010.GO9310@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinOJ9T9_i=Vg6qKhDM8SXgzZYtUBxq0Dx1Pi5Vx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 1:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 26, 2010 at 12:38:54PM +0000, Catalin Marinas wrote:
>> On Fri, 2010-11-26 at 12:28 +0000, Russell King - ARM Linux wrote:
>> > On Fri, Nov 26, 2010 at 12:22:15PM -0000, Will Deacon wrote:
>> > > Hi Russell,
>> > >
>> > > > $ arm-linux-as -v -o /dev/null /dev/null
>> > > > GNU assembler version 2.19.1 (arm-linux) using BFD version (GNU Binutils) 2.19.1
>> > > > $ arm-linux-as -march=armv6 -mfloat-abi=soft -meabi=5 -march=armv7-a -o /dev/null t.s
>> > > > $ arm-linux-as -march=armv6 -mfloat-abi=soft -meabi=5 -o /dev/null t.s
>> > > > t.s: Assembler messages:
>> > > > t.s:1: Error: selected processor does not support `ldrexb r7,[r6]'
>> > > >
>> > > > So it looks like someone's changed the behaviour of the assembler so it's
>> > > > no longer possible to override the -march= argument from the gcc frontend.
>> > > >
>> > > > Maybe Will can shed some light on this?
>> > >
>> > > Well we pass -march=armv6 to GCC and -march=v7-a to the assembler using the -Wa
>> > > option. This means that the compiler generates a .arch armv6 directive in the .s
>> > > file and the assembler barfs.
>> > >
>> > > Please can you try this patch?
>> >
>> > We can't do this - we'll end up running ARMv7 code on ARMv6 CPUs.
>>
>> An alternative would be to add the '.arch armv7-a' in the inline
>> assembly in swp_emulate.c. But that's an ugly workaround and you can't
>> revert to the previous .arch unless you add another '.arch armv6' at the
>> end of the asm (with lots of #ifdef's).
>
> Yup, so this won't work either. ?Also, as I understand it, I don't think
> you can rely upon the compiler ordering functions wrt. asm() statements
> outside of the function blocks, so I don't think this will work anyway.

The compiler treats inline asms as solid lumps, so providing that the
two .arch directives are inside the affected inline asm block, it
should work.

What you presumably can't do reliably is something like

#include <...>
#include <...>

asm(".arch armv7-a");

...

{
    asm( v7-dependent code )
}

> We could separate out the non-ARMv7 specific code into a separate file
> (maybe called swp_emulate-init.c) and export proc_read_status and swp_hook
> into the global namespace. ?These would have to be renamed to avoid any
> possible clashes with other symbols.
>
> We could just take the view that we don't allow SWP on ARMv7 at all,
> which would make it a pain for userspace people.
>
> We could also re-enable SWP support on ARMv7 without the emulation code.
>
> Luckily, this is the only place - at present - where we have C code built
> containing instructions (via asm() statements) for higher versions of the
> architecture.

For this case, I agree that separating the affected assembler out into
a separate .S file is probably the cleanest and simplest solution...
but I guess we should think about whether we're going to need to
revisit this in the future.

Cheers
---Dave
