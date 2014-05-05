From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 5 May 2014 14:05:19 -0700
Subject: [PATCH 5/5] net: macb: Fix race between HW and driver
In-Reply-To: <20140505.165653.1184059074645793091.davem@davemloft.net>
References: <1399243382-12528-1-git-send-email-soren.brinkmann@xilinx.com>
 <1399243382-12528-6-git-send-email-soren.brinkmann@xilinx.com>
 <20140505.165653.1184059074645793091.davem@davemloft.net>
Message-ID: <7c62baab-5f60-4f04-87f7-6b53fecc4746@CH1EHSMHS038.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-05-05 at 04:56PM -0400, David Miller wrote:
> From: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Date: Sun,  4 May 2014 15:43:02 -0700
> 
> > Under "heavy" RX load, the driver cannot handle the descriptors fast
> > enough. In detail, when a descriptor is consumed, its used flag is
> > cleared and once the RX budget is consumed all descriptors with a
> > cleared used flag are prepared to receive more data. Under load though,
> > the HW may constantly receive more data and use those descriptors with a
> > cleared used flag before they are actually prepared for next usage.
> > 
> > The head and tail pointers into the RX-ring should always be valid and
> > we can omit clearing and checking of the used flag.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> Isn't the RX_USED bit the only thing that controls what RX entries
> the chip will try to use?
> 
> I can't see how you can just remove the RX_USED bit handling
> altogether.
> 
> The problem actually seems to be that in the current code we clear the
> RX_USED bit before we actually reallocate the buffer and set it up.
> 
> It should be a bug to see the RX_USED bit set in gem_rx_refill(), and
> the only reason why it can happen is exactly because you're clearing it
> too early in gem_rx().

I don't follow. The HW uses the descriptor and the driver handles the
received data. So, in gem_rx_refill we should actually only replace
descriptor which have the RX_USED _set_, not? Currently the test tests
for the opposite, since SW clears RX_USED in gem_rx. This patch just
removes those two parts. The RX_USED is left as is (HW should have set
it). And in gem_rx_refill we simply rely on the head and tail pointers
to refill the used descriptors. I didn't see a reason to do the additional
checking of the RX_USED bit.
After the refill the RX_USED flags are of course cleared for all
refilled descriptors.

	Thanks,
	S?ren
