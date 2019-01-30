Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E37DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33B22184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5zjebDZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO2hnQZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33B22184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hsla/HC/ZCnYCdA1LzFLvIisTsRuTtGBNPZ3gA6Z8MI=; b=T5zjebDZBmNyqT
	sVFmdkKOMhU/WQzBk6Xwvr9ulXbrKjMbdr5LU6kQmWWCMR4Hf4cPc/F3cUXb3Atp0WPOoofkz0HXh
	KLm+LSLlQPcPes6W607TUPI5j35hVpQAlXHumm7gtzYQ8YxDFGe0msFYQB3xYPCwZYgY4HBUQOpf4
	RLBkQsM/tigWBpzZR8AqLN+PQCck46Npn3PHY+n28yVg0R2++pGHtTohbiiWQPwuX1eI9AfFvTxfF
	9TwSmT43r9s2DK6WVtVV6xRUbAYHAxXFV0rmyB+ZSPQ8cPQW/sfjpwDXscJzHjVyqsY+Q3RxSJFD5
	Hk2cON5CpVZv7pHSRvnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotST-0001HB-VC; Wed, 30 Jan 2019 17:15:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotSQ-0001Go-KY; Wed, 30 Jan 2019 17:15:28 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A9502087F;
 Wed, 30 Jan 2019 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548868525;
 bh=rL8MOHGzlA9uP8ZVfBxcHv6afRZ6IvHg9FHRaOPcosk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YO2hnQZac79tNmomIgsJVI8OVsrSL2Qx3EndLyD28MP07Ics+sQpM5I9hBgLBYUZZ
 K9hT1fGkj+1ZQOHuJ11Ae1pH69bglZxftA/ej4r/u60uibd4BZ83hKrqUhu9plKZz4
 z5dw4Av/dwlRfgAnpzErEbFw5xiMb+ev/WpIDOlU=
Date: Wed, 30 Jan 2019 18:15:15 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Message-ID: <20190130181505.4f495d3a@bbrezillon>
In-Reply-To: <20190130150818.24902-2-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_091526_806740_2CB908D7 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 15:08:29 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Set the QSPI controller in Serial Memory Mode at init and not
> at each exec_op() call.

If you ever want to support regular SPI you'll have to put it back to
atmel_qspi_exec_op(), so I'm not sure this is a good move. Another
approach would be to cache the MR value to avoid doing a write access
on the bus when the value hasn't changed.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/spi/atmel-quadspi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..f79b17792a11 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -238,8 +238,6 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> -
>  	mode = find_mode(op);
>  	if (mode < 0)
>  		return -ENOTSUPP;
> @@ -381,6 +379,9 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  	/* Reset the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
> +	/* Set the QSPI controller in Serial Memory Mode */
> +	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +
>  	/* Enable the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
