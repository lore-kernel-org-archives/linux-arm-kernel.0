Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A0FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:04:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C23D218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iw6Y0DhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C23D218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ok1JCj167gZj+vJB7eRak/rSHS20dXYz00K/owbKiKs=; b=Iw6Y0DhPhekfjB
	Xlm2MAAThOK2VxTb5sofMmiqL5xzwV9/DAhdL3TY5lR3YgtofR9MuaLJzRuBQXGcQeX0ETSpTOHfQ
	lxfXvgwW95Rsx1yDQw7dtaUnGV9oM0Uxwmdggx7G6Akk2Jqc2LVEExCajVHpAMbrCjRX6yPUIbsCU
	KE5HNED6LMCH8ttFF/bqt6kWQQsw1r2p/o1JNF/wybhldKR8uwFW6Reazl8jp4inPACE0EZKJM0kA
	rm9sgMR2NCT22h0U6ZDi3oVx4lfdUwO8D1Xkq1ORuxPam8THwAcNFl2dIlIYDPVXU6L02H8CJrwAj
	dDUYP8HvT7nqoX4+eDQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgCm-0005q4-HM; Wed, 19 Dec 2018 18:04:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgCi-0005o1-TQ
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:04:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A9F15AB;
 Wed, 19 Dec 2018 10:04:12 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93393F675;
 Wed, 19 Dec 2018 10:04:09 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 01/28] arm64: KVM: Skip MMIO insn after emulation
Date: Wed, 19 Dec 2018 18:03:22 +0000
Message-Id: <20181219180349.242681-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100420_957375_5E0CB900 
X-CRM114-Status: GOOD (  13.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4KCldoZW4gd2UgZW11bGF0
ZSBhbiBNTUlPIGluc3RydWN0aW9uLCB3ZSBhZHZhbmNlIHRoZSBDUFUgc3RhdGUgd2l0aGluCmRl
Y29kZV9oc3IoKSwgYmVmb3JlIGVtdWxhdGluZyB0aGUgaW5zdHJ1Y3Rpb24gZWZmZWN0cy4KCkhh
dmluZyB0aGlzIGxvZ2ljIGluIGRlY29kZV9oc3IoKSBpcyBvcGFxdWUsIGFuZCBhZHZhbmNpbmcg
dGhlIHN0YXRlCmJlZm9yZSBlbXVsYXRpb24gaXMgcHJvYmxlbWF0aWMuIEl0IGdldHMgaW4gdGhl
IHdheSBvZiBhcHBseWluZwpjb25zaXN0ZW50IHNpbmdsZS1zdGVwIGxvZ2ljLCBhbmQgaXQgcHJl
dmVudHMgdXMgZnJvbSBiZWluZyBhYmxlIHRvIGZhaWwKYW4gTU1JTyBpbnN0cnVjdGlvbiB3aXRo
IGEgc3luY2hyb25vdXMgZXhjZXB0aW9uLgoKQ2xlYW4gdGhpcyB1cCBieSBvbmx5IGFkdmFuY2lu
ZyB0aGUgQ1BVIHN0YXRlICphZnRlciogdGhlIGVmZmVjdHMgb2YgdGhlCmluc3RydWN0aW9uIGFy
ZSBlbXVsYXRlZC4KCkNjOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClJldmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+ClJldmll
d2VkLWJ5OiBDaHJpc3RvZmZlciBEYWxsIDxjaHJpc3RvZmZlci5kYWxsQGFybS5jb20+ClNpZ25l
ZC1vZmYtYnk6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+ClNpZ25lZC1vZmYt
Ynk6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+Ci0tLQogdmlydC9rdm0vYXJt
L21taW8uYyB8IDExICsrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2FybS9tbWlvLmMgYi92aXJ0
L2t2bS9hcm0vbW1pby5jCmluZGV4IGRhYzdjZWIxYTY3Ny4uMDg0NDNhMTVlNmJlIDEwMDY0NAot
LS0gYS92aXJ0L2t2bS9hcm0vbW1pby5jCisrKyBiL3ZpcnQva3ZtL2FybS9tbWlvLmMKQEAgLTEx
Nyw2ICsxMTcsMTIgQEAgaW50IGt2bV9oYW5kbGVfbW1pb19yZXR1cm4oc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKQogCQl2Y3B1X3NldF9yZWcodmNwdSwgdmNwdS0+
YXJjaC5tbWlvX2RlY29kZS5ydCwgZGF0YSk7CiAJfQogCisJLyoKKwkgKiBUaGUgTU1JTyBpbnN0
cnVjdGlvbiBpcyBlbXVsYXRlZCBhbmQgc2hvdWxkIG5vdCBiZSByZS1leGVjdXRlZAorCSAqIGlu
IHRoZSBndWVzdC4KKwkgKi8KKwlrdm1fc2tpcF9pbnN0cih2Y3B1LCBrdm1fdmNwdV90cmFwX2ls
X2lzMzJiaXQodmNwdSkpOworCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTE0NCwxMSArMTUwLDYgQEAg
c3RhdGljIGludCBkZWNvZGVfaHNyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCAqaXNfd3Jp
dGUsIGludCAqbGVuKQogCXZjcHUtPmFyY2gubW1pb19kZWNvZGUuc2lnbl9leHRlbmQgPSBzaWdu
X2V4dGVuZDsKIAl2Y3B1LT5hcmNoLm1taW9fZGVjb2RlLnJ0ID0gcnQ7CiAKLQkvKgotCSAqIFRo
ZSBNTUlPIGluc3RydWN0aW9uIGlzIGVtdWxhdGVkIGFuZCBzaG91bGQgbm90IGJlIHJlLWV4ZWN1
dGVkCi0JICogaW4gdGhlIGd1ZXN0LgotCSAqLwotCWt2bV9za2lwX2luc3RyKHZjcHUsIGt2bV92
Y3B1X3RyYXBfaWxfaXMzMmJpdCh2Y3B1KSk7CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuMTkuMgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
