From: chripell@fsfe.org (christian pellegrin)
Date: Mon, 8 Mar 2010 17:14:05 +0100
Subject: [PATCH v2] Fix GPIOs bank H and J not being preserved during
	suspend
In-Reply-To: <20100308155522.GE24864@trinity.fluff.org>
References: <cabda6421003080317t37124990v72ac56906719c091@mail.gmail.com>
	<1268047288-11166-1-git-send-email-chripell@fsfe.org>
	<20100308155522.GE24864@trinity.fluff.org>
Message-ID: <cabda6421003080814j2e17b664x1806a418928e09d4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 8, 2010 at 4:55 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>
> Still not getting why you're changing this from x, to x - 1.
>

ok: the reason is that gpio_nr is already incremented by one in the
for instruction. So gpio_nr is not pointing to the first pin of a bank
after the first iteration. Of course this doesn't matter because we
don't have 32 banks of gpio pins and s3c_gpiolib_getchip works even if
we point to a pin in the middle of a bank. But if we get a s3c device
with more than 32 banks the 33rd will be skipped. Or at least this is
the reason why I did this, maybe I'm mistaken.

Anyway this is a minor point, I fixed it when catching why bank H was
not preserved (and so my serial console ttyS1 was dead).

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
