From: smunnings@gabaedevelopment.com (Stephen Munnings)
Date: Mon, 31 Aug 2009 12:58:30 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
Message-ID: <4A9C0136.3080102@gabaedevelopment.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pedro I. Sanchez wrote:
> Hello,
>
> I'm trying to get a clock on pin PC6 of my AT1SAM9260-based board and I
> would like some advice on how to do it. For all purposes this board can be
> considered to be a clone of the sam9260ek evaluation board.
>
> I see doing this as a two-step process: First, link pin PC6 to the PCK0
> clock. Second, program and enable the clock. My kernel module has the
> following code (I'm using kernel 2.26.29.3):
>
> Step 1:
>
> at91_set_A_periph(AT91_PIN_PC6, 0);
>
> I'm taking this piece of code from somewhere else. is this all I need to do
> for step 1?
>
>
> Step 2:
>
> pck0 = clk_get(NULL, "pck0");
> if (IS_ERR(pck0)) {
> pr_err("%s: Failed to get PCK0\n", __func__);
> ret = PTR_ERR(pck0);
> goto err;
> }
> pllb = clk_get(NULL, "pllb");
> if (IS_ERR(pllb)) {
> pr_err("%s: Failed to get PLLB\n", __func__);
> ret = PTR_ERR(pllb);
> goto err_pllb;
> }
> ret = clk_set_parent(pck0, pllb);
> if (ret != 0) {
> pr_err("%s: Failed to set PCK0 parent\n", __func__);
> goto err_parent;
> }
> clk_set_rate(pck0, 11289600);
> clk_enable(pck0);
> clk_put(pllb);
>
>
> Neither step fails. Step 2 gives me a printout "PCK0 rate 6000000Hz" which
> is not what I expected, some clock divisor must be in the way, but at least
> it is a clock of some kind. Unfortunately nothing is output on pin PC6.
>
> Could you provide me with some advice on how to do this properly?
>
> Thank you,
>
>   
Here is the code I use to get PC1 to be 50Mhz (from PLLA which is 
running at 800Mhz - this is actually on a 9G20, not a 9620)

    pck0 = clk_get(NULL, "pck0");
    plla = clk_get(NULL, "plla");

    at91_set_B_periph(AT91_PIN_PC1, 0);    /* PCK0 */

    clk_set_parent(pck0, plla);
    clk_set_rate(pck0, 50000000);
    clk_enable(pck0);

There are some differences (I use PC1, not PC6; I use PLLA, not PLLB, etc.,)

I am not sure what the "clk_put(pllb)" does for you.  I certainly did 
not need something like that. (PLLA was already running just fine)

But, I also found that you must have the PMC clock for the GPIOC bank 
running before GPIO (even the configuration, it seems) will work.
I am not sure if I had this issue in Linux, or only in the loaders, but 
I did have to turn on the PMC clocks to get any GPIO based things working.
The standard boot loader only seems to turn on GPIOA, but I am also 
using GPIOB and GPIOC, and I had to turn on the PMC clocks for those
also before I could get very far.

Stephen Munnings
