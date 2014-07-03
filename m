From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 3 Jul 2014 16:40:04 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703150008.GX32514@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com> <5534788.ziUvZhb6y0@wuerfel>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
Message-ID: <CACxGe6v4X+NGReTX5DP3kX4fGB0-AM+0i+EHTYGYJ5strMJ6VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 3, 2014 at 4:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 03, 2014 at 04:28:38PM +0200, Arnd Bergmann wrote:
>> On Thursday 03 July 2014 11:41:35 Catalin Marinas wrote:
>> >
>> > In my view, we don't break user space. It's rather a choice of how much
>> > legacy we support on ARMv8 hardware with an arm64 kernel. We don't even
>> > provide HWCAP_SWP for compat (not that anyone bothers checking that).
>> > It's a similar reason we choose not to support/emulate NWFPE or OABI
>> > even though there are existing binaries out there. If we choose to
>> > support SWP in the arm64 kernel, then we won't be able to break user
>> > space and have to carry it for a long time (unless you figure out a way
>> > to remove such features from the kernel because HWCAP certainly doesn't
>> > work, nor printk).
>> >
>> > The ARM feature deprecation/removal cycle allows for two architecture
>> > revisions before being entirely removed. SWP has been deprecated in
>> > ARMv6, made optional in ARMv7 (with the possibility of disabling it if
>> > still available) and removed in ARMv8. The Thumb-1/2 instruction sets
>> > never had the SWP instruction. Even when SWP was available in certain
>> > ARMv7 implementations, it was no longer guaranteed to be atomic.
>>
>> The problem really is that the ARM architecture deprecation method is
>> not compatible with the one we use in the kernel. I don't think there
>> is a good answer to that.
>>
>> Note that other architectures have a different way of handling this
>> by never removing instructions. Obviously knowing that does not help
>> deal with the problem on ARM.
>
> Actually, there's not much difference.
>
> Let's take a look at what x86 does.  As the instruction set there
> develops, they too "retire" old instructions.  Rather than deprecating
> them and then removing them entirely, instructions which were once
> fast become slower because the core is no longer optimised to execute
> that instruction.
>
> This encourages those who wish to have high performance to move to the
> new solution - but most importantly, existing software continues to
> work.
>
> We can have that on ARM, but only for userspace.  The difference is
> that the kernel has to do the backwards compatibility rather than the
> (nonexistent) CPU microcode - and we do have that capability for SWP.
>
> We may not find it desirable to do it for ARMv8, but _if_ we wish to
> allow users to migrate... if we wish to allow the existing set of
> userspace programs (some of which may be statically linked to their
> C library) to continue to work, there's only one option here.
>
> While I can understand ARM Ltd not wanting to pollute their nice clean
> ARM64 kernel with ARM32 "legacy junk", the fact of the matter is that
> even the CPU is already polluted with the legacy ARM32 stuff - it
> supports ARM32 binaries.
>
> As ARM Ltd is moving towards server type systems, they should really
> start demonstrating that they understand this point, otherwise people
> are going to run away from ARM.  ISA compatibility - and a standardised
> platform is what has made x86 become the universal platform that it
> has.
>
> The problem here is the embedded thinking, which is "we can make any
> change, we just need to update and rebuild all the software which runs
> on the CPU."  That really doesn't work when people want to provide a
> single binary which works everywhere.

Well said. Exactly my point. I was ready to write a long reply, but
this email pretty much covers it.

g.
