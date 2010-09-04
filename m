From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 4 Sep 2010 13:38:24 +0800
Subject: [PATCH] ARM: pxa: Fix pxa3xx-u2d crash when ULPI not used
In-Reply-To: <1283546146-20000-1-git-send-email-marek.vasut@gmail.com>
References: <1283546146-20000-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTim5Gw9P91WWeoebq_qzoy+UUHMLx01nn7b0ybLf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 4, 2010 at 4:35 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> In case the pxa3xx-u2d driver isn't used, probing of ohci-pxa27x will cause an
> ugly kernel crash (NULL pointer dereference in pxa3xx_u2d_start_hc(), because
> struct u2d is NULL and clk_enable() call will crash the kernel, trying to access
> it).
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied to 'devel'.

> ---
> ?arch/arm/mach-pxa/pxa3xx-ulpi.c | ? ?8 ++++++++
> ?1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> index e57439e..ce7168b 100644
> --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> @@ -252,6 +252,10 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
> ?{
> ? ? ? ?int err = 0;
>
> + ? ? ? /* In case the PXA3xx ULPI isn't used, do nothing. */
> + ? ? ? if (!u2d)
> + ? ? ? ? ? ? ? return 0;
> +
> ? ? ? ?clk_enable(u2d->clk);
>
> ? ? ? ?if (cpu_is_pxa310()) {
> @@ -264,6 +268,10 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
>
> ?void pxa3xx_u2d_stop_hc(struct usb_bus *host)
> ?{
> + ? ? ? /* In case the PXA3xx ULPI isn't used, do nothing. */
> + ? ? ? if (!u2d)
> + ? ? ? ? ? ? ? return;
> +
> ? ? ? ?if (cpu_is_pxa310())
> ? ? ? ? ? ? ? ?pxa310_stop_otg_hc();
>
> --
> 1.7.1
>
>
