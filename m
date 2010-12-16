From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 16 Dec 2010 14:08:11 +0530
Subject: [PATCH v4 4/5] OMAP: mailbox: build device using
	omap_device/omap_hwmod
In-Reply-To: <1292482079-2226-5-git-send-email-omar.ramirez@ti.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-5-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTik4K3LEovr-wJiv_PG+ivHNj8hxPT7QPua-ytVf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

couple of comments.

On Thu, Dec 16, 2010 at 12:17, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> Remove static platform_device and resource data within
> omap mailbox driver; use the one defined in the hwmod
> database along with omap_device framework for device
> build and registration.
>
> Add device latency functions to be used, so clock can be
> enabled and sysconfig is configured.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> ?arch/arm/mach-omap2/devices.c | ?102 ++++++++---------------------------------
> ?1 files changed, 20 insertions(+), 82 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index b5cafd3..7493c30 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -142,95 +142,33 @@ static inline void omap_init_camera(void)
> ?#endif

<<snip>>

> +
> + ? ? ? oh = omap_hwmod_lookup("mailbox");
> + ? ? ? if (!oh) {
> + ? ? ? ? ? ? ? pr_err("%s: unable to find hwmod\n", __func__);
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> +
> + ? ? ? od = omap_device_build("omap-mailbox", -1, oh,
> + ? ? ? ? ? ? ? ? ? ? ? NULL, 0,
> + ? ? ? ? ? ? ? ? ? ? ? mbox_latencies, ARRAY_SIZE(mbox_latencies),
> + ? ? ? ? ? ? ? ? ? ? ? 0);
> + ? ? ? if (!od) {

Check for IS_ERR(od).

> + ? ? ? ? ? ? ? pr_err("%s: could not build device\n", __func__);
> ? ? ? ? ? ? ? ?return;

This "return" can be removed.

> ? ? ? ?}
> - ? ? ? platform_device_register(&mbox_device);
> ?}
> ?#else
> ?static inline void omap_init_mbox(void) { }
> --
> 1.7.1
>
>
