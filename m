From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 19 Mar 2018 08:55:25 -0600
Subject: [PATCH 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <1516924513-20183-3-git-send-email-ckadabi@codeaurora.org>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-3-git-send-email-ckadabi@codeaurora.org>
Message-ID: <20180319145525.GD28808@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 03:55:13PM -0800, Channagoud Kadabi wrote:
> LLCC (Last Level Cache Controller) provides additional cache memory
> in the system. LLCC is partitioned into muliple slices and each
> slice gets its own priority, size, ID and other config parameters.
> LLCC driver programs these parameters for each slice. Clients that
> are assigned to use LLCC need to get information such size & ID of the
> slice for their usecase and activate or deactivate the slice as needed.
> LLCC driver provides API interfaces for the clients to perform these
> operations.

<snip>

> +/**
> + * llcc_slice_deactivate - Deactivate the llcc slice
> + * @desc: Pointer to llcc slice descriptor
> + *
> + * A value zero will be returned on success and a negative errno will
> + * be returned in error cases
> + */
> +int llcc_slice_deactivate(struct llcc_slice_desc *desc)
> +{
> +	u32 act_ctrl_val;
> +	int rc = -EINVAL;
> +	struct llcc_drv_data *drv;
> +
> +	if (desc == NULL) {
> +		pr_err("Input descriptor supplied is invalid\n");

Sorry that this is out of the blue, but I was reviewing a client driver that
uses this API. This should not print an error - we should be allowed to safely
pass a null pointer from an aborted sequence in the driver without the
conditional checks and it shouldn't generate a bit of log spam as it goes about
it's business.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
