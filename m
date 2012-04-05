From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Apr 2012 12:30:39 +0200
Subject: Query: clk: Defining new struct clk_foo types
In-Reply-To: <4F7D705D.7050004@st.com>
References: <4F7D443E.3010800@st.com> <20120405095835.GB20478@pengutronix.de>
 <4F7D705D.7050004@st.com>
Message-ID: <20120405103039.GC3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 03:43:49PM +0530, Viresh Kumar wrote:
> On 4/5/2012 3:28 PM, Sascha Hauer wrote:
> > If you have a gate and a divider then register a gate and a divider.
> > We don't need clk providers for combination of these, the clock
> > framework will handle it just fine.
> 
> Thanks Sashca, but i didn't get your reply completely.
> Lets see if i can understand it with help of an example:
> 
> I have uart's clock that can be gated and its rate derived as a divider.
> So to define static clock structures, i do following:
> 
> DEFINE_CLK_GATE(uart_gate_clk, "uart_parent", &uart_parent_clk,	0,
> 	0xd0000000, 5, 0, NULL);
> DEFINE_CLK_DIVIDER(uart_divider_clk, "uart_parent", &uart_parent_clk,
> 	0, 0xd0000080, 4, 2, 0, NULL);
> 
> You are suggesting this?

No, more like this:

DEFINE_CLK_DIVIDER(uart_divider_clk, "uart_parent", &uart_parent_clk,
       0, 0xd0000080, 4, 2, 0, NULL);
DEFINE_CLK_GATE(uart_gate_clk, "uart_divider_clk", &uart_divider_clk,
	CLK_SET_RATE_PARENT, 0xd0000000, 5, 0, NULL);

So the divider is the parent of the gate and a set_rate call to the gate
will propagate up to the divider.
You could make the gate the parent of the divider if that's how your
hardware really is built, but for the software it makes no difference in
this case.

Besides, I don't  recommend using the DEFINE_CLK_* macros. You should
really consider using clk_register_* instead.

Grmpf. These DEFINE_CLK_* macros are so omnipresent and huge in
clk-private.h that people *must* think they are the way to go.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
