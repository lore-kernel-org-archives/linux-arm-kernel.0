From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 May 2015 11:02:41 +0200
Subject: [PATCH V3] ARM: imx: correct Audio/Video PLL rate calculation
 formula
In-Reply-To: <1431015264-8320-1-git-send-email-b20788@freescale.com>
References: <1431015264-8320-1-git-send-email-b20788@freescale.com>
Message-ID: <20150507090241.GI12306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

apart from a few minor issues regarding the wording of the commit log
I'm happy now. See below.

On Fri, May 08, 2015 at 12:14:24AM +0800, Anson Huang wrote:
> The audio/video PLL's rate calculation formula is as below in RM:
> 
> Fref * (DIV_SELECT + NUM / DENOM),
> 
> in original clk-pllv3's code, below code is used:
> 
> (parent_rate * div) + ((parent_rate / mfd) * mfn)
> 
> as it does NOT consider the float data using div, so below
s/float data using div/non-integer part of the division/

> calculation formula should be used as a decent method:
"decent" sounds strange to my (German) ears. Maybe better write:

	.. should be better used instead:

> 
> (parent_rate * div) + ((parent_rate * mfn) / mfd)
> 
> and we also need to consider parent_rate * mfd may exceed
s/exceed/overflow/

> a 32 bit value, 64 bit value should be used.
> 
> Below is one example of old/new formula's difference:
> 
> On i.MX7D, DRAM PLL is a Audio/Video type PLL, the target freq
> is 1066MHz, the register settings are as below:
> 
> PLL_DDRn: 8060202C   -> div = 0x2C
> DDR_NUM: 06AAAC4D    -> mfn = 0x6AAAC4D
> DDR_DENOM: 100003EC  -> mfd = 0x100003EC
> 
> parent_rate = 24MHz.
> 
> with old formula, the (parent_rate / mfd) * mfn = 0, with new formula,
> the (parent_rate * mfn) / mfd = 10MHz, so old formula gets
> PLL_DDR = 1056MHz, while the updated formuls gets PLL_DDR = 1066MHz
s/formuls/formula/

> which exactly matches the real rate.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
