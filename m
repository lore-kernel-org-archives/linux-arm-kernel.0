From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 13:20:50 -0600
Subject: [PATCH 2/3] ARM: kirkwood: Move the crypto node under the mbus
 node
In-Reply-To: <5238A609.30302@gmail.com>
References: <20130917184309.GE21230@obsidianresearch.com>
 <5238A609.30302@gmail.com>
Message-ID: <20130917192050.GA4067@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 08:57:13PM +0200, Sebastian Hesselbarth wrote:
> On 09/17/2013 08:43 PM, Jason Gunthorpe wrote:
> >There should be no nodes that are not children of the mbus. Move
> >the crypto node under the mbus.
> >
> >Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >  arch/arm/boot/dts/kirkwood.dtsi | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> I'd prefer not to move crypto out of internal regs. It is IP located
> in internal registers. 

Well, that isn't entirely right. Internal registers isn't an IP block,
it is yet another internal bus. MBUS is bridged to the (presumably low
speed) internal registers bus, and then the internal registers bus is
routed to IP block.

There is a page in the manual that describes each of the IP blocks
hanging off the internal registers bus.

The crypto IP block has connections to two busses. One to MBUS and one
to internal-regs bus. The sram is dual ported (mbus and IP both access
it), it is an integral part of the crypto IP.

So, I think the current binding is fine, and this change makes it very
clear that it is a single IP block with connections to two of the
internal busses.

Certainly is is cleaner than contaminating the internal bus node's
decode ranges with addresses that are not decoded by the MBUS to
internal bus bridge.

Anyhow, I don't want to churn the DT binding for crypto, we are
supposed to be trying to keep these things stable and there is no
functional change or bug fix in splitting the node into two.

Jason
