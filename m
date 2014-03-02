From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 02 Mar 2014 12:35:50 +0100
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <20140301135002.GA4307@katana>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <20140301135002.GA4307@katana>
Message-ID: <3584854.kj2ZbTBvnM@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Saturday 01 March 2014 14:50:03 Wolfram Sang wrote:
> > +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> > +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> > +	if (cpg == NULL || clks == NULL) {
> > +		/* We're leaking memory on purpose, there's no point in cleaning
> > +		 * up as the system won't boot anyway.
> > +		 */
> > +		pr_err("%s: failed to allocate cpg\n", __func__);
> > +		return;
> > +	}
> 
> I have problems with this sloppiness. Writing the comment took probably
> the same time as writing the proper exit path :) On the drawback side,
> static code checkers will keep reporting this.

Then static code checkers should be fixed :-) or at least provide an override. 
Given that the system won't boot if this fails I don't see a point in adding 
useless code to the kernel that would just result in a larger binary size.

> > +	cpg->reg = of_iomap(np, 0);
> > +	if (WARN_ON(cpg->reg == NULL))
> > +		return;
> 
> if (WARN(!cpg->reg, "can't ioremap CPG\n"))
> 
> ?

We can probably remove this altogether given that the driver doesn't make use 
of the ioremap'ed memory.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140302/e9607627/attachment.sig>
