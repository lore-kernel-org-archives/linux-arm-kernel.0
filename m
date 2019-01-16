Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:01:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE1C206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KM0uqvfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE1C206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/cwVy58q42fCqw6CLB/UDbcETUGR08dC/ps/zeYbDCE=; b=KM0uqvfv7k96pF
	9vchUno0gX/PUwgGHGff6R+if74jcW69E8ivJcTvqsEcorbzMuJHzRYocKFf8Ep7ad0sVeLTpxlFf
	9mt/T09dL0N8RpM0D7isngEHCStYRo+Y5gDtTxc8YPUBZ2vxacmPHRymx1yKBcIx9uDcSNhes+QSv
	qvvGGbKuEY8UjBaI2Wm5NRD2+NP34ksTSZ4gfKhC5gmKQ0BZvM/YqddlnrVqEP2LLxZqSGe0fX993
	a21zto4VJvoq6n0uFAgoOXdlzttEsE43UXkMvhBtu6NAGgUIbwVTq+TZwl7qSLwbQEXqbcdVxP+1L
	/DmjokL71+bD46mKanYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpUz-000647-LO; Wed, 16 Jan 2019 18:01:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpUw-00063c-BG
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 18:01:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F6DEBD;
 Wed, 16 Jan 2019 10:01:05 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CDEA3F763;
 Wed, 16 Jan 2019 10:01:03 -0800 (PST)
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
From: Julien Thierry <julien.thierry@arm.com>
To: Mark Rutland <mark.rutland@arm.com>, Balbir Singh <bsingharora@gmail.com>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190114121359.GB26056@350D>
 <20190114122616.GD10258@lakrids.cambridge.arm.com>
 <e82df4bd-804e-de46-d1d9-93b56f9db9c8@arm.com>
Message-ID: <82f231a8-c757-da97-bbce-33ac6199a4d9@arm.com>
Date: Wed, 16 Jan 2019 18:01:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e82df4bd-804e-de46-d1d9-93b56f9db9c8@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_100106_415673_2E50B073 
X-CRM114-Status: GOOD (  18.47  )
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



On 16/01/2019 15:56, Julien Thierry wrote:
> On 14/01/2019 12:26, Mark Rutland wrote:
>> On Mon, Jan 14, 2019 at 11:13:59PM +1100, Balbir Singh wrote:
>>> On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
>>>> Hi Torsten,
>>>>
>>>> On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
>>>>> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
>>>>> of each function. Replace the first NOP thus generated with a quick LR
>>>>> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
>>>>> to ftrace, does not clobber the value. Ftrace will then generate the
>>>>> standard stack frames.
>>>
>>> Do we know what the overhead would be, if this was a link time change
>>> for the first instruction?
>>
>> No, but it should be possible to benchamrk that for a given workload,
>> which is what I'd like to see.
>>
> 
> So, I hacked up something to have the -fpachable-function-entry=2 in the
> build and then have ftrace_init() patch in the "mov x9, lr" in the first
> nop of the function preludes.
> 
> I tested it on a 8 x Cortex A-57 machine and compared with a version
> that just has the two nops in the function prelude.
> 
> On workloads like hackbench, the average difference is within the noise
> (<1%). Time results below are in seconds.
> 
> 	+------------+--------------------+
> 	| "nop; nop" | "mov x9, lr; nop"  |
> 	+------------+--------------------+
> 	|     43.497 |             42.694 |
> 	|     43.464 |             43.148 |
> 	|     43.599 |             43.131 |
> 	|     43.785 |              43.63 |
> 	|     43.458 |             43.281 |
> 	|       44.3 |             43.328 |
> 	|     43.541 |             43.059 |
> 	|     43.529 |             43.298 |
> 	|      43.58 |             43.937 |
> 	|     43.385 |             43.122 |
> 	|     43.514 |             43.825 |
> 	|     45.508 |             43.268 |
> 	|     43.757 |             43.316 |
> 	|     43.392 |             43.146 |
> 	|     44.029 |             43.236 |
> 	|     43.515 |             43.139 |
> 	|      43.22 |             43.108 |
> 	|     43.496 |             43.836 |
> 	|     43.669 |             43.083 |
> 	|     43.388 |              43.38 |
> 	+------------+--------------------+
> average	|    43.6813 |           43.29825 |
> 	+------------+--------------------+
> 
Here are also some results running hackbench on 4 x Cortex-A53 (pay no
attention to the fact that the timescales are similar, I changed the
number of iteration done by hackbench so it wouldn't take too long)

	+------------+-------------------+
	| "nop; nop" | "mov x9, lr; nop" |
	+------------+-------------------+
	|     43.815 |            44.455 |
	|     43.758 |            45.173 |
	|     44.075 |             43.95 |
	|     44.021 |            44.185 |
	|     43.959 |            44.826 |
	|     44.039 |            44.478 |
	|     43.836 |            44.626 |
	|     44.071 |            45.177 |
	|     43.619 |            45.033 |
	|     44.052 |            45.095 |
	|     43.903 |            44.802 |
	|     43.773 |            44.955 |
	|     43.908 |             45.02 |
	|     43.441 |            44.986 |
	|     44.167 |            45.182 |
	|     44.106 |            45.229 |
	|     43.974 |             45.07 |
	|     43.859 |            45.283 |
	|     43.706 |            44.892 |
	|     43.897 |            44.194 |
	+------------+-------------------+
average |     43.899 |            44.835 |
        +------------+-------------------+


So, in this case the performance take a ~2% hit from keeping the mov
always present in the function prelude instead of a nop.

Makes it a bit less obvious whether the always having that mov there
(whether patched at build time or run time) is good enough.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
