From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 17 Mar 2011 23:06:51 +0800
Subject: [PATCH 2/2] [ARM] am300epd: fix resource leak in
	am300_init_gpio_regs error path
In-Reply-To: <1299477371.10486.2.camel@mola>
References: <1299477315.10486.1.camel@mola> <1299477371.10486.2.camel@mola>
Message-ID: <AANLkTikQiFxEhn5pMDQY6K_oB+i4r1Y64aA+98FyAxDk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applied.

On Mon, Mar 7, 2011 at 1:56 PM, Axel Lin <axel.lin@gmail.com> wrote:
> If gpio_request fails when i > 0, gpios[0] is not freed in current
> implementation.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> ?arch/arm/mach-pxa/am300epd.c | ? 13 +++++++------
> ?1 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
> index 993d75e..fa8bad2 100644
> --- a/arch/arm/mach-pxa/am300epd.c
> +++ b/arch/arm/mach-pxa/am300epd.c
> @@ -125,10 +125,7 @@ static int am300_init_gpio_regs(struct broadsheetfb_par *par)
> ? ? ? ? ? ? ? ?if (err) {
> ? ? ? ? ? ? ? ? ? ? ? ?dev_err(&am300_device->dev, "failed requesting "
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"gpio %d, err=%d\n", i, err);
> - ? ? ? ? ? ? ? ? ? ? ? while (i >= DB0_GPIO_PIN)
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? gpio_free(i--);
> - ? ? ? ? ? ? ? ? ? ? ? i = ARRAY_SIZE(gpios) - 1;
> - ? ? ? ? ? ? ? ? ? ? ? goto err_req_gpio;
> + ? ? ? ? ? ? ? ? ? ? ? goto err_req_gpio2;
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
>
> @@ -159,9 +156,13 @@ static int am300_init_gpio_regs(struct broadsheetfb_par *par)
>
> ? ? ? ?return 0;
>
> +err_req_gpio2:
> + ? ? ? while (--i >= DB0_GPIO_PIN)
> + ? ? ? ? ? ? ? gpio_free(i);
> + ? ? ? i = ARRAY_SIZE(gpios);
> ?err_req_gpio:
> - ? ? ? while (i > 0)
> - ? ? ? ? ? ? ? gpio_free(gpios[i--]);
> + ? ? ? while (--i >= 0)
> + ? ? ? ? ? ? ? gpio_free(gpios[i]);
>
> ? ? ? ?return err;
> ?}
> --
> 1.7.2
>
>
>
>
