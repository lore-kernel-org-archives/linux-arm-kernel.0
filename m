From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Aug 2014 19:36:53 +0100
Subject: [PATCHv3 6/7] arm64: use fixmap for text patching when text is RO
In-Reply-To: <53FB82A7.3030806@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-7-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jJKhBZigRYtAa0h554tNoGoMd46_nsNvQS2Wds_DbZM1g@mail.gmail.com>
 <53FB82A7.3030806@codeaurora.org>
Message-ID: <20140826183653.GL4078@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >> +static int __kprobes __aarch64_insn_write(void *addr, u32 insn, bool patch)
> >> +{
> >> +       void *waddr = addr;
> >> +       unsigned long flags;
> >> +       int ret;
> >> +
> >> +       if (patch)
> >> +               waddr = patch_map(addr, FIX_TEXT_POKE0, &flags);
> >> +
> >> +       ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
> >> +
> >> +       if (waddr != addr) {
> >> +               __flush_dcache_area(waddr, AARCH64_INSN_SIZE);
> > 
> > Is this flush to make sure the waddr change has actually made it to
> > physical memory?
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > -Kees
> > 
> 
> It's more for the alias flushing to match what arm was doing. This was
> one of the parts that I wasn't sure if it was necessary or not.

ARMv8 doesn't allow for aliases in the D-cache, so I think we can drop
the __flush_dcache_area call:

  - D-cache maintenance instructions execute in program-order relative
    to loads & stores that access an address in Normal memory with Inner
    Write {Through,Back} attributes within the same cache line. (per
    ARMv8 ARM, D3-1615).

  - D-cache maintenance for an address is visible at all aliases. (per
    ARMv8 ARM, D4-1750)

So we shouldn't need a barrier between the write and the D-cache
maintenance, and we don't care which virtual alias we perform the
maintenance on. As flush_icache_range flushes the VA matching the
I-cache, that should be sufficient.

Cheers,
Mark.
