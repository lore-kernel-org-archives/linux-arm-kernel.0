From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Aug 2015 11:13:58 +0200
Subject: [PATCH v2 1/7] clk: Add a basic factor clock
In-Reply-To: <20150811213041.31346.58562@quantum>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
 <20150523074930.GI8557@lukather> <20150724000001.642.84690@quantum>
 <20150724065017.GJ2373@lukather> <20150724182619.642.11590@quantum>
 <20150725073925.GK2564@lukather>
 <20150811213041.31346.58562@quantum>
Message-ID: <20150819091358.GB30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 02:30:41PM -0700, Michael Turquette wrote:
> > > The real problem with these basic clock types is that they are an
> > > abstraction layer at the wrong level. Each clock type implements both
> > > the policy of a given clock, as well as the machine-specific details.
> > > For example clk-divider.c has made some assumptions in the past about
> > > rounding the rate, or how to calculate the best divider; this is a
> > > matter of policy and is useful on its own. But additionally that same
> > > policy is glued to a specific implementation: memory-mapped register
> > > controls for a clock divider.
> > > 
> > > The I/O accessor stuff needs to be addressed at some point.  Currently
> > > the basic clock types assume specific patterns of access to
> > > memory-mapped clock registers. There are lots of other clock controls
> > > out there that talk to firmware, or over i2c, or whatever. The amount of
> > > code that has to be copy/pasted for each different type of access is
> > > 100%; i.e. we do not have abstractions at the right level such as
> > > .get_best_div(struct clk_hw *hw, unsigned long rate).
> > > 
> > > What I would like to see in time is a re-usable layer for clock policy
> > > (e.g. common rules for how dividers or multipliers should behave), and
> > > then have that sit on top of the machine-specific callbacks that
> > > directly touch the hardware, such as the .get_best_div callback above.
> > 
> > Can't that be solved by moving to regmap using Matthias' patches, or
> > at least the IO method abstraction?
> 
> I need to look at those patches again, but I do not think they address
> the problem I described above: abstraction at the wrong level (or more
> specifically, combining two abstract layers into one).

Well, maybe I'm missing something, but you end up with this patch with
the clock driver allocating the regmap, and passing it to the generic
part of the clock framework, that will only do regmap calls and not
care anymore about what kind of accesses it is (the point of regmap
being the abstraction).

Isn't it what you were looking for?

> I'll have more bandwidth to look at this problem after the next merge
> window. The clk framework is slowly be rewritten in bits and pieces here
> on the list (shh don't tell anybody) and this is on my radar and
> Stephen's.

Ok, i'll resend it after the merge window then.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/4a3c9aeb/attachment.sig>
