From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 11 Oct 2012 17:18:16 +0100
Subject: alignment faults in 3.6
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 (David Laight's message of "Thu, 11 Oct 2012 16:39:38 +0100")
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
 <1349952574.21172.8604.camel@edumazet-glaptop>
 <201210111228.25995.arnd@arndb.de>
 <1349959248.21172.8970.camel@edumazet-glaptop>
 <5076C78E.1020408@gmail.com>
 <1349963227.21172.9188.camel@edumazet-glaptop>
 <5076E472.8030703@gmail.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
Message-ID: <yw1xtxu1nfsn.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"David Laight" <David.Laight@ACULAB.COM> writes:

>> Not exactly. It is asked to to perform 2 32-bit loads which are combined
>> into a single ldm (load multiple) which cannot handle unaligned
>> accesses. Here's a simple example that does the same thing:
>> 
>> void test(char * buf)
>> {
>> 	printf("%d, %d\n", *((unsigned int *)&buf[0]), *((unsigned int *)&buf[4]));
>> }
>
> Have you actually looked at what an ARM processor traditionally did
> with misaligned memory reads?
> While useful, it probably wasn't what was intended.
>
> Actually, and IIRC, some very recent ARM cpus will do the 'expected'
> thing for single-word loads from misaligned addesses.

What various CPUs do with unaligned accesses is not the issue here.  The
casts in the code above act as a promise to the compiler that the
address is in fact properly align for the pointer type.

> However they almost certainly won't for ldm/stm.
>
> The 'ldm' optimisation for adjacent memory loads is also dubious.

There is nothing whatsoever dubious about the compiler using the most
efficient instruction sequence to accomplish what the code asks for.

> On at least some ARMs it is very slow (might only be strongarms).

The compiler will pick instructions suitable for the CPU you specify.

>> So I guess the only ABI legal unaligned access is in a packed struct.
>
> Correct. And you mustn't try casting the address, the compiler is
> allowed to remember where it came from.
> (This causes a lot of grief...)

It is only a problem when you try to outsmart the compiler.

> If you are targeting the ARM cpu that can do misaligned transfers,
> then gcc should generate single instructions for misaligned structure
> members, and never do the 'ldm' optimisations.

That is exactly how gcc works.

> But, the IP header is expected to be aligned.

Everything tells the compiler the struct is perfectly aligned.  When the
buggy driver passes a misaligned pointer, bad things happen.

-- 
M?ns Rullg?rd
mans at mansr.com
