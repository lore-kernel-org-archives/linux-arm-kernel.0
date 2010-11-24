From: charu@ti.com (Varadarajan, Charulatha)
Date: Wed, 24 Nov 2010 10:59:54 +0530
Subject: [PATCH v4 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <1290547617-16640-6-git-send-email-h-kanigeri2@ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-6-git-send-email-h-kanigeri2@ti.com>
Message-ID: <AANLkTi=tzuzOMa6kPp-a6+yn6xMLGtdVSvAxPFP5RU5q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote:
> In the current mailbox driver, the mailbox internal pointer for
> callback can be directly manipulated by the Users, so a second
> User can easily corrupt the first user's callback pointer.
> The initial effort to correct this issue can be referred here:
> https://patchwork.kernel.org/patch/107520/
>
> Along with fixing the above stated issue, this patch ?adds the
> flexibility option to register notifications from
> multiple readers to the events received on a mailbox instance.
> The discussion regarding this can be referred here.
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg30671.html
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
> ?arch/arm/plat-omap/include/plat/mailbox.h | ? ?7 +-
> ?arch/arm/plat-omap/mailbox.c ? ? ? ? ? ? ?| ?104 ++++++++++++++++-------------
> ?2 files changed, 62 insertions(+), 49 deletions(-)
>

<<snip>>

> @@ -363,10 +372,13 @@ int omap_mbox_register(struct device *parent, struct omap_mbox **list)
> ? ? ? ? ? ? ? ? ? ? ? ?ret = PTR_ERR(mbox->dev);
> ? ? ? ? ? ? ? ? ? ? ? ?goto err_out;
> ? ? ? ? ? ? ? ?}
> +

Do this change in the patch where the below code was added.

> ? ? ? ? ? ? ? ?if (cpu_is_omap44xx())
> ? ? ? ? ? ? ? ? ? ? ? ?mbox->rev = OMAP_MBOX_IP_VERSION_2;
> ? ? ? ? ? ? ? ?else
> ? ? ? ? ? ? ? ? ? ? ? ?mbox->rev = OMAP_MBOX_IP_LEGACY;
> +
> + ? ? ? ? ? ? ? BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
> ? ? ? ?}
> ? ? ? ?return 0;
>
> --
> 1.7.0
>
