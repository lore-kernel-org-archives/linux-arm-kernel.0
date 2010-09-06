From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 6 Sep 2010 13:52:24 +0900
Subject: [PATCH 3/4] ARM: S5PC110: add common FIMC setup code
In-Reply-To: <1283745044-15514-4-git-send-email-m.szyprowski@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
	<1283745044-15514-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <AANLkTinhbmKX5gs4TPZwVUX0WSEQ5RLN+_gHAqXsTj1b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 6, 2010 at 12:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
....
> + ? ? ? parent = clk_get(NULL, "mout_epll");
> + ? ? ? if (IS_ERR(parent))
> + ? ? ? ? ? ? ? return PTR_ERR(parent);
> +
> + ? ? ? for (i = 0; err == 0 && i < ARRAY_SIZE(fimc_devs); i++) {
> + ? ? ? ? ? ? ? if (fimc_devs[i]) {
> + ? ? ? ? ? ? ? ? ? ? ? clk_fimc = clk_get(fimc_devs[i], "sclk_fimc");
> + ? ? ? ? ? ? ? ? ? ? ? if (IS_ERR(clk_fimc)) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? err = PTR_ERR(clk_fimc);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? clk_set_parent(clk_fimc, parent);
> + ? ? ? ? ? ? ? ? ? ? ? clk_put(clk_fimc);
> + ? ? ? ? ? ? ? }
> + ? ? ? }

The sclk_fimc could source clock from a number of options out of a mux.
mout_epll is just one of them. Different machines may want to source the
clock differently.
So, IMO the parent selection should not be done in platform code, but rather
in machine init code.
Not the best, but a better solution can be found in
arch/arm/mach-s5pc100/dev-spi.c
Give it a thought.
