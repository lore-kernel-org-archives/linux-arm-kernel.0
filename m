From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 05 Oct 2010 22:00:02 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953
	and	ENGcm09472
In-Reply-To: <20101005194659.GY11737@pengutronix.de>
References: <20101005094510.GJ28242@pengutronix.de>
	<1286280012-19809-1-git-send-email-eric@eukrea.com>
	<20101005183308.GX11737@pengutronix.de>
	<4CAB7D0F.9020600@eukrea.com>
	<20101005194659.GY11737@pengutronix.de>
Message-ID: <4CAB83C2.3040301@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 05/10/2010 21:46, Uwe Kleine-K?nig a ?crit :
> hmm, it's a copy of the code suggested there, yes.  The text before the
> example doesn't suggest that timing is an issue for the work around.  I
> interpret it that everything is fine when the caches are off before
> executing the wfi instruction.  But OK, it wouldn't be the first time
> hardware documentation isn't exact to the point.
>
Well the doc says there is an other workaround (setting CPU freq = AHB 
freq, waiting clock to switch, WFI, restore original CPU freq) doesn't 
work for me and support seems not very confident with this other 
workaround as they immediatl directed me to this one ...

> Hmm, when the caches are off before entering wfi, does that mean that
> all interrupt (and fiq) handlers run with the caches off, too?  That's
> very bad, isn't it?
>
If I understand well, this case happens only when they run after WFI 
which means cpuidle was called (and thus CPU activity was null for a 
certain amount of time, which explains why it's easier to reproduce the 
problem with tslib than with qtdemo which takes 100% CPU and don't let 
cpuidle to execute very often).

That may seems bad, but I find this solution better than having an oops 
after a few IRQs which makes the CPU unusable for real life applications :-)

Eric
