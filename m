Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBA32087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V02BNRc0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOMvXWSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBA32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GAJ+oKG63ebJhrOn+eut+Wr3cbV1a/IjKKXC82RvxnI=; b=V02BNRc0++1uAQ
	n7S6fR9Xwl7MsXfLl3GVeyF+RAWUFqbEB6VmmCmeGhoPzkVLSZ7EKwNuzN8hGSxfm2OwXdzVZELWE
	7BusCKhwgIhH4UyW4KJ2o+tW+KJYSktjHTYh8g6+KRv09aeLQ9Z+bGl5TAP0Bop3IbwwUqccZFwUt
	fPz6f6ntNKixEaclm/ar/gkdr30npFPoDCdSL58p/fW696c8yFMtHh3bhVUVdwR1glrfk6vUgEDX2
	Be/I03bezwcDGGVwLZhvB8aAOEzI4OIa9doAQdK/fmLLeLQimspMfs9LHu/tB8AWoIBqNBwc8iESQ
	QdOdgAt4urYc4UCiiA5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqenJ-0008Es-0a; Mon, 04 Feb 2019 14:00:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqenG-0008ER-3K; Mon, 04 Feb 2019 14:00:15 +0000
Received: from bbrezillon (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BAB872082F;
 Mon,  4 Feb 2019 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549288813;
 bh=rWhYzT7UjHT4ejUyjxjI9R2JCrNUWzH8DfYNDXDEMWQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UOMvXWSVLM1sjqhzgedjrPZL37SAyM1KYnh7VZyQg2PSGoYC3sDIuu5cIEP1vQ9DR
 +fY4kuf+1qOBbEBxOmhTEaM/tCGhPUCcTc3iENUI8ThCz9bxr/07wH+/+oV5gD+5EF
 w/E25sENpGxO2KcI583sv9xwcFWozi2YpC8Gll5A=
Date: Mon, 4 Feb 2019 15:00:05 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v4 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190204150005.3567bf29@bbrezillon>
In-Reply-To: <20190204100910.26701-2-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
 <20190204100910.26701-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_060014_159222_B632C2ED 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019 10:09:22 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Set the controller by default in Serial Memory Mode (SMM) at probe.
> Cache Mode Register (MR) value to avoid write access when setting
> the controller in serial memory mode at exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v4: s/smm/mr, init controller in serial memory mode by default
> v3: update smm value when different. rename mr/smm
> v2: cache MR value instead of moving the write access at probe
> 
>  drivers/spi/atmel-quadspi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..d6864d29f294 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -155,6 +155,7 @@ struct atmel_qspi {
>  	struct clk		*clk;
>  	struct platform_device	*pdev;
>  	u32			pending;
> +	u32			mr;
>  	struct completion	cmd_completion;
>  };
>  
> @@ -238,7 +239,14 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	/*
> +	 * If the QSPI controller is set in regular SPI mode, set it in
> +	 * Serial Memory Mode (SMM).
> +	 */
> +	if (aq->mr != QSPI_MR_SMM) {
> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +		aq->mr = QSPI_MR_SMM;
> +	}
>  
>  	mode = find_mode(op);
>  	if (mode < 0)
> @@ -381,6 +389,10 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  	/* Reset the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
> +	/* Set the QSPI controller by default in Serial Memory Mode */
> +	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	aq->mr = QSPI_MR_SMM;
> +
>  	/* Enable the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
