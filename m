From: olof@lixom.net (Olof Johansson)
Date: Fri, 24 Oct 2014 14:47:29 -0700
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141023222645.GM27405@n2100.arm.linux.org.uk>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <5876859.V209eoUfHk@wuerfel>
 <20141023161220.GK27405@n2100.arm.linux.org.uk>
 <3345399.JKaCjH1LWX@wuerfel>
 <20141023222645.GM27405@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMi=HU-Z60d5bvbMaDDVd4xxWowZLh7jsSygZG5OGXEuhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 3:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 23, 2014 at 10:31:07PM +0200, Arnd Bergmann wrote:
>> On Thursday 23 October 2014 17:12:20 Russell King - ARM Linux wrote:
>> >
>> > > I haven't found the code in gcc that performs the type check for
>> > > printf, but I've found a comment about that code intentionally
>> > > resolving the type (printing 'unsigned int') when the typedef
>> > > does not match the expected type.
>> >
>> > If I had a copy of the GCC 4.9 source locally, I'd dig into it too and
>> > try to work out what's going on.  My gut feeling is that it's a bug in
>> > GCC rather than something which the kernel is doing wrong.
>> >
>>
>> I suspect it has something to do with the way that Olof's gcc is built,
>> since it doesn't happen for me using the same kernel source and gcc-4.9.1
>> or 4.10-prerelease.
>>
>> The fact that it doesn't define __linux__ means that it must be configured
>> in some other way than what I do or what I get from the distros.
>
> Hmm, which may mean that it does expect "unsigned long" for size_t.
>
> Olof, please can you try this fragment:
>
> typedef __SIZE_TYPE__ gcc_size_t;
> #include <stdio.h>
> int main() { size_t size = 1; printf("%zu\n", size); return 0; }
>
> with "arm-linux-gcc -E -o - test.c | grep size_t" and check what the
> actual typedefs passed to the compiler proper are?  Thanks.


Since it's a baremetal compiler, there's no stdio.h. Anyway, taking
out the include line:

typedef unsigned int gcc_size_t;
int main() { size_t size = 1; printf("%zu\n", size); return 0; }


I guess I should just look at building a full compiler set instead of
this silliness. On the other hand, it's good to get it exposed I
suppose.


-Olof
