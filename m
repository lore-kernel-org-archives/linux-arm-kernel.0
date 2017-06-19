From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 19 Jun 2017 11:51:20 -0600
Subject: [PATCH] [perf/core branch] perf coresight: Fix ARM builds caused
 by misplaced __printf
In-Reply-To: <20170616145907.baba73eda242efe194e072d0@arm.com>
References: <20170616145907.baba73eda242efe194e072d0@arm.com>
Message-ID: <CANLsYkyG3E9xiOyJz_5EA0B0oQGsSCy2oW7i1iY5YUxU1imKng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2017 at 13:59, Kim Phillips <kim.phillips@arm.com> wrote:
> Trailing __printf attributes work for function declarations, but not
> definitions.  This patch fixes arm32/64 builds by placing __printf
> before the declarator.  Otherwise this happens:
>
> arch/arm64/util/../../arm/util/cs-etm.c:586:1: error: attributes should be specified before the declarator in a function definition
>  static int cs_device__print_file(const char *name, const char *fmt, ...) __printf(2, 3)
>  ^~~~~~
> arch/arm64/util/../../arm/util/cs-etm.c: In function ?cs_etm_set_drv_config?:
> arch/arm64/util/../../arm/util/cs-etm.c:610:8: error: implicit declaration of function ?cs_device__print_file? [-Werror=implicit-function-declaration]
>   ret = cs_device__print_file(enable_sink, "%d", 1);
>         ^~~~~~~~~~~~~~~~~~~~~
> arch/arm64/util/../../arm/util/cs-etm.c:610:2: error: nested extern declaration of ?cs_device__print_file? [-Werror=nested-externs]
>   ret = cs_device__print_file(enable_sink, "%d", 1);
>   ^~~
> At top level:
> arch/arm64/util/../../arm/util/cs-etm.c:566:14: error: ?cs_device__open_file? defined but not used [-Werror=unused-function]
>  static FILE *cs_device__open_file(const char *name)
>               ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Fixes: 2ee261d962ac "tools: Adopt __printf from kernel sources"
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Applies to acme's perf/core branch
>
>  tools/perf/arch/arm/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 90a6f42ba904..7ce3d1a25133 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -583,7 +583,7 @@ static FILE *cs_device__open_file(const char *name)
>
>  }
>
> -static int cs_device__print_file(const char *name, const char *fmt, ...) __printf(2, 3)
> +static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
>  {
>         va_list args;
>         FILE *file;

I just tested Kim's solution on my side.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> --
> 2.11.0
>
