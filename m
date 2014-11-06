From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Nov 2014 09:54:24 +0100
Subject: [PATCH 1/6] clk: sunxi: Add support for sun9i a80 usb clocks and
 resets
In-Reply-To: <CAGb2v64RT4PKTji2KfDTFfc8b_kiTk0Vh49nEE9ZJukum7h2_Q@mail.gmail.com>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
 <1415074039-16590-2-git-send-email-wens@csie.org>
 <20141104165733.GI26729@lukather>
 <CAGb2v65VojZVEijdjXYGkMud7dMFzMzagfN=_4S3msZygu3YPQ@mail.gmail.com>
 <20141105100912.GD27686@lukather>
 <CAGb2v64RT4PKTji2KfDTFfc8b_kiTk0Vh49nEE9ZJukum7h2_Q@mail.gmail.com>
Message-ID: <20141106085424.GF2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 10:09:27AM +0800, Chen-Yu Tsai wrote:
> >> >> +static void __init sun9i_a80_usb_mod_setup(struct device_node *node)
> >> >> +{
> >> >> +     /* AHB1 gate must be enabled to access registers */
> >> >> +     struct clk *ahb = of_clk_get(node, 0);
> >> >> +
> >> >> +     WARN_ON(IS_ERR(ahb));
> >> >> +     clk_prepare_enable(ahb);
> >> >
> >> > Hmmmm. That look off.
> >> >
> >> > Why do you need the clock to be enabled all the time? Isn't the CCF
> >> > already taking care of enabling the parent clock whenever it needs to
> >> > access any register?
> >>
> >> There are also resets in the same block. That and I couldn't get it
> >> working without enabling the clock beforehand.
> >
> > Ah, right.
> >
> > What happens if you just enable and disable the clocks in the
> > reset_assert and reset_deassert right before and after accessing the
> > registers?
> 
> That doesn't work either. I forgot to mention that most of the clock
> gates have the peripheral pll as their parent, not the ahb clock gate.

Why it doesn't work? The clock needs more time to stabilize? The reset
line is set back in reset if the clocks are disabled?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/a9d73154/attachment.sig>
