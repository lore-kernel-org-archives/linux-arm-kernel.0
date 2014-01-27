From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Jan 2014 15:39:08 +0100
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140127153908.4f6f46c2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Sat, 25 Jan 2014 19:19:06 +0100, Sebastian Hesselbarth wrote:
> This patch set fixes clk init order that went upside-down with
> v3.14. I haven't really investigated what caused this, but I assume
> it is related with DT node reordering by addresses.
> 
> Anyway, with v3.14 for MVEBU SoCs, the clock gating driver gets
> registered before core clocks driver. Unfortunately, we cannot
> return -EPROBE_DEFER in drivers initialized by clk_of_init. As the
> init order for our drivers is always core clocks before clock gating,
> we maintain init order ourselves by hooking CLK_OF_DECLARE to one
> init function that will register core clocks before clock gating
> driver.
> 
> This patch is based on pre-v3.14-rc1 mainline and should go in as
> fixes for it. As we now send MVEBU clk pull-requests to Mike directly,
> I suggest Jason picks it up as a topic branch.

I'm not sure I really like the solution you're proposing here. I'd very
much prefer to keep one CLK_OF_DECLARE() per clock type, associated to
one function registering only this clock type.

Instead, shouldn't the clock framework be improved to *not* register a
clock until its parent have been registered? If the DT you have the
gatable clocks that depend on the core clocks, then the gatable clocks
should not be registered if the core clocks have not yet been
registered.

Do you think this is possible? Am I missing something here?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
