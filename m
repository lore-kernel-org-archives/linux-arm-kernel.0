Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B93EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 01:07:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C704520665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 01:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kcdazFhB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JutblmnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g6wXnh9bDJFI0k6Noh18nMLTOOEeK2PxVrS8ynf6Zl0=; b=kcdazFhBbteC8t
	uEsnsxQu354UGZ6guxLCTMIjgz9sZfecEm7/xhaDPuEoD3FPEc0GS8I+Wzvgo+7+4/SVBO2FqXSf+
	GkS/5TMxyKKknSF/C6MQ+/Jh9Mj6HBH+FTNNiIcFYO98Kb/mVGHYGZSnFKnE/zgev0IjlUFGmHaaV
	Fn8HugIUO3P7D/3NHu17fF9pmafR2Ywn0waMK/QfpeqAXjzbF44RpH6pTdY4cM5Jh+KjiJHcq/9/E
	6Icz1+Um3JYVbqKw3Cd8kx/XTV9j3laglCNWpnBlRCyKCRCndwUO5umJmzV09e0OcrithSJLAULlL
	Y6FSykSNTOmTFg/fKskA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdPZB-0002RW-Dn; Sun, 30 Dec 2018 01:06:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdPYu-0002Qw-C9
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 01:06:42 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A95B220866;
 Sun, 30 Dec 2018 01:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546131988;
 bh=YtaPTXGknpyU/bcWB2uz0k5w2UEfoyeiuTnK+iJnJ/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JutblmnK5sLieLI4VTbKTDtf7zYBSWqgOQ/YlAefQY1MBefA347szUcXUSFck0p7k
 vDZOv1g9oP9avd6eHV6X/6AMIZaI9zjQP96RYJpKLSCv4TVUQ/y/+U72gxOTJ2czX3
 1nIB/eOE/pT7eY8i6jxUnk7u3BMe7Vf6MYe8EBE0=
Date: Sat, 29 Dec 2018 19:06:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Message-ID: <20181230010625.GC159477@google.com>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_170640_495552_CFA5BFF7 
X-CRM114-Status: GOOD (  25.12  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+cc linux-pci]

On Tue, Dec 18, 2018 at 12:17:43PM +0100, Koen Vandeputte wrote:
> Originally, cns3xxx used it's own functions for mapping, reading and writing registers.
> 
> Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> removed the internal PCI config write function in favor of the generic one:
> 
> cns3xxx_pci_write_config() --> pci_generic_config_write()
> 
> cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
> while the generic one pci_generic_config_write() actually expects the real address
> as both the function and hardware are capable of byte-aligned writes.
> 
> This currently leads to pci_generic_config_write() writing
> to the wrong registers on some ocasions.
> 
> First issue seen due to this:
> 
> - driver ath9k gets loaded
> - The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
> - cns3xxx_pci_map_bus() aligns the address to 0x0C
> - pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)
> 
> This seems to cause some slight instability when certain PCI devices are used.
> 
> Another issue example caused by this this is the PCI bus numbering,
> where the primary bus is higher than the secondary, which is impossible.
> 
> Before:
> 
> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 255
>     Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0
> 
> After fix:
> 
> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 255
>     Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
> 
> And very likely some more ..
> 
> Fix all by omitting the alignment being done in the mapping function.
> 
> Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Krzysztof Halasa <khalasa@piap.pl>
> CC: Olof Johansson <olof@lixom.net>
> CC: Robin Leblon <robin.leblon@ncentric.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Tim Harvey <tharvey@gateworks.com>
> CC: stable@vger.kernel.org # v4.0+
> ---
>  arch/arm/mach-cns3xxx/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
> index 318394ed5c7a..5e11ad3164e0 100644
> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
>  	} else /* remote PCI bus */
>  		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
>  
> -	return base + (where & 0xffc) + (devfn << 12);
> +	return base + where + (devfn << 12);

802b7c06adc7 replaced cns3xxx_pci_write_config(), which always used
__raw_writel() so it only did 32-bit accesses, with
pci_generic_config_write(), which uses writeb/writew/writel()
depending on the size.

802b7c06adc7 also converted cns3xxx_pci_read_config() from always
using __raw_readl() (a 32-bit access) to using
pci_generic_config_read32(), which also always does a 32-bit access.

This makes me think the cnx3xxx hardware is only capable of 32-bit
accesses, and this patch should change the driver to use
pci_generic_config_write32() instead of pci_generic_config_write() in
addition to the mapping fix above.

What do you think?

I don't think hardware that only supports 32-bit PCI writes can be
quite spec-compliant (see the comments in
pci_generic_config_write32()).  So (1) you may see an additional
dmesg warning when you convert to use it, and (2) it's possible that
there may still be instability related to the corruption caused by
using a 32-bit write when an 8-bit write was intended.

>  }
>  
>  static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
