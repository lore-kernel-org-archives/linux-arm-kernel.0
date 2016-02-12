From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Feb 2016 15:10:06 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
Message-ID: <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 04:02:58PM +0100, Ard Biesheuvel wrote:
> On 12 February 2016 at 15:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Hi Ard,
> >
> > On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
> >> This moves the module area to right before the vmalloc area, and
> >> moves the kernel image to the base of the vmalloc area. This is
> >> an intermediate step towards implementing KASLR, which allows the
> >> kernel image to be located anywhere in the vmalloc area.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > This patch is causing lots of KASAN warnings on Juno (interestingly, it
> > doesn't seem to trigger on Seattle, though we only tried for-next/core).
> > I pushed the branch that I'm currently using here:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/kernmap
> >
> >
> > A typical error (though its place varies based on the config options,
> > kernel layout):
> >
> > BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x28/0x1b0 at addr ffffffc936257cc8
> 
> Can you confirm that these are stack accesses? I was having similar
> errors before, and I ended up creating the kasan zero page patch
> because it turned out the kasan shadow page in question was aliased
> and the stack writes were occurring elsewhere.

It's possible, we are looking into this. Is there any other patch I miss on
the above branch?

BTW, disabling CPU_IDLE, I get other errors:

WARNING: at /work/Linux/linux-2.6-aarch64/mm/vmalloc.c:135
Modules linked in:

CPU: 2 PID: 973 Comm: systemd-modules Tainted: G        W       4.5.0-rc1+ #131
Hardware name: Juno (DT)
task: ffffffc93448e200 ti: ffffffc9346ac000 task.ti: ffffffc9346ac000
PC is at vmap_page_range_noflush+0x240/0x2e8
LR is at vmap_page_range_noflush+0x16c/0x2e8
pc : [<ffffff90041fef78>] lr : [<ffffff90041feea4>] pstate: 20000145
sp : ffffffc9346af9b0
x29: ffffffc9346af9b0 x28: ffffff90050da000
x27: ffffffc001438008 x26: ffffffbde6d16440
x25: 0000004240000000 x24: ffffffc97ff3a000
x23: 0000000000000041 x22: ffffffc078e9e600
x21: ffffff8200002000 x20: ffffff8200001000
x19: 0000000000000000 x18: 00000000f3294c2f
x17: 00000000f7dc90fb x16: 0000000087b402ce
x15: ffffffffffffffff x14: ffffff0000000000
x13: ffffffffffffffff x12: 0000000000000028
x11: 0101010101010101 x10: 00000001801a001a
x9 : 0000000000000000 x8 : ffffff89268b2400
x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000
x3 : 0000000000000000 x2 : 1ffffff800287001
x1 : dfffff9000000000 x0 : 00e8000081439713

---[ end trace 8a78d7ad8d08d2a9 ]---
Call trace:
Exception stack(0xffffffc9346af790 to 0xffffffc9346af8b0)
f780:                                   0000000000000000 ffffff8200001000
f7a0: ffffffc9346af9b0 ffffff90041fef78 0000000020000145 000000000000003d
f7c0: 0000004240000000 ffffffc078e9f600 0000000041b58ab3 ffffff9004f0c370
f7e0: ffffff9004082608 ffffffc078e9f620 00000000024080c2 0000000000400000
f800: ffffffc9346afe70 ffffffc9346afe50 ffffffc9346af9b0 ffffffc93448e200
f820: ffffffc9346af830 ffffff900408b1b0 ffffffc9346af900 ffffff900408b228
f840: ffffffc9346ac000 ffffffc9346af9b0 ffffffc9346ac000 ffffffc078e9e600
f860: 0000000041b58ab3 ffffff9004f0c8a8 ffffff900408b080 000000010010000e
f880: ffffffc9346af9b0 0000000000000000 00e8000081439713 dfffff9000000000
f8a0: 1ffffff800287001 0000000000000000
[<ffffff90041fef78>] vmap_page_range_noflush+0x240/0x2e8
[<ffffff90041ff078>] map_vm_area+0x58/0x88
[<ffffff9004200400>] __vmalloc_node_range+0x2b8/0x350
[<ffffff9004224394>] kasan_module_alloc+0x64/0xb8
[<ffffff90040943f4>] module_alloc+0x5c/0xa0
[<ffffff9004169460>] load_module+0x1798/0x3098
[<ffffff900416b020>] SyS_finit_module+0xf8/0x108
[<ffffff9004085d30>] el0_svc_naked+0x24/0x28
vmalloc: allocation failure, allocated 4096 of 4096 bytes

-- 
Catalin
