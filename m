From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Dec 2014 11:05:07 +0000
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <3551792.oHatG1W6W1@wuerfel>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <5480F12D.90007@suse.de>
 <CAOesGMi-sVTxdo8f7vNnYMgd+meBF+Gsf3Pk5VbHEPxv5Q6iDA@mail.gmail.com>
 <3551792.oHatG1W6W1@wuerfel>
Message-ID: <20141205110507.GB28339@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 10:39:40AM +0000, Arnd Bergmann wrote:
> On Thursday 04 December 2014 15:48:50 Olof Johansson wrote:
> > On Thu, Dec 4, 2014 at 3:41 PM, Alexander Graf <agraf@suse.de> wrote:
> > > On 04.12.14 22:15, Olof Johansson wrote:
> > >> On Thu, Dec 4, 2014 at 7:46 AM, Alexander Graf <agraf@suse.de> wrote:
> > >>> With binutils 2.25 the default alignment for 32bit arm sections changed to
> > >>> have everything 64k aligned. Armv7 binaries built with this binutils version
> > >>> run successfully on an arm64 system.
> > >>>
> > >>> Since effectively there is now the chance to run armv7 code on arm64 even
> > >>> with 64k page size, it doesn't make sense to block people from enabling
> > >>> CONFIG_COMPAT on those configurations.
> > >>>
> > >>> Signed-off-by: Alexander Graf <agraf@suse.de>
> > >>> ---
> > >>>  arch/arm64/Kconfig | 1 -
> > >>>  1 file changed, 1 deletion(-)
> > >>>
> > >>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > >>> index 9532f8d..3cf4f238 100644
> > >>> --- a/arch/arm64/Kconfig
> > >>> +++ b/arch/arm64/Kconfig
> > >>> @@ -409,7 +409,6 @@ source "fs/Kconfig.binfmt"
> > >>>
> > >>>  config COMPAT
> > >>>         bool "Kernel support for 32-bit EL0"
> > >>> -       depends on !ARM64_64K_PAGES
> > >>>         select COMPAT_BINFMT_ELF
> > >>>         select HAVE_UID16
> > >>>         select OLD_SIGSUSPEND3
> > >>
> > >> This is hardly "compat". Sure, it's great to have a new binutils that
> > >> has larger alignment, but practically not a single existing binary
> > >> will work today if someone tries to do this.
> > >
> > > Yes, but IMHO that's an implementation detail. The same applies for
> > > 32bit PPC binaries if you use 4k aligned segments. If your applications
> > > are not aligned for your page size, you can't run them. The only
> > > platform that managed nevertheless FWIW was IA64 ;).
> > 
> > Yes, but there the binutils change happened early enough that by the
> > time the kernel change went in, all major distros had binaries that
> > were compatible.
> 
> What is the exact symptom you see when running an unaligned user
> space binary on 64k-pages? Do we at least print a helpful error
> message somewhere or does it just crash?

The application doesn't even start because it cannot map page 0. It
looks like most 32-bit arm binaries are linked to be loaded at 32K.

> Should we add support for 64k-pages in the arm32 kernel as well now?

32-bit LPAE doesn't support 64K pages but IIRC the classic MMU does
(though I have to check whether it was optional). But it's not feasible
to enable this in a 32-bit environment because of the memory wasted with
large pages (on average 32KB per mapped file, possibly even more if you
have lots of small files).

-- 
Catalin
