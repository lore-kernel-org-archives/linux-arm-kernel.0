Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A311C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3AF21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nSZcvNvt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eTZbhfnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3AF21902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jQfMK9FZuCk9vzKUS4fxZawuva6ZDzXwXWGpFj/mL6k=; b=nSZcvNvtyKc/sU3s6pRcQMLma
	KXtrMaX3irSzFveiY+w6SkyPpjFJvXaQVHVac7tY0FqTptXplZYBmJK2AJ+4ZKklXVmLeHqPVApJ2
	IBu4zi2feWOwQCCtQ1CuJX7eomtcqJdWps4Ahcf+RqL+IyNGcCaAOupC5iUUg+fURLuv2kbnKWITE
	PavyVcMDEccDPANIF+vlWvAMcb/yrK5UvkfBc7A+9Dv+d5KmmRBJdNxsH+bUov8kseYhpaKqpd0kO
	/oD7atPapGBPFp3X8e0+hYD85FoANLI8sbpQRDDHL0D1/9P6d2FT6GKF35PUNof/FuWgq1cAT80o0
	5qZHOioeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1griPB-0004ku-M1; Thu, 07 Feb 2019 12:03:45 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1griOx-0004db-92; Thu, 07 Feb 2019 12:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gm9K+i4NzBEWKyZUgxdC/mempUtOzUZgP4D0EegQEPg=; b=eTZbhfnCohFp/uEzQXKKUn8yW
 rj37lPV03DeVirULHjHXbsJFuWpfBdQGcBLxIbd8Sd6lN53xAgDd86DLItW17UZh8spHLMmcJg/uL
 j02bc9QsHGAXf60Sk7aqxo3FihzqAmQOjBNgPQkExsPHhB/n277jGMK+VM1t+XJj+iZyo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1griOo-0004s4-ML; Thu, 07 Feb 2019 12:03:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 2A4BD1127EF9; Thu,  7 Feb 2019 12:03:22 +0000 (GMT)
Date: Thu, 7 Feb 2019 12:03:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 4/6] mfd: Add support for the MediaTek MT6358 PMIC
Message-ID: <20190207120322.GA6190@sirena.org.uk>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-5-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20190207093450.GH4672@dell>
 <345df368-b247-9c4b-a69d-e95f14bff8b6@arm.com>
