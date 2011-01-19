From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jan 2011 21:34:49 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <20110118121455.GB9719@n2100.arm.linux.org.uk>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
Message-ID: <AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> How reliable is the FIFOCNT register ?
>
> What I'm wondering is whether we can get rid of the DATABLOCKEND
> interrupts completely, and instead read the FIFOCNT register to
> discover how many blocks have been successfully transferred. ?FIFOCNT
> on read gives you the remaining number of words to be transferred into
> the FIFO from the card, not the number of words still to be read by the
> host CPU.

Hmm... the FIFOCNT is just the FIFO.

Do you mean the MMCIDATACNT register? According to the manual
it has exactly that meaning, and is valid "when the data transfer is
complete" which you could assume it to be if you hit an error.
But I'm not betting on it...

Possibly you should add/subtract the words in FIFOCNT too,
but I would say that's a later excercise.

But I think it's a good idea. I'll prep an RFC patch we can test,
we may need some broken cards to test it on though.

> Not sure if that's valid for write atm.

In that specific case you may need to also add the FIFOCNT I
suspect, but I guess we can/will find out.

This approach surely gives better precision than using the blockend
interrupts any day.

I'll hack up something and give it a spin.

I don't know what the purpose of the blockend interrupt really
is, but suspect it may be about reusing ring buffers for MMC
transfers which Linux currently doesn't have need for.

Yours,
Linus Walleij
