From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 28 May 2015 19:13:32 +0200
Subject: [PATCH v3 4/6] clk: add lpc18xx ccu clk driver
In-Reply-To: <20150528034424.22384.83956@quantum>
References: <1431988559-23338-1-git-send-email-manabian@gmail.com>
 <1431988559-23338-5-git-send-email-manabian@gmail.com>
 <20150528034424.22384.83956@quantum>
Message-ID: <CAGhQ9VyQV0gZQx4V+AMM6T-38x6UiL+atVro9LyTbrHqEYntfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On 28 May 2015 at 05:44, Michael Turquette <mturquette@linaro.org> wrote:
> Thanks for sending V3. This driver is getting close!

Thanks for your patience.

> So the main thing I don't understand is why you do not encode the CGU
> clock parent string names into this CCU driver. If I understand your
> approach correctly, you do the following in lpc18xx_ccu_init:
>
> 1) count the number of parent clocks (ostensibly CGU clocks)
> 2) iterate through all of those CGU clocks, extracting a base_id value
> (loop #1)
> 3) using this base_id as a key you walk through an array in the CCU
> driver trying to find a matching base_id value
> (loop #2)
> 4) after finding the corresponding CCU clocks you get the parent clock
> with of_clk_get
> 5) using of_clk_get you fetch its name with __clk_get_name
> 6) you pass this parent name into a fairly typical looking registration
> function
>
> Assuming I got all of that right, I hope we can simplify it
> considerably.
>
> You already have an array of CCU clock information in this driver,
> clk_branches[]. Why not encode the parent string name here? This would
> involve adding a "parent_name" member to struct lpc18xx_clk_branch.
>
> Doing the above, your O(n^2)-ish registration function becomes O(n):
>
> 1) iterate through the array of the CCU clocks (clk_branchs[])
> 2) register them
> 3) profit

Since there are two instances of the CCU IP block and the clk_branchs[]
table contain branch clocks from both of them the driver needs to know
on which CCU instance the clocks belong.

So just registering all clocks in clk_branchs[] we would end up with
all the clocks on both CCU nodes and some clock ids would conflict.

An alternative approach could be to split the clk_branchs[]. Each one
with branch clocks for the respective CCU. But the driver would still
need to know which of the tables to register. This could be done either
by using two DT compac strings; like "nxp,lpc1850-ccu1" and "...-ccu2"
or by having a 'id' propery in DT. I don't find these two approaches
very appealing.

So the reason for some of the complexity in the driver is to keep it
generic and work on multiple CCU instances by looking at the connected
clocks.

I hope this make it more understandable. Sorry for failing to describe the
hardware properly.

Either way I'll send out a v4 with parent clocks in the clk_branchs[]
and which use a clock-names property to match the clocks between the
CCU. Let me know what you think when you get a chance to look at it.

> I'm starting to think any reference to base_id is sign that things are
> wrong in your driver. I am unconvinced that you need to "share" this
> base_id across CGU and CCU drivers in the way you do. If I'm wrong
> please help me to understand.

I don't mind putting the parent clock names in the clk_branches[] but
the driver still needs to distinguish between the CCUs in the system
and register the correct clocks on them.

If you have a another good way of doing so I am all ears.


I have put up the full DT in the link if you would like to take a look.
http://slexy.org/raw/s21h9lCxQa

You may also find the data sheet at the link below. There is a figure
of the CGU and both CCUs at page 161, Figure 34.
http://www.nxp.com/documents/user_manual/UM10503.pdf


regards,
Joachim Eastwood
