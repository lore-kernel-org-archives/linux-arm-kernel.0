From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 6 Dec 2012 17:58:00 +0100
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <CAMiH66EPDKhd=pBJWhtm3P+qgGcdVbHD-hb93ZB7Ou7Sc=vByg@mail.gmail.com>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
 <50BFFFE8.8040002@freescale.com>
 <20121206095213.GA2589@pengutronix.de>
 <CAMiH66EPDKhd=pBJWhtm3P+qgGcdVbHD-hb93ZB7Ou7Sc=vByg@mail.gmail.com>
Message-ID: <20121206165800.GA17129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Did you power-cycle between each test or reboot? I still need to test if
> What's the meaning of "power-cycle"?

power off - power on

> I only tested with the soft reset, the power is never shut down.

OK.

> With your patch, we have resetted the BCH twice in the driver. Could
> we only reset BCH one time?

You tell me, please :) Is it needed when changing the layout? I don't
have any setup to test that. Unless I can test that, I prefer to not
remove it. I am a bit anxious, because the reason for the stalled BCH is
not fully understood and all I can reliably say is that resetting twice
does not hurt.

> Do you ever remove another reset-bch code, and test it?

It will probably work, but we don't cover the case of changing the
layout?

> Frankly speaking, it's strange to reset the BCH twice, and it makes no sense. :(

The stalled BCH makes no sense either, currently.

> I am afraid that we have to add three-reset-bch in the future, if we
> can not find the root cause.

Well, ask the IC guys if something can go wrong when the BCH has been
active and the GPMI gets reset and issues NAND commands (without needing
ECC).

> If you can remove another reset-bch code, i will ack the patch.

Removing code that late in the cycle without proof sounds dangerous to
me.

> > The setup needs to be done properly to ensure a consistent state at the
> > beginning, especially when somebody used the NAND before (ROM code,
> At the beginning? it's really interesting.
> I want to test it myself.
> 
> could you wait for some time?

What is some time? :)

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121206/7fba6926/attachment.sig>
