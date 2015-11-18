From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Nov 2015 11:31:29 -0800
Subject: [PATCH 4/7] phy: rockchip-usb: add missing of_node_put
In-Reply-To: <19587543.sZ81DoLUBT@diego>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-5-git-send-email-Julia.Lawall@lip6.fr>
 <19587543.sZ81DoLUBT@diego>
Message-ID: <20151118193129.GA48815@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 08:27:07PM +0100, Heiko St?bner wrote:
> Am Montag, 16. November 2015, 12:33:17 schrieb Julia Lawall:
> hmm, while I agree that the rockchip phy has an issue in the node lifecycle, 
> I'm not sure that patch fixes it fully.
> 
> It currently iterates over each phy, but would only of_node_put the phy it 
> handled last. So if an error happens on the 3rd phy, the first 2 are already 
> instantiated and would also get removed when the overall probe fails, but 
> their of_node would never be "put".

Note the behavior of of_get_next_child() (and
of_get_next_available_child()); it "Decrements the refcount of prev." So
the loop only keeps a reference for (at most) one node at a time.

I believe Julia's patch is correct. It's possible the commit description
could have made this aspect clearer though, since I was confused about
this at first as well.

Regards,
Brian
