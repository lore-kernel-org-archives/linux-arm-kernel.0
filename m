From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Mar 2015 10:32:28 +0000
Subject: [STLinux Kernel] [PATCH 3/4] clk: Provide always-on clock support
In-Reply-To: <54F43A98.509@st.com>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
 <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
 <CAJe_Zhf=GBb8AfnTLaGxGcZkVSm9TtdnTsmpH_MBmbMT8ViMDg@mail.gmail.com>
 <20150302083652.GE31325@x1>
 <CABb+yY07woiiG8e2kff_AsiFCHNP+TKYyNm_o6=f5WmFsLi8gQ@mail.gmail.com>
 <20150302101859.GB32347@x1> <54F43A98.509@st.com>
Message-ID: <20150302103228.GD32347@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Mar 2015, Maxime Coquelin wrote:
> On 03/02/2015 11:18 AM, Lee Jones wrote:
> >On Mon, 02 Mar 2015, Jassi Brar wrote:
> >
> >>On Mon, Mar 2, 2015 at 2:06 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >>>On Sat, 28 Feb 2015, Jassi Brar wrote:
> >>>
> >>>>On 28 February 2015 at 02:44, Lee Jones <lee.jones@linaro.org> wrote:
> >>>>>Lots of platforms contain clocks which if turned off would prove fatal.
> >>>>>The only way to recover from these catastrophic failures is to restart
> >>>>>the board(s).  Now, when a clock is registered with the framework it is
> >>>>>compared against a list of provided always-on clock names which must be
> >>>>>kept ungated.  If it matches, we enable the existing CLK_IGNORE_UNUSED
> >>>>>flag, which will prevent the common clk framework from attempting to
> >>>>>gate it during the clk_disable_unused() procedure.
> >>>>>
> >>>>If a clock is critical on a certain board, it could be got+enabled
> >>>>during early boot so there is always a user.
> >>>I tried this.  There was push-back from the DT maintainers.
> >>>
> >>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/324417.html
> >>>
> >>Thanks, I wasn't aware of the history.
> >>
> >>>>To be able to do that from DT, maybe add a new, say, CLK_ALWAYS_ON
> >>>>flag could be made to initialize the clock with one phantom user
> >>>>already. Or just reuse the CLK_IGNORE_UNUSED?
> >>>How is that different to what this set is doing?
> >>>
> >>The phantom user - that's there but none can see it.
> >>
> >>How about?
> >>
> >>+       of_property_for_each_string(np, "clock-always-on", prop, clkname) {
> >>+               clk = __clk_lookup(clkname);
> >>+               if (!clk)
> >>+                       continue;
> >>+
> >>+               clk->core->enable_count = 1;
> >>+               clk->core->prepare_count = 1;
> >>+       }
> >This is only fractionally different from the current implementation.
> >
> >I believe the current way it slightly nicer, as we don't have to fake
> >the user count.  This solution is saying "one of the drivers is still
> >consuming this clock", instead, in the original implementation we're
> >saying "we know there are no consumers of this clock, but keep it on
> >anyway due to [insert reason here]".
> >
> So maybe introducing a new "CLK_DISABLE_NEVER" flag will be more
> explicit than hacking around "CLK_IGNORE_UNUSED" one?

I am okay with that if Mike is; however, personally I think
CLK_IGNORE_UNUSED is pretty descriptive.  If clocks are unused
(reference count reaches zero) the framework will disable the clock --
fair enough.  So in order to prevent that from happening in cases
where these clocks are used by entities other than device drivers
(perhaps these devices are even invisible to Linux) we have to tell
the framework to "ignore the fact that this clock _appears_ to be
unused".  Hence CLK_IGNORE_UNUSED.

I'm struggling to think of a solid reason for inventing new flags when
we have one that is perfectly suitable/descriptive.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
