From: keescook@chromium.org (Kees Cook)
Date: Tue, 22 Nov 2016 13:14:02 -0800
Subject: [PATCH] ARM: fix kmemleak for XIP_KERNEL
In-Reply-To: <20161122142829.1776129-1-arnd@arndb.de>
References: <20161122142829.1776129-1-arnd@arndb.de>
Message-ID: <CAGXu5jLAFHtErSCip+xBsY+qd1adp5fwxj6Nxwo_cuXzcZGezg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 6:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added check for RO_AFTER_INIT_DATA in kmemleak breaks ARM whenever
> XIP_KERNEL is enabled:
>
> mm/kmemleak.o: In function `kmemleak_scan':
> kmemleak.c:(.text.kmemleak_scan+0x2e4): undefined reference to `__end_data_ro_after_init'
> kmemleak.c:(.text.kmemleak_scan+0x2e8): undefined reference to `__start_data_ro_after_init'
>
> This adds the start/end symbols for the section even in the case of having
> no data in the section, to make the check work while keeping the architecture
> specific override in one place.
>
> Fixes: d7c19b066dcf ("mm: kmemleak: scan .data.ro_after_init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> The patch causing this was merged late into v4.9-rc, this one should
> probably go there as well.
>
> I assume the same problem exists on s390, but I have not checked that.
> ---
>  arch/arm/kernel/vmlinux-xip.lds.S | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 06c178214629..bf900f5421a1 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -3,8 +3,11 @@
>   * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
>   */
>
> -/* No __ro_after_init data in the .rodata section - which will always be ro */
> -#define RO_AFTER_INIT_DATA
> +/* empty __ro_after_init data in the .rodata section - it will always be ro */
> +#define RO_AFTER_INIT_DATA                                             \
> +       __start_data_ro_after_init = .;                                 \
> +       __end_data_ro_after_init = .;
> +
>
>  #include <asm-generic/vmlinux.lds.h>
>  #include <asm/cache.h>
> --
> 2.9.0
>



-- 
Kees Cook
Nexus Security
