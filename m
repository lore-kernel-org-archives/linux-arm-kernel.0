Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F1CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D0520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHzBYG54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D0520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TcnrQu5qOwvvi46qAyF594eAdZ+JT1I2uWDWP3Mn78M=; b=SHzBYG54Sa/8kD
	je1xmNKXVPSlAj5G2SIFY9M4oUFKw2mck6lNUBcyf+XPb40boHHTlH5VRpV1IkJhpPZdkm/oFXSpU
	SyqKAf0lHoYz4IoMoa6/UtWmh7b3B76XLDTnH4V0nijMlkBOo5bavqSvUkqU7YP3pH005/cMBzkl2
	WzAwpTOxxk3ndQQI4B3dAWxsDmSrZbghhgOFQ+KW/8j03Zk0js73JTgrNfshn7OnJTr4aDxL3Ho01
	bINyUV+4D7htqoMbtc1h5kXqNf68xYrZBf4G/TS/RHlM38gNo/b6EV0ern8Voej9arFDQOy9OmWpr
	OrttLHYVYTyaCrk921SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUy77-0007k5-6Z; Thu, 06 Dec 2018 18:11:05 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUy73-000664-O7
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:11:03 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 3A8DD2007D;
 Thu,  6 Dec 2018 19:08:28 +0100 (CET)
Date: Thu, 6 Dec 2018 19:08:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] arch: simplify several early memory allocations
Message-ID: <20181206180826.GB19166@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
 <20181203162908.GB4244@ravnborg.org>
 <20181203164920.GB26700@rapoport-lnx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203164920.GB26700@rapoport-lnx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=5FtgESxhPiTmXxFRN-kA:9 a=CjuIK1q_8ugA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_101101_963946_275519F6 
X-CRM114-Status: GOOD (  15.02  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:49:21PM +0200, Mike Rapoport wrote:
> On Mon, Dec 03, 2018 at 05:29:08PM +0100, Sam Ravnborg wrote:
> > Hi Mike.
> > 
> > > index c37955d..2a17665 100644
> > > --- a/arch/sparc/kernel/prom_64.c
> > > +++ b/arch/sparc/kernel/prom_64.c
> > > @@ -34,16 +34,13 @@
> > >  
> > >  void * __init prom_early_alloc(unsigned long size)
> > >  {
> > > -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> > > -	void *ret;
> > > +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
> > >  
> > > -	if (!paddr) {
> > > +	if (!ret) {
> > >  		prom_printf("prom_early_alloc(%lu) failed\n", size);
> > >  		prom_halt();
> > >  	}
> > >  
> > > -	ret = __va(paddr);
> > > -	memset(ret, 0, size);
> > >  	prom_early_allocated += size;
> > >  
> > >  	return ret;
> > 
> > memblock_alloc() calls memblock_alloc_try_nid().
> > And if allocation fails then memblock_alloc_try_nid() calls panic().
> > So will we ever hit the prom_halt() code?
> 
> memblock_phys_alloc_try_nid() also calls panic if an allocation fails. So
> in either case we never reach prom_halt() code.

So we have code here we never reach - not nice.
If the idea is to avoid relying on the panic inside memblock_alloc() then
maybe replace it with a variant that do not call panic?
To make it clear what happens.

	Sam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
