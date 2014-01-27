From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Jan 2014 13:28:07 -0500
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <52E6A3B2.6060301@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140127153908.4f6f46c2@skate> <52E6A3B2.6060301@gmail.com>
Message-ID: <20140127182807.GM29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 07:21:38PM +0100, Sebastian Hesselbarth wrote:
> On 01/27/14 15:39, Thomas Petazzoni wrote:
> >On Sat, 25 Jan 2014 19:19:06 +0100, Sebastian Hesselbarth wrote:
> >>This patch set fixes clk init order that went upside-down with
> >>v3.14. I haven't really investigated what caused this, but I assume
> >>it is related with DT node reordering by addresses.
> >>
> >>Anyway, with v3.14 for MVEBU SoCs, the clock gating driver gets
> >>registered before core clocks driver. Unfortunately, we cannot
> >>return -EPROBE_DEFER in drivers initialized by clk_of_init. As the
> >>init order for our drivers is always core clocks before clock gating,
> >>we maintain init order ourselves by hooking CLK_OF_DECLARE to one
> >>init function that will register core clocks before clock gating
> >>driver.
> >>
> >>This patch is based on pre-v3.14-rc1 mainline and should go in as
> >>fixes for it. As we now send MVEBU clk pull-requests to Mike directly,
> >>I suggest Jason picks it up as a topic branch.
> >
> >I'm not sure I really like the solution you're proposing here. I'd very
> >much prefer to keep one CLK_OF_DECLARE() per clock type, associated to
> >one function registering only this clock type.
> 
> Have you ever had a look at e.g. clk-imx28.c? Not that I really like
> the approach, but it is common practice to do so.
> 
> >Instead, shouldn't the clock framework be improved to *not* register a
> >clock until its parent have been registered? If the DT you have the
> >gatable clocks that depend on the core clocks, then the gatable clocks
> >should not be registered if the core clocks have not yet been
> >registered.
> >
> >Do you think this is possible? Am I missing something here?
> 
> As I said, clk_of_init does not care about return values from the
> clock init functions. Without it, it cannot decide if a clock
> driver failed horribly, failed because of missing dependencies, or
> successfully installed all clocks. Also, it is early stuff and I guess
> clk_of_init will have to build its own "defered_list" and loop over
> until done.
> 
> BTW, this is a fix not an improvement. We should find an acceptable
> solution soon. But I am still open for suggestions, too.

fyi: I suspect this may be the problem currently experienced by Kevin on
mirabox in the boot farm.  He sees it on current master.  Adding him to
the Cc.

thx,

Jason.
