From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 12:06:28 -0800
Subject: [PATCH 2/6] clk: bcm2835: add locking to pll*_on/off methods
In-Reply-To: <1456745963-2403-3-git-send-email-kernel@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87y4a35liz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add missing locking to:
> * bcm2835_pll_divider_on
> * bcm2835_pll_divider_off
> to protect the read modify write cycle for the
> register access protecting both cm_ctl and a2w_ctl
> registers.

s/ctl/reg/ in the commit message

bcm2835_pll_divider_set_rate() also does an RMW on cm_reg, why was it
left out?

Since the a2w reg is only modified by _on and _off, and the core holds
the prepare lock across those, I think it was already safe and doesn't
need to be mentioned here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/39df8abd/attachment.sig>
