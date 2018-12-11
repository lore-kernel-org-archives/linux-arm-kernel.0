Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98835C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6756C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WQdRcSJb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Q/XCbD4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6756C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P+XEA/Jyrn4oP9ogzOZfrUA3hMDvowq2ps/hyVa4D1Q=; b=WQdRcSJbNfukrofPmr3d6qGJ0
	gcLE8+lCAU/dtEKjbhThnngO22XswDXvC2Frl8TkQvQrsCLaYNtuNUYu/ad6Zu4yBNssPZW1uPioA
	YjLBFVFb2XwHGHg8LhFDqVol2839y8LMHbJBuFOWiXFiZ+3OPTuVoaYUzTBt0rBNBjlZNMjbSZre5
	3zOnICEArWSIhWAHEV8NAjwaFm7/0LE7+fpgTDNlzbuPZSaAZ0N7xzFJ5qoI0xzBvvhFhLmN4au5d
	7yY3IFGjFuJMiz+W68+XsHZhOTF8q6+ohVSDlSPZmz5Bh8BGO0M5mukU/cZ1ASib/VR3yhlfDSIR4
	Dh+h8L/TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWliW-000126-FB; Tue, 11 Dec 2018 17:21:08 +0000
Received: from mail.micronovasrl.com ([212.103.203.10])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWliR-000118-OR
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:21:06 +0000
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
 by mail.micronovasrl.com (Postfix) with ESMTP id 9847FB00963
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 18:20:41 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
 h=content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:to:subject:subject; s=dkim; t=
 1544548840; x=1545412841; bh=lzUdzsh9nSO9ox+zpeQnept2f623iwFC8hL
 wWZnPPSs=; b=Q/XCbD4YW822u/bs0Rq3ekC73D/QRPYHFw5BVL2ICy3xLTR7h7Y
 aZjNbYAE5IGpZU2wa+gd0ptGHK3kGKm0kvKeivz3BSZ5K4sUdfft7hViXuV69C8d
 N5XQIIUpL0W2UVXY9Aufy/j9ZLcwhav5v9ZJxH2udhJHR/oevhZ43ji0=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
 by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id opFJzgISwDLO for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 18:20:40 +0100 (CET)
