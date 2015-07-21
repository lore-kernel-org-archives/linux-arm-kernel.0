From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 21 Jul 2015 23:04:25 +0200
Subject: [PATCH] clk: rockchip: Fix PLL bandwidth
In-Reply-To: <1437511283-14216-1-git-send-email-dianders@chromium.org>
References: <1437511283-14216-1-git-send-email-dianders@chromium.org>
Message-ID: <2227753.WV2ipXIsxy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am Dienstag, 21. Juli 2015, 13:41:23 schrieb Douglas Anderson:
> In the TRM we see that BWADJ is "a 12-bit bus that selects the values
> 1-4096 for the bandwidth divider (NB)":
>  NB = BWADJ[11:0] + 1
> The recommended setting of NB: NB = NF / 2.
> 
> So:
>   NB = NF / 2
>   BWADJ[11:0] + 1 = NF / 2
>   BWADJ[11:0] = NF / 2 - 1
> 
> Right now, we have:
> 
> {                                               \
>         .rate   = _rate##U,                     \
>         .nr = _nr,                              \
>         .nf = _nf,                              \
>         .no = _no,                              \
>         .bwadj = (_nf >> 1),                    \
> }
> 
> That means we set bwadj to NF / 2, not NF / 2 - 1
> 
> All of this is a bit confusing because we specify "NR" (the 1-based
> value), "NF" (the 1-based value), "NO" (the 1-based value), but
> "BWADJ" (the 0-based value) instead of "NB" (the 1-based value).
> 
> Let's change to working with "NB" and fix the off by one error.  This
> may affect PLL jitter in a small way (hopefully for the better).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

we talked about this beforehand in the Chromeos bug and I verified this in the 
manual for all currently supported Rockchip socs (rk3066 - rk3368), so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Background: the original code stems from a time when I was still operating 
without documentation and I took this from the upstream kernel from that time 
and sadly forgot to double check once I had docs.


Thanks for fixing this
Heiko
