From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Mar 2012 11:17:08 +0100
Subject: [PATCH v5 4/4] clk: basic clock hardware types
In-Reply-To: <20120305092948.GV3852@pengutronix.de>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-5-git-send-email-mturquette@linaro.org>
 <20120304174229.GD11546@lunn.ch>
 <CAJOA=zNWN6L+-YEkNKoQnjnrrswNpCBmtnhKBm04HekWP46i5w@mail.gmail.com>
 <20120305084823.GD24858@lunn.ch>
 <20120305092948.GV3852@pengutronix.de>
Message-ID: <20120305101708.GF24858@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I think i can wrap your simple gate clock, to make my "complex" gate
> > clock. What would help is if you would EXPORT_SYMBOL_GPL
> > clk_gate_enable() and clk_gate_disable(), since they do exactly what i
> > want. I can then build my own clk_ops structure, with my own
> > unprepare() function. I would probably use DEFINE_CLK_GATE as is, and
> > then at run time, before calling __clk_init() overwrite the .ops with
> > my own version.
> 
> Maybe I don't get your point, but clk_unprepare should be used when
> you have to sleep to disable your clock. When clk_gate_disable() is
> exactly why do you want to use clk_unprepare instead of clk_disable?

I'm trying to avoid having to implement a new clock provider. The
whole point of the generic clk code is to consolidate code. It seems
silly to create a new clk provider which is 95% identical to Mike's
gated provider, if i can avoid it.

If i stuff it into clk_disable(), it means i cannot use the basic gate
clock Mike provides in the generic clock framework. Which is a shame,
since it does exactly what i want in terms of gating the clock.

If i can use unprepare(), which basic gate does not use, i can use
Mikes code, and just extend it. It is there, it is unused, so why not
use it?

    Andrew
