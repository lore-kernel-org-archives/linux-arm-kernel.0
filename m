Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD45C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:56:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B181206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AfYXOVBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B181206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JoYucqBb/351d/3OlSniDpYJsFqTbWO5jKmYedPQzC8=; b=AfYXOVBmvzcL3F
	IDffYUmX96vNiAyzlI98Ins9N/c6CT7Qffh8jrBYtWlBSty2R+sSNh9TTGTUwP6SeJsxT4fe+DlFo
	SkDXsDU4jl/vKDa6SDDQajUAg/Sz256rAOS6HT/frv8AuF0r6vnXJ2VnmPHjQNVxdGVtvFn0JAWLG
	lsURuo98R/jP9/QflD0UVHr8ZV39gTPkhII1wFcovyayBxNLQ17D2BZvlgxPod6Pp7Wu6K4Sh20A2
	erWUcnMylciBrNx0Uz5j3C/LpxWbpoE8yC/ZvD7hcp3uucD8gqFDgfwGPLkjY26QuTa+KOQOy29wz
	joTq/9Qkn5rig7qoCVqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnYQ-00015L-LW; Wed, 16 Jan 2019 15:56:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnYM-00014U-DB
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 15:56:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6667A78;
 Wed, 16 Jan 2019 07:56:28 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481B53F7D7;
 Wed, 16 Jan 2019 07:56:26 -0800 (PST)
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
To: Mark Rutland <mark.rutland@arm.com>, Balbir Singh <bsingharora@gmail.com>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190114121359.GB26056@350D>
 <20190114122616.GD10258@lakrids.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e82df4bd-804e-de46-d1d9-93b56f9db9c8@arm.com>
Date: Wed, 16 Jan 2019 15:56:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114122616.GD10258@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_075630_459468_C6FFB0E3 
X-CRM114-Status: GOOD (  19.34  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 14/01/2019 12:26, Mark Rutland wrote:
> On Mon, Jan 14, 2019 at 11:13:59PM +1100, Balbir Singh wrote:
>> On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
>>> Hi Torsten,
>>>
>>> On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
>>>> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
>>>> of each function. Replace the first NOP thus generated with a quick LR
>>>> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
>>>> to ftrace, does not clobber the value. Ftrace will then generate the
>>>> standard stack frames.
>>
>> Do we know what the overhead would be, if this was a link time change
>> for the first instruction?
> 
> No, but it should be possible to benchamrk that for a given workload,
> which is what I'd like to see.
> 

So, I hacked up something to have the -fpachable-function-entry=2 in the
build and then have ftrace_init() patch in the "mov x9, lr" in the first
nop of the function preludes.

I tested it on a 8 x Cortex A-57 machine and compared with a version
that just has the two nops in the function prelude.

On workloads like hackbench, the average difference is within the noise
(<1%). Time results below are in seconds.

	+------------+--------------------+
	| "nop; nop" | "mov x9, lr; nop"  |
	+------------+--------------------+
	|     43.497 |             42.694 |
	|     43.464 |             43.148 |
	|     43.599 |             43.131 |
	|     43.785 |              43.63 |
	|     43.458 |             43.281 |
	|       44.3 |             43.328 |
	|     43.541 |             43.059 |
	|     43.529 |             43.298 |
	|      43.58 |             43.937 |
	|     43.385 |             43.122 |
	|     43.514 |             43.825 |
	|     45.508 |             43.268 |
	|     43.757 |             43.316 |
	|     43.392 |             43.146 |
	|     44.029 |             43.236 |
	|     43.515 |             43.139 |
	|      43.22 |             43.108 |
	|     43.496 |             43.836 |
	|     43.669 |             43.083 |
	|     43.388 |              43.38 |
	+------------+--------------------+
average	|    43.6813 |           43.29825 |
	+------------+--------------------+


On a kernel build from defconfig, there seems to be around 5%
difference, but funnily enough it's the version with "mov x9, lr" that
seems faster (but maybe that might be caused by delays from the disk or
other IO related stuff).

I'll try a bit more runs of the kernel builds to make sure, but having
"mov x9, lr; nop" does not appear to deteriorate the performance
compared to "nop; nop" as function prelude.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
