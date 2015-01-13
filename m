From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 Jan 2015 12:35:38 +0100
Subject: [PATCH v5 2/2] i2c: cadence: Check for errata condition
 involving master receive
In-Reply-To: <1418357907-4215-3-git-send-email-harinik@xilinx.com>
References: <1418357907-4215-1-git-send-email-harinik@xilinx.com>
 <1418357907-4215-3-git-send-email-harinik@xilinx.com>
Message-ID: <20150113113538.GB7660@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -541,6 +541,18 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 * processed with a repeated start.
>  	 */
>  	if (num > 1) {
> +		/*
> +		 * This controller does not give completion interrupt after a
> +		 * master receive transfer if HOLD bit is set (repeated start),
> +		 * resulting in SW timeout. Hence, if a receive transfer is
> +		 * followed by any other transfer, an error is returned
> +		 * indicating that this sequence is not supported.
> +		 */
> +		for (count = 0; count < num-1; count++) {
> +			if (msgs[count].flags & I2C_M_RD)
> +				dev_warn(adap->dev.parent, "No support for repeated start when receive is followed by a transfer\n");
> +				return -EOPNOTSUPP;
> +		}
>  		id->bus_hold_flag = 1;
>  		reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
>  		reg |= CDNS_I2C_CR_HOLD;

Have you ever tested this code? There is a huge bug in it :(

Also, in the comment, use "message" instead of "transfer". One transfer
consists of multiple messages.

Maybe the warning can be simplified, too: "can't do repeated start after
read messages".

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/0c9bc59e/attachment-0001.sig>
