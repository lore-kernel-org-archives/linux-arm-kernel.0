Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:03:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E362087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nrff/Ink"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E362087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TxMsvDHCqjsFcDMD1ptBOFdTfGZaghd6pvDWV5PG2rw=; b=nrff/InkhmBQh1
	H8ErHWT4BunkDZ0ZU0PoOATVL7B0YkIDsCvNeV1VXaTSTsDm1AzXA1OB4KG1q4F62fxSbUg/+5iSO
	n1OFBaI5pwDgbs4+vnrr813bTaLu5vr6MlncZwekK1navysLwgZkI44vTLH6Us5Xxm6aihMwhUvC5
	uodbuFHI52ziR6bA5v2dgBVBViqRUB/rG6t1q1Qxkf1xzZfZRTm9Mav9qzzD0+UaFdJpOCNCVIiAJ
	gtIx6kAoIO//0MCohx9klQh+NPPLRy9kDsRygLnm9M+2DFrPWi0dJAbQgEWCvxTZU9mIbUgKK9yMU
	HbH+ahHEWpMSWiz7jO3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcyD-0006aI-Ka; Mon, 04 Feb 2019 12:03:25 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqcy3-0006Z4-VJ
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 12:03:20 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 0B62868D93; Mon,  4 Feb 2019 13:03:09 +0100 (CET)
Date: Mon, 4 Feb 2019 13:03:09 +0100
From: Torsten Duwe <duwe@lst.de>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190204120308.GA7660@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com>
 <20190122132832.GB16778@lst.de>
 <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_040316_676896_59C54A6C 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, "Singh,
 Balbir" <bsingharora@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 02:55:12PM +0100, Ard Biesheuvel wrote:
> On Tue, 22 Jan 2019 at 14:28, Torsten Duwe <duwe@lst.de> wrote:
> >
> > On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
> > > Hi Torsten,
> > >
> > > A few suggestions below.
> > >
> > > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > > > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > > > +/* All we need is some magic value. Simply use "_mCount:" */
> > >
> > > Nit: Should the casing be "_mcount" ?
> >
> > No! The string makes it clear what it's supposed to be and the peculiar
> > casing makes it unique and leaves no doubt were it came from. So whenever
> > you see this register value in a crash dump you don't have to wonder about
> > weird linkage errors, as it surely did not originate from a symtab.
> >
> 
> In that case, do you need to deal with endianness here?
> 
> > > > +#define MCOUNT_ADDR                (0x5f6d436f756e743a)

Strictly speaking, yes. OTOH "wrong-andian" machines always show a difference
when memory is dumped in bigger units than bytes, so when you see the register
value in hex...

Since all that's needed is a somewhat unique constant, let's not over-engineer
this ok?

If there are no other comments I'll send out v8 with the discussed changes.

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
