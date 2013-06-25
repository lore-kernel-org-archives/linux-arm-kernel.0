From: naresh.kamboju@linaro.org (Naresh Kamboju)
Date: Tue, 25 Jun 2013 22:46:02 +0530
Subject: linux-next: panda build failed at
 arch/arm/mach-omap2/omap4-restart.c
In-Reply-To: <CA+G9fYv_9EQUmpRNPUwioSwJVXnXJC5odEKiMd=vKHNWYRT8xw@mail.gmail.com>
References: <CA+G9fYv_9EQUmpRNPUwioSwJVXnXJC5odEKiMd=vKHNWYRT8xw@mail.gmail.com>
Message-ID: <CA+G9fYupw8Gi=5p2nKVJ9GqfhwBcTw7hyzGA8+K+gHmdL96mJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

On 23 June 2013 13:53, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> Hi,
>
> panda build broken on linux-next branch
>
> kernel_config=omap2plus_defconfig
> KERNEL_VERSION=3.10.0-rc6
> KERNEL_GIT=git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> KERNEL_COMMIT=e1a86578747376f08985627c84df088a5d0d1e92
>
> Build error log :
> -------------------
> 04:43:18   CC      arch/arm/mach-omap2/omap4-restart.o
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel_cloud/arch/arm/mach-omap2/omap4-restart.c:21:28:
> warning: ?enum reboot_mode? declared inside parameter list [enabled by
> default]
> 04:43:18  void omap44xx_restart(enum reboot_mode mode, const char *cmd)
> 04:43:18                             ^
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel_cloud/arch/arm/mach-omap2/omap4-restart.c:21:28:
> warning: its scope is only this definition or declaration, which is
> probably not what you want [enabled by default]
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel_cloud/arch/arm/mach-omap2/omap4-restart.c:21:40:
> error: parameter 1 (?mode?) has incomplete type
> 04:43:18  void omap44xx_restart(enum reboot_mode mode, const char *cmd)
> 04:43:18                                         ^
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel_cloud/arch/arm/mach-omap2/omap4-restart.c:21:6:
> warning: function declaration isn?t a prototype [-Wstrict-prototypes]
> 04:43:18  void omap44xx_restart(enum reboot_mode mode, const char *cmd)
> 04:43:18       ^
> 04:43:18 make[2]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1
> 04:43:18 make[1]: *** [arch/arm/mach-omap2] Error 2
>
> Full build log:
> ------------------
> https://ci.linaro.org/jenkins/job/linux-next/hwpack=panda,label=kernel_cloud/lastBuild/console
>
> Suspecting patch which caused build failed:
> --------------------------------------------------------
> commit b61cdf2aebc5cd2f4efc4e0cbebeb8a91884a43e
> Author: Robin Holt <holt@sgi.com>
> Date:   Wed Jun 19 10:08:43 2013 +1000
>
> reboot: arm: change reboot_mode to use enum reboot_mode
>
> Preparing to move the parsing of reboot= to generic kernel code forces the
> change in reboot_mode handling to use the enum.
>
> Signed-off-by: Robin Holt <holt@sgi.com>
>
> ...
> diff --git a/arch/arm/mach-omap2/omap4-restart.c
> b/arch/arm/mach-omap2/omap4-restart.c
> index f90e02e..652adde 100644
> --- a/arch/arm/mach-omap2/omap4-restart.c
> +++ b/arch/arm/mach-omap2/omap4-restart.c
> @@ -18,7 +18,7 @@
>   * Resets the SoC.  For @cmd, see the 'reboot' syscall in
>   * kernel/sys.c.  No return value.
>   */
> -void omap44xx_restart(char mode, const char *cmd)
> +void omap44xx_restart(enum reboot_mode mode, const char *cmd)
>  {
>         /* XXX Should save 'cmd' into scratchpad for use after reboot */
>         omap4_prminst_global_warm_sw_reset(); /* never returns */
> ...
>
> Best regards
> Naresh Kamboju
