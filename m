Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64009206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tgb99fkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64009206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ul+dHpFaceBDL1WU4DU7rlNK8UVSqNWIiLtkBSOsWcI=; b=Tgb99fkI4K1q3U
	gQy4m26qt26vHXVx2S/s3WiXppLszp/8P6ens/NE+RoaagI2hPjOskxwQVvd1hoHlgYC/LtNOKyZe
	F6phG8lC3f38jtpe171X80tJdqZq73TVJ68sV81nK21V0I4hwiLNjVAHPJsjThIisU2U6ESYkCspI
	Il3dhfU/M1la6Y6tq4jUHTnEk1Bpgk7op7PRjK/piPmrPc7ScVXMNTuuRFDur+vTVbyWODsMX3an7
	ssyCPwsraUCqGyoFoF8VlYL4ATsrEdXSbr16yq5hGINpdkK50kqRyGVc8D+Gz1P/N19wFCePwKnO2
	p/PcpImAZpxCaX1iS+Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvge-0002ES-P6; Tue, 08 Jan 2019 18:01:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggveZ-0007Ko-SA
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:59:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD16A78;
 Tue,  8 Jan 2019 09:59:03 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DCD33F5AF;
 Tue,  8 Jan 2019 09:59:01 -0800 (PST)
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Dave Martin <Dave.Martin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190108153957.GA5840@e103592.cambridge.arm.com>
 <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
 <20190108164510.GB5840@e103592.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <699ebbc0-fff9-0a1c-9dfa-4b7da078904c@arm.com>
