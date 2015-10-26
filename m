From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Oct 2015 10:55:37 +0000
Subject: [PATCH] arm64: kernel: fix tcr_el1.t0sz restore on systems with
 extended idmap
In-Reply-To: <CAKv+Gu_9_O4GQgm++BvC0i_cGT4pBmozqO5ddy7J2-8-shFRDA@mail.gmail.com>
References: <1445441202-21484-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKv+Gu_9_O4GQgm++BvC0i_cGT4pBmozqO5ddy7J2-8-shFRDA@mail.gmail.com>
Message-ID: <20151026105537.GC8299@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Sat, Oct 24, 2015 at 10:47:22AM +0200, Ard Biesheuvel wrote:
> Hi Lorenzo,
> 
> Thanks for the fix. I'm a bit embarrassed since this is quite
> obviously broken, and I (nor anyone else, for that matter) spotted it
> through testing suspend/resume on Seattle (frankly, I don't even know
> if suspend/resume works currently on Seattle or if it did at the time)

You could not spot it by testing on Seattle, it does not implement PM yet,
I spotted it by code inspection while reviewing James' suspend-to-disk
patches, there is nothing to be embarassed about, you paved the way
to fix it.

> On 21/10/2015, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > Commit dd006da21646 ("arm64: mm: increase VA range of identity map")
> > introduced a mechanism to extend the virtual memory map range
> > to support arm64 systems with system RAM located at very high offset,
> > where the identity mapping used to enable/disable the MMU requires
> > additional translation levels to map the physical memory at an equal
> > virtual offset.
> >
> > The kernel detects at boot time the tcr_el1.t0sz value required by the
> > identity mapping and sets-up the tcr_el1.t0sz register field accordingly,
> > any time the identity map is required in the kernel (ie when enabling the
> > MMU).
> >
> > After enabling the MMU, in the cold boot path the kernel resets the
> > tcr_el1.t0sz to its default value (ie the actual configuration value for
> > the system virtual address space) so that after enabling the MMU the
> > memory space translated by ttbr0_el1 is restored as expected.
> >
> 
> 'After enabling the MMU' is confusing, especially since you use it
> twice to describe two different points in time.

I will sum up this commit log, it is ways too long and not clear
at times.

> > Commit dd006da21646 ("arm64: mm: increase VA range of identity map")
> > also added code to set-up the tcr_el1.t0sz value when the kernel resumes
> > from low-power states with the MMU off through cpu_resume() in order to
> > effectively use the identity mapping to enable the MMU but failed to add
> > the code required to restore the tcr_el1.t0sz to its default value, when
> > the core returns to the kernel with the MMU enabled, so that the kernel
> > might end up running with tcr_el1.t0sz value set-up for the identity
> > mapping which can be lower than the value required by the actual virtual
> > address space, resulting in an erroneous set-up.
> >
> > This patchs adds code in the resume path that restores the tcr_el1.t0sz
> > default value upon core resume, mirroring this way the cold boot path
> > behaviour therefore fixing the issue.
> >
> 
> Of course, I agree with the patch, but could you condense the commit
> log, please?  I don't think we need five paragraphs to point out that
> the sequence to set T0SZ to its idmap value, enable the MMU, branch
> into the kernel virtual mapping and set T0SZ to its default value is
> missing the final step on the resume path, and it actually took me a
> while to figure out what the problem was from reading the text.

Agreed.

> > Fixes: 95322526ef62 ("arm64: kernel: cpu_{suspend/resume} implementation")
> 
> Wrong commit id

Technically speaking I am not fixing

Commit dd006da21646 ("arm64: mm: increase VA range of identity map")

I am fixing the commit I reported, because it never worked on platforms
requiring extended idmap, if anything, your commit dd006da21646 gave
CPUidle states and suspend2RAM a chance to work on those platforms,
and this patch completes the implementation.

To make things simpler I can report:

Fixes: dd006da21646 ("arm64: mm: increase VA range of identity map")

as long as we all agree on the above.

> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks, I will prepare a v2 and ask Catalin to merge it at -rc1, it
conflicts with patches currently on arm64 for-next/core we can wait till
-rc1.

Thanks,
Lorenzo
