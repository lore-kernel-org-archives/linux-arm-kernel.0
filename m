From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 5 Jun 2015 13:38:03 +0200
Subject: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
In-Reply-To: <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
 <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
Message-ID: <20150605133803.59990a66@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, 4 Jun 2015 23:02:25 +0000 (UTC)
Paul Walmsley <paul@pwsan.com> wrote:

> Hi folks
> 
> just a brief comment on this one:
> 
> On Thu, 30 Apr 2015, Boris Brezillon wrote:
> 
> > Clock rates are stored in an unsigned long field, but ->round_rate()
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can lead
> > to long overflow if the clock rate exceed 2Ghz.
> > 
> > Change ->round_rate() prototype to return 0 or an error code, and pass the
> > requested rate as a pointer so that it can be adjusted depending on
> > hardware capabilities.
> 
> ...
> 
> > diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> > index 0e4f90a..fca8b7a 100644
> > --- a/Documentation/clk.txt
> > +++ b/Documentation/clk.txt
> > @@ -68,8 +68,8 @@ the operations defined in clk.h:
> >  		int		(*is_enabled)(struct clk_hw *hw);
> >  		unsigned long	(*recalc_rate)(struct clk_hw *hw,
> >  						unsigned long parent_rate);
> > -		long		(*round_rate)(struct clk_hw *hw,
> > -						unsigned long rate,
> > +		int		(*round_rate)(struct clk_hw *hw,
> > +						unsigned long *rate,
> >  						unsigned long *parent_rate);
> >  		long		(*determine_rate)(struct clk_hw *hw,
> >  						unsigned long rate,
> 
> I'd suggest that we should probably go straight to 64-bit rates.  There 
> are already plenty of clock sources that can generate rates higher than 
> 4GiHz.

Yep, that was something I was considering too. If Stephen agrees I'll
change that in the next version.
BTW, you're referring to the second version of this patch, but things
have changed a bit: Stephen recommended to only modify the
->determine_rate() prototype and pass a structure instead of a list of
arguments.
Here is the last version of this series [1].

Best Regards,

Boris

[1]http://patchwork.linux-mips.org/patch/10092/

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
