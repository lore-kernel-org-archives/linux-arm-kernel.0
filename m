From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 10 Jul 2012 09:21:09 +0100
Subject: [PATCH 5/6] Clk: SPEAr1340: fix sys clock parent source and
 corresponding mask value
In-Reply-To: <20120709225700.GB16202@gmail.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
 <1341829866-26091-5-git-send-email-shiraz.hashim@st.com>
 <CAOh2x=n9dOaxW7hibg3M5XYTtbMkyrvUMt0ORKzWLULxUNtXEg@mail.gmail.com>
 <4FFAC8D2.4080601@st.com>
 <CAOh2x=k5Tx2Gjrk1uRod-N-6gvYSeEKiZgms8gQfJ61TL8RXCQ@mail.gmail.com>
 <20120709225700.GB16202@gmail.com>
Message-ID: <CAKohponeGSG376uj_jEGCEj4m4OgShD7zRGNpF-8BP2rmQUOYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2012 23:57, Mike Turquette <mturquette@ti.com> wrote:

> I assume this change has been tested and wouldn't be posted if modifying
> the parent names broke things.
>
> That said, as long as the parent names are valid strings then the clk
> framework should handle them.  When calling __clk_lookup for parent name
> "none", __clk_lookup will return NULL (of course assuming no one else in
> the system registered a clock named "none", which would be silly).  This
> is handled gracefully by the clk framework by re-parenting your "sys"
> clk from $old_parent to the "orphan" list.
>
> At the top level, there are basically two clock trees.  The first tree
> is "real" clock tree which starts as a list of clocks that set the
> CLK_IS_ROOT flag.  The second tree is a tree of "orphans" for clocks
> which are defined but "disconnected" from any real root clock (which
> might be caused by missing data, etc).
>
> In general it is OK to declare parent names which might result in your
> clock being orphaned.  In practice it is more likely that your data
> matches your code: e.g. if you don't support a parent clock in the data
> then you likely never try use that missing parent clock in your code.
>
> The OMAP port does in fact make use of the orphan tree for some clocks,
> so it is tested.  However we haven't had any users of the clock tree
> which made a lot of use of "dynamic" reparenting to and from the orphan
> tree.  I did unit test this back during the 3.4 cycle, but I haven't
> since.  Let me know if you have any problems with it.
>

Hi Mike,

For example, clk1 have parents pclk1 and pclk2. Register values
for pclk1 is 0X and for pclk2 is 1X. i.e. pclk1 is selected for both 00 and
01.
And pclk2 is selected for 10 and 11. so, its better to take care of all
these situations,
otherwise there can be corner cases like: In linux we decide to use 00 for
pclk1, 10 for
pclk2 and other two for "none". But bootloader, enabled the clock with 01
for pclk1.
This clock isn't a orphan but it will look like that in our clock tree.

So, is this OK in the current implementation of clk framework to have
parents like
"pclk1", "pclk1", "pclk2", "pclk2"?

--
viresh
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/01ab87ad/attachment-0001.html>
