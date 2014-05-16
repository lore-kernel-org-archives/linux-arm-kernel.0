From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 16 May 2014 10:50:24 +0200
Subject: [PATCH v2] cpufreq: exynos:  Fix the compile error
In-Reply-To: <000001cf70dc$9ccfe4e0$d66faea0$@samsung.com>
References: <000001cf70dc$9ccfe4e0$d66faea0$@samsung.com>
Message-ID: <5375D150.1020109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonghwan,

On 16.05.2014 09:58, Jonghwan Choi wrote:
> Commit 7da83a80 ("ARM: EXYNOS: Migrate Exynos specific macros from plat to mach")
> which lands in samsung tree causes build breakage for cpufreq-exynos like following:
> drivers/cpufreq/exynos-cpufreq.c: In function 'exynos_cpufreq_probe':
> drivers/cpufreq/exynos-cpufreq.c:166:2: error: implicit declaration of function 'soc_is_exynos4210'
> [-Werror=implicit-function-declaration]
> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of function 'soc_is_exynos4212'
> [-Werror=implicit-function-declaration]
> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of function 'soc_is_exynos4412'
> [-Werror=implicit-function-declaration]
> drivers/cpufreq/exynos-cpufreq.c:170:2: error: implicit declaration of function 'soc_is_exynos5250'
> [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> drivers/cpufreq/exynos4x12-cpufreq.c: In function 'exynos4x12_set_clkdiv':
> drivers/cpufreq/exynos4x12-cpufreq.c:118:2: error: implicit declaration of function 'soc_is_exynos4212'
> [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/cpufreq/exynos4x12-cpufreq.o] Error 1
> make[1]: *** [drivers/cpufreq] Error 2
> This fixes above error with getting SoC information via DT instead of soc_is_exynosXXXX().
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-exynos.txt |   18 ++++++++
>  drivers/cpufreq/Kconfig.arm                        |    4 +-
>  drivers/cpufreq/exynos-cpufreq.c                   |   47 +++++++++++++++++---
>  drivers/cpufreq/exynos-cpufreq.h                   |    8 ++++
>  drivers/cpufreq/exynos4x12-cpufreq.c               |   11 ++---
>  5 files changed, 72 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
> new file mode 100644
> index 0000000..f5e8ac6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
> @@ -0,0 +1,18 @@
> +
> +Exynos cpufreq driver
> +-------------------
> +
> +Exynos4210/4212/4412/5250 SoC cpufreq driver for CPU frequency scaling.
> +
> +Required properties:
> +  - compatible: value should be either of the following.
> +      (a) "samsung, exynos4210-cpufreq", for Exynos4210.
> +      (b) "samsung, exynos4212-cpufreq", for Exynos4212.
> +      (c) "samsung, exynos4412-cpufreq", for Exynos4412.
> +      (d) "samsung, exynos5250-cpufreq", for Exynos5250.
> +
> +Example:
> +--------
> +	cpufreq at 10030000 {
> +		compatible = "samsung,exynos4210-cpufreq";
> +	};

Sorry, NAK. Cpufreq is not a real device on the SoC and this is not the
right way to represent it in DT.

We have been discussing Exynos cpufreq framework rework, including DT
support since quite a long time. so if you want to know details, please
look at respective discussion threads. I don't have time to find them
for you right now, but if you look for threads of cpufreq patches by
Thomas Abraham and ones about Exynos multiplatform support, then you
should have quite complete set of information.

In general, I can see three ways to "fix" this for 3.15:

1) revert moving soc_is_* macros to mach-exynos/common.h,

2) move soc_is_* macros to a header in mach-exynos/include/mach/,

3) use of_machine_is_compatible() or of_match_node() on root node in
this driver to match directly with SoC compatible strings.

Probably option 3) would be preferred, as it would remove some of the
dependencies of this driver on arch code and including plat/cpu.h (or
mach/cpu.h as would be introduced by 2)) would be no longer necessary.

Best regards,
Tomasz