Date: Tue, 8 Jan 2019 17:58:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108164510.GB5840@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095905_591833_E23D0A76 
X-CRM114-Status: GOOD (  31.95  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAwOC8wMS8yMDE5IDE2OjQ1LCBEYXZlIE1hcnRpbiB3cm90ZToKPiBPbiBUdWUsIEphbiAw
OCwgMjAxOSBhdCAwMzo1MToxOFBNICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+IE9uIDA4
LzAxLzIwMTkgMTU6NDAsIERhdmUgTWFydGluIHdyb3RlOgo+Pj4gT24gVHVlLCBKYW4gMDgsIDIw
MTkgYXQgMDI6MDc6MzBQTSArMDAwMCwgSnVsaWVuIFRoaWVycnkgd3JvdGU6Cj4+Pj4gSW5zdGVh
ZCBkaXNhYmxpbmcgaW50ZXJydXB0cyBieSBzZXR0aW5nIHRoZSBQU1IuSSBiaXQsIHVzZSBhIHBy
aW9yaXR5Cj4+Pj4gaGlnaGVyIHRoYW4gdGhlIG9uZSB1c2VkIGZvciBpbnRlcnJ1cHRzIHRvIG1h
c2sgdGhlbSB2aWEgUE1SLgo+Pj4+Cj4+Pj4gV2hlbiB1c2luZyBQTVIgdG8gZGlzYWJsZSBpbnRl
cnJ1cHRzLCB0aGUgdmFsdWUgb2YgUE1SIHdpbGwgYmUgdXNlZAo+Pj4+IGluc3RlYWQgb2YgUFNS
LltEQUlGXSBmb3IgdGhlIGlycWZsYWdzLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSnVsaWVu
IFRoaWVycnkgPGp1bGllbi50aGllcnJ5QGFybS5jb20+Cj4+Pj4gU3VnZ2VzdGVkLWJ5OiBEYW5p
ZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPgo+Pj4+IENjOiBDYXRhbGlu
IE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgo+Pj4+IENjOiBXaWxsIERlYWNvbiA8
d2lsbC5kZWFjb25AYXJtLmNvbT4KPj4+PiBDYzogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+Cj4+Pj4gQ2M6IE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVkaGF0LmNvbT4K
Pj4+PiAtLS0KPj4+PiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9lZmkuaCAgICAgIHwgIDExICsr
KysKPj4+PiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9pcnFmbGFncy5oIHwgMTIzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMTA2
IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+Pj4KPj4+IFsuLi5dCj4+Pgo+Pj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lycWZsYWdzLmggYi9hcmNoL2FybTY0
L2luY2x1ZGUvYXNtL2lycWZsYWdzLmgKPj4+PiBpbmRleCAyNDY5MmVkLi5mYTNiMDZmIDEwMDY0
NAo+Pj4+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaAo+Pj4+ICsrKyBi
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaAo+Pj4+IEBAIC0xOCw3ICsxOCw5IEBA
Cj4+Pgo+Pj4gWy4uLl0KPj4+Cj4+Pj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX2xvY2FsX2ly
cV9lbmFibGUodm9pZCkKPj4+PiAgewo+Pj4+IC0JYXNtIHZvbGF0aWxlKAo+Pj4+IC0JCSJtc3IJ
ZGFpZmNsciwgIzIJCS8vIGFyY2hfbG9jYWxfaXJxX2VuYWJsZSIKPj4+PiAtCQk6Cj4+Pj4gKwl1
bnNpZ25lZCBsb25nIHVubWFza2VkID0gR0lDX1BSSU9fSVJRT047Cj4+Pj4gKwo+Pj4+ICsJYXNt
IHZvbGF0aWxlKEFMVEVSTkFUSVZFKAo+Pj4+ICsJCSJtc3IJZGFpZmNsciwgIzIJCS8vIGFyY2hf
bG9jYWxfaXJxX2VuYWJsZVxuIgo+Pj4+ICsJCSJub3AiLAo+Pj4+ICsJCSJtc3JfcyAgIiBfX3N0
cmluZ2lmeShTWVNfSUNDX1BNUl9FTDEpICIsJTBcbiIKPj4+PiArCQkiZHNiCXN5IiwKPj4+Cj4+
PiBJJ20gc3RpbGwgbm90IGNvbnZpbmNlZCB0aGVzZSBkc2JzIGFyZSBuZWVkZWQuCj4+Pgo+Pj4g
V2l0aG91dCB0aGUgZHNiLCB3ZSBhcmUgcHJvYmFibHkgbm90IGd1YXJhbnRlZWQgdG8gdGFrZSBh
IHBlbmRpbmcKPj4+IGludGVycnVwdCBfaW1tZWRpYXRlbHlfIG9uIHVubWFza2luZywgYnV0IEkn
bSBub3Qgc3VyZSB0aGF0J3MgYQo+Pj4gcHJvYmxlbS4KPj4+Cj4+PiBXaGF0IGdvZXMgd3Jvbmcg
aWYgd2Ugb21pdCB0aGVtPwo+Pgo+PiBUaGVuIHRoZSBHSUMgZG9lc24ndCBrbm93IGl0IGNhbiBu
b3cgZGVsaXZlciBpbnRlcnJ1cHRzIG9mIGEgbG93ZXIKPj4gcHJpb3JpdHkuIE9ubHkgYSBkc2Ig
Y2FuIGd1YXJhbnRlZSB0aGF0IHRoZSBHSUMncyB2aWV3IG9mIFBNUiB3aWxsIGdldAo+PiB1cGRh
dGVkLgo+Pgo+PiBTZWUgOS4xLjYgKE9ic2VydmFiaWxpdHkgb2YgdGhlIGVmZmVjdHMgb2YgYWNj
ZXNzZXMgdG8gdGhlIEdJQwo+PiByZWdpc3RlcnMpLCB3aGljaCBzdGF0ZXM6Cj4+Cj4+IDxxdW90
ZT4KPj4gQXJjaGl0ZWN0dXJhbCBleGVjdXRpb24gb2YgYSBEU0IgaW5zdHJ1Y3Rpb24gZ3VhcmFu
dGVlcyB0aGF0Cj4+IOKAlCBUaGUgbGFzdCB2YWx1ZSB3cml0dGVuIHRvIElDQ19QTVJfRUwxIG9y
IEdJQ0NfUE1SIGlzIG9ic2VydmVkIGJ5IHRoZQo+PiBhc3NvY2lhdGVkIFJlZGlzdHJpYnV0b3Iu
Cj4+IDwvcXVvdGU+Cj4+Cj4+IFNvIHllcywgRFNCIGlzIHJlcXVpcmVkLgo+IAo+IEJ1dCBpdCBz
YXlzIG5laXRoZXIgd2hhdCBpcyBtZWFucyBmb3IgdGhlIFBNUiB3cml0ZSB0byBiZSAib2JzZXJ2
ZWQgYnkKPiB0aGUgcmVkaXN0cmlidXRvciIsIG5vciB3aGV0aGVyIHRoZSBEU0IgaXMgcmVxdWly
ZWQgZm9yIHRoZQo+IHJlZGlzdHJpYnV0b3IgdG8gb2JzZXJ2ZSB0aGUgd3JpdGUgYXQgYWxsLiAg
KFNvLCBpcyBhbiBpbXBsZW1lbnRhdGlvbgo+IGFsbG93ZWQgdG8gY2FjaGVkIGluIHRoZSBDUFUg
aW50ZXJmYWNlIGluZGVmaW5pdGVseSB1bnRpbCBmb3JjaWJseQo+IGZsdXNoZWQgdG8gdGhlIHJl
ZGlzdHJpYnV0b3IgYnkgYSBEU0IsIGFuZCBpbiBhbnkgY2FzZSBjYW4gdGhlIHdyaXRlJ3MKPiBy
ZWFjaGluZyB0aGUgZGlzdHJpYnV0b3IgaW4gZmluaXRlIHRpbWUgb3Igbm90IGhhdmUgYW55IGVm
ZmVjdCB0aGF0IHdlCj4gY2FyZSBhYm91dCBpbiB0aGlzIGNhc2U/KS4KPiAKPiAKPiBNeSByZWFz
b24gZm9yIHF1ZXJ5aW5nIHRoaXMgaXMgdGhhdCB0ZW1wb3JhcnkgbG9jYWwgbWFza2luZyBvZiBj
bGFzc2VzCj4gb2YgaW50ZXJydXB0cyBzZWVtcyBhbiBvYnZpb3VzIHVzZSBjYXNlIGZvciB0aGUg
UE1SLCBhbmQgdGhlIERTQgo+IHJlcXVpcmVtZW50IGZsaWVzIHJhdGhlciBpbiB0aGUgZmFjZSBv
ZiB0aGlzLgo+IAo+IAo+IEhhdmUgd2Ugc2VlbiBoYXJkd2FyZSB3aGVyZSBpbnRlcnJ1cHRzIG1h
eSBzdGFsbCBmb3JldmVyIHVwc3RyZWFtIG9mIHRoZQo+IENQVSBpbnRlcmZhY2UgYWZ0ZXIgYSBQ
TVIgd3JpdGUsIHVudGlsIGEgZHNiIGlzIGV4ZWN1dGVkIGJ5IHRoZSBDUFU/Cj4gCgpJIGRvbid0
IGhhdmUgdG9vIG11Y2ggR0lDdjMgaGFyZHdhcmUgYXQgaGFuZCBidXQgdGhlIG9uZSBJIHRlc3Rl
ZAoqc2VlbXMqIHRvIHdvcmsgd2l0aG91dCB0aGUgRFNCLiBCdXQgb2YgY291cnNlIHRoaXMgZG9l
cyBub3QgbWVhbiBpdCBpcwpjb3JyZWN0IGV2ZW4gb24gdGhhdCBoYXJkd2FyZS4KCkFzIHlvdSBz
YWlkIGl0IGlzIG5vdCBjbGVhciB3aGF0IGlzIG1lYW50IGJ5ICJvYnNlcnZlZCBieSB0aGUKcmVk
aXN0cmlidXRvciIsIGl0IGNhbiBtZWFuIHRoYXQgdGhlIHJlZGlzdHJpYnV0b3IgaXMgYWxsb3dl
ZCB0byBzdG9wCmZvcndhcmRpbmcgaW50ZXJydXB0cyBvZiBsb3dlciBwcmlvcml0eSBvciBpdCBj
YW4gbWVhbiB0aGF0IGl0IGFsd2F5cwpmb3J3YXJkcyB0aGVtIGFzIHRoZSBDUFUgaW50ZXJmYWNl
IGlzIHJlcXVpcmVkIHRvIHByZXZlbnQgbWFza2VkCnByaW9yaXR5IGludGVycnVwdHMgdG8gYmUg
c2lnbmFsZWQgdG8gdGhlIENQVS4gVGhlIGhhcmR3YXJlIEknbSB1c2luZwptaWdodCBiZSBpbiB0
aGUgbGF0dGVyIGNhc2UuLi4gb3Igbm90Li4uCgoKCj4gSWYgc28gdGhhdCBpcyBzYWQsIGJ1dCBJ
IGd1ZXNzIHdlIGhhdmUgdG8gbGl2ZSB3aXRoIGl0Lgo+IAo+IEFsc28sIGlzIGl0IGV2ZXIgaW1w
b3J0YW50IGluIExpbnV4IHRoYXQgYSBwZW5kaW5nIGludGVycnVwdCBiZSB0YWtlbgo+IGltbWVk
aWF0ZWx5IHVwb24gdW5tYXNraW5nIChhbmQgaG93IGRvIHdlIGtub3cgdGhhdCBzYWlkIGludGVy
cnVwdCBpcwo+IHBlbmRpbmcpPyAgSWYgbm90LCB3ZSBkb24ndCBjYXJlIHByZWNpc2VseSB3aGVu
IHN1Y2ggaW50ZXJydXB0cyBhcmUKPiBwZW5kZWQgdG8gdGhlIFBFLCBqdXN0IHRoYXQgc3VjaCBh
biBpbnRlcnJ1cHQgY2Fubm90IGJlIHRha2VuIGJlZm9yZQo+IHRoZSBQTVIgd3JpdGUgdGhhdCB1
bm1hc2tzIGl0LiAgSXQgd291bGQgYmUgaW5zYW5lIGZvciB0aGUgc2VsZi0KPiBzeW5jaHJvbml6
YXRpb24gb2YgUE1SIHdyaXRlcyB0byBsYWNrIHRoaXMgZ3VhcmFudGVlIChhbmQgYSBEU0IgYWZ0
ZXIKPiB0aGUgUE1SIHdyaXRlIHdvdWxkIGRvIG5vIGdvb2QgYW55d2F5IGluIHRoYXQgY2FzZSku
Cj4gCgpUaGUgZmlyc3QgdGhpbmcgdGhhdCBjb21lcyB0byBtaW5kIGZvciB0aGlzIHdvdWxkIGJl
IHRoZSBSVCB3b3JsZCwgSSdtCm5vdCBzdXJlIGl0IHdvdWxkIGl0IHdvdWxkIGJlIG5pY2UgdG8g
aGF2ZSBpbnRlcnJ1cHRzICJhY3R1YWxseQp1bm1hc2tlZCIgYXQgc29tZSByYW5kb20gdGltZSBp
biB0aGUgZnV0dXJlLgoKT3RoZXJ3aXNlLCBhcmVuJ3QgdGhlcmUgc29tZSBwYXJ0cyBvZiB0aGUg
a2VybmVsIHRoYXQgZXhwZWN0IGJlaW5nIGFibGUKdG8gdGFrZSBpbnRlcnJ1cHRzPyAobWVtb3J5
IGFsbG9jYXRpb24gY29tZXMgdG8gbWluZCkuIFdoYXQgaGFwcGVucyBpZgp0aGUgaW50ZXJydXB0
IG1pZ2h0IG5vdCBoYXBwZW4/CgpBbHNvLCBjb2RlIHRoYXQgZG9lczoKCndoaWxlICghcG9sbF91
cGRhdGVfZnJvbV9pcnEoKSkgewoJbG9jYWxfaXJxX2Rpc2FibGUoKTsKCgkvLyBkbyBzdHVmZgoK
CWxvY2FsX2lycV9lbmFibGUoKTsKfQoKTWlnaHQgbmV2ZXIgc2VlIGludGVycnVwdHMuIEl0IGlz
IG5vdCBjbGVhciB0byBtZSB3aGV0aGVyIHRoYXQgaXMgdGhlCmNhc2UgZm9yIHRoZSBsb29wIGlu
IGRvX2lkbGUoKSBhbmQgdGhlIGNoZWNrIGZvciBuZWVkX3Jlc2NoZWQoKS4KCkkgZG9uJ3Qga25v
dyBpZiBkcml2ZXJzIG1pZ2h0IGhhdmUgc3VjaCBjb2RlIHBhdHRlcm5zLgoKQ2hlZXJzLAoKLS0g
Ckp1bGllbiBUaGllcnJ5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
