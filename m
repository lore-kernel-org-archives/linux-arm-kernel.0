From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 04 Feb 2013 12:20:52 +0000
Subject: [RFC PATCH] arm: decompressor: initialize PIC offset base register
 for uClinux tools
In-Reply-To: <20130204120708.GB17786@n2100.arm.linux.org.uk>
References: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
 <alpine.LFD.2.02.1301291453530.6300@xanadu.home> <510BF0B3.3030608@arm.com>
 <20130201181854.GU23505@n2100.arm.linux.org.uk> <510FA2C0.3020505@arm.com>
 <20130204120708.GB17786@n2100.arm.linux.org.uk>
Message-ID: <510FA7A4.5030409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/13 12:07, Russell King - ARM Linux wrote:
> On Mon, Feb 04, 2013 at 12:00:00PM +0000, Jonathan Austin wrote:
>> You seem to have understood! Specifying -mno-single-pic-base
>> means the compiler *won't* expect r9 to point to the GOT, but also
>> means r9 is free as a general purpose register, the effect that I
>> believe gives the performance improvement in the decompresser.
>>
>> Perhaps the context missing is that these are two independent patch
>> suggestions that achieve the same thing in different ways (that is,
>> they stop the decompresser running off to some incorrect memory location
>> because r9 isn't set-up). The -mno-single-pic base patch does it by not
>> using r9 as a PIC offset, and the 'initialise r9' patch does what it says
>> on the tin.
>>
>> As you see, I benchmarked them and got the opposite result to what I
>> expected (IE -mno-songle-pic-base is quicker), so, based also on
>> Nicolas's Ack, would now champion a different patch to the original one
>> that I posted...
>>
>> This is probably overkill, but here's a simple C example for comparison:
>> $cat pic.c
>> ----------------
>> int foo;
>> int ret_foo()
>> {
>> 	return foo;
>> }
>> ----------------
>> $arm-none-uclinux-uclibceabi-gcc -O2 -fPIC -S pic.c -o pic.s
>> $cat pic.s
>> -------------
>> [...]
>> ret_foo:
>> 	ldr	r3, .L2
>> 	ldr	r3, [r9, r3]
>> 	ldr	r0, [r3, #0]
>> 	bx	lr
>> .L3:
>> 	.align	2
>> .L2:
>> 	.word	foo(GOT)
>> 	.size	ret_foo, .-ret_foo
>
> Ah, so the problem is that the default for single-pic-base is different
> with uclinux compilers from other compilers.  Other compilers will
> default to -mno-single-pic-base, but what your build above shows is that
> for your compiler, your default is -msingle-pic-base.
>
> So, passing -mno-single-pic-base means that you're actually _restoring_
> the compiler behaviour that we're expecting for the decompressor.
>

Ahh, I see.

My experience is that my toolchain behaves much like most other uclinux 
toolchains - I've just checked:
- Codesourcery
- A Pengutronix one for the M3
- An ARM one

And they all default to using r9.

So shall I put the -m*no*-single-pic-base one in to the patch system?

Jonny
