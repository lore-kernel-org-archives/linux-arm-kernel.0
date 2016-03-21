From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Mar 2016 09:25:49 +0100
Subject: [PATCH] clk: sunxi: Accept a greater rate when setting a parent
 clock
In-Reply-To: <20160321072546.GT30977@lukather>
References: <20160310081658.B749246B@mail.free-electrons.com>
 <20160321072546.GT30977@lukather>
Message-ID: <20160321092549.4e6245e4f02839e29aeb86a9@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Mar 2016 08:25:46 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > -	/* find the parent that can help provide the fastest rate <= rate */
> > +	/* find the parent that can help provide the fastest rate */
> >  	num_parents = clk_hw_get_num_parents(hw);
> >  	for (i = 0; i < num_parents; i++) {
> >  		parent = clk_hw_get_parent_by_index(hw, i);
> > @@ -100,7 +100,7 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
> >  		child_rate = clk_factors_round_rate(hw, req->rate,
> >  						    &parent_rate);
> >  
> > -		if (child_rate <= req->rate && child_rate > best_child_rate) {
> > +		if (child_rate > best_child_rate) {
> 
> I'm not sure this would work, since you'll end up picking the fastest
> rate without considering whether it is the closest or not.
> 
> I guess what you want here is using the absolute difference between
> the requested rate and the rate you're evaluating.
> 
> That being said, we had a similar discussion for SPI around a month
> ago where we wanted a rate strictly lower than the requested one. I
> guess it's time to add a flag to tell how you want to round.

You are right, I just removed half of the constraint, but I still wonder
why does this sequence introduced by the commit 862b728387aef3a37
(clk: sunxi: factors: automatic reparenting support) do
	"provide the fastest rate <= rate"
instead of
	"provide the closest rate" ?

Emilio?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
