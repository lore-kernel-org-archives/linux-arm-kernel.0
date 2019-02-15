Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314842075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i3bBZuhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314842075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xsIjqdBnW2Eey4rdPC8pW/oKoDTHeuU7gAqgxHb+FRs=; b=i3bBZuhVjzMW2A
	nDqQer6i/TfaD2ynmNw/SBKqSuJCwfWMtThSdftOPifmWBqPcLr7gcuoRwMU7fl09qtOi0ZDiaMET
	V92mfm8Lh+PmRxEXaCbZDZafgGVCH6//vAakC1TNFu8bk0Y9SB7tPOIUyss1F4Hd0HyPRjdM8Rfs2
	gT08nddhocN9nCm96vhOl7OVdxQ/msvRj5iVAh/FqiWNOZl2Qg7+j6HpJHd4NgHkIlLMvXg3f/9DM
	6sF6Bo3Ycf2qDdSJlAVHMElZID3LiTPDuB6oaGpN1PZQjZsM5K7Sjmajpe6BNgYbdEZgwcnYDOYGh
	A+7RAGMEAeZQ62mL0atw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guaAh-0006hc-Eo; Fri, 15 Feb 2019 09:52:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guaAe-0006gP-4l; Fri, 15 Feb 2019 09:52:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092C6A78;
 Fri, 15 Feb 2019 01:52:34 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24223F557;
 Fri, 15 Feb 2019 01:52:31 -0800 (PST)
Date: Fri, 15 Feb 2019 09:52:21 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
Message-ID: <20190215095214.GA24988@e107981-ln.cambridge.arm.com>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
 <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
 <ebadc615-f633-e84e-041a-99b7936a123b@ti.com>
 <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
 <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_015236_188596_C105DA3A 
X-CRM114-Status: GOOD (  22.40  )
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
Cc: Heiko Stuebner <heiko@sntech.de>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 11:49:12AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 14/02/19 9:59 PM, Lorenzo Pieralisi wrote:
> > On Wed, Feb 13, 2019 at 07:17:14PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Lorenzo,
> >>
> >> On 11/02/19 11:07 PM, Lorenzo Pieralisi wrote:
> >>> On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
> >>>> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
> >>>> Base Address Register irrespective of the size. Fix it here to indicate
> >>>> 64-bit BAR if the size is > 2GB.
> >>>>
> >>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>> ---
> >>>>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> This looks like a fix and should me marked as such. Does it work
> >>> as as standalone patch if it gets backported ?
> >>
> >> Yeah, it should work. But the current users doesn't allocate > 2GB and some
> >> EPC drivers configure their registers based on size. So nothing is broken
> >> without this patch as such.
> > 
> > I suspect you mean 4GB (here and the commit log), right ? I am checking
> > the commit logs, aiming at merging the patches.
> 
> A 32bit BAR register can support a 'size' of only up to 2GB. Though it
> can hold a memory address of up to 4GB.
> 
> This is also mentioned in the PCI Local Bus Specification.  "A 32-bit
> register can be implemented to support a single memory size that is a
> power of 2 from 16 bytes to 2 GB"

Very true - sorry for the noise.

Lorenz,o

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
