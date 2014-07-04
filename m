From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Jul 2014 13:00:49 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704103326.GE21766@n2100.arm.linux.org.uk>
References: <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com>
 <yw1xoax6dr67.fsf@unicorn.mansr.com>
 <20140703224753.GB21766@n2100.arm.linux.org.uk>
 <CAKv+Gu-taih4ZdWkmup5JVSeWhcYbatzoHqra+=+bdZorTBCvg@mail.gmail.com>
 <20140704082437.GA16404@arm.com>
 <CAKv+Gu9id59J-DP9tPLGXxsz5yFdfpCmypgRbtuccVUWLQSsdg@mail.gmail.com>
 <yw1x8uo9eax9.fsf@unicorn.mansr.com>
 <20140704093401.GD21766@n2100.arm.linux.org.uk>
 <yw1x4myxe86j.fsf@unicorn.mansr.com>
 <20140704103326.GE21766@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-idre5jtA45wF=2ah1D9R5oRKvVEfo_0gc9baDOcaMfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 12:33, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Jul 04, 2014 at 11:21:08AM +0100, M?ns Rullg?rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> > Sort of.  It isn't that legal, but we /do/ have bits of kernel code
>> > (particularly networking) which /do/ make use of this.  Whether it's
>> > legal or not really doesn't come into it.
>>
>> You keep saying this, and the netdev guys keep saying that isn't true,
>> and if it does happen, it's a bug they want to know about.
>
> Take a look at the code which parses the ethernet header.  This uses
> struct ethhdr, which is passed a pointer which is typically not word
> aligned (intentionally so, to ensure that the IP header *is* word
> aligned.)
>
> They may say that it isn't true, but I've had the discussion with them
> about adding the packed attribute to ethhdr, and it's something they
> are completely against.
>
>> > It falls into the same class as the additional padding of structures
>> > which caused soo much pain in the early days, where many people used
>> > structures to define the layout of data passed between different
>> > systems, expecting (eg) a three char struct to have a size of 3 rather
>> > than 4.
>>
>> It's quite different from that.  Even if the struct layout isn't the
>> expected, there's nothing _invalid_ about the code; it just happens to
>> do the wrong thing.  Code using unaligned pointers is invalid at a
>> fundamental level and can't be expected to work (whatever that means)
>> anywhere.
>
> That's your opinion (again) which is different from other people's
> opinion.  You haven't been the one to discover these things, and
> raise them with the authors.
>
> The normal response has been "ARM is broken, ARM needs to be fixed
> so it behaves like x86 does" even when the code is not legal C for
> whatever reason.
>
> Thankfully, since then things have moved on a bit and some of the
> issues did get resolved.  However, the one you refer to above
> concerning unaligned pointers... that still is very much alive and
> well in the kernel networking code even today.
>
> It is _standard_ practise to receive a network packet into a buffer
> which is offset by two bytes, and then cast the start address to
> a struct ethhdr.  To prove this to yourself (because it's obvious
> that you don't believe whatever I say) you need to read and understand
> rather a lot of code - the network drivers, the socket buffer code,
> and eth_type_trans() (which is where the implicit cast to struct ethhdr
> occurs.)
>

I won't contradict anything you say here, but the question is really
how likely it is whether this happens in userspace.

My assessment would be that it is not as unlikely as some of us think:
I know from prior experience (TomTom) that it's not just games (if
that even matters) that ship with a fairly large native [non-Java]
component based on a legacy, proprietary code base, in this case doing
decryption and decompression of a proprietary map format. I don't know
for a fact that this particular issue exists in this case, but it is
code that follows a similar pattern as the case Russell describes,
i.e., overlaying some structure on a stream of data.

-- 
Ard.
