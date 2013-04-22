From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:25:55 +0100
Subject: [PATCH] clk: vexpress: Add separate SP810 driver
In-Reply-To: <1366305802.3077.37.camel@hornet>
References: <1363358409-5693-1-git-send-email-pawel.moll@arm.com>
 <20130417222630.19887.75481@quantum> <1366305802.3077.37.camel@hornet>
Message-ID: <20130422142555.GN14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 06:23:22PM +0100, Pawel Moll wrote:
> On Wed, 2013-04-17 at 23:26 +0100, Mike Turquette wrote:
> > In this case you are using clk_prepare for one-time configuration.  I
> > agree that no alternative exists yet, but there have been discussions
> > recently about using DT for configuration details that are not strictly
> > descriptions of the hardware.  I've added a comment block in the patch
> > below which notes this with a FIXME since there isn't a graceful
> > alternative to using clk_prepare for ont-time configuration.
> 
> Fair enough.
> 
> > Can you test the patch below against the latest clk-next and let me know
> > if it working on your platform?
> 
> It wasn't:
> 
> WARNING: at [...]/drivers/clk/clk.c:808 __clk_enable+0x94/0xa0()
> 
> because the new parent is not prepared automagically. This simple change
> heals the problem and now everything is just fine:
> 
>         /* Switch the parent if necessary */
> -       if (old_parent != new_parent)
> +       if (old_parent != new_parent) {
> +               clk_prepare(new_parent);
>                 clk_set_parent(hw->clk, new_parent);
> +               clk_unprepare(old_parent);
> +       }
> 
> So, to summarize, the patch that works for me is below.

So what if the old parent clock wasn't prepared?
