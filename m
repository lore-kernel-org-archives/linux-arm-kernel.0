From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Oct 2016 15:45:43 -0700
Subject: [PATCHv2 1/4] arm64: dump: Make ptdump debugfs a separate option
In-Reply-To: <1476311522-15381-2-git-send-email-labbott@redhat.com>
References: <1476311522-15381-1-git-send-email-labbott@redhat.com>
 <1476311522-15381-2-git-send-email-labbott@redhat.com>
Message-ID: <CAGXu5jLNUrt22Qg2gFmLj9rgStOTTTsOT7QGaw5efk==WbFwRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 3:31 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> ptdump_register currently initializes a set of page table information and
> registers debugfs. There are uses for the ptdump option without wanting the
> debugfs options. Split this out to make it a separate option.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Minor style fixups per Mark Rutland, intialization is now separate from
>     register since it never needed to be combined in the first place, EFI
>     page table registration.
> ---
>  arch/arm64/Kconfig.debug           |  6 +++++-
>  arch/arm64/include/asm/ptdump.h    | 13 ++++++++-----
>  arch/arm64/mm/Makefile             |  3 ++-
>  arch/arm64/mm/dump.c               | 26 +++++---------------------
>  arch/arm64/mm/ptdump_debugfs.c     | 31 +++++++++++++++++++++++++++++++
>  drivers/firmware/efi/arm-runtime.c |  5 ++---
>  6 files changed, 53 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm64/mm/ptdump_debugfs.c
>
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index b661fe7..21a5b74 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -2,9 +2,13 @@ menu "Kernel hacking"
>
>  source "lib/Kconfig.debug"
>
> -config ARM64_PTDUMP
> +config ARM64_PTDUMP_CORE
> +       def_bool n
> +
> +config ARM64_PTDUMP_DEBUGFS
>         bool "Export kernel pagetable layout to userspace via debugfs"

I think this can be a tristate now, yes? (I did this on x86 so I could
load ptdump as a module for Chrome OS image testing but then leave the
module off the read-only partition for release images...)

https://git.kernel.org/linus/8609d1b5daa36350e020e737946c40887af1743a

-Kees

>         depends on DEBUG_KERNEL
> +       select ARM64_PTDUMP_CORE
>         select DEBUG_FS
>          help
>           Say Y here if you want to show the kernel pagetable layout in a



-- 
Kees Cook
Nexus Security
