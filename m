From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Apr 2017 11:33:14 +0100
Subject: [PATCH] fs: Preventing READ_IMPLIES_EXEC Propagation
In-Reply-To: <CAFEAcA_wH1dDbcjEEBaLX0q8pfWsfYUGGL-zOC4MuxySqa=uvA@mail.gmail.com>
References: <1492088223-98232-1-git-send-email-zhangshaokun@hisilicon.com>
 <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
 <20170418170118.GH27592@e104818-lin.cambridge.arm.com>
 <CAFEAcA_wH1dDbcjEEBaLX0q8pfWsfYUGGL-zOC4MuxySqa=uvA@mail.gmail.com>
Message-ID: <20170419103313.GA3238@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 09:01:52PM +0100, Peter Maydell wrote:
> On 18 April 2017 at 18:01, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Apr 13, 2017 at 08:33:52PM +0800, dongbo (E) wrote:
> >> From: Dong Bo <dongbo4@huawei.com>
> >>
> >> In load_elf_binary(), once the READ_IMPLIES_EXEC flag is set,
> >> the flag is propagated to its child processes, even the elf
> >> files are marked as not requiring executable stack. It may
> >> cause superfluous operations on some arch, e.g.
> >> __sync_icache_dcache on aarch64 due to a PROT_READ mmap is
> >> also marked as PROT_EXEC.
> 
> > That's affecting most architectures with a risk of ABI breakage. We
> > could do it on arm64 only, though I'm not yet clear on the ABI
> > implications (at a first look, there shouldn't be any).
> 
> Is there a reason why it isn't just straightforwardly a bug
> (which we could fix) to make READ_IMPLIES_EXEC propagate to
> child processes?

While I agree that it looks like a bug, if there are user programs
relying on such bug we call it "ABI". On arm64, I don't think there is
anything relying on inheriting READ_IMPLIES_EXEC but I wouldn't change
the compat task handling without the corresponding change in arch/arm.

> AFAICT this should be per-process: just because
> init happens not to have been (re)compiled to permit non-executable
> stacks doesn't mean every process on the system needs to have
> an executable stack.

I think this also affects the heap if brk(2) is used (via
VM_DATA_DEFAULT_FLAGS though I guess malloc mostly uses mmap these
days).

> Behaviour shouldn't be variable across architectures either, I would
> hope.

The behaviour has already been variable for a long time. Even on x86,
AFAICT x86_32 differs from x86_64 in this respect.

Anyway, the patch should be posted to linux-arch for a cross-arch
discussion.

-- 
Catalin
