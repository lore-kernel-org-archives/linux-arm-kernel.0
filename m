From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Feb 2018 11:29:40 +0100
Subject: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
In-Reply-To: <5A7916A2.7010307@samsung.com>
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
 <20180205142230.9755-1-s.nawrocki@samsung.com>
 <5A7916A2.7010307@samsung.com>
Message-ID: <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2018 03:44 AM, Chanwoo Choi wrote:
> When I developed the clk-exynos5433.c I referred to the following description.
> TRM specified that "Samsung recommends only the values
> between 252MH ~ 400MHz in the PMS2460X PMS value" for aud_pll.

Thanks, I somehow missed it. There is also another sentence pointing to
a contact person if other values are needed.

> It looks like that you refer to clk-exynos5420.c driver.
> But, I'm wondering exynos5433 might not guarantee the additional clock
> of this patch as the stable clock.

I took the values from downstream SM-N910C_LL kernel, I would say they
are well tested and reliable. How about adding just these 3 entries:

+	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
+	PLL_36XX_RATE(180633609U, 301, 5, 3,   3671),
+	PLL_36XX_RATE(131072006U, 131, 3, 3,   4719),
?
 
They are needed for audio sample rates that are multiple of 32000, 44100
or 48000 Hz. The AUD PLL frequency values which are currently defined
are not useful for anything except fs 48000 (fpll = 393216000 Hz).

We could add new PLL rates: 361267218, 262144000, but I'm not convinced
these would be any better than values used in a shipped product. We would 
need to confirm below values with the HW team, and I'm not sure what 
would be the P, M, S, K set for 262144000 frequency.

	PLL_36XX_RATE(361267218U, 301, 5, 2,   3671),

As it turns out, the 393216000 Hz entry needs correction, the actual 
frequency value from the P, M, S, K equation is 393216003:

-	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
+	PLL_36XX_RATE(393216003U, 197, 3, 2, -25690),

Hmm, I have tested with the PLL frequency set to 393216003 Hz and there
are some glitches during audio playback, I can't get it to work properly.

--
Regards,
Sylwester
