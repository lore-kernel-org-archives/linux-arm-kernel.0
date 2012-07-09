From: mturquette@ti.com (Mike Turquette)
Date: Mon, 9 Jul 2012 15:57:00 -0700
Subject: [PATCH 5/6] Clk: SPEAr1340: fix sys clock parent source and
 corresponding mask value
In-Reply-To: <CAOh2x=k5Tx2Gjrk1uRod-N-6gvYSeEKiZgms8gQfJ61TL8RXCQ@mail.gmail.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
 <1341829866-26091-5-git-send-email-shiraz.hashim@st.com>
 <CAOh2x=n9dOaxW7hibg3M5XYTtbMkyrvUMt0ORKzWLULxUNtXEg@mail.gmail.com>
 <4FFAC8D2.4080601@st.com>
 <CAOh2x=k5Tx2Gjrk1uRod-N-6gvYSeEKiZgms8gQfJ61TL8RXCQ@mail.gmail.com>
Message-ID: <20120709225700.GB16202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120709-13:34, viresh kumar wrote:
> On Mon, Jul 9, 2012 at 1:04 PM, vipul kumar samar
> <vipulkumar.samar@st.com> wrote:
> > On 7/9/2012 4:34 PM, viresh kumar wrote:
> >>
> >> On Mon, Jul 9, 2012 at 11:31 AM, Shiraz Hashim<shiraz.hashim@st.com>
> >> wrote:
> >>>
> >>> From: Vipul Kumar Samar<vipulkumar.samar@st.com>
> >>>
> >>> sys_clk have multiple parents and selection of parent is depends on
> >>
> >>
> >> s/ is//
> 
> I hope you haven't missed this comment :)
> 
> >>>   static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
> >>> -static const char *sys_parents[] = { "none", "pll1_clk", "none", "none",
> >>> -       "sys_synth_clk", "none", "pll2_clk", "pll3_clk", };
> >>> +static const char *sys_parents[] = { "pll1_clk", "pll1_clk", "pll1_clk",
> >>> +       "pll1_clk", "sys_synth_clk", "sys_synth_clk", "pll2_clk",
> >>> "pll3_clk", };
> >>
> >>
> >> Don't know what would be the implication of this?
> >>
> >> @Mike: Can you please tell us what should we do in such cases?
> >>
> >
> > Is there any other solution for such cases ???
> 
> That's what i have asked mike for :)
> Probably you can go through the clock framework code and check how these
> names are used. Shouldn't be too complex to understand.
> 

I assume this change has been tested and wouldn't be posted if modifying
the parent names broke things.

That said, as long as the parent names are valid strings then the clk
framework should handle them.  When calling __clk_lookup for parent name
"none", __clk_lookup will return NULL (of course assuming no one else in
the system registered a clock named "none", which would be silly).  This
is handled gracefully by the clk framework by re-parenting your "sys"
clk from $old_parent to the "orphan" list.

At the top level, there are basically two clock trees.  The first tree
is "real" clock tree which starts as a list of clocks that set the
CLK_IS_ROOT flag.  The second tree is a tree of "orphans" for clocks
which are defined but "disconnected" from any real root clock (which
might be caused by missing data, etc).

In general it is OK to declare parent names which might result in your
clock being orphaned.  In practice it is more likely that your data
matches your code: e.g. if you don't support a parent clock in the data
then you likely never try use that missing parent clock in your code.

The OMAP port does in fact make use of the orphan tree for some clocks,
so it is tested.  However we haven't had any users of the clock tree
which made a lot of use of "dynamic" reparenting to and from the orphan
tree.  I did unit test this back during the 3.4 cycle, but I haven't
since.  Let me know if you have any problems with it.

Regards,
Mike

> --
> viresh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
