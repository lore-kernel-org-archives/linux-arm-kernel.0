Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55681C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:20:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FCD2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SKe7WK1A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvn9i/T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FCD2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=juVafX/rqi0LSMYZSIKwZb1+m2YCYWCpHvTgGQDw6cA=; b=SKe7WK1AbQ+CFs
	cbRsoYGgri/BLYbF1M8jxYvcwG9fu+lUT5PwfF1lWrCp3ibovtLM2zBEJUE3NB0JPu9F+fEgFHCrq
	h0I1XSt0MRr5lHIFpe6JhLj+mALEuqguEa7tNTsCJx2LLmUBm6d/zji0/5ygn8KL/rSoBd/fXIqox
	eIE1qXqi/kJaVE5DYg9OxJMCnhjAKd/qN/2s/swLgTsOh5cUZxxbWJb2SZbdMAOdnqiuL8hYCLkyt
	q3l6GE3zVfNH/HB+z7m+MCXCRVrlCWMwSU68AHqdJdhayl1UcaVK/yvByRHvowTxAEIjQ9NAlZIFk
	jUiPTi1V7bgPCNOZa1yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpvDz-0003mB-1J; Sat, 02 Feb 2019 13:20:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpvDv-0003ln-OP; Sat, 02 Feb 2019 13:20:45 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F9682173B;
 Sat,  2 Feb 2019 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549113641;
 bh=KsuDKuKlJQAE474thXEYS0gFc9Y879d0/apCZUyA2BU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Yvn9i/T2YxRQ61YiDLwBBRswAL47uWfTMzRseCidx4/oSP5KHtFEi4EqDwqd2vnMH
 BXlWwtA8Jn3yaPKxyNZ3MdUcPWwt7lCFAJppVeqndFKVzXmHvtyIrvHtQrAwUr3XNj
 iayI1CXdSAhgQf2EiWgoD48l/4oVA6cr2v3UFo0M=
Date: Sat, 2 Feb 2019 14:20:29 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190202142029.76ac36b6@bbrezillon>
In-Reply-To: <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-2-tudor.ambarus@microchip.com>
 <20190202080650.44becc2d@bbrezillon>
 <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_052043_852625_80089E9B 
X-CRM114-Status: GOOD (  23.30  )
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
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2 Feb 2019 08:38:40 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:06 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:13 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Cache Serial Memory Mode (SMM) value to avoid write access when
> >> setting the controller in serial memory mode. SMM is set in
> >> exec_op() and not at probe time, to let room for future regular
> >> SPI support.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: update smm value when different. rename mr/smm
> >> v2: cache MR value instead of moving the write access at probe
> >>
> >>  drivers/spi/atmel-quadspi.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index ddc712410812..645284c6ec9a 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -155,6 +155,7 @@ struct atmel_qspi {
> >>  	struct clk		*clk;
> >>  	struct platform_device	*pdev;
> >>  	u32			pending;
> >> +	u32			smm;
> >>  	struct completion	cmd_completion;
> >>  };
> >>  
> >> @@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >>  	icr = QSPI_ICR_INST(op->cmd.opcode);
> >>  	ifr = QSPI_IFR_INSTEN;
> >>  
> >> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> >> +	/* Set the QSPI controller in Serial Memory Mode */
> >> +	if (aq->smm != QSPI_MR_SMM) {  
> > 
> > Sorry, I think I misunderstood your previous suggestion, I thought the
> > reg was called SMM. If the reg is called MR and the value you expect in
> > there is SMM, then the field should be named ->mr as it caches the
> > whole reg, not only the SMM bit. So it's actually:
> > 
> > 	if (aq->mr != QSPI_MR_SMM) {  
> 
> No worries. When keeping the reg name, and not the bit itself, I would expect to
> do the check as in v2, to let room for checking other bits too:
> 
> +	if (!(aq->mr & QSPI_MR_SMM))
> 
> I don't have any problems to keep "mr" name, but I would like to understand your
> reasons.

Either you want to only set the SMM bit and keep the other bits
untouched or you want to make sure the register contains the value you
expect for all bitfields. If you're trying to achieve the former, you
should only update SMM instead of setting SMM + clearing all other
bits. In the other hand, if you want to apply a new MR setting where
you know exactly that only SMM should be set, that means you should
test the value in the cache (->mr) against the value you expect, and
not only the check that QSPI_MR_SMM is set.

BTW, you should probably initialize ->mr at probe time (using a
readl_relaxed()).

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
