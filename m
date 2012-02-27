From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Feb 2012 13:48:12 -0800
Subject: [PATCH] ARM: tegra: uncompress.h: Don't depend on kernel headers
In-Reply-To: <1330378039-21030-1-git-send-email-swarren@nvidia.com>
References: <1330378039-21030-1-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMj7Cz-44Z2C6ZA4RwdFFKLXLornuN368Y9XjCLFCs07eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 1:27 PM, Stephen Warren <swarren@nvidia.com> wrote:
> This fixes the following compile error:
>
> ?CC ? ? ?arch/arm/boot/compressed/misc.o
> In file included from arch/arm/boot/compressed/misc.c:28:0:
> arch/arm/mach-tegra/include/mach/uncompress.h: In function 'arch_decomp_setup':
> arch/arm/mach-tegra/include/mach/uncompress.h:125:2: error: implicit declaration of function 'BUILD_BUG_ON_ZERO' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
>
> This is due to use of the ARRAY_SIZE() macro. Typically, this would be
> solved by including <linux/bug.h>, but the compressor code isn't part of
> the kernel, and so should not include kernel headers. Instead, define
> the few macros the code uses directly, and in a way that doesn't depend
> on <linux/bug.h>.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied on for-3.4/soc-drivers, since that's the branch the
linux/kernel.h include was introduced on.

We're losing bisectability over about 9 commits unless I rebase the
branch to squash it in, but there might be downstream users of it so I
don't want to do that.


-Olof
