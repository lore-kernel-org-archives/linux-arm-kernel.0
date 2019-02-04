Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F29C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:15:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC462080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dTwznTR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC462080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B8XU7Ch2q/UxdofLayT7r1z4B26a/vweY6ic9PKqeMM=; b=dTwznTR7B7f2m5
	w/Chit5UDzYJUkj/Z4I4EYC+wbV9sGFv1tQ6RPUdcIrdGifdFxvZMIqy1FW1At9Sr73mZvejtrhF2
	yfbFKAa+9iIRqh7jIxUjfVfMFVuemxwewP/Q/yhbaqqrfn5qP/h1eOQ9k3+UWvAYvVw+H9NQyETkg
	qj+E9sl78S+rGpKa+iba7H7G6w5hUioyGAKuyI33+4uZtoVB9jZzLMRPSAwQb9YKKyPNDDjF13dzA
	Ncoz0HceNkmyKaD8Jo75yx7Aj5iil8kkqvBCM9IPoOrnvBctYai6WsoaXFCkqDLNPQnHLdI2bDOcQ
	8Av+1EYb/w2rT79NK81w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqfxl-0003As-JL; Mon, 04 Feb 2019 15:15:09 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqfxi-0002la-0G
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 15:15:08 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3807EFA28E;
 Mon,  4 Feb 2019 15:15:05 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E09EC74144;
 Mon,  4 Feb 2019 15:15:03 +0000 (UTC)
Date: Mon, 4 Feb 2019 16:15:01 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Message-ID: <20190204151501.mebefojnm6rhyg6v@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-3-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125094656.5026-3-christoffer.dall@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 04 Feb 2019 15:15:05 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_071506_083816_54912F3B 
X-CRM114-Status: GOOD (  17.97  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 10:46:53AM +0100, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> The current kvm_psci_vcpu_on implementation will directly try to
> manipulate the state of the VCPU to reset it.  However, since this is
> not done on the thread that runs the VCPU, we can end up in a strangely
> corrupted state when the source and target VCPUs are running at the same
> time.
> 
> Fix this by factoring out all reset logic from the PSCI implementation
> and forwarding the required information along with a request to the
> target VCPU.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   | 10 +++++++++
>  arch/arm/kvm/reset.c              | 24 +++++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h | 11 ++++++++++
>  arch/arm64/kvm/reset.c            | 24 +++++++++++++++++++++
>  virt/kvm/arm/arm.c                | 10 +++++++++
>  virt/kvm/arm/psci.c               | 36 ++++++++++++++-----------------
>  6 files changed, 95 insertions(+), 20 deletions(-)
>

 
Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
