From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 04 Feb 2013 12:00:00 +0000
Subject: [RFC PATCH] arm: decompressor: initialize PIC offset base register
 for uClinux tools
In-Reply-To: <20130201181854.GU23505@n2100.arm.linux.org.uk>
References: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
 <alpine.LFD.2.02.1301291453530.6300@xanadu.home> <510BF0B3.3030608@arm.com>
 <20130201181854.GU23505@n2100.arm.linux.org.uk>
Message-ID: <510FA2C0.3020505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 01/02/13 18:18, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 04:43:31PM +0000, Jonathan Austin wrote:
>> Code that needs to access anything global will need to derive the location
>> of the GOT for itself, but there's a possible upside there that there's an
>> extra free register (r9 can be used as a general purpose register...)
>>
>> The patch would look like:
>> -----8<-------
>> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
>> index 5cad8a6..afed28e 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -120,7 +120,7 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
>>   KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>>   endif
>>   -ccflags-y := -fpic -fno-builtin -I$(obj)
>> +ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
>>   asflags-y := -Wa,-march=all -DZIMAGE
>>    # Supply kernel BSS size to the decompressor via a linker symbol.
>> ------>8---------
>>
>>
>> I did a fairly crude benchmark - count how many instructions we need in
>> order to finish decompressing the kernel...
>>
>> Setup r9 correctly:       129,976,282
>> Use -mno-single-pic-base: 124,826,778
>>
>> (this was done using an R-class model and a magic semi-hosting call to pause
>> the model at the end of the decompress_kernel function)
>>
>> So, it seems like the extra register means there's actually a 4% *win*
>> in instruction terms from using -mno-single-pic-base
> 
> Hmm.  This is the opposite of what I'd expect.  -msingle-pic-base says:
> 
>       Treat the register used for PIC addressing as read-only, rather
>       than loading it in the prologue for each function.  The run-time
>       system is responsible for initializing this register with an
>       appropriate value before execution begins.
> 
> which implies that we should be able to load it before calling the C
> code (as you're doing) and then the compiler won't issue instructions
> to reload that register.
> 
> Giving -mno-single-pic-base suggests that it would turn _off_ this
> behaviour (which afaik - sensibly - is not by default enabled.)
> 
> So, I'm not sure I fully understand what's going on here.

You seem to have understood! Specifying -mno-single-pic-base
means the compiler *won't* expect r9 to point to the GOT, but also
means r9 is free as a general purpose register, the effect that I
believe gives the performance improvement in the decompresser.

Perhaps the context missing is that these are two independent patch
suggestions that achieve the same thing in different ways (that is,
they stop the decompresser running off to some incorrect memory location
because r9 isn't set-up). The -mno-single-pic base patch does it by not
using r9 as a PIC offset, and the 'initialise r9' patch does what it says
on the tin.

As you see, I benchmarked them and got the opposite result to what I
expected (IE -mno-songle-pic-base is quicker), so, based also on
Nicolas's Ack, would now champion a different patch to the original one
that I posted...

This is probably overkill, but here's a simple C example for comparison:
$cat pic.c
----------------
int foo;
int ret_foo()
{
	return foo;
}
----------------
$arm-none-uclinux-uclibceabi-gcc -O2 -fPIC -S pic.c -o pic.s
$cat pic.s
-------------
[...]
ret_foo:
	ldr	r3, .L2
	ldr	r3, [r9, r3]
	ldr	r0, [r3, #0]
	bx	lr
.L3:
	.align	2
.L2:
	.word	foo(GOT)
	.size	ret_foo, .-ret_foo
[...]
-------------
$arm-none-uclinux-uclibceabi-gcc -O2 -fPIC -mno-single-pic-base -S pic.c -o no-single-pic-base.s
$cat no-single-pic-base.s
-------------
[...]
ret_foo:
	ldr	r3, .L2
	ldr	r2, .L2+4
.LPIC0:
	add	r3, pc, r3
	ldr	r3, [r3, r2]
	ldr	r0, [r3, #0]
	bx	lr
.L3:
	.align	2
.L2:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC0+8)
	.word	foo(GOT)
[...]
-----------

So we have a 'penalty' of an extra ldr and add when we don't use a read-only
PIC base, but the win of a register free seems to trump that in the decompresser.

Does that clear things up, or did I miss the point of what wasn't clear to you?

Jonny
