From: anilk4.v@gmail.com (Anil Kumar)
Date: Fri, 15 Feb 2013 21:49:21 +0530
Subject: [PATCH v2 3/8] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return
 value
In-Reply-To: <1360682305-20935-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360682305-20935-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CABYxbz6tZJjuz0NKorPSz_tWD42+HuHL3kwW0cegWW5QTDxH8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 12, 2013 at 8:48 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Currently gpmc_cs_reserved() return value is somewhat inconsistent,
> returning a negative value on an error condition, a positive value
> if the chip select is reserved and zero if it's available.
>
> Fix this by returning a boolean value as the function name suggests:
>   * true if the chip select is reserved,
>   * false if it's available
>
> Suggested-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changelog from v1:
>  * As suggested by Felipe Balbi, fix return code to a boolean
>
>  arch/arm/mach-omap2/gpmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index bd3bc93..fa4764f 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -452,10 +452,10 @@ static int gpmc_cs_set_reserved(int cs, int reserved)
>         return 0;
>  }
>
> -static int gpmc_cs_reserved(int cs)
> +static bool gpmc_cs_reserved(int cs)
>  {
>         if (cs > GPMC_CS_NUM)
> -               return -ENODEV;
> +               return true;
>
>         return gpmc_cs_map & (1 << cs);
>  }

commit "6797b4fe0e554ce71f47038fd929c9ca929a9f3c"
Marking all the chip-selects as reserved by default.

In this case gpmc_cs_map is 0xff. So it will return 0x1 if cs is 0.
So gpmc_cs_request() function will fail in nand (gpmc-nand.c) case.

I am taking reference, branch "omap-for-v3.9/gpmc" of git tree
http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

I am sorry if this question is very vague.

Thanks,
Anil
