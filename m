From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 29 Jun 2017 17:45:53 -0700
Subject: [PATCH V1 0/9] add clock driver for Spreadtrum platforms
In-Reply-To: <CAAfSe-uTzgz0kyhQQzqpYKnYxDLv+3gG_9MfdrBTY-AUC549Gg@mail.gmail.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170620012530.GG4493@codeaurora.org>
 <CAAfSe-uTzgz0kyhQQzqpYKnYxDLv+3gG_9MfdrBTY-AUC549Gg@mail.gmail.com>
Message-ID: <20170630004553.GH22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22, Chunyan Zhang wrote:
> Hi Stephen,
> 
> On 20 June 2017 at 09:25, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/18, Chunyan Zhang wrote:
> >> In the last cycle, the patches support Whale2 sc9860 mobile chip have been
> >> merged. This patchset adds clock driver which is used on almost all
> >> Spreadtrum SoCs.
> >>
> >> This is a rewrite of Spreadtrum's original clock driver[1] according to the
> >> comments[2] from Stephen Boyd.
> >>
> >> This series also adds Spreadtrum clock binding documentation and devicetree
> >> data.
> >>
> >> Any comments would be greatly appreciated.
> >
> > Overall it seems to copy quite a bit of code from sunxi-ng, which
> > is OK, but if that's just copy/paste + replace some names then
> > perhaps we should consolidate the two implementations into one
> > that both SoCs can use.
> >
> 
> OK, will try.

Ok. Please don't spend too much time on it though. 

> 
> > Also, is there any reason why we can't use a platform device
> > driver for this instead of the DT probing mechanism? That is more
> > preferred method of probing clk controllers.
> 
> From what I have known on ARM platforms, device drivers cannot
> recognize out which SoC the driver is running on, assume that the
> device on different SoC has some differences.  To make one only kernel
> Image can be used on all SoCs of Spreadtrum, we selected the way of
> loading different dtb for each SoC.

Device drivers can figure out what device the driver is bound to
based on the compatible string of the node. Typically, the clk
driver binds to a device node with a compatible indicating the
clock controller it is, like spd,soc-name-clk-controller-name.
Then that can be used to determine what sort of associated data
there is.

> 
> Actually, I haven't understood the merits of moving more clk things to
> driver from DT, could you please introduce more about that?
> 
> 

Some mailing list digging may be helpful, but I admit I need to
have some sort of canned response here that I can just repeat
each time this comes up. Here it goes.

We really only need CLK_OF_DECLARE() if a clk needs to be
available for timers or interrupt controllers. Otherwise, its
possible to put the rest of the clk tree registration in the
normal device driver path.

Reasons (in no particular order):

  1. We get a dev pointer to use with clk_hw_register()

  2. We can handle probe defer if some resource is not available

  3. Using device model gets us a hook into power management frameworks
     like runtime PM and system PM for things like suspend and hibernate

  4. It encourages a single DT node clk controller style binding
     instead of a single node per clk style binding

  5. We can use non-DT specific functions like devm_ioremap_resource() to map
     registers and acquire other resources, leading to more portable and
     generic code

  6. We may be able to make the device driver a module, which will
     make distros happy if we don't have to compile in all
     these clk drivers to the resulting vmlinux

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
