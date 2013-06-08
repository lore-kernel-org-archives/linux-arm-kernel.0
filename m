From: Russ.Dill@ti.com (Russ Dill)
Date: Sat, 8 Jun 2013 11:46:39 -0700
Subject: [PATCH 2/7] omap: mailbox: check for NULL nb in mailbox_put
In-Reply-To: <1370656664-41250-1-git-send-email-s-anna@ti.com>
References: <1370656664-41250-1-git-send-email-s-anna@ti.com>
Message-ID: <CA+Bv8XZW-Xv7D-TxqTiUF-t-QESMQqWGOq2fLshXVA-N7if_5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 6:57 PM, Suman Anna <s-anna@ti.com> wrote:
> The mailbox_put function must check the notifier block for
> NULL before trying to unregister it.

I'm going to nack this one. Why must it check for NULL? None of the
callers pass a NULL argument and blocking_notifier_chain_unregister
handles a NULL nb argument just fine.

> Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/plat-omap/mailbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 42377ef..5fb4027 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -356,7 +356,8 @@ EXPORT_SYMBOL(omap_mbox_get);
>
>  void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
>  {
> -       blocking_notifier_chain_unregister(&mbox->notifier, nb);
> +       if (nb)
> +               blocking_notifier_chain_unregister(&mbox->notifier, nb);
>         omap_mbox_fini(mbox);
>  }
>  EXPORT_SYMBOL(omap_mbox_put);
> --
> 1.8.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
