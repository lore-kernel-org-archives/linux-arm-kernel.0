From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Aug 2015 21:33:11 +0800
Subject: CLK_IGNORE_UNUSE looks buggy
In-Reply-To: <CAGsJ_4wxVL9sFWkc9dnZsAA++MfFJ1KXoq481wPLoQ-HaDRFEA@mail.gmail.com>
References: <CAGsJ_4wxVL9sFWkc9dnZsAA++MfFJ1KXoq481wPLoQ-HaDRFEA@mail.gmail.com>
Message-ID: <CAGb2v661-dzXHpa4Vt7fPXONRgPvWuOmBixUKg=wRj6Se5--VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 4:43 PM, Barry Song <21cnbao@gmail.com> wrote:
> hi Stephen, Michael,
>
> currently we can set a CLK_IGNORE_UNUSE flag to  a clock to stop
> clk_disable_unused()  from disabling it at the boot stage:
>
> static void clk_disable_unused_subtree(struct clk_core *core)
> {
> ...
> if (core->flags & CLK_IGNORE_UNUSED)
> goto unlock_out;
>
> ...
> }
>
> static int clk_disable_unused(void)
> {
> ...
> clk_unprepare_unused_subtree(core);
> ...
>
> return 0;
> }
> late_initcall_sync(clk_disable_unused);
>
> so if there are two clocks A and B, A is the parent of B, and A is
> marked as CLK_IGNORE_UNUSED.
>
> in boot stage if there is nobody using A and B, Linux will disable B
> due to clk_disable_unused() , but keep A being enabled since A has
> CLK_IGNORE_UNUSED.
>
> but in Linux runtime, we might frequently disable /enable B in runtime
> power management, this will cause A disabled since Linux will not
> check CLK_IGNORE_UNUSED for runtime disabling clk .
>
> so this makes CLK_IGNORE_UNUSE only work if we don't disable its
> sub-clock at runtime. this looks making no sense.
>
> i am thinking whether we should do some changes to make it have side
> affect for runtime clk disable. otherwise, why do we want to stop it
> from being disabled during boot stage?
>
> I am not sure whether i missed something in clk core level support.

CLK_IGNORE_UNUSED is not really a safe or proper mechanism to
protect critical clocks from being disabled. Quite a few people
have noticed this.

People are using their own "critical clocks" implementations.
Sunxi uses a list of clocks the clock driver is supposed to get
and enable. Newer clock providers directly enable the clock
after registering it.

Both Lee Jones [1] and Mike [2] have posted patches to move the
critical clock preservation mechanism into the clock core.

[1] https://lkml.org/lkml/2015/7/22/311
[2] http://www.spinics.net/lists/kernel/msg2052297.html


ChenYu
