From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 May 2015 15:03:04 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <55528046.4030107@codeaurora.org>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <1981330.kGUrTurMy5@diego> <5543E79F.2080400@codeaurora.org>
 <22709390.NTAlubMgNB@diego> <55440EDA.4030905@codeaurora.org>
 <CAMAWPa_n+59+v+x3fKkmdtW1wMJF7kqtTjLLowmv1xwGWprYJw@mail.gmail.com>
 <554BD33D.7050907@codeaurora.org> <20150508100247.GQ11057@lukather>
 <55528046.4030107@codeaurora.org>
Message-ID: <20150513130304.GA4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 03:35:50PM -0700, Stephen Boyd wrote:
> On 05/08/15 03:02, Maxime Ripard wrote:
> > On Thu, May 07, 2015 at 02:03:57PM -0700, Stephen Boyd wrote:
> >> On 05/07/15 08:17, Kevin Hilman wrote:
> >>> On Fri, May 1, 2015 at 4:40 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >>>> On 05/01/15 15:07, Heiko St?bner wrote:
> >>>>> Am Freitag, 1. Mai 2015, 13:52:47 schrieb Stephen Boyd:
> >>>>>
> >>>>>>> Instead I guess we could hook it less deep into clk_get_sys, like in the
> >>>>>>> following patch?
> >>>>>> It looks like it will work at least, but still I'd prefer to keep the
> >>>>>> orphan check contained to clk.c. How about this compile tested only patch?
> >>>>> I gave this a spin on my rk3288-firefly board. It still boots, the clock tree
> >>>>> looks the same and it also still defers nicely in the scenario I needed it
> >>>>> for. The implementation also looks nice - and of course much more compact than
> >>>>> my check in two places :-) . I don't know if you want to put this as follow-up
> >>>>> on top or fold it into the original orphan-check, so in any case
> >>>>>
> >>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >>>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >>>> Thanks. I'm leaning towards tossing your patch 2/2 and replacing it with
> >>>> my patch and a note that it's based on an earlier patch from you.
> >>> It appears this has landed in linux-next in the form of 882667c1fcf1
> >>> clk: prevent orphan clocks from being used.  A bunch of boot failures
> >>> for sunxi in today's linux-next[1] were bisected down to that patch.
> >>>
> >>> I confirmed that reverting that commit on top of next/master gets
> >>> sunxi booting again.
> >>>
> >>>
> >> Thanks for the report. I've removed the two clk orphan patches from
> >> clk-next. Would it be possible to try with next-20150507 and
> >> clk_ignore_unused on the command line?
> > This makes it work, but it's not really an option.
> >
> 
> Hmm.. I thought it didn't fix it for Kevin. Confused.

I'm too, but it does fix things here.

> >> Also we can try to see if critical clocks aren't being forced on by
> >> applying this patch and looking for clk_get() failures
> > And that shows that the CPU and DDR clocks are not protected, which
> > obviously is pretty mad.
> >
> > I've mass converted all our probing code to use OF_CLK_DECLARE, and
> > make things work again.
> >
> > http://code.bulix.org/5goa5j-88345?raw
> >
> > Is this an acceptable solution?
> >
> > We were already moving to this, I'm not really fond of doing this like
> > that, but I guess this whole debacle makes it necessary.
> >
> 
> I wonder why we can't switch out the clk_ops on the affected platforms +
> clocks to be read-only (at least for the enable/disable part)? That
> would fix it just the same right? I wasn't around for the original
> discussion regarding this always-on stuff so perhaps I've missed something.

We're using clk-gate, so that would require to recode our own
driver. That change seemed less invasive, while fixing the issue and
ensuring that we wouldn't have any orphan clock, which seems to be
hunted down these days...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/34503f2b/attachment-0001.sig>
