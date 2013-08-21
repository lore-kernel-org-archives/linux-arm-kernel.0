From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 21 Aug 2013 16:49:57 -0500
Subject: [PATCH 1/2] DMA: fix AMBA PL08x driver issue with 64bit DMA
 address type
In-Reply-To: <CACRpkdZg6kQSY2bm6LWpNCDhd90-7G2GSFQv7Jho2+Xq-EQCkw@mail.gmail.com>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
 <1376484729-11826-2-git-send-email-andre.przywara@linaro.org>
 <CACRpkdZg6kQSY2bm6LWpNCDhd90-7G2GSFQv7Jho2+Xq-EQCkw@mail.gmail.com>
Message-ID: <CAHCPf3tCMG1hjqE3hzuVpYqzAXEKXddbOZ6UuDzhOVpbdsq_KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 4:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 14, 2013 at 2:52 PM, Andre Przywara
> <andre.przywara@linaro.org> wrote:
>
>> In Rob's recent pull request the patch
>>         ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
>> promotes dma_addr_t to 64bit, which breaks compilation of the
>> AMBA PL08x DMA driver.
>> GCC has no function for the 64bit/8bit modulo operation.
>> Looking more closely the divisor can only be 1, 2 or 4, so the full
>> featured '%' modulo operation is overkill and can be replaced by
>> simple bit masking.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>
> Can you give some context? Which platform have you tested
> this on after the change, or is this only compile-tested?
>
> Of the current defconfigs selecting this driver, none is 64bit,
> so makes me a bit curious if there is really some PL08x
> on the Highbank or similar?

I thought the whole PL08x thing was just a side-effect, no?

The issues here I see that Rob is trying to fix:

* If you want to put a 64-bit address into a DMA controller somewhere
- be it a register (64-bit) or descriptor (64-bit), dma_addr_t is how
the kernel handles it. If dma_addr_t is only 32-bit, how can you
specify the address there? How can you do some mapping and return a
pointer into 64-bit address space into a 32-bit value? How can you
even allocate memory (dma_alloc_coherent, for example) for the range
you want?

The objections here are obvious - as below:

1) In the case where you have an LPAE platform which enables Rob's
patch, and you use dma_addr_t and the write descriptors in memory that
are 32-bit or registers that are 32-bit using specific knowledge of
the size of dma_addr_t or just assume it's a 32-bit wide value (why
would anyone do that?) then these drivers ARE buggy and should be
fixed. But that could be all of them if they're not setting their
masks correctly.. considering you can mix DMA controllers in a system,
some with 32-bit address spaces and some with >32-bit address spaces,
making dma_addr_t 64-bit might fix one and break all the others
depending on driver quality (i.e. masks..)

2) dma_addr_t being 64-bit everywhere couldn't be that much of a
problem, though, with properly written drivers. The main culprits will
be (if they're broken):

- If they're writing values into descriptors and just using writel()
then surely there'll be a compiler warning first, which may be ignored
by the developer, and then end up writing the wrong 32-bit value to
memory or just the lower 32-bits giving a perfectly 'random' DMA
failure where it silently walks over something 4GB below where it
needed to be or somewhere else (so you'd see memory trashing, random
bus faults..)

- Passing dma_addr_t in function calls to assembly code, with an
assumption of the register usage in the following case where it's
called from C (rarer but, could happen):

void write_some_dma_thing_in_assembly(int a, dma_addr_t b, char c);

 -> r0, r1, r2 on 32-bit dma_addr_t
-> r0, r2+r3, stack on 64-bit dma_addr_t

If the assembly code assumes the dma_addr_t is 32-bit and therefore
the address (per EABI) is in r1 and not r2+r3 it will get garbage from
elsewhere in the 64-bit dma_addr_t case, and plug it into the target
descriptor or register. Same memory trashing and random bus faults as
above.

They're going to explode and there's not going to be ANY warning until
there's an explosion..

On the second point, I wonder if sparse or checkpatch can figure out
somehow if a 64-bit value is being passed as the second argument to a
function where the first argument is smaller, and print a nitpick
warning about how one might want to be careful about doing this
considering possible ABI differences depending on possible
configuration differences? Does it already?

~~

So, here's the question; how do you determine what size dma_addr_t is
considering that it may be possible that the actual size for the DMA
controller may be either, but you have a minimum of 64-bit because at
least ONE DMA controller needs that can address the full range? If any
drivers are accidentally setting >32-bit masks on non-LPAE then
there're bad addresses coming back anyway and these should have been
caught already, right?

So nothing will magically get trashed in the beginning, only during
rafts of patches to "update the dma mask to full 64-bit" where it
actually depends on the runtime CPU and config options in play anyway?

I recall something around late-to-discontinued time on Windows
XP/Server 2003 where they quit certifying 32-bit drivers that would
bail or do weird things given a 64-bit pointer. The driver core of
Windows managed to move up to 64-bit dma addresses (even on "32-bit"
hardware) internally forcing the driver developers with it. The main
reason: every x86 chip worth a damn that they supported had PAE so it
could have had 8GB of RAM, on Server 2003 Datacenter Edition I think
the upper limit was 32GB. It was perfectly possible to have a "32-bit"
system with DMA going right up to the end of the extended physical
memory address..

Did I miss something here?

-- Matt
