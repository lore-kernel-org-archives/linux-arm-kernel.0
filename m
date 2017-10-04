From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 13:36:39 +0200
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> This patch adds ARM MHU specific mailbox interface for SCMI.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This clearly needs an explanation why we need another driver.

> +union mhu_data {
> +       void *ptr;
> +       u32 val;
> +};
> +
> +static void mhu_tx_prepare(struct mbox_client *cl, void *m)
> +{
> +       struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
> +       union mhu_data tmp;
> +
> +       scmi_generic_tx_prepare(cinfo, m);
> +
> +       /* clear only the relavant bit */
> +       tmp.ptr = cinfo->priv;
> +       *(u32 *)m &= tmp.val;
> +}

Why do you use the first 32 bits of the pointer here? That doesn't
seem to make any sense, in particular on big-endian 64-bit
architectures.

> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 97285a22dfaa..bdc9c566e6c1 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -648,6 +648,9 @@ EXPORT_SYMBOL_GPL(devm_scmi_handle_get);
>  /* Each compatible listed below must have descriptor associated with it */
>  static const struct of_device_id scmi_of_match[] = {
>         { .compatible = "arm,scmi", .data = &scmi_generic_desc },
> +#if IS_REACHABLE(CONFIG_ARM_MHU)
> +       { .compatible = "arm,mhu-scmi", .data = &mhu_scmi_desc },
> +#endif
>         { /* Sentinel */ },
>  };
>

This again is a bad abstraction, if the main part needs to know about
each mailbox that it could use.

Turn the registration around so rather than referring to an exported
symbol from mhu_scmi_desc.c in the main driver, you export
a symbol to register the operations and make the mhu
part its own module.

       Arnd
