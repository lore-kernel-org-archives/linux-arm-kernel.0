From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 30 Mar 2016 18:02:26 +0200
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <56D60C90.7080703@timesys.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
Message-ID: <1459353746.2505.86.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akshay,

Am Dienstag, den 01.03.2016, 16:41 -0500 schrieb Akshay Bhat:
[...]
> > +		/*
> > +		 * It is unclear whether the procedure works for switching from
> > +		 * pll3_usb_otg to any other parent than pll5_video_div
> > +		 */
> > +		if (sel[i][0] > 3 && sel[i][0] != (sel[i][3] | 4)) {
> > +			pr_err("ccm: ldb_di%d_sel workaround only for top mux\n",
> > +			       i);
> > +			sel[i][3] = sel[i][2] = sel[i][1] = sel[i][0];
> > +			continue;
> > +		}
> 
> EB821 doesn't mention the above restriction. My understanding was as 
> long as the clock source you are switching from/to is disabled it should 
> be ok to do so. Maybe someone from Freescale can comment?

Maybe. If the only issue was that all input clocks have to be disabled,
I don't understand why the intermediate steps 3 -> 7 -> 4 -> 0 are
necessary though. See below for an explanation why I felt I have no idea
how to properly switch from 4 to 1, for example. Maybe this is indeed
not a problem at all and this condition can just be dropped. Do you have
a way to test this?

> > +
> > +		/* First switch to the bottom mux */
> > +		sel[i][1] = sel[i][0] | 4;
> > +
> 
> Not sure if this really matters but as per EB821 Section 4.2, 6 b, the 
> recommended setting for sel[i][1] is 7

As I understand, the EB821 does not explain why it should be 7, or why
the second step should be 4, and the section you quote is explicitly
just an example that assumes that the initial setting is the reset
default (3).
>From the original patch description it sounded like it is necessary to
first switch from the top mux to the bottom mux without changing the
4-port mux, which I interpreted as |4 (and describe in the last
paragraph of the comment above init_ldb_clocks). That information could
well be incorrect or incomplete. I'd love to see ERR009219.

regards
Philipp
