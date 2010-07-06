From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 6 Jul 2010 18:49:24 +0300
Subject: [PATCH 04/15] mmc: support embedded data field in mmc_host
In-Reply-To: <1278376666-3509-5-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-5-git-send-email-ohad@wizery.com>
Message-ID: <AANLkTilfjBIbylUDKlTGiEC_U6pJnkC6HoENOzK2eFFq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 6, 2010 at 3:37 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> From: Ohad Ben-Cohen <ohadb@ti.com>
>
> Add support to set/get mmc_host private embedded
> data.
>
> This is needed to allow software to dynamically
> create (and remove) SDIO functions which represents
> embedded SDIO devices.
>
> Typically, it will be used to set the context of
> a driver that is creating a new SDIO function
> (and would then expect to be able to get that context
> back upon creation of the new sdio func).
>
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> ---
> ?drivers/mmc/core/Kconfig | ? ?8 ++++++++
> ?include/linux/mmc/host.h | ? 16 ++++++++++++++++
> ?2 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bb22ffd..ab27eb3 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -16,3 +16,11 @@ config MMC_UNSAFE_RESUME
>
> ? ? ? ? ?This option sets a default which can be overridden by the
> ? ? ? ? ?module parameter "removable=0" or "removable=1".
> +
> +config MMC_EMBEDDED_SDIO
> + ? ? ? boolean "MMC embedded SDIO device support"
> + ? ? ? help
> + ? ? ? ? If you say Y here, support will be added for embedded SDIO
> + ? ? ? ? devices (e.g. hardwired embedded WLAN SDIO devices).
> + ? ? ? ? Such devices require software support for emulating
> + ? ? ? ? card detect events.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..9a48486 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -209,6 +209,10 @@ struct mmc_host {
> ? ? ? ?struct led_trigger ? ? ?*led; ? ? ? ? ? /* activity led */
> ?#endif
>
> +#ifdef CONFIG_MMC_EMBEDDED_SDIO
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?*embedded_data;
> +#endif
> +

Hm, do we really need a Kconfig option just for a single pointer? It
only saves sizeof(void *) bytes per host, but adds rather confusing
config option for users and some ifdef complexity.
