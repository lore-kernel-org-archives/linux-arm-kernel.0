From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 19 Apr 2016 16:24:02 +0900
Subject: [PATCH] pinctrl-exynos5440: Use off-stack memory for
 pinctrl_gpio_range
In-Reply-To: <1461039222-26592-1-git-send-email-andrew@aj.id.au>
References: <1461039222-26592-1-git-send-email-andrew@aj.id.au>
Message-ID: <CA+Ln22Fcdp=W1A7ZY5nNNkUqHWfTTepVBS+SzjdoeO2HDJGpuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

2016-04-19 13:13 GMT+09:00 Andrew Jeffery <andrew@aj.id.au>:
> The range is registered into a linked list which can be referenced
> throughout the lifetime of the driver. Ensure the range's memory is useful
> for the same lifetime by adding it to the driver's private data structure.
>
> The bug was introduced in the driver's initial commit, which was present in
> v3.10.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Fixes: f0b9a7e521fa ("pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC")
> Cc: stable at vger.kernel.org
> ---
> This is my first contribution to the kernel, so hopefully I've followed all the
> relevant documentation. If not, please let me know and point me in the right
> direction!
>
> I don't have the means to test the patch, but it compiles. Someone with
> appropriate hardware should probably give it a spin.
>

Thanks for the patch. Good catch, I wonder how this even worked. Just
one minor nitpick below.

Unfortunately I don't have any platform based on this SoC to test, so
I'll defer to Krzysztof or Sylwester to handle this.

Given the nitpick is fixed:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

>  drivers/pinctrl/samsung/pinctrl-exynos5440.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
> index 00ab63abf1d9..d45028a75c0f 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
> @@ -117,6 +117,7 @@ struct exynos5440_pinctrl_priv_data {
>         unsigned int                    nr_groups;
>         const struct exynos5440_pmx_func        *pmx_functions;
>         unsigned int                    nr_functions;
> +       struct pinctrl_gpio_range       range;

It would be nice to also describe this field in the kerneldoc comment
above the struct.

Best regards,
Tomasz
