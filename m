From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 5 Mar 2012 18:38:58 -0500
Subject: [PATCH] arm: fix unresolved restart build failure in
 plat-iop/restart.c
In-Reply-To: <1327288578-30852-1-git-send-email-paul.gortmaker@windriver.com>
References: <1327288578-30852-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CAP=VYLrEvqdL+S3a_XVQoHbAGJXS_sfQzxLs52YcresmGKOOXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 10:16 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Upstream commit bec92b1ec67b4998b6a3bad7c2f03c846cbac71e
>
> ?"ARM: restart: iop3xx: use new restart hook"
>
> created this file, but it needs asm/system.h since upstream
> commit e879c862fb81b986095ae7a4676b2281c2f97957
>
> ?"ARM: restart: only perform setup for restart when soft-restarting"
>
> added the soft_restart() entry. ?Add in that header to resolve
> the below build failure:

Just checking that this didn't fall through the cracks, as I don't
see it in linux-next yet.  I just re-tested on today's linux-next and
it still fixes these defconfig build failures:

http://kisskb.ellerman.id.au/kisskb/target/1257/

Thanks,
Paul.
--

>
> ?CC ? ? ?arch/arm/plat-iop/restart.o
> ?arch/arm/plat-iop/restart.c: In function 'iop3xx_restart':
> ?arch/arm/plat-iop/restart.c:18: error: implicit declaration of function 'soft_restart'
> ?make[3]: *** [arch/arm/plat-iop/restart.o] Error 1
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> diff --git a/arch/arm/plat-iop/restart.c b/arch/arm/plat-iop/restart.c
> index 6a85a0c..728b5c7 100644
> --- a/arch/arm/plat-iop/restart.c
> +++ b/arch/arm/plat-iop/restart.c
> @@ -7,6 +7,7 @@
> ?* it under the terms of the GNU General Public License version 2 as
> ?* published by the Free Software Foundation.
> ?*/
> +#include <asm/system.h>
> ?#include <asm/hardware/iop3xx.h>
> ?#include <mach/hardware.h>
>
> --
> 1.7.7.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