MIME-Version: 1.0
In-Reply-To: <345df368-b247-9c4b-a69d-e95f14bff8b6@arm.com>
X-Cookie: A day without sunshine is like night.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_040331_779317_3D6BDC4B 
X-CRM114-Status: GOOD (  26.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 jason@lakedaemon.net, srv_heupstream@mediatek.com,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, tglx@linutronix.de,
 Lee Jones <lee.jones@linaro.org>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Content-Type: multipart/mixed; boundary="===============3600379005731225894=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3600379005731225894==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 10:04:50AM +0000, Marc Zyngier wrote:
> On 07/02/2019 09:34, Lee Jones wrote:

> >> +static struct irq_top_t mt6358_ints[] =3D {
> >> +	MT6358_TOP_GEN(BUCK),
> >> +	MT6358_TOP_GEN(LDO),
> >> +	MT6358_TOP_GEN(PSC),
> >> +	MT6358_TOP_GEN(SCK),
> >> +	MT6358_TOP_GEN(BM),
> >> +	MT6358_TOP_GEN(HK),
> >> +	MT6358_TOP_GEN(AUD),
> >> +	MT6358_TOP_GEN(MISC),
> >> +};

> > What is a 'top' IRQ?

It looks like it's an intermediate parent IRQ controller; that's quite a
common design for MFDs on slow buses to cut down on the number of status
registers to poll.  IIRC there at least used to be some framework reason
for not using normal chained interrupts for these but I can't remember
it any more - possibly something to do with threaded handlers.

This is all looking very famililar, I suspect it's based on other
drivers dating back years rather than doing anything original.  There's
certainly a bunch of other drivers with very similar patterns in tree,
this doesn't look like it's got any problems over what most similar
drivers are doing.  The patterns all predate drivers/irqchip and a lot
of them will come from me.

> >> +static void pmic_irq_enable(struct irq_data *data)
> >> +{
> >> +	unsigned int hwirq =3D irqd_to_hwirq(data);
> >> +	struct mt6397_chip *chip =3D irq_data_get_irq_chip_data(data);
> >> +	struct pmic_irq_data *irq_data =3D chip->irq_data;
> >> +
> >> +	irq_data->enable_hwirq[hwirq] =3D 1;
> >> +}

> > I see that you're doing your own caching operations.  Is that
> > required?  I think I'm going to stop here and as for some IRQ guy's
> > input on this.

> Dunno either. I thought that's what regmap was for?

IIRC from when I wrote drivers for chips like this these operations are
called with interrupts disabled so you can't write to interrupt driven
buses so you need to cache the write and flush in sync_unlock().  You
can't do this with regmap as it stands since on a device that can't be
accessed with interrupts disabled you'd need to disable the writes
before going into the interrupts off section and there's a risk that
having the device cache disabled would disrupt some other function on
the chip that was expecting writes to get posted immediately. =20

It would be possible to add per-register cache only behaviour but
someone would need to do that and it's not clear that it's worth the
effort, especially since for slow buses we currently lock the entire
regmap including the cache with mutexes so you can't actually access the
cache with interrupts off at the minute.

> >> +	for (i =3D 0; i < irq_data->num_pmic_irqs; i++) {
> >> +		if (irq_data->enable_hwirq[i] =3D=3D
> >> +				irq_data->cache_hwirq[i])
> >> +			continue;

> Please explain what you are trying to do here. The unlock operation is
> supposed to affect exactly one interrupt. Instead, you seem to deal with
> a bunch of them at once. Operations are supposed to happen on the "leaf"
> IRQs, not on the multiplexing interrupt.

IIRC it was done this way because it wasn't altogether clear if
operations on multiple interrupts could ever be batched or not and given
that we're dealing with slow buses the cost of the loop is negligable.

> Also, the whole cache thing seems pretty pointless. Why isn't regmap
> doing that for you?

See above.

> >> +	for (i =3D 0; i < mt6358_irq_data->num_top; i++) {
> >> +		if (top_int_status & BIT(mt6358_ints[i].top_offset))
> >> +			mt6358_irq_sp_handler(chip, i);
> >> +	}
> >> +
> >> +	return IRQ_HANDLED;
> >> +}

> Why isn't this a normal chained irq flow, instead of a homegrown irq
> handler? Is that because this is a threaded handler?

I think that's it but like I say I can't remember clearly any more, it's
been a decade.

> >> +	ret =3D devm_request_threaded_irq(chip->dev, chip->irq, NULL,
> >> +					mt6358_irq_handler, IRQF_ONESHOT,
> >> +					mt6358_irq_chip.name, chip);
> >> +	if (ret) {
> >> +		dev_err(chip->dev, "failed to register irq=3D%d; err: %d\n",
> >> +			chip->irq, ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	enable_irq_wake(chip->irq);

> Why is that decided at probe time, from kernel space?

IIRC it's due to it being the main interrupt for the device and there
being at some point issues with this getting propagated to parent
interrupts so wake just got turned on all the time for the parent and we
relied on controlling the children.  Making things be proper chained
interrupt controllers would solve that I think.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxcHocACgkQJNaLcl1U
h9B9mAf/RuWwFpw3PPjPrnHv+xB/CJ53tlD3ne/pLesX3Dj2s5CJwyZ4IQSzAGFi
B8KuBsT4410iudGgjRUBaa/S/CxDa+krUbCDhsSQJtYtKrnluYU0H8oxTCHklMJa
TwOOY9wb3DHgtkfqpPW9rGYEh9QVf6eBBDwVdxFezg7L6zkpZo5jNhSn11bpfnQK
XoEvqqNcQlUaPHQYxLO7UUwLjHwQf6RPJ7Apz+cq+Ba1PodachBYgorlmwpri1Uo
rQoaK1gWRrhfYo6t5seS/boh1lh3UG8wcPsOCC8oUsK+slMnoh/JgMR12D1EMy0I
Hab61OGqyBJKO3G+lhhm+xRtWYADHg==
=wiwY
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


--===============3600379005731225894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3600379005731225894==--

