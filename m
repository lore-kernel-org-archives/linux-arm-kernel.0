Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64196C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2254F222D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t7cK3N21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2254F222D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gNKhR8XMX7NIQMDtrmWIY/NzQG6E6h/E6Z0K9CL/jd0=; b=t7cK3N21ePVQDpFUtCIHcp3+tm
	E5wl4X67bbIszJyj6W1ntewdO2MsNvthqXX0wP9nP63pTHopV5MwB/eQTPwtDDgOALwS+4B/KxKhC
	FJrrKjg7x+VeKexrlJMVALFimSA+dclbPh9FrnRWBRR/kR8kzIcfJ8ZMBT1Fyv8GQFVPFtnZwiLdr
	OUSDZqrMxcqQEUEIo8lf/YpIwgwSc1+NY7apvl054YCtzbBpRqoBdeKQho9AqWTWthTsxFpe47AwB
	spG0o298yuS2GDMXb1HhUvaXjGdd32hQiAJvHyooCoBQNveKbr6cW/PaibweErhEk8D0HL8MnA+62
	HueE+G2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDgj-0006xS-WC; Thu, 14 Feb 2019 09:52:14 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDgg-0006mb-2J
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:52:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2349EADF1;
 Thu, 14 Feb 2019 09:52:08 +0000 (UTC)
Subject: Re: [PATCH v2] hugetlb: allow to free gigantic pages regardless of
 the configuration
To: Dave Hansen <dave.hansen@intel.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190213192610.17265-1-alex@ghiti.fr>
 <d367b5c7-eb05-6d0b-f9bf-5b3fc3f392a9@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <bcffa37e-22cd-f0d7-ee85-769c0d54520a@suse.cz>
Date: Thu, 14 Feb 2019 10:52:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d367b5c7-eb05-6d0b-f9bf-5b3fc3f392a9@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_015210_263486_92062787 
X-CRM114-Status: GOOD (  16.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/13/19 8:30 PM, Dave Hansen wrote:
>> -#if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
>> +#ifdef CONFIG_COMPACTION_CORE
>>  static __init int gigantic_pages_init(void)
>>  {
>>  	/* With compaction or CMA we can allocate gigantic pages at runtime */
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index ac474a61be37..8fecd3ea5563 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -207,8 +207,9 @@ config HUGETLB_PAGE
>>  config MEMFD_CREATE
>>  	def_bool TMPFS || HUGETLBFS
>>  
>> -config ARCH_HAS_GIGANTIC_PAGE
>> +config COMPACTION_CORE
>>  	bool
>> +	default y if (MEMORY_ISOLATION && MIGRATION) || CMA
> 
> This takes a hard dependency (#if) and turns it into a Kconfig *default*
> that can be overridden.  That seems like trouble.
> 
> Shouldn't it be:
> 
> config COMPACTION_CORE
> 	def_bool y
> 	depends on (MEMORY_ISOLATION && MIGRATION) || CMA

Agreed. Also I noticed that it now depends on MIGRATION instead of
COMPACTION. That intention is correct IMHO, but will fail to
compile/link when both COMPACTION and CMA are disabled, and would need
more changes in mm/internal.h and mm/compaction.c (possibly just
replacing CMA in all "if defined CONFIG_COMPACTION || defined
CONFIG_CMA" instances with COMPACTION_CORE, but there might be more
problems, wanna try? :)

Also, I realized that COMPACTION_CORE is a wrong name, sorry about that.
What the config really provides is alloc_contig_range(), so it should be
named either CONFIG_CMA_CORE (as it provides contiguous memory
allocation, but not the related reservation and accounting), or
something like CONFIG_CONTIG_ALLOC. I would also move it from fs/Kconfig
to mm/Kconfig.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
