From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Apr 2015 21:57:51 +0200
Subject: [PATCH v2 2/4] staging/nvec: reimplement on top of tegra i2c
 driver
In-Reply-To: <1427745615-5428-3-git-send-email-danindrey@mail.ru>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <1427745615-5428-3-git-send-email-danindrey@mail.ru>
Message-ID: <20150403195751.GD2016@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/**
> + * nvec_slave_cb - I2C slave callback
> + *
> + * This callback fills our RX buffers and empties our TX
> + * buffers. This uses a finite state machine.
> + */
> +static int nvec_slave_cb(struct i2c_client *client,
> +		enum i2c_slave_event event, u8 *val)
> +{
> +	struct nvec_chip *nvec = i2c_get_clientdata(client);
> +
> +	switch (event) {
> +	case I2C_SLAVE_WRITE_REQUESTED:
> +		/* Alloc new msg only if prev transaction finished */
> +		if (nvec->state == ST_NONE)
> +			nvec->rx = nvec_msg_alloc(nvec, NVEC_MSG_RX);
> +
> +		/* Should not happen in a normal world */
> +		if (unlikely(nvec->rx == NULL)) {
> +			nvec->state = ST_NONE;
> +			return -1;
> +		}
> +		nvec->rx->pos = 0;
> +
> +		if (client->addr != ((*val) >> 1)) {

Uh, I2C_SLAVE_WRITE_REQUESTED should not use val.

> +			dev_err(&client->dev,
> +				"received address 0x%02x, expected 0x%02x\n",
> +				((*val) >> 1), client->addr);
> +			return -1;
> +		}
> +		nvec->state = ST_TRANS_START;
> +		break;
> +
...

> +	case I2C_SLAVE_READ_PROCESSED:
> +		if (nvec->state != ST_RX &&
> +		    nvec->state != ST_TX) {
> +			dev_err(&client->dev,
> +				"unexpected read: state %d\n",
> +				nvec->state);
> +			return -1;
> +		}
> +
> +		if (!nvec->tx || nvec->tx->pos >= nvec->tx->size) {
> +			dev_err(nvec->dev,
> +				"tx buffer underflow on %p (%u > %u)\n",
> +				nvec->tx,
> +				(uint) (nvec->tx ? nvec->tx->pos : 0),
> +				(uint) (nvec->tx ? nvec->tx->size : 0));
> +			nvec->state = ST_NONE;
> +			break;
> +		}
> +
> +		nvec->state = ST_TX;
> +		*val = nvec->tx->data[nvec->tx->pos++];

Are you sure you want to increase the pointer here? Remember that this
byte is requested but might not be sent out if the remote master stops
the transfer after the previous byte using NACK instead of ACK.

> +		break;
> +
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/69aaf73d/attachment.sig>
