From: emil@limesaudio.com (Emil Lundmark)
Date: Tue, 11 Oct 2016 11:52:23 +0200
Subject: [PATCH v2 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <20161010135454.a6t46o4ocpwjmkwi@pengutronix.de>
References: <cover.1476092427.git.emil@limesaudio.com>
 <4e8696869cc82443825a590966bbd3a265befdfa.1476092427.git.emil@limesaudio.com>
 <20161010135454.a6t46o4ocpwjmkwi@pengutronix.de>
Message-ID: <20161011095223.GA8477@lime>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 03:54:54PM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Oct 10, 2016 at 12:03:05PM +0200, Emil Lundmark wrote:
> > Since 'parent_rate * mfn' may overflow 32 bits, the result should be
> > stored using 64 bits.
> > 
> > Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
> > Signed-off-by: Emil Lundmark <emil@limesaudio.com>
> > ---
> >  drivers/clk/imx/clk-pllv3.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> > index 19f9b622981a..bc7f163ea13c 100644
> > --- a/drivers/clk/imx/clk-pllv3.c
> > +++ b/drivers/clk/imx/clk-pllv3.c
> > @@ -247,7 +247,11 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
> >  	do_div(temp64, parent_rate);
> >  	mfn = temp64;
> >  
> > -	return parent_rate * div + parent_rate * mfn / mfd;
> > +	temp64 = (u64)parent_rate;
> > +	temp64 *= mfn;
> > +	do_div(temp64, mfd);
> 
> If you change parent_rate from unsigned long to u64 this simplifies to
> 
> 	temp64 = parent_rate * mfn
> 	do_div(temp64, mfd);
> 

Yes, I took my inspiration from clk_pllv3_av_recalc_rate().

> > +
> > +	return parent_rate * div + (u32)temp64;
> 
> When thinking about overflow problems: Should this fail somehow if
> temp64 != (u32)temp64?

Well, it will fail in the sence that the desired clock will not be
returned. However, since mfn / mfd < 1 it should be fine as long as
ULONG_MAX <= U32_MAX. So, maybe it would be better to cast it to unsigned
long? This would then also need to be changed in
clk_pllv3_av_recalc_rate().

-- 
Emil Lundmark
