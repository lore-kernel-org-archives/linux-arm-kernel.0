From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 1 Aug 2017 21:36:57 +0530
Subject: [PATCH v2 2/3] mailbox: introduce ARM SMC based mailbox
In-Reply-To: <1500852206-28771-3-git-send-email-andre.przywara@arm.com>
References: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
 <1500852206-28771-3-git-send-email-andre.przywara@arm.com>
Message-ID: <CABb+yY0H3yKJeGLxnaYVrd=XVnRTU4z0eZj2yGGWRmYo0hoN8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 4:53 AM, Andre Przywara <andre.przywara@arm.com> wrote:

> +static int arm_smc_send_data(struct mbox_chan *link, void *data)
> +{
> +       struct arm_smc_chan_data *chan_data = link->con_priv;
> +       u32 function_id = chan_data->function_id;
> +       struct arm_smccc_res res;
> +       u32 msg = *(u32 *)data;
> +
> +       if (chan_data->flags & ARM_SMC_MBOX_USE_HVC)
> +               arm_smccc_hvc(function_id, msg, 0, 0, 0, 0, 0, 0, &res);
> +       else
> +               arm_smccc_smc(function_id, msg, 0, 0, 0, 0, 0, 0, &res);
> +
Sorry, I didn't notice earlier that you cull parameters [R2, R7] to
SMC/HVC call by making them all 0s ...
        arm_smccc_smc(function_id, msg, 0, 0, 0, 0, 0, 0, &res);

I see you have SCMI/SCPI on your mind, however we need to make
controller drivers independent of users.

I think this driver should simply emulate mailbox over the SMC/HVC
calls. That is, respect all parameters.
So maybe we should define a
   struct arm_smccc_mbox_cmd {
         unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
   }

and have
static int arm_smc_send_data(struct mbox_chan *link, void *data)
{
       struct arm_smc_chan_data *chan_data = link->con_priv;
       struct arm_smccc_res res;
       struct arm_smccc_mbox_cmd *cmd = data;
       u32 function_id = cmd->a0;

       ..... and pass cmd.{a1, a2, a3, a4, a5, a6, a7} to the SMC/HVC call.
          ....
}

And BTW, instead of specifying 'func-ids' in DT, we can have
'num-chans' which will tell how many identical channels to populate.
Also because the Function-Identifier seems like belong to the client
driver more than controller.

Cheers!
