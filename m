From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Mar 2016 11:48:10 +0100
Subject: DWord alignment on ARMv7
In-Reply-To: <20160303235426.GA11237@arm.com>
References: <56D8BA3F.7050508@pengutronix.de> <20160303235426.GA11237@arm.com>
Message-ID: <CAKv+Gu8D37DgfbopvB1On_=fNqrBzmCmOCTotX2Lvv6NoSCtvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Russell, Arnd)

On 4 March 2016 at 00:54, Will Deacon <will.deacon@arm.com> wrote:
> Hi Marc,
>
> On Thu, Mar 03, 2016 at 11:27:11PM +0100, Marc Kleine-Budde wrote:
>> I'm using btrfs on am ARMv7 and it turns out, that the kernel has to
>> fixup a lot of kernel originated alignment issues.
>>
>> See /proc/cpu/alignment (~4h of uptime):
>> > System: 22304815 (btrfs_get_token_64+0x13c/0x148 [btrfs])
>>
>> For example, when compiling the kernel on a btrfs volume the counter
>> increases by 100...1000 per second.
>>
>> The function shown "btrfs_get_token_64()" is defined here:
>> > http://lxr.free-electrons.com/source/fs/btrfs/struct-funcs.c#L53
>> ...it already uses get_unaligned_leXX accessors.
>>
>> Quoting a comment in arch/arm/mm/alignment.c:
>>
>>          * ARMv6 and later CPUs can perform unaligned accesses for
>>          * most single load and store instructions up to word size.
>>          * LDM, STM, LDRD and STRD still need to be handled.
>>
>> But on a 32bit ARMv7 64bits are not word-sized.
>>
>> Is the exception and fixup overhead neglectable? Do we have to introduce
>> something like HAVE_EFFICIENT_UNALIGNED_64BIT_ACCESS?
>
> Ouch, that trap/emulate is certainly going to have an effect on your
> performance. I doubt that HAVE_EFFICIENT_UNALIGNED_ACCESS applies to
> types bigger than the native word size on many architectures, so my
> hunch is that the btrfs code should be checking BITS_PER_LONG or similar
> to establish whether or not to break the access up into word accesses.
>
> A cursory look at the network layer indicates that kind of trick is done
> over there.
>

I don't think it is the job of the filesystem driver to reason about
whether get_unaligned_le64() does the right thing under any particular
configuration. If ARM's implementation of get_unaligned_le64() issues
load instructions that result in a trap, it is misbehaving and should
be fixed.

I think that something like HAVE_EFFICIENT_UNALIGNED_64BIT_ACCESS
makes sense. Or, based on Will's comment regarding other
architectures, we could change the generic get_unaligned_le64()
implementation for HAVE_EFFICIENT_UNALIGNED_ACCESS to split accesses
when running on 32-bit archs.

-- 
Ard.
