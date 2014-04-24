From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 24 Apr 2014 10:15:15 -0500
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <CAKv+Gu-jFAo8JKqz3XHx348pSUBWaDy48RryKwgsxdM15jeAVw@mail.gmail.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>	<20140423215040.GC26756@n2100.arm.linux.org.uk>
 <CAKv+Gu-jFAo8JKqz3XHx348pSUBWaDy48RryKwgsxdM15jeAVw@mail.gmail.com>
Message-ID: <53592A83.2040401@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 02:37 AM, Ard Biesheuvel wrote:
> On 23 April 2014 23:50, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Tue, Apr 22, 2014 at 07:48:51PM -0500, Nathan Lynch wrote:
>>> - Build vdso.so with -lgcc: calls to __lshrdi3, __divsi3 sometimes
>>>   emitted (especially with -Os).  Override certain libgcc functions to
>>>   prevent undefined symbols.
> 
> After reading Russell's concerns below, I had a quick play with these
> patches, and I noticed that the libgcc dependencies are actually only
> present when compiling -Os. However, with normal optimization enabled
> (which most people are using anyway), you don't need libgcc at all. So
> why not override -O2 optimization for vdso.so, and be done with it?
> 
> WIth -Os:
> 
> Archive member included because of file (symbol)
> 
> /usr/lib/gcc-cross/arm-linux-gnueabihf/4.8/sf/libgcc.a(_divsi3.o)
>                               arch/arm/kernel/vdso/vgettimeofday.o
> (__aeabi_idiv)
> /usr/lib/gcc-cross/arm-linux-gnueabihf/4.8/sf/libgcc.a(_lshrdi3.o)
>                               arch/arm/kernel/vdso/vgettimeofday.o
> (__aeabi_llsr)
> 
> Without CONFIG_OPTIMIZE_FOR_SIZE, no archive members are included at all.

Thanks.  I had thought about forcing -O2 in the past but just wasn't
confident that it would prevent calls to __divsi3 etc in all situations.
 I mean, that's not really a documented or guaranteed behavior of -O2,
is it?

I've now built vdso.so with your suggested change with GCC 4.[4-8]
without getting any unresolved symbols, so here's hoping this is a
viable option.
