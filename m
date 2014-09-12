From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Sep 2014 18:21:51 +0100
Subject: [PATCH arm64-next] net: bpf: arm64: address randomize and write
 protect JIT code
In-Reply-To: <54132A76.4070501@redhat.com>
References: <1410505897-20122-1-git-send-email-dborkman@redhat.com>
 <20140912160345.GF5532@arm.com> <54131D87.9060008@redhat.com>
 <20140912164656.GH5532@arm.com> <54132A76.4070501@redhat.com>
Message-ID: <20140912172151.GI5532@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 06:16:38PM +0100, Daniel Borkmann wrote:
> On 09/12/2014 06:46 PM, Catalin Marinas wrote:
> > On Fri, Sep 12, 2014 at 05:21:27PM +0100, Daniel Borkmann wrote:
> >> On 09/12/2014 06:03 PM, Catalin Marinas wrote:
> >>> On Fri, Sep 12, 2014 at 08:11:37AM +0100, Daniel Borkmann wrote:
> >>>> --- a/arch/arm64/net/bpf_jit_comp.c
> >>>> +++ b/arch/arm64/net/bpf_jit_comp.c
> >>> [...]
> >>>> +static void jit_fill_hole(void *area, unsigned int size)
> >>>> +{
> >>>> +	/* Insert illegal UND instructions. */
> >>>> +	u32 *ptr, fill_ins = 0xe7ffffff;
> >>>
> >>> On arm64 we don't have a guaranteed undefined instruction space (and
> >>> Will tells me that on Thumb-2 for the 32-bit arm port it actually is a
> >>> valid instruction, it seems that you used the same value).
> >>
> >> Hm, ok, the boards we've tried out and where Zi tested it too, it worked.
> >
> > So, if I try this:
> >
> > $ echo 0xffffffe7 | xxd -r > test.bin
> > $ arm-linux-gnueabihf-objdump -m arm -D -b binary test.bin
> > ...
> >     0:   e7ffffff        udf     #65535  ; 0xffff
> >
> > Do you use the same constant on arm32?
> 
> I was using something along that lines, but I guess I missed
> something:
> 
> # cat foo.S
> .globl foobar
> foobar:
> .word 0xe7ffffff

That's missing a mov pc, lr.

> # cat bar.c
> #include <stdio.h>
> extern void foobar(void);
> int main(void)
> {
>      foobar();

So you call it here and ends up in some data section, possibly hitting
some undefined instruction. For ARM it is undefined, for Thumb-2 it is
not as Will pointed out.

> >>> I think the only guaranteed way is to use the BRK #imm instruction but
> >>> it requires some changes to the handling code as it is currently used
> >>> for kgdb (unless you can use two instructions for filling in which could
> >>> generate a NULL pointer access).
> >>
> >> The trade-off would be that if we align on 8, it would certainly increase
> >> the probability to jump to the right offset. Note, on x86_64 we have no
> >> alignment requirements, hence 1, and on s390x only alignment of 2.
> >>
> >> So, on that few (?) boards where UND would be a valid instruction [ as
> >> opposed to crash the kernel ], would it translate into a NOP and just
> >> 'walk' from there into the JIT image?
> >
> > On current ARMv8 CPU implementations, the above constant is unallocated
> > in the A64 instruction space. But you never know, it may be allocated in
> > the future.
> >
> > I think it's easier if you just use something like BRK #0x100 (opcode
> > 0xd4202000) which would trigger a fault in the kernel (kgdb uses #imm
> > 0x400 and 0x401).
> >
> > An unallocated BRK would trigger a fault via do_debug_exception ->
> > brk_handler and panic the kernel.
> 
> Okay, that's fine by me, I'll just update s/0xe7ffffff/0xd4202000/.
> 
> Do you want me to use the same suggestion for arm32 as well as it
> would be less fragile?

We don't have a brk instruction for arm32 but we have guaranteed
undefined space. Have a look at the kgdb support for example (or grep
for register_undef_hook under arch/arm) to get an idea.

> Last but not least ;), if I would resend it today, would you queue
> it for later on, or do you want to handle it differently?

You can send it now, it will be pushed upstream at the right time.

Thanks.

-- 
Catalin
