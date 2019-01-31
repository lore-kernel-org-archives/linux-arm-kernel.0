Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363B6218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMteEBG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363B6218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5xAdiONXPNYKu+mSug6d7TrOy8uKHYUFfpBbnoVMb0Y=; b=OMteEBG4U+8ENSzbNu0Ip2ejc
	88geXVtVoP1JTNv5uPYfEKq8y2fpPn4ixxnLdEUZuLiEuip/sPADLnMI8NZp/iTkK6kmoCDJxvTnP
	lCc75AnSNdZvfoQp892Kja5tWbRLdzmVUQuRSWpg+Jp1ZdmOCvilJp4Ruxp5i/RoLLRx1+K5XgUpG
	j9rEN5oNbbS8/w2sd5JzWA5gfv6g/hzhGQ7ZM/MP98r7miXlX18hpAaFMWXbYyKBuTwWasnwDNOLS
	RraeFLIhBiGT9Vt89CEshqSVpeS+4jzINlcGhGY1gI4WDngkRzdrI9Fxz3jObXvYgBcVe+NreDJnV
	ZusdrDqoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGwv-0003GX-38; Thu, 31 Jan 2019 18:20:29 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGwq-0003FZ-NC
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:20:26 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2019 10:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="112695419"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.147])
 ([10.7.153.147])
 by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 10:20:22 -0800
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
To: Wolfram Sang <wsa@the-dreams.de>,
 Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <c9b312af-4c0f-5629-386c-8a72bcb3c1b0@linux.intel.com>
