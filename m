From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 10 May 2012 22:51:59 -0500
Subject: [PATCH] ARM: imx: Modify IMX_IO_P2V macro
In-Reply-To: <1336609457-25502-1-git-send-email-rob.lee@linaro.org>
References: <1336609457-25502-1-git-send-email-rob.lee@linaro.org>
Message-ID: <CAMXH7KFgCnoGR=7VjF48EAZhq31=-oatw-7yWy+Fhoxg9TSksg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe and Sascha,

On Wed, May 9, 2012 at 7:24 PM, Robert Lee <rob.lee@linaro.org> wrote:
> A change is needed in the IMX_IO_P2V macro to allow all imx5 platforms
> to use common definitions when accessing registers of peripherals on
> the AIPS2 bus.
>
> This change was tested for mapping conflicts using the iop2v script
> found at git://git.pengutronix.de/git/ukl/imx-iop2v.git and by
> performing a bootup of a default build using imx_v6_v7_defconfig
> on a imx51 babbage board and imx53 loco board.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> ?arch/arm/plat-mxc/include/mach/hardware.h | ? ?1 +
> ?1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
> index 0630513..065cc04 100644
> --- a/arch/arm/plat-mxc/include/mach/hardware.h
> +++ b/arch/arm/plat-mxc/include/mach/hardware.h
> @@ -96,6 +96,7 @@
> ?*/
> ?#define IMX_IO_P2V(x) ?( ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ? ? ? ? ? ? ? ? ?0xf4000000 + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? (((x) & 0x80000000) >> 7) + ? ? ? ? ? ? ? ? ? ? \

I doubled checked this today and this will result in some of the
platform addresses being in the 0xf6000000 boundary.  Instead, the '+'
can be made an '|' and the addresses that get generated all appear to
be acceptable without any conflicts.

I'll re-submit this patch with the above fix and commet changes as
part of a imx5 idle cleanup series unless I'm told that a change to
this macro is unacceptable.

Thanks,
Rob

> ? ? ? ? ? ? ? ? ? ? ? ?(((x) & 0x50000000) >> 6) + ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ? ? ? ? ? ? ? ? ?(((x) & 0x0b000000) >> 4) + ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ? ? ? ? ? ? ? ? ?(((x) & 0x000fffff)))
> --
> 1.7.10
>
