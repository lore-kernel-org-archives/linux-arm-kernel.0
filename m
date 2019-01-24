Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BEC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:45:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643C4218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kYAP4bQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643C4218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fTkLvFv+IR1oyNm9OD+kPdYxxo6dwqVwyulClWDXNTU=; b=kYAP4bQ3OqcIP0
	eVFUYApt8TmZSWipUqlUMEuetbV5TRRRAQvgdWQ7BnRHcd0rSZ4pNE8VNGefeGu+ZbTPpdSJUbOPu
	XCZ1o+BY/bmStvzl7Osrm2xW4FB9vyU/UsjK5iuApu3R03G+FO5AjrwySNyqnzsXI9ygGHZfYGegK
	S6W8D+hA5YiOC+R0FLqNbyi5xZCKTGe4y3SvIt4Kqw9NKtFA1Ux7tX0ummtqqLdI7uH1HAan3wDnW
	UVWz41kC/a8ZH9juA6/a1w7s9FWGi37bNbjPIMH79khOnmCoFsfoNyopCq8LnEaWR3pdp0Li0cewm
	LRDwdvYCWsbPrxjLQjlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeNz-0000Vw-GA; Thu, 24 Jan 2019 12:45:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmeNw-0000V4-Ef
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 12:45:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 765A4EBD;
 Thu, 24 Jan 2019 04:45:31 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0143F237;
 Thu, 24 Jan 2019 04:45:29 -0800 (PST)
Date: Thu, 24 Jan 2019 12:45:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, marc.zyngier@arm.com
Subject: Re: [PATCH 02/10] PCI: keystone: Use "dummy_irq_chip" instead of new
 irqchip for legacy interrupt handling
Message-ID: <20190124124526.GC23362@e107981-ln.cambridge.arm.com>
References: <20181219124207.13479-1-kishon@ti.com>
 <20181219124207.13479-3-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181219124207.13479-3-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_044532_500682_74E04C47 
X-CRM114-Status: GOOD (  19.23  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-kernel@vger.kernel.org,
 Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 06:11:59PM +0530, Kishon Vijay Abraham I wrote:
> Instead of creating a new irqchip with empty callback functions, use
> dummy_irq_chip. Since there is nothing to do in the irqchip callback
> functions, use handle_simple_irq instead of handle_level_irq.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 24 ++---------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5286a480f76b..1ef443009da5 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -266,31 +266,12 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
>  	return IRQ_HANDLED;
>  }
>  
> -static void ks_pcie_ack_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static void ks_pcie_mask_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static struct irq_chip ks_pcie_legacy_irq_chip = {
> -	.name = "Keystone-PCI-Legacy-IRQ",
> -	.irq_ack = ks_pcie_ack_legacy_irq,
> -	.irq_mask = ks_pcie_mask_legacy_irq,
> -	.irq_unmask = ks_pcie_unmask_legacy_irq,
> -};
> -
>  static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
>  				       unsigned int irq,
>  				       irq_hw_number_t hw_irq)
>  {
> -	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
> -				 handle_level_irq);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> +				 handle_simple_irq);

Hi Kishon,

thanks for putting it together. I think I'd rather move some of
the logic for acking the interrupt in ks_pcie_handle_legacy_irq()
into proper irq_chip methods than using a dummy_irq_chip (that
Marc wants to deprecate).

Also, the flow handler should be handle_level_irq() since that's
what legacy IRQs are.

I hope Marc can chime in when he has a minute to help you finalize this.

Overall you are doing the right thing and I would like to get this
series merged for v5.1.

Thanks,
Lorenzo

>  	irq_set_chip_data(irq, d->host_data);
>  
>  	return 0;
> @@ -298,7 +279,6 @@ static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
>  
>  static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
>  	.map = ks_pcie_init_legacy_irq_map,
> -	.xlate = irq_domain_xlate_onetwocell,
>  };
>  
>  /**
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
