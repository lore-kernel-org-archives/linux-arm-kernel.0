From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Jul 2014 13:28:19 -0400 (EDT)
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <CAKv+Gu-idre5jtA45wF=2ah1D9R5oRKvVEfo_0gc9baDOcaMfg@mail.gmail.com>
References: <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com> <yw1xoax6dr67.fsf@unicorn.mansr.com>
 <20140703224753.GB21766@n2100.arm.linux.org.uk>
 <CAKv+Gu-taih4ZdWkmup5JVSeWhcYbatzoHqra+=+bdZorTBCvg@mail.gmail.com>
 <20140704082437.GA16404@arm.com>
 <CAKv+Gu9id59J-DP9tPLGXxsz5yFdfpCmypgRbtuccVUWLQSsdg@mail.gmail.com>
 <yw1x8uo9eax9.fsf@unicorn.mansr.com>
 <20140704093401.GD21766@n2100.arm.linux.org.uk>
 <yw1x4myxe86j.fsf@unicorn.mansr.com>
 <20140704103326.GE21766@n2100.arm.linux.org.uk>
 <CAKv+Gu-idre5jtA45wF=2ah1D9R5oRKvVEfo_0gc9baDOcaMfg@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407041259290.22282@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jul 2014, Ard Biesheuvel wrote:

> On 4 July 2014 12:33, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > It is _standard_ practise to receive a network packet into a buffer
> > which is offset by two bytes, and then cast the start address to
> > a struct ethhdr.  To prove this to yourself (because it's obvious
> > that you don't believe whatever I say) you need to read and understand
> > rather a lot of code - the network drivers, the socket buffer code,
> > and eth_type_trans() (which is where the implicit cast to struct ethhdr
> > occurs.)
> >
> 
> I won't contradict anything you say here, but the question is really
> how likely it is whether this happens in userspace.
> 
> My assessment would be that it is not as unlikely as some of us think:
> I know from prior experience (TomTom) that it's not just games (if
> that even matters) that ship with a fairly large native [non-Java]
> component based on a legacy, proprietary code base, in this case doing
> decryption and decompression of a proprietary map format. I don't know
> for a fact that this particular issue exists in this case, but it is
> code that follows a similar pattern as the case Russell describes,
> i.e., overlaying some structure on a stream of data.

We know this isn't legal C to do so, but people do and did it 
nevertheless.  Especially in proprietary code.

And in the Android case we're talking about binary executables and many 
of them are unlikely to ever be recompiled.  Puristic comments about 
language definition conformance won't fix that.

So... how likely are fixed-up unaligned accesses in user space?  At 
least if they happen the kernel may tell you via /proc/cpu/alignment 
where different fixups are counted. Documentation available in 
Documentation/arm/mem_alignment.

So someone at Google should really think about adding statistics 
capturing from /proc/cpu/alignment to Android and gather results from 
the largest user base possible.  Maybe do it with Chrome OS as well.  
There shouldn't be any privacy concerns tied to those statistics.

And if the half/dword/multi counts are ever growing from zero then 
pragmatism must prevail i.e. those misaligned accesses must be emulated 
on ARM64 as well (although for ARM32 user space apps only).


Nicolas
