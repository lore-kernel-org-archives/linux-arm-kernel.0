From: keescook@chromium.org (Kees Cook)
Date: Thu, 29 Sep 2016 18:29:22 -0700
Subject: [kernel-hardening] [PATCH 0/3] WX Checking for arm64
In-Reply-To: <20160929213257.30505-1-labbott@redhat.com>
References: <20160929213257.30505-1-labbott@redhat.com>
Message-ID: <CAGXu5jKamEFzkR+iVxfZKJ_YK41E8a8ta1mQRY7tHfcz-NFwOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 2:32 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> Hi,
>
> This is an implementation to check for writable and executable pages on arm64.
> This is heavily based on the x86 version which uses the existing page table
> dumping code to do the checking. Some notes:
>
> - The W^X checking is important so this option should become defaut eventually.
>   To make this feasible, the debugfs functionality has been split out as a
>   separate option. I didn't see a good way to make it modular like x86 but
>   an option should be good enough.
> - This checks all page tables registered with ptdump_register. I don't see this
>   being called elsewhere right now though.
> - Once this is merged, I'd like to see about moving DEBUG_WX to the top level
>   instead of having each arch call it in mark_rodata.

Awesome!

Yeah, I think we should take a look at refactoring x86, arm, and arm64
to use a common infrastructure with callbacks. That way other
architectures can gain all these features with just a few callbacks
implemented.

-Kees

>
> Laura Abbott (3):
>   arm64: dump: Make ptdump debugfs a separate option
>   arm64: dump: Make the page table dumping seq_file optional
>   arm64: dump: Add checking for writable and exectuable pages
>
>  arch/arm64/Kconfig.debug        | 34 ++++++++++++++-
>  arch/arm64/include/asm/ptdump.h | 25 ++++++++++-
>  arch/arm64/mm/Makefile          |  3 +-
>  arch/arm64/mm/dump.c            | 92 ++++++++++++++++++++++++++++-------------
>  arch/arm64/mm/mmu.c             |  2 +
>  arch/arm64/mm/ptdump_debugfs.c  | 33 +++++++++++++++
>  6 files changed, 157 insertions(+), 32 deletions(-)
>  create mode 100644 arch/arm64/mm/ptdump_debugfs.c
>
> --
> 2.10.0
>



-- 
Kees Cook
Nexus Security
