From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 11:11:33 +0100
Subject: [RFC 22/37] watchdog: renesas_wdt: Add restart support
In-Reply-To: <1516903391-30467-23-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-23-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdU+n=VA4T-fOF4SjsxZtu1M1thxNAD8dHex=H_bz95jgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC Wolfram

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This commit extends the driver to add restart support by implementing
> the restart callback to trigger the watchdog as quickly as possible.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
>  drivers/watchdog/renesas_wdt.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 831ef83..120ddac 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -107,6 +107,24 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
>         return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
>  }
>
> +static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
> +                       void *data)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       pm_runtime_get_sync(wdev->parent);
> +
> +       rwdt_write(priv, 0x00, RWTCSRB);
> +       rwdt_write(priv, 0x00, RWTCSRA);
> +       rwdt_write(priv, 0xffff, RWTCNT);
> +
> +       while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +               cpu_relax();
> +
> +       rwdt_write(priv, 0x80, RWTCSRA);
> +       return 0;
> +}
> +
>  static const struct watchdog_info rwdt_ident = {
>         .options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
>         .identity = "Renesas WDT Watchdog",
> @@ -118,6 +136,7 @@ static const struct watchdog_ops rwdt_ops = {
>         .stop = rwdt_stop,
>         .ping = rwdt_init_timeout,
>         .get_timeleft = rwdt_get_timeleft,
> +       .restart = rwdt_restart,
>  };
>
>  static int rwdt_probe(struct platform_device *pdev)
> --
> 2.7.4
