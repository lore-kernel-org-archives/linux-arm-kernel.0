From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 15:12:15 +0200
Subject: [PATCH v3 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
In-Reply-To: <20180702114033.15654-5-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-5-mperttunen@nvidia.com>
Message-ID: <20180702131215.GF13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:40:29PM +0300, Mikko Perttunen wrote:
> The HSP driver is currently in many places written with the assumption
> of only supporting doorbells. Prepare for the addition of shared
> mailbox support by removing these assumptions and cleaning up the code.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Moved fixes for some style and other issues from the next patch
>       here, where they belong.
>     
>     v3:
>     - Added Jon's Reviewed-by.
> 
>  drivers/mailbox/tegra-hsp.c | 123 +++++++++++++++++++++++++++++---------------
>  1 file changed, 81 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 0cde356c11ab..5dc21a6d01bb 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -42,6 +42,7 @@ struct tegra_hsp_channel;
>  struct tegra_hsp;
>  
>  struct tegra_hsp_channel {
> +	unsigned int type;

I think it would've been slightly nicer to avoid the type member and the
differentiation made by having different mailbox operations for each
type, but since the mailbox operations are not per "channel", I don't
see how it could be done otherwise, so:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/dd53790b/attachment.sig>
