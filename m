From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 25 May 2011 09:51:54 +0200 (CEST)
Subject: [PATCH 0/4] Add a generic struct clk
In-Reply-To: <BANLkTinVnFasvOmu0MWRDzv21P3vM8eM6g@mail.gmail.com>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
	<20110524062620.GA22096@pengutronix.de>
	<BANLkTimEoCaKwJtpbQTDSEDydNkZ1BkKog@mail.gmail.com>
	<20110524080936.GI20715@pengutronix.de>
	<BANLkTinVnFasvOmu0MWRDzv21P3vM8eM6g@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1105250911220.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 May 2011, Colin Cross wrote:
> With multiple smaller building blocks that can fit inside a clock, all
> you need is:
> INIT_CLK(..., clk_mux_ops, clk_div_ops, clk_gate_ops)
> You have one struct clk, which is exposed to the device and matches
> the datasheet.  If the clock has rate ops, clk_set_rate works with no

It matches what the datasheet shows you, but it's still separate
building blocks in silicon. Creating uberclocks will fall flat in no
time.

Simply expand your example to:

    mux -> divider1 -> gate1
    	|
	---divider2--> gate2

That's not doable with a combo clock and you end up with a mux and two
combos of divider/gates.

Having a straight simple building blocks view is way more easier to
handle and allows arbitrary combinations and ordering at the tree
level instead of moving the ordering decision into the hardware
implementation level. We want the lowlevel ops implementation to be as
simple and stupid as it gets and want to have as much complexity as
necessary at the core code level.

And it's not that complex. We can propagate set_rate from gateN down
to the divider and it's not rocket science to make the divider consult
the mux for a better suiting frequency, which implies that the mux
decision checks and verifies the resulting damage for the other
child. And this wants to be done at the core level not in the low
level implementations.

Thanks,

	tglx
