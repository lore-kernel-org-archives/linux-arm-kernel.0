From: vitalywool@gmail.com (Vitaly Wool)
Date: Wed, 28 Jul 2010 21:47:41 +0200
Subject: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
In-Reply-To: <1279733634-21974-4-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-4-git-send-email-ohad@wizery.com>
Message-ID: <AANLkTimzA_JJ-byTDWznbL3YzeJ8LAP4M50onf2_3fBF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Wed, Jul 21, 2010 at 7:33 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Add support to set/get mmc_host private embedded
> data.
>
> This is needed to allow software to dynamically
> create (and remove) SDIO functions which represents
> embedded SDIO devices.
>
<snip>
> @@ -209,6 +209,8 @@ struct mmc_host {
> ? ? ? ?struct led_trigger ? ? ?*led; ? ? ? ? ? /* activity led */
> ?#endif
>
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?*embedded_data;
> +

To my understanding, this data doesn't belong to mmc_host. It's not a
host data at all. E. g. imagine a GPIO IRQ for some SDIO chip -- it's
totally unrelated to host.

I think a cleaner way would be to introduce something similar to what
we have for SPI, e. g. struct sdio_board_info. This board info will
contain platform-specific stuff and vendor id/chip id for each onboard
SDIO device. Then the SDIO core will pick up the appropriate data
basing on vendor id/chip id.

~Vitaly
