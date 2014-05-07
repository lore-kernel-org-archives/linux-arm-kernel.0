From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 May 2014 11:32:24 +0800
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <20140507020950.GB2794@dragon>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
 <20140506141310.GA2794@dragon>
 <CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
 <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
 <5369081D.5030400@st.com> <20140506200029.GD5858@pengutronix.de>
 <20140507020950.GB2794@dragon>
Message-ID: <20140507033223.GB2798@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:09:51AM +0800, Shawn Guo wrote:
> On Tue, May 06, 2014 at 10:00:29PM +0200, Sascha Hauer wrote:
> > On Tue, May 06, 2014 at 06:04:45PM +0200, Maxime Coquelin wrote:
> > > Hi Fabio,
> > > 
> > > On 05/06/2014 05:49 PM, Fabio Estevam wrote:
> > > >On Tue, May 6, 2014 at 12:36 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > > >
> > > >>Indeed, if I revert:
> > > >>
> > > >>commit e7489693b3a853ab6dfad52f7e6af553ae8d3f28
> > > >>Author: Maxime COQUELIN <maxime.coquelin@st.com>
> > > >>Date:   Wed Jan 29 17:24:08 2014 +0100
> > > >>
> > > >>     clk: divider: Optimize clk_divider_bestdiv loop
> > > >>
> > > >>     Currently, the for-loop used to try all the different dividers to find the
> > > >>     one that best fit tries all the values from 1 to max_div,
> > > >>incrementing by one.
> > > >>     In case of power-of-two, or table based divider, the loop isn't optimal.
> > > >>
> > > >>     Instead of incrementing by one, this patch provides directly the
> > > >>next divider.
> > > >>
> > > >>     Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> > > >>     Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > > >>
> > > >>Then the board does not hang.
> > > >
> > > >Isn't the increment of i missing?
> > > 
> > > i is incremented in _next_div():
> > > 
> > > +static int _next_div(struct clk_divider *divider, int div)
> > > +{
> > > +	div++;
> > > +
> > > +	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> > > +		return __roundup_pow_of_two(div);
> > > +	if (divider->table)
> > > +		return _round_up_table(divider->table, div);
> > > +
> > > +	return div;
> > > +}
> > 
> > This cannot work. _round_up_table is implemented like this:
> > 
> > static int _round_up_table(const struct clk_div_table *table, int div)
> > {
> > 	const struct clk_div_table *clkt;
> > 	int up = _get_table_maxdiv(table);
> > 
> > 	for (clkt = table; clkt->div; clkt++) {
> > 		if (clkt->div == div)
> > 			return clkt->div;
> > 		...
> > 	}
> > 	...
> > }
> > 
> > Here when a table entry matches the input div this function will return
> > exactly the input div. This means _next_div() will always return the
> > same value and clk_divider_bestdiv() has an infinite loop:
> > 
> > 	for (i = 1; i <= maxdiv; i = _next_div(divider, i)) {
> > 		...
> > 	}
> 
> Hmmm, isn't the first thing that _next_div() does to increment the input
> div?

I think the infinite loop happens in this case because "i" will never
exceed maxdiv for a table divider.

Shawn
