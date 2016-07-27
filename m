From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Jul 2016 07:55:32 +0100
Subject: [PATCH] arm64: Fix Kconfig dependencies for RANDOMIZE_BASE
In-Reply-To: <CAKv+Gu-4i=8F3jJFjN3+_nbiYxGTvBTNqVJbF60nuL4REPJ+9Q@mail.gmail.com>
References: <1469553415-26839-1-git-send-email-jeffv@google.com>
 <20160726174556.GH2423@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-4i=8F3jJFjN3+_nbiYxGTvBTNqVJbF60nuL4REPJ+9Q@mail.gmail.com>
Message-ID: <20160727065531.GA14658@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 07:52:33PM +0200, Ard Biesheuvel wrote:
> On 26 July 2016 at 19:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Jul 26, 2016 at 10:16:55AM -0700, Jeff Vander Stoep wrote:
> >> Selecting CONFIG_RANDOMIZE_BASE=y and CONFIG_MODULES=n causes a
> >> build error due to dependencies on modules. This patch makes KASLR
> >> module config options dependent on CONFIG_MODULES=y.
> >>
> >> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> >> ---
> >>  arch/arm64/Kconfig | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 7e23f95..c9eff79 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -891,7 +891,6 @@ config RELOCATABLE
> >>
> >>  config RANDOMIZE_BASE
> >>       bool "Randomize the address of the kernel image"
> >> -     select ARM64_MODULE_PLTS
> >>       select RELOCATABLE
> >>       help
> >>         Randomizes the virtual address at which the kernel image is
> >
> > I thought we need the module PLTs once we randomize the kernel base,
> > independent of whether we randomize the modules base or not.
> 
> Indeed. The module region is always randomized with KASLR, but either
> fully (i.e., anywhere in the vmalloc region) or partially, in which
> case a random 128 MB range is selected that also covers vmlinux's
> .text segment, allowing jumps without veneers. However, since this
> range is part of the ordinary vmalloc space, there is a >0 probability
> that other allocations may exhaust it before you have loaded all your
> modules, in which case the module loader will fall back to ordinary
> vmalloc region allocations, which are most likely too far away to be
> resolved without PLTs
> 
> > Could we do
> > something like:
> >
> >         select ARM64_MODULE_PLTS if MODULES
> >
> > Whichever way we fix this, we probably need:
> >
> > Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> > Cc: <stable@vger.kernel.org> # 4.6+
> >
> 
> With these changes
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks. I pushed my variant above to arm64 for-next/core.

-- 
Catalin
