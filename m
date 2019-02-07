Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4313C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:15:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE5820863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X522K4re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE5820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=poyXk5Q8YVd248t8EE0RdpeMxfr1Ya2cfgdzDR7lff8=; b=X522K4re9UueK3
	NL6cU0ZLLIf7hypIURuGHt2+Ff3A5/F7JiI2mqQs0TVWFCJ1lOe27j0dzmmsZRuH1Lk12Llmjq8X3
	5g1hKHzlauPCSqUtugMP5zx5cp0pTOSE6/WpPZ4sVGuOcVBS3VOBE52KwukSU8IxETR9vL0sR3oa8
	7kaohz95Zn3DA+cAvbGYez8xKDp3X0x1QTMGkcoG2kIKeJdn6hkM6/03AQKzPCjWJizHkrOFu2xvK
	JhVO4J4DU68EgArgyaSkJ+3Qa3tW8qOYLVB7TuhpzZKcMt++AXw/s8D4vOmIuOsmoh05gZsv3Hg42
	d5Z4sPdF6MMW4EZld/jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grmKW-00083e-Nf; Thu, 07 Feb 2019 16:15:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grmKT-0007pz-FN
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 16:15:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77532A78;
 Thu,  7 Feb 2019 08:15:07 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15133F675;
 Thu,  7 Feb 2019 08:15:05 -0800 (PST)
Date: Thu, 7 Feb 2019 16:15:02 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check
 the IRQ_STATUS of INTA/B/C/D
Message-ID: <20190207161502.GC21111@e107981-ln.cambridge.arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-3-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-3-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_081509_528327_51CC6110 
X-CRM114-Status: GOOD (  26.33  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 04:39:17PM +0530, Kishon Vijay Abraham I wrote:
> The legacy interrupt handler directly checks the IRQ_STATUS register
> corresponding to a interrupt line inorder to invoke generic_handle_irq.
> 
> While this is okay for K2G platform which has separate interrupt line for
> each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
> has a single interrupt line for all the legacy interrupts. So for AM654
> the interrupt handler won't be able to directly check the IRQ_STATUS
> register corresponding to the interrupt line.
> 
> Also the legacy interrupt handler uses 'virq' obtained from
> irq_of_parse_and_map to find the correct interrupt line which raised the
> interrupt. There is no guarantee that virq assigned for contiguous hardware
> irq will be contiguous and the interrupt handler might end up checking
> the wrong IRQ_STATUS register.
> 
> In order to overcome the above issues, read the IRQ_STATUS register of
> all the 4 legacy interrupts to determine which interrupt was raised.
> 
> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5286a480f76b..4cf9849d5a1d 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>  {
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 pending;
>  	int virq;
>  
> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
> -
> -	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> -		generic_handle_irq(virq);
> -	}
> +	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> +	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> +	generic_handle_irq(virq);
>  
>  	/* EOI the INTx interrupt */
>  	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
> @@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq_no;
> +	u32 reg;
>  
>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>  
> @@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	 * ack operation.
>  	 */
>  	chained_irq_enter(chip, desc);
> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> +	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {

I understand the aim of this code but now on platforms where there
is a 1:1 relationship between Linux IRQ and INTX this loop has
steps carried out for nothing.

If I understand the code correctly what this code does is force
looping over INTX status regs regardless of what linux IRQ number was
actually active.

You could do something faster by creating a matrix LinuxIRQ x INTx to
detect what INTx status register should actually be checked.

This seems overkill to me but it is not that complicated to implement
and may clarify the code (and avoid reading up to three registers for
nothing on the IRQ code path, which can make things faster too).

Lorenzo

> +		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
> +		if (!(reg & INTx_EN))
> +			continue;
> +		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);
> +	}
> +
>  	chained_irq_exit(chip, desc);
>  }
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
