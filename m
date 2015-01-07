From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 7 Jan 2015 22:22:09 +0800
Subject: [PATCH 3/3] clk: berlin: bg2q: remove non-exist "smemc" gate clock
In-Reply-To: <54AD3EAE.6090009@gmail.com>
References: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
 <1420016272-6789-4-git-send-email-jszhang@marvell.com>
 <54AD3EAE.6090009@gmail.com>
Message-ID: <20150107222209.64ed24a0@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Wed, 7 Jan 2015 06:11:58 -0800
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 31.12.2014 09:57, Jisheng Zhang wrote:
> > The "smemc" clock is removed on BG2Q SoCs. In fact, bit19 of clkenable
> > register is for nfc. Current code use bit19 for non-exist "smemc"
> > incorrectly, this prevents eMMC from working due to the sdhci's
> > "core" clk is still gated.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > Cc: stable at vger.kernel.org # 3.16+
> > ---
> >   drivers/clk/berlin/bg2q.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
> > index 21784e4..440ef81 100644
> > --- a/drivers/clk/berlin/bg2q.c
> > +++ b/drivers/clk/berlin/bg2q.c
> > @@ -285,7 +285,6 @@ static const struct berlin2_gate_data bg2q_gates[]
> > __initconst = { { "pbridge",	"perif",	15,
> > CLK_IGNORE_UNUSED }, { "sdio",	"perif",	16,
> > CLK_IGNORE_UNUSED }, { "nfc",	"perif",	18 },

The nfc here is really confusing, we call it as nfccore internally. Is it better
to rename it as nfccore?

> > -	{ "smemc",	"perif",	19 },
> 
> Jisheng,
> 
> if bit 19 is for nfc, how does that work out with bit 18 which is
> still assigned to nfc? Can you re-evaluate clkenable registers for

bit 19 is for nfcEcc, the "io" clock; bit 18 is for nfcCore, the "core" clock.


> BG2Q and fix it up accordingly? I'd suggest to still disable as many

I'll recheck the clk driver for BG2Q.

Thanks very much,
Jisheng
