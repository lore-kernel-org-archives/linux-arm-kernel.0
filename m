From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 2 Mar 2014 12:59:56 +0100
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <3584854.kj2ZbTBvnM@avalon>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <20140301135002.GA4307@katana> <3584854.kj2ZbTBvnM@avalon>
Message-ID: <20140302115955.GA4021@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 02, 2014 at 12:35:50PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
> 
> On Saturday 01 March 2014 14:50:03 Wolfram Sang wrote:
> > > +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> > > +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> > > +	if (cpg == NULL || clks == NULL) {
> > > +		/* We're leaking memory on purpose, there's no point in cleaning
> > > +		 * up as the system won't boot anyway.
> > > +		 */
> > > +		pr_err("%s: failed to allocate cpg\n", __func__);
> > > +		return;
> > > +	}
> > 
> > I have problems with this sloppiness. Writing the comment took probably
> > the same time as writing the proper exit path :) On the drawback side,
> > static code checkers will keep reporting this.
> 
> Then static code checkers should be fixed :-)

How should they know if you 'return'? :) They will know if you BUG().
Which might be the better (read: more descriptive) option which would
save the comment, too.

> > > +	cpg->reg = of_iomap(np, 0);
> > > +	if (WARN_ON(cpg->reg == NULL))
> > > +		return;
> > 
> > if (WARN(!cpg->reg, "can't ioremap CPG\n"))
> > 
> > ?
> 
> We can probably remove this altogether given that the driver doesn't make use 
> of the ioremap'ed memory.

Okay. Was still a good place to advertise WARN() over WARN_ON ;)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140302/0a181b53/attachment.sig>
