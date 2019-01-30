Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD526C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974FB2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EU4TpVlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974FB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iYsHgjswX/tLMF/ADlzA+bdR+rXrs3sXsS3C1X04+t0=; b=EU4TpVlKwlyZV0
	QsQsncCNFy6IgsuaLAHR+rzMCKSm7AXA8KgutBcnF3Fk129pmdndFeC9ZjyeD6LVlNW4qg75BNNUc
	55aI32RYD6KVnuZaXApUKGPcPI/yrfIbSmmL9AhE2rF/978zgxNvX8h3QXTrJ7p2gn6nJ5mTpHH4d
	uA4+IPT5METtUzZXb+POcI/Npfrsa/uPizLvt9KqUC17Cr9uhlv9ikiSEtbwMbM/nXCF05XVLtcbf
	c0MPxO+5WiRiwZBpBnLpeJsO5RAgB/3gbuMA6kXzvkNPvByvLZBmEoWuUjZOyPar9wNGz6m0PE1aX
	tP3aCjDU7edCfgTAZzGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golwP-0001cV-U6; Wed, 30 Jan 2019 09:13:53 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golwK-0001XH-Ay
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:13:51 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1golwA-0004YS-Bn; Wed, 30 Jan 2019 17:13:38 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1golw4-0000JP-O9; Wed, 30 Jan 2019 17:13:32 +0800
Date: Wed, 30 Jan 2019 17:13:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 0/3] crypto: crct10dif assembly cleanup and
 optimizations
Message-ID: <20190130091332.gbcce2oyb24ienu2@gondor.apana.org.au>
References: <20190130031444.28935-1-ebiggers@kernel.org>
 <CAKv+Gu95j-ZJC7vbUzJKqNczht1cjgx09sBiSRcwg+qn-HtXew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu95j-ZJC7vbUzJKqNczht1cjgx09sBiSRcwg+qn-HtXew@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011348_949382_7F454D44 
X-CRM114-Status: GOOD (  10.92  )
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
Cc: Eric Biggers <ebiggers@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 09:33:57AM +0100, Ard Biesheuvel wrote:
> 
> So what remains is the way these implementations are encapsulated by
> the crct10dif() library function, which is raster nasty, making
> CRC-T10DIF an excellent use case to discuss whether we can make any
> improvements to address some of the concerns that were also raised in
> the zinc discussion. I threw some code together a while ago [0] (and
> posted it as well, IIRC). In the mean time, a 'static call'
> infrastructure is being proposed that could be used in a similar way
> to avoid function pointers. I'm also interested in hearing opinions on
> whether the indirect call overhead is actually significant in use
> cases such as this one.

I think even if the overhead wasn't significant it would still make
sense to make the move just for the sake of simplicity.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
