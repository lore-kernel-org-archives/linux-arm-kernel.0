Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D16C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:49:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2FA2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdeRXPkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2FA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qZK+SPE77ScOMczpQl/Zt+Nhct+8Gg8p4Wq3GKZhVSw=; b=QdeRXPkLu/62YP
	/7SZ4eLm1hTuFpwLZPVV/uLlyTeu0CBx2/SiHEuKu3fTjboX4xudWIZxf6UQPqz8CEWR5Q7RI1RDu
	M/aEl5ywpYi0RPpw3iUIURyLshfJK/+nD4rN+wn7nMBCDsQj6VCIvYBEVHjYAwoPT+lwpZskgasNl
	cEjtepXiy3jjWLE9cLpwf/EFmbcEs/Vu6vKyn05oZmd3NpdpOGTFJkz9eJ97nojdR/v3gMTDwToLR
	woCrF+PUiZb/3deLY/Rb9d+Cogbv01N+/M+WI5sbW5fPCbL/Ho50UG+QQ1eE6Pg9vPSf+G4PxDSBc
	JFwPOo5bC++4Yk79N4vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJ82-0000Lc-GE; Mon, 10 Dec 2018 10:49:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ7y-0000Kb-LH
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:49:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185161596;
 Mon, 10 Dec 2018 02:49:20 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A609E3F6A8;
 Mon, 10 Dec 2018 02:49:19 -0800 (PST)
Date: Mon, 10 Dec 2018 11:49:17 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 1/8] arm64: KVM: Make VHE Stage-2 TLB invalidation
 operations non-interruptible
Message-ID: <20181210104917.GM30263@e113682-lin.lund.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-2-marc.zyngier@arm.com>
 <20181210100356.GG30263@e113682-lin.lund.arm.com>
 <d9219768-bbef-5d51-3bb4-84cf35714a4d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9219768-bbef-5d51-3bb4-84cf35714a4d@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_024930_703910_9CA6ACCF 