Received: from [192.168.2.69] (88-149-228-83.v4.ngi.it [88.149.228.83])
 by mail.micronovasrl.com (Postfix) with ESMTPSA id 7C26DB00307;
 Tue, 11 Dec 2018 18:20:39 +0100 (CET)
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Jonathan Liu <net147@gmail.com>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
Date: Tue, 11 Dec 2018 18:20:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
Content-Language: it
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_092103_987860_C3496396 
X-CRM114-Status: GOOD (  48.88  )
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSm9uYXRoYW4sCgpJbCAxMS8xMi8yMDE4IDExOjQ5LCBKb25hdGhhbiBMaXUgaGEgc2NyaXR0
bzoKPiBIaSBHaXVsaW8sCj4gCj4gT24gVGh1LCA2IERlYyAyMDE4IGF0IDIyOjAwLCBHaXVsaW8g
QmVuZXR0aQo+IDxnaXVsaW8uYmVuZXR0aUBtaWNyb25vdmFzcmwuY29tPiB3cm90ZToKPj4KPj4g
SGkgSm9uYXRoYW4sCj4+Cj4+IElsIDA2LzEyLzIwMTggMDg6MjksIEpvbmF0aGFuIExpdSBoYSBz
Y3JpdHRvOgo+Pj4gSGkgR2l1bGlvLAo+Pj4KPj4+IE9uIFRodSwgMTUgRmViIDIwMTggYXQgMTc6
NTQsIEdpdWxpbyBCZW5ldHRpCj4+PiA8Z2l1bGlvLmJlbmV0dGlAbWljcm9ub3Zhc3JsLmNvbT4g
d3JvdGU6Cj4+Pj4KPj4+PiBEaWZmZXJlbnRseSBmcm9tIG90aGVyIExjZCBzaWduYWxzLCBIU1lO
QyBhbmQgVlNZTkMgc2lnbmFscwo+Pj4+IHJlc3VsdCBpbnZlcnRlZCBpZiB0aGVpciBiaXRzIGFy
ZSBjbGVhcmVkIHRvIDAuCj4+Pj4KPj4+PiBJbnZlcnQgdGhlaXIgc2V0dGluZ3Mgb2YgSU9fUE9M
IHJlZ2lzdGVyLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogR2l1bGlvIEJlbmV0dGkgPGdpdWxp
by5iZW5ldHRpQG1pY3Jvbm92YXNybC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUv
ZHJtL3N1bjRpL3N1bjRpX3Rjb24uYyB8IDQgKystLQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3N1bjRpL3N1bjRpX3Rjb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9z
dW40aV90Y29uLmMKPj4+PiBpbmRleCAzYzE1Y2YyLi5hYWY5MTFhIDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW40aV90Y29uLmMKPj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vc3VuNGkvc3VuNGlfdGNvbi5jCj4+Pj4gQEAgLTM4OSwxMCArMzg5LDEwIEBAIHN0YXRp
YyB2b2lkIHN1bjRpX3Rjb24wX21vZGVfc2V0X3JnYihzdHJ1Y3Qgc3VuNGlfdGNvbiAqdGNvbiwK
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgIFNVTjRJX1RDT04wX0JBU0lDM19IX1NZTkMoaHN5
bmMpKTsKPj4+Pgo+Pj4+ICAgICAgICAgICAvKiBTZXR1cCB0aGUgcG9sYXJpdHkgb2YgdGhlIHZh
cmlvdXMgc2lnbmFscyAqLwo+Pj4+IC0gICAgICAgaWYgKCEobW9kZS0+ZmxhZ3MgJiBEUk1fTU9E
RV9GTEFHX1BIU1lOQykpCj4+Pj4gKyAgICAgICBpZiAobW9kZS0+ZmxhZ3MgJiBEUk1fTU9ERV9G
TEFHX1BIU1lOQykKPj4+PiAgICAgICAgICAgICAgICAgICB2YWwgfD0gU1VONElfVENPTjBfSU9f
UE9MX0hTWU5DX1BPU0lUSVZFOwo+Pj4+Cj4+Pj4gLSAgICAgICBpZiAoIShtb2RlLT5mbGFncyAm
IERSTV9NT0RFX0ZMQUdfUFZTWU5DKSkKPj4+PiArICAgICAgIGlmIChtb2RlLT5mbGFncyAmIERS
TV9NT0RFX0ZMQUdfUFZTWU5DKQo+Pj4+ICAgICAgICAgICAgICAgICAgIHZhbCB8PSBTVU40SV9U
Q09OMF9JT19QT0xfVlNZTkNfUE9TSVRJVkU7Cj4+Pj4KPj4+PiAgICAgICAgICAgcmVnbWFwX3Vw
ZGF0ZV9iaXRzKHRjb24tPnJlZ3MsIFNVTjRJX1RDT04wX0lPX1BPTF9SRUcsCj4+Pgo+Pj4gSSBh
bSBydW5uaW5nIExpbnV4IDQuMTkuNiBhbmQgbm90aWNlZCB3aXRoIE9saW1leCBMQ0QtT0xpbnVY
aW5vLTdUUyA3Igo+Pj4gTENEIHRvdWNoc2NyZWVuIChJbm5vbHV4IEFUMDcwVE45MikgY29ubmVj
dGVkIHRvIE9saW1leAo+Pj4gQTIwLU9MaW51WGluby1NSUNSTyB0aGF0IHRoZSBpbWFnZSBkb2Vz
IG5vdCBkaXNwbGF5IGNvcnJlY3RseSBhZnRlcgo+Pj4gdGhpcyBjaGFuZ2UuCj4+PiBUaGUgaW1h
Z2UgaXMgc2hpZnRlZCB0byB0aGUgcmlnaHQuCj4+Pgo+Pj4gUmV2ZXJ0aW5nIHRoZSBjaGFuZ2Ug
cmVzdWx0cyBpbiB0aGUgaW1hZ2UgYmVpbmcgZGlzcGxheWVkIGNvcnJlY3RseSBvbgo+Pj4gdGhl
IHNjcmVlbi4KPj4+Cj4+PiBJIGhhdmUgaW4gdGhlIGRldmljZSB0cmVlIGEgInBhbmVsIiBub2Rl
IHdpdGggY29tcGF0aWJsZSA9Cj4+PiAiaW5ub2x1eCxhdDA3MHRuOTIiIHdoaWNoIHVzZXMgdGhl
IHRpbWluZ3MgaW4KPj4+IGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1zaW1wbGUuYy4KPj4+
Cj4+PiBBbnkgaWRlYXM/Cj4gCj4+Cj4+IENoZWNraW5nIERpc3BsYXkgRGF0YXNoZWV0Ogo+PiBo
dHRwczovL3d3dy5vbGltZXguY29tL1Byb2R1Y3RzL1JldGlyZWQvQTEzLUxDRDctVFMvcmVzb3Vy
Y2VzL1M3MDAtQVQwNzBUTjkyLnBkZgo+Pgo+PiBQYWdlIDEzIHNlY3Rpb24gMy4zLjIgeW91IGNh
biBzZWUgaXQgbmVlZHMgYWN0aXZlIGxvdyBWUyBhbmQgSFMuCj4+Cj4+IFlvdSBjYW4gcmVmZXIg
dG8gdGhpcyBUaHJlYWQgYW5kIGNoZWNrIHNjb3BlIGNhcHR1cmVzIGFib3V0IFZTIGFuZCBIUwo+
PiB2ZXJzdXMgVENPTjBfSU9QT0wgcmVnaXN0ZXI6Cj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE4LUphbnVhcnkvMTYzODc0Lmh0bWwKPj4KPj4g
VGhlcmUgc2hvdWxkIGJlIHNvbWV0aGluZyB0aGF0IHdyb25nbHkgc2V0cyBvbmUgb2YgdGhlc2Ug
b3IgYm90aDoKPj4gbW9kZS0+ZmxhZ3MgfD0gRFJNX01PREVfRkxBR19QSFNZTkM7Cj4+IGFuZC9v
cgo+PiBtb2RlLT5mbGFncyB8PSBEUk1fTU9ERV9GTEFHX1BWU1lOQzsKPj4KPj4gQ2hlY2tlZCBp
biBwYW5lbC1zaW1wbGUuYyBidXQgaXQncyBub3QgdGhlcmUuCj4gCj4gZmxhZ3MgaXMgMCBiZWNh
dXNlIGl0IGlzIG5vdCBhc3NpZ25lZCBpbiB0aGUgc3RydWN0IGRlZmluaXRpb24gZm9yIHRoZSBw
YW5lbC4KCkkgZG9uJ3QgdGhpbmsgaXQgaXMgMCwgYmVjYXVzZSBvdGhlcndpc2UgSU9fUE9MX1JF
RyB3b3VsZG4ndCBiZSBzZXQgdG8gCjB4MDMwMDAwMDAgYnV0IHRvIDAuCldoYXQgaXMgY2hlY2tl
ZCBpcyBleGFjdGx5IG1vZGUtPmZsYWdzLCBzbyB0aGUgcHJvYmxlbSBzZWVtcyB0byBiZSB1cHN0
cmVhbS4KClRoaXMgaXMgbXkgZG91YnQsIGl0IHNlZW1zIG1vZGUtPmZsYWdzIGlzIG5vdCBpbml0
aWFsaXplZCBvciBvdmVycmlkZW4gCmF0IGEgY2VydGFpbiBwb2ludCwgdGhpcyBpcyB3aHkgSSB3
YW50IHRvIGRlYnVnIGl0IHdpdGggSnRhZyB0b21vcnJvdy4KCj4gQmVmb3JlIHRoaXMgY2hhbmdl
LCBUQ09OMF9JT19QT0xfUkVHIHdvdWxkIGJlIDB4MDMwMDAwMDAgKGJvdGggYml0cwo+IHNldCB0
byAxKSBhbmQgaW1hZ2UgZGlzcGxheXMgY29ycmVjdGx5ID4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIFRD
T04wX0lPX1BPTF9SRUcgaXMgMHgwMDAwMDAwMCAoYm90aCBiaXRzIHNldCB0byAwKQo+IGFuZCBp
bWFnZSBkb2Vzbid0IGRpc3BsYXkgY29ycmVjdGx5Lgo+IAo+IENoZWNrZWQgdXNpbmcgImRldm1l
bTIgMHgwMWMwYzA4OCIgb24gQTIwLU9MaW51WGluby1NSUNSTyBSZXYgSi4KCjB4MDMwMDAwMDAg
YXMgSSd2ZSB0cmlwbGUgY2hlY2tlZCB3aXRoIHNjb3BlIG1lYW5zIFBvc2l0aXZlIEgvVnN5bmMs
CmFuZCAweDAwMDAwMDAwIE5lZ2F0aXZlIEgvVlN5bmMuCgpQbGVhc2UgY2hlY2sgb24gdGhlIFRo
cmVhZCBJJ3ZlIHBvaW50ZWQgeW91IGFib3ZlIHdoZXJlIHRoZXJlIGFyZSBhbGwgCnRoZSBsaW5r
cyB0byB0aGUgc2NvcGUgY2FwdHVyZXMuCgpBcmUgeW91IGNvbXBsZXRlbHkgc3VyZSB5b3UncmUg
dXNpbmcgdGhlIGNvcnJlY3QgcGFuZWw/ClRoaXMgaXMgYmVjYXVzZSBpZiB3aXRoIDB4MDMwMDAw
MDAgaXQgd29ya3MgY29ycmVjdGx5LCBpdCBtZWFucyB0aGF0IAp5b3UncmUgdXNpbmcgUG9zaXRp
dmUgVlMgYW5kIEhTIGJ1dCBvbiBkYXRhc2hlZXQgb24gRmlndXJlIDMuMiBpdCBzaG93cyAKdGhh
dCB0aGV5IG11c3QgYmUgbmVnYXRpdmUuCgpEbyB5b3UgaGF2ZSBhbnkgY2hhbmNlIHRvIG1lYXN1
cmUgdGhvc2Ugc2lnbmFscyB3aXRoIGEgc2NvcGU/CgpUb21vcnJvdywgd2hpbGUgZGVidWdnaW5n
LCBJJ2xsIHJlLWNoZWNrIEgvVnN5bmMgc2lnbmFscyBhZ2Fpbi4KCktpbmQgcmVnYXJkcwotLSAK
R2l1bGlvIEJlbmV0dGkKQ1RPCgpNSUNST05PVkEgU1JMClNlZGU6IFZpYSBBLiBOaWVkZGEgMyAt
IDM1MDEwIFZpZ29uemEgKFBEKQpUZWwuIDA0OS84OTMxNTYzIC0gRmF4IDA0OS84OTMxMzQ2CkNv
ZC5GaXNjYWxlIC0gUC5JVkEgMDI2NjM0MjAyODUKQ2FwaXRhbGUgU29jaWFsZSDigqwgMjYuMDAw
IGkudi4KSXNjcml0dGEgYWwgUmVnLiBJbXByZXNlIGRpIFBhZG92YSBOLiAwMjY2MzQyMDI4NQpO
dW1lcm8gUi5FLkEuIDI1ODY0MgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
