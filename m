Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:20:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470AB20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SUDp2G6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470AB20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JRMf1t6yHE0LDtr+K9u2tDQPmTX5Vr6mgzRQ/+bhU1Q=; b=SUDp2G6vn2y4Lo
	qbjqj4ncEgTm7LMqOnuMmdGGdhKaAyFG6DEeHp2EXrT+1JJO//H6no7bnhLKsPw5a7cE5YA/rNQbD
	/wExM009eFhH2Eip4dzSbe2LQWBRPvfFWo16uqaCmevH+TMaehHHCoog4JczSv0RkS/WEMyPLkdFU
	aNW2gsf5yvgYu42lFHbrVD30mujOXJksXLkpnUJxR6/1W9Q/oYZmJIya7RC4Uq5l+N+INI0mSBh4M
	6sRed5zD0AiqCuAKlfaucoZmqjFnCkJAOYtpIh2ZkY5ENMohQjDnYf3n+VegtM6yObhQgyug7Z+eY
	TCL5z8STKl33vd0VG8jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghewg-00043Y-Dh; Thu, 10 Jan 2019 18:20:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghewc-00042v-D4
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:20:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA80AA78;
 Thu, 10 Jan 2019 10:20:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2540C3F694;
 Thu, 10 Jan 2019 10:20:37 -0800 (PST)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 04/25] ACPI / APEI: Make hest.c manage the estatus
 memory pool
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-5-james.morse@arm.com>
 <20181211164802.GI27375@zn.tnic>
 <ad48f9a1-404e-7878-3173-f8a4a417a723@arm.com>
 <20181219144234.GA31643@zn.tnic>
Message-ID: <7f1621ac-09ba-71c0-d47d-e9ad61660307@arm.com>
Date: Thu, 10 Jan 2019 18:20:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181219144234.GA31643@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_102042_454582_CE6ADB02 
X-CRM114-Status: GOOD (  21.14  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

On 19/12/2018 14:42, Borislav Petkov wrote:
> On Fri, Dec 14, 2018 at 01:56:16PM +0000, James Morse wrote:
>> /me digs a bit,
>>
>> ghes_estatus_pool_init() allocates memory from hest_ghes_dev_register().
>> Its caller is behind a 'if (!ghes_disable)' in acpi_hest_init(), and is after
>> another 2 calls to apei_hest_parse().
>>
>> If ghes_disable is set, we don't call this thing.
>> If hest_disable is set, acpi_hest_init() exits early.
>> If we don't have a HEST table, acpi_hest_init() exits early.
>>
>> ... if the HEST table doesn't have any GHES entries, hest_ghes_dev_register() is
>> called with ghes_count==0, and does nothing useful. (kmalloc_alloc_array(0,...)
>> great!) But we do call ghes_estatus_pool_init().
>>
>> I think a check that ghes_count is non-zero before calling
>> hest_ghes_dev_register() is the cleanest way to avoid this.
> 
> Grrr, what an effing mess that code is! There's hest_disable *and*
> ghes_disable. Do we really need them both?

ghes_disable lets you ignore the firmware-first notifications, but still 'use'
the other error sources:
drivers/pci/pcie/aer.c picks out the three AER types, and uses apei_hest_parse()
to know if firmware is controlling AER, even if ghes_disable is set.

x86's arch_apei_enable_cmcff() looks like it disables MCE to get firmware to
handle them. hest_disable would stop this, but instead ghes_disable keeps that,
and stops the NOTIFY_NMI being registered.


> With my simplifier hat on I wanna say, we should have a single switch -
> apei_disable - and kill those other two. What a damn mess that is.

(do you consider cmdline arguments as ABI, or hard to justify and hard to remove?)

I don't think its broken enough to justify ripping them out. A user of
ghes_disable would be someone with broken firmware-first handling of AER. They
need to know firmware is changing the register values behind their back (so need
to parse the HEST), but want to ignore the junk notifications. It doesn't sound
like an unlikely scenario.


>> I wanted the estatus pool to be initialised before creating the platform devices
>> in case the order of these things is changed in the future and they get probed
>> immediately, before the pool is initialised.
> 
> Hmmm.
> 
> Actually, I meant flipping those two calls:
> 
>         rc = ghes_estatus_pool_init(ghes_count);
>         if (rc)
>                 goto out;
> 
>         rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
>         if (rc)
>                 goto err;
> 
> to
> 
>         rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
>         if (rc)
>                 goto err;
> 
>         rc = ghes_estatus_pool_init(ghes_count);
>         if (rc)
>                 goto out;
> 
> so as not to alloc the pool unnecessarily if the parsing fails.
> 
> Also, AFAICT, the order you have them in now might be a problem anyway
> if
> 
> 	apei_hest_parse(hest_parse_ghes, &ghes_arr);
> 
> fails because then you goto err and and that pool leaks, right?

Right, yes. I've been ignoring errors like this on the probe path as it implies
you've got busted ACPI tables, or so little memory you're never going to make it
to user-space. I was more worried about ghes_probe() trying to use the pool
memory before its been allocated. I doesn't seem right to register the device if
the driver wouldn't work yet. But one is an subsys_initcall(), the drivers is
device_initcall(), which is obvious enough.

Fixed.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