X-CRM114-Status: GOOD (  23.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMTAsIDIwMTggYXQgMTA6MjQ6MzFBTSArMDAwMCwgTWFyYyBaeW5naWVyIHdy
b3RlOgo+IEhpIENocmlzdG9mZmVyLAo+IAo+IE9uIDEwLzEyLzIwMTggMTA6MDMsIENocmlzdG9m
ZmVyIERhbGwgd3JvdGU6Cj4gPiBPbiBUaHUsIERlYyAwNiwgMjAxOCBhdCAwNTozMToxOVBNICsw
MDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gPj4gQ29udHJhcnkgdG8gdGhlIG5vbi1WSEUgdmVy
c2lvbiBvZiB0aGUgVExCIGludmFsaWRhdGlvbiBoZWxwZXJzLCB0aGUgVkhFCj4gPj4gY29kZSAg
aGFzIGludGVycnVwdHMgZW5hYmxlZCwgbWVhbmluZyB0aGF0IHdlIGNhbiB0YWtlIGFuIGludGVy
cnVwdCBpbgo+ID4+IHRoZSBtaWRkbGUgb2Ygc3VjaCBhIHNlcXVlbmNlLCBhbmQgc3RhcnQgcnVu
bmluZyBzb21ldGhpbmcgZWxzZSB3aXRoCj4gPj4gSENSX0VMMi5UR0UgY2xlYXJlZC4KPiA+IAo+
ID4gRG8gd2UgaGF2ZSB0byBjbGVhciBUR0UgdG8gcGVyZm9ybSB0aGUgVExCIGludmFsaWRhdGlv
biwgb3IgaXMgdGhhdCBqdXN0Cj4gPiBhIHNpZGUtZWZmZWN0IG9mIHJlLXVzaW5nIGNvZGU/Cj4g
Cj4gV2UgcmVhbGx5IGRvIG5lZWQgdG8gY2xlYXIgVEdFLiBGcm9tIHRoZSBkZXNjcmlwdGlvbiBv
ZiBUTEJJIFZNQUxMRTFJUzoKPiAKPiA8cXVvdGU+Cj4gV2hlbiBFTDIgaXMgaW1wbGVtZW50ZWQg
YW5kIGVuYWJsZWQgaW4gdGhlIGN1cnJlbnQgU2VjdXJpdHkgc3RhdGU6Cj4g4oCUIElmIEhDUl9F
TDIue0UySCwgVEdFfSBpcyBub3QgezEsIDF9LCB0aGUgZW50cnkgd291bGQgYmUgdXNlZCB3aXRo
IHRoZQo+IGN1cnJlbnQgVk1JRCBhbmQgd291bGQgYmUgcmVxdWlyZWQgdG8gdHJhbnNsYXRlIHRo
ZSBzcGVjaWZpZWQgVkEgdXNpbmcKPiB0aGUgRUwxJjAgdHJhbnNsYXRpb24gcmVnaW1lLgo+IOKA
lCBJZiBIQ1JfRUwyLntFMkgsIFRHRX0gaXMgezEsIDF9LCB0aGUgZW50cnkgd291bGQgYmUgcmVx
dWlyZWQgdG8KPiB0cmFuc2xhdGUgdGhlIHNwZWNpZmllZCBWQSB1c2luZyB0aGUgRUwyJjAgdHJh
bnNsYXRpb24gcmVnaW1lLgo+IDwvcXVvdGU+Cj4gCj4gPiBBbHNvLCBkbyB3ZSBnZW5lcmFsbHkg
cGVyZm9ybSBUTEIgaW52YWxpZGF0aW9ucyBpbiB0aGUga2VybmVsIHdpdGgKPiA+IGludGVycnVw
dHMgZGlzYWJsZWQsIG9yIGlzIHRoaXMganVzdCBhIHJlc3VsdCBvZiBjbGVhcmluZyBUR0U/Cj4g
Cj4gVGhhdCdzIGRlZmluaXRlbHkgYSByZXN1bHQgb2YgY2xlYXJpbmcgVEdFLiBXZSBjb3VsZCBi
ZSB0YWtpbmcgYW4KPiBpbnRlcnJ1cHQgaGVyZSwgYW5kIGV4ZWN1dGUgYSB1c2VyIGFjY2VzcyBv
biB0aGUgYmFjayBvZiBpdCAocGVyZiB3aWxsCj4gaGFwcGlseSB3YWxrIGEgdXNlci1zcGFjZSBz
dGFjayBpbiB0aGF0IGNvbnRleHQsIGZvciBleGFtcGxlKS4gSGF2aW5nCj4gVEdFIGNsZWFyIGlu
IHRoYXQgY29udGV4dC4gQW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gd291bGQgYmUgdG8KPiBzYXZl
L3Jlc3RvcmUgVEdFIG9uIGludGVycnVwdCBlbnRyeS9leGl0LCBidXQgdGhhdCdzIGEgYml0IG92
ZXJraWxsIHdoZW4KPiB5b3UgY29uc2lkZXIgaG93IHJhcmVseSB3ZSBpc3N1ZSBzdWNoIFRMQiBp
bnZhbGlkYXRpb24uCj4gCj4gPiBTb21laG93IEkgZmVlbCBsaWtlIHRoaXMgc2hvdWxkIGxvb2sg
bW9yZSBsaWtlIGp1c3QgYW5vdGhlciBUTEIKPiA+IGludmFsaWRhdGlvbiBpbiB0aGUga2VybmVs
LCBidXQgaWYgdGhlcmUncyBhIGdvb2QgcmVhc29uIHdoeSBpdCBjYW4ndAo+ID4gdGhlbiB0aGlz
IGlzIGZpbmUuCj4gCj4gVGhlIHJlc3Qgb2YgdGhlIFRMQiBpbnZhbGlkYXRpb24gaW4gdGhlIGtl
cm5lbCBkb2Vzbid0IG5lZWQgdG8KPiBzYXZlL3Jlc3RvcmUgYW55IGNvbnRleHQuIFRoZXkgYXBw
bHkgdG8gYSBzZXQgb2YgcGFyYW1ldGVycyB0aGF0IGFyZQo+IGFscmVhZHkgbG9hZGVkIG9uIHRo
ZSBDUFUuIFdoYXQgd2UgaGF2ZSBoZXJlIGlzIHN1YnN0YW50aWFsbHkgZGlmZmVyZW50Lgo+IAoK
VGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24gYW5kIEFybSBBUk0gcXVvdGUuICBJIGZhaWxlZCB0
byBmaW5kIHRoYXQgb24KbXkgb3duIHRoaXMgcGFydGljdWxhciBNb25kYXkgbW9ybmluZy4KCkFj
a2VkLWJ5OiBDaHJpc3RvZmZlciBEYWxsIDxjaHJpc3RvZmZlci5kYWxsQGFybS5jb20+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
