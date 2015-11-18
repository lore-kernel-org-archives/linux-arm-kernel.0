From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 Nov 2015 21:38:02 +0100 (CET)
Subject: [PATCH 4/7] phy: rockchip-usb: add missing of_node_put
In-Reply-To: <3792177.PEjN5hRYe2@diego>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <19587543.sZ81DoLUBT@diego> <20151118193129.GA48815@google.com>
 <3792177.PEjN5hRYe2@diego>
Message-ID: <alpine.DEB.2.02.1511182136270.2059@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 18 Nov 2015, Heiko St?bner wrote:

> Am Mittwoch, 18. November 2015, 11:31:29 schrieb Brian Norris:
> > On Wed, Nov 18, 2015 at 08:27:07PM +0100, Heiko St?bner wrote:
> > > Am Montag, 16. November 2015, 12:33:17 schrieb Julia Lawall:
> > > hmm, while I agree that the rockchip phy has an issue in the node
> > > lifecycle, I'm not sure that patch fixes it fully.
> > > 
> > > It currently iterates over each phy, but would only of_node_put the phy it
> > > handled last. So if an error happens on the 3rd phy, the first 2 are
> > > already instantiated and would also get removed when the overall probe
> > > fails, but their of_node would never be "put".
> > 
> > Note the behavior of of_get_next_child() (and
> > of_get_next_available_child()); it "Decrements the refcount of prev." So
> > the loop only keeps a reference for (at most) one node at a time.
> > 
> > I believe Julia's patch is correct. It's possible the commit description
> > could have made this aspect clearer though, since I was confused about
> > this at first as well.
> 
> oh, I hadn't realized that :-) .
> 
> Although in this case, what happens with the last child, if only "prev"s get 
> decremented? When the loop finished I'd think that the last one would keep 
> it's reference, as the patch stand right - or I'm just blind.

The loop finishes when the child is NULL.  So there is nothing to put in 
that case.  The process of getting from the last child to the NULL does 
the of_node_put.

julia
