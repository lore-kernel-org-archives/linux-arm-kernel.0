From: psanchez@fosstel.com (Pedro I. Sanchez)
Date: Mon, 31 Aug 2009 11:32:38 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
Message-ID: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to get a clock on pin PC6 of my AT1SAM9260-based board and I
would like some advice on how to do it. For all purposes this board can be
considered to be a clone of the sam9260ek evaluation board.

I see doing this as a two-step process: First, link pin PC6 to the PCK0
clock. Second, program and enable the clock. My kernel module has the
following code (I'm using kernel 2.26.29.3):

Step 1:

at91_set_A_periph(AT91_PIN_PC6, 0);

I'm taking this piece of code from somewhere else. is this all I need to do
for step 1?


Step 2:

pck0 = clk_get(NULL, "pck0");
if (IS_ERR(pck0)) {
pr_err("%s: Failed to get PCK0\n", __func__);
ret = PTR_ERR(pck0);
goto err;
}
pllb = clk_get(NULL, "pllb");
if (IS_ERR(pllb)) {
pr_err("%s: Failed to get PLLB\n", __func__);
ret = PTR_ERR(pllb);
goto err_pllb;
}
ret = clk_set_parent(pck0, pllb);
if (ret != 0) {
pr_err("%s: Failed to set PCK0 parent\n", __func__);
goto err_parent;
}
clk_set_rate(pck0, 11289600);
clk_enable(pck0);
clk_put(pllb);


Neither step fails. Step 2 gives me a printout "PCK0 rate 6000000Hz" which
is not what I expected, some clock divisor must be in the way, but at least
it is a clock of some kind. Unfortunately nothing is output on pin PC6.

Could you provide me with some advice on how to do this properly?

Thank you,

-- 
Pedro



-- 
Pedro I. Sanchez
