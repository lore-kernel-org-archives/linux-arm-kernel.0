From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 14 Mar 2014 13:00:38 -0500
Subject: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140314180038.GT18529@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 07:07:43PM -0700, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> +++ b/drivers/i2c/busses/i2c-qup.c
[..]
> +static int qup_i2c_xfer(struct i2c_adapter *adap,
> +			struct i2c_msg msgs[],
> +			int num)
> +{
> +	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> +	int ret, idx;
> +
> +	ret = pm_runtime_get_sync(qup->dev);
> +	if (IS_ERR_VALUE(ret))
> +		goto out;

General i2c question: is there a reason why the core isn't responsible
for ensuring a device is not suspended before invoking ->master_xfer
(and smbus_xfer)?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
