From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Mon, 11 May 2015 20:10:58 +0530
Subject: [PATCH 1/1] mailbox: Add ability for clients to request channels
 by name
In-Reply-To: <1430323164-26945-1-git-send-email-lee.jones@linaro.org>
References: <1430323164-26945-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAJe_Zhdw4PW3uUekhj=ifc29cJWcFHVvCHKTm18Q9Dn_801ZZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 April 2015 at 21:29, Lee Jones <lee.jones@linaro.org> wrote:
> This patch supplies a new framework API; mbox_request_channel_byname().
>
> It works by supplying the usual client pointer as the first argument and
> a string as the second.  The API will search the client's node for a
> 'mbox-names' property then request a channel in the normal way using the
> requested string's index as the expected second 'index' argument.
>
The api seems prudent. Thanks.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mailbox/mailbox.c      | 23 +++++++++++++++++++++++
>  include/linux/mailbox_client.h |  2 ++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 19b491d..981a76cb 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -357,6 +357,29 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
>  }
>  EXPORT_SYMBOL_GPL(mbox_request_channel);
>
> +struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
> +                                             const char *name)
> +{
> +       struct device_node *np = cl->dev->of_node;
> +       struct property *prop;
> +       const char *mbox_name;
> +       int index = 0;
> +
> +       if (!np) {
> +               dev_err(cl->dev, "%s() only supports DT\n", __func__);
> +               return ERR_PTR(-ENOSYS);
> +       }
> +
> +       of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
> +               if (!strncmp(name, mbox_name, strlen(name)))
> +                       break;
> +               index++;
> +       }
> +
> +       return mbox_request_channel(cl, index);
>
'mbox-names' property is specified as optional in Mailbox bindings. We
don't want to return chan at 0 if the property isn't populated.

Also please remove the line "The use of this property is discouraged
..." from Documentation/devicetree/bindings/mailbox/mailbox.txt now
that we add an api for just that.

Thanks.
