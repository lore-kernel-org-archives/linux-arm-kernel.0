From: mpatocka@redhat.com (Mikulas Patocka)
Date: Mon, 6 Aug 2018 04:02:03 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
Message-ID: <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sun, 5 Aug 2018, Florian Weimer wrote:

> On 08/04/2018 01:04 PM, Mikulas Patocka wrote:
> > There's plenty of memcpy's in the graphics stack. No one will be rewriting
> > all the graphics drivers because of tiny market share that ARM has in
> > desktop computers. So if you refuse to fix things and blame everyone else,
> > you can as well announce that you don't want to have PCIe graphics on ARM
> > at all.
> 
> The POWER toolchain maintainers said pretty much the same thing not too 
> long ago. I wonder how many architectures need to fail until the 
> graphics stack is finally fixed.
> 
> Thanks,
> Florian

If you say that your architecture doesn't support unaligned accesses at 
all, there's no problem - the compiler won't generate them and the libc 
won't contain them.

But if you say that your architecture supports unaligned accesses except 
for the framebuffer, then you have a problem - the compiler can't know 
which pointers point to the framebuffer and libc can't know either - you 
caused this problem by your architectural decision.

You can use 'volatile' to suppress memory optimizations, but it's 
impossible to go through the whole Linux graphics stack and add volatile 
to every pointer that may point to videoram. Even if you succeesed, new 
videoram accesses without volatile will appear after a year of 
development.

See for example the macros READ_ONCE and WRITE_ONCE in Linux kernel - they 
should be used when there's concurrent access to the particular variable, 
but mainstream architectures don't require them, so many kernel developers 
are omitting them in their code.

If you are building a supercomputer with a particular GPU, you can force 
the GPU vendor to provide POWER-compliant drivers. If you are building a 
workstation where the user can plug any GPU, forcing developers will go 
nowhere. You have to emulate the unaligned accesses and make sure that the 
next versions of your architecture support them in hardware.

Mikulas
