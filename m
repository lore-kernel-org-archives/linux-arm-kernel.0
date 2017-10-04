From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 13:19:40 +0200
Subject: [PATCH v3 04/22] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <1506604306-20739-5-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-5-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a1o+thrkyUmf2DGYq4pb087y8gwHo2jTyqcDxWdMAnogQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> +static int scmi_mbox_free_channel(struct scmi_info *info)
> +{
> +       if (!IS_ERR_OR_NULL(info->tx_chan)) {
> +               mbox_free_channel(info->tx_chan);
> +               info->tx_chan = NULL;
> +       }
> +
> +       return 0;
> +}

Any use of IS_ERR_OR_NULL() tends to be an indication of a bad API
design. Please make a decision about what you want to store in
info->tx_chan and stick with it.

Usually, we don't store error pointers in permanent data structures.
If you can deal with tx_chan being absent here, then you can just
store NULL into it when you don't have one, otherwise you should
make sure you never call this and fail the probe function earlier.

      Arnd