Date: Thu, 31 Jan 2019 10:20:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_102024_854864_6C8DF6AC 
X-CRM114-Status: GOOD (  33.07  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vernon Mauery <vernon.mauery@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 James Feist <james.feist@linux.intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Brendan,

Can you please review this patch?

Thanks,
Jae

On 1/16/2019 11:39 AM, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
> 
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>   drivers/i2c/busses/i2c-aspeed.c | 118 +++++++++++++++++++++++++-------
>   1 file changed, 92 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 8dc9161ced38..9253ebccb008 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -117,6 +117,7 @@
>   
>   enum aspeed_i2c_master_state {
>   	ASPEED_I2C_MASTER_INACTIVE,
> +	ASPEED_I2C_MASTER_PENDING,
>   	ASPEED_I2C_MASTER_START,
>   	ASPEED_I2C_MASTER_TX_FIRST,
>   	ASPEED_I2C_MASTER_TX,
> @@ -126,12 +127,13 @@ enum aspeed_i2c_master_state {
>   };
>   
>   enum aspeed_i2c_slave_state {
> -	ASPEED_I2C_SLAVE_STOP,
> +	ASPEED_I2C_SLAVE_INACTIVE,
>   	ASPEED_I2C_SLAVE_START,
>   	ASPEED_I2C_SLAVE_READ_REQUESTED,
>   	ASPEED_I2C_SLAVE_READ_PROCESSED,
>   	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
>   	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
> +	ASPEED_I2C_SLAVE_STOP,
>   };
>   
>   struct aspeed_i2c_bus {
> @@ -156,6 +158,8 @@ struct aspeed_i2c_bus {
>   	int				cmd_err;
>   	/* Protected only by i2c_lock_bus */
>   	int				master_xfer_result;
> +	/* Multi-master */
> +	bool				multi_master;
>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
>   	struct i2c_client		*slave;
>   	enum aspeed_i2c_slave_state	slave_state;
> @@ -251,7 +255,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   	}
>   
>   	/* Slave is not currently active, irq was for someone else. */
> -	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
> +	if (bus->slave_state == ASPEED_I2C_SLAVE_INACTIVE)
>   		return irq_handled;
>   
>   	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
> @@ -277,16 +281,15 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
>   		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>   	}
> -	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
> +	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
> +	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
>   		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
>   		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>   	}
> -	if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
> -		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
>   
>   	switch (bus->slave_state) {
>   	case ASPEED_I2C_SLAVE_READ_REQUESTED:
> -		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
> +		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_ACK))
>   			dev_err(bus->dev, "Unexpected ACK on read request.\n");
>   		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
>   		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
> @@ -294,9 +297,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
>   		break;
>   	case ASPEED_I2C_SLAVE_READ_PROCESSED:
> -		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
>   			dev_err(bus->dev,
>   				"Expected ACK after processed read.\n");
> +			break;
> +		}
> +		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
>   		i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
>   		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
>   		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
> @@ -310,10 +316,15 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   		break;
>   	case ASPEED_I2C_SLAVE_STOP:
>   		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> +		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
> +		break;
> +	case ASPEED_I2C_SLAVE_START:
> +		/* Slave was just started. Waiting for the next event. */;
>   		break;
>   	default:
> -		dev_err(bus->dev, "unhandled slave_state: %d\n",
> +		dev_err(bus->dev, "unknown slave_state: %d\n",
>   			bus->slave_state);
> +		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
>   		break;
>   	}
>   
> @@ -329,6 +340,17 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
>   	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
>   
>   	bus->master_state = ASPEED_I2C_MASTER_START;
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	/*
> +	 * If it's requested in the middle of a slave session, set the master
> +	 * state to 'pending' then H/W will continue handling this master
> +	 * command when the bus comes back to the idle state.
> +	 */
> +	if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
> +		bus->master_state = ASPEED_I2C_MASTER_PENDING;
> +#endif /* CONFIG_I2C_SLAVE */
> +
>   	bus->buf_index = 0;
>   
>   	if (msg->flags & I2C_M_RD) {
> @@ -384,10 +406,6 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
>   		irq_handled |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
>   		goto out_complete;
> -	} else {
> -		/* Master is not currently active, irq was for someone else. */
> -		if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
> -			goto out_no_complete;
>   	}
>   
>   	/*
> @@ -399,11 +417,32 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   	if (ret) {
>   		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
>   			irq_status);
> -		bus->cmd_err = ret;
> -		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
>   		irq_handled |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
> -		goto out_complete;
> +		if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> +			bus->cmd_err = ret;
> +			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +			goto out_complete;
> +		}
> +	}
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	/*
> +	 * A pending master command will be started by H/W when the bus comes
> +	 * back to idle state after completing a slave operation so change the
> +	 * master state from 'pending' to 'start' at here if slave is inactive.
> +	 */
> +	if (bus->master_state == ASPEED_I2C_MASTER_PENDING) {
> +		if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
> +			goto out_no_complete;
> +
> +		bus->master_state = ASPEED_I2C_MASTER_START;
>   	}
> +#endif /* CONFIG_I2C_SLAVE */
> +
> +	/* Master is not currently active, irq was for someone else. */
> +	if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE ||
> +	    bus->master_state == ASPEED_I2C_MASTER_PENDING)
> +		goto out_no_complete;
>   
>   	/* We are in an invalid state; reset bus to a known state. */
>   	if (!bus->msgs) {
> @@ -423,6 +462,20 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   	 * then update the state and handle the new state below.
>   	 */
>   	if (bus->master_state == ASPEED_I2C_MASTER_START) {
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +		/*
> +		 * If a peer master starts a xfer immediately after it queues a
> +		 * master command, change its state to 'pending' then H/W will
> +		 * continue the queued master xfer just after completing the
> +		 * slave mode session.
> +		 */
> +		if (unlikely(irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)) {
> +			bus->master_state = ASPEED_I2C_MASTER_PENDING;
> +			dev_dbg(bus->dev,
> +				"master goes pending due to a slave start\n");
> +			goto out_no_complete;
> +		}
> +#endif /* CONFIG_I2C_SLAVE */
>   		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
>   			if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_NAK))) {
>   				bus->cmd_err = -ENXIO;
> @@ -566,7 +619,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>   	 * interrupt bits. Each case needs to be handled using corresponding
>   	 * handlers depending on the current state.
>   	 */
> -	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> +	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE &&
> +	    bus->master_state != ASPEED_I2C_MASTER_PENDING) {
>   		irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
>   		irq_remaining &= ~irq_handled;
>   		if (irq_remaining)
> @@ -601,15 +655,15 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>   {
>   	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
>   	unsigned long time_left, flags;
> -	int ret = 0;
> +	int ret;
>   
>   	spin_lock_irqsave(&bus->lock, flags);
>   	bus->cmd_err = 0;
>   
> -	/* If bus is busy, attempt recovery. We assume a single master
> -	 * environment.
> -	 */
> -	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
> +	/* If bus is busy in a single master environment, attempt recovery. */
> +	if (!bus->multi_master &&
> +	    (readl(bus->base + ASPEED_I2C_CMD_REG) &
> +	     ASPEED_I2CD_BUS_BUSY_STS)) {
>   		spin_unlock_irqrestore(&bus->lock, flags);
>   		ret = aspeed_i2c_recover_bus(bus);
>   		if (ret)
> @@ -629,10 +683,20 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>   	time_left = wait_for_completion_timeout(&bus->cmd_complete,
>   						bus->adap.timeout);
>   
> -	if (time_left == 0)
> +	if (time_left == 0) {
> +		/*
> +		 * If timed out and bus is still busy in a multi master
> +		 * environment, attempt recovery at here.
> +		 */
> +		if (bus->multi_master &&
> +		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
> +		     ASPEED_I2CD_BUS_BUSY_STS))
> +			ret = aspeed_i2c_recover_bus(bus);
> +
>   		return -ETIMEDOUT;
> -	else
> -		return bus->master_xfer_result;
> +	}
> +
> +	return bus->master_xfer_result;
>   }
>   
>   static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
> @@ -672,7 +736,7 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
>   	__aspeed_i2c_reg_slave(bus, client->addr);
>   
>   	bus->slave = client;
> -	bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> +	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
>   	spin_unlock_irqrestore(&bus->lock, flags);
>   
>   	return 0;
> @@ -827,7 +891,9 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
>   	if (ret < 0)
>   		return ret;
>   
> -	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
> +	if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
> +		bus->multi_master = true;
> +	else
>   		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
>   
>   	/* Enable Master Mode */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
