From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Mon, 16 Apr 2012 15:35:38 +0530
Subject: [PATCH] ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
In-Reply-To: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
References: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAMrsUdLMugSaq74ke+1pdu9sUbAd7av61sB+hywTiZiOoxy-zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 11:25 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> The current serial UART code, while fidling with ocp idlemode bits,
> forget about the smart idle wakeup bit even if it is supported by
> UART IP block. This will lead to missing the module wakeup on OMAP's
> where the smart idle wakeup is supported.
>
> This was the root cause of the console sluggishness issue, I have been
> observing on OMAP4 devices and also can be potential reason for some
> other UART wakeup issues.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

Adding to git://gitorious.org/linux-3-x/omap-serial.git  for_3.4/uart_fixes

> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> ?arch/arm/mach-omap2/serial.c | ? ?8 +++++++-
> ?1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index c9503a7..b28aae1 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -108,8 +108,14 @@ static void omap_uart_set_noidle(struct platform_device *pdev)
> ?static void omap_uart_set_smartidle(struct platform_device *pdev)
> ?{
> ? ? ? ?struct omap_device *od = to_omap_device(pdev);
> + ? ? ? u8 idlemode;
>
> - ? ? ? omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
> + ? ? ? if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
> + ? ? ? ? ? ? ? idlemode = HWMOD_IDLEMODE_SMART_WKUP;
> + ? ? ? else
> + ? ? ? ? ? ? ? idlemode = HWMOD_IDLEMODE_SMART;
> +
> + ? ? ? omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
> ?}
>
> ?#else
> --
> 1.7.5.4
>
