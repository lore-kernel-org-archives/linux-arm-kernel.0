Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A884C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:25:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C835218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cb6z7HuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C835218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wJykG08paKiM4ozP+D8ggJhB9SjEedAkcM2pPHxM1y4=; b=cb6z7HuT0yk0z8
	wo6+1kyc5KJr2Et2/39TLSOEZgeR6LyaiSONvv39f6sILihQjHkwiNKQjrS4FNK1/18HdfImL1Enl
	X6CjxU6Vk2m98Q46aAGTHiLX7wkX+qvcPUzH2zUn8dIigdAxWVQCGn+T37LU1f8IHO6i3q2Tdw5kD
	c8h96d3HatOCDLQuCQsSF7Vcx77sGK3kMzEh2RYZpj/3wYIQ+Jg6N2c/v+psCJTOFJAC5c7WPuPyk
	kfswtgmxtyNdUytz178735QgvK2/fkusirOlrxzhp/Cc2ZzRXFMgehwoB06aQSk9moXDzjZzrBnGj
	qO0hZ0Yzs2a5n4Jepm3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4II-0003Bw-S3; Fri, 25 Jan 2019 16:25:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4IG-0003BA-IW; Fri, 25 Jan 2019 16:25:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D00D9A78;
 Fri, 25 Jan 2019 08:25:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 DBDCD3F5AF; Fri, 25 Jan 2019 08:25:20 -0800 (PST)
Date: Fri, 25 Jan 2019 16:25:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 6/9] arm64: kexec: no need to ClearPageReserved()
Message-ID: <20190125162517.GJ25901@arrakis.emea.arm.com>
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-7-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114125903.24845-7-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_082524_616487_27A2DC39 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
 Dave Kleikamp <dave.kleikamp@oracle.com>, linux-mediatek@lists.infradead.org,
 James Morse <james.morse@arm.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 01:59:00PM +0100, David Hildenbrand wrote:
> This will be done by free_reserved_page().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Acked-by: James Morse <james.morse@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
