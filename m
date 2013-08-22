From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Aug 2013 16:01:09 +0900
Subject: [GIT PULL 3/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <20130822065325.GA6615@quad.lixom.net>
References: <cover.1375839719.git.horms+renesas@verge.net.au>
 <4901e136aa5c35873701156c4c0af5b3c2c8faee.1375839719.git.horms+renesas@verge.net.au>
 <87siy3owxj.fsf@linaro.org> <5215115A.1010400@cogentembedded.com>
 <20130822001647.GA6902@verge.net.au>
 <20130822065325.GA6615@quad.lixom.net>
Message-ID: <20130822070109.GA26589@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 11:53:25PM -0700, Olof Johansson wrote:
> On Thu, Aug 22, 2013 at 09:16:49AM +0900, Simon Horman wrote:
> > On Wed, Aug 21, 2013 at 11:13:30PM +0400, Sergei Shtylyov wrote:
> > > Hello.
> > > 
> > > On 08/21/2013 08:01 PM, Kevin Hilman wrote:
> > > 
> > > >>Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > >>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > >This one is triggering a new build failure in -next:
> > > 
> > > >arch/arm/mach-shmobile/board-lager.c:99:2: error: unknown field 'register_type' specified in initializer
> > > >arch/arm/mach-shmobile/board-lager.c:99:19: error: 'SH_ETH_REG_FAST_RCAR' undeclared here (not in a function)
> > > 
> > > >>+/* Ether */
> > > >>+static struct sh_eth_plat_data ether_pdata __initdata = {
> > > >>+	.phy			= 0x1,
> > > >>+	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> > > >>+	.register_type		= SH_ETH_REG_FAST_RCAR,
> > > 
> > > >and it looks to be because this board is trying to use the register_type
> > > >field which was removed by:
> > > 
> > > >commit 8d3214c4e8c8be6efd8ec7a172239ebbd4deb04b
> > > >Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > >Date:   Sun Aug 18 03:13:26 2013 +0400
> > > >
> > > >     sh_eth: remove 'register_type' field from 'struct sh_eth_plat_data'
> > > >
> > > >     Now that the 'register_type' field of the 'sh_eth' driver's platform data is not
> > > >     used by the driver anymore, it's time to remove it and  its initializers from
> > > >     the SH platform code. Also  move *enum* declaring values for this  field from
> > > >     <linux/sh_eth.h>  to  the  local driver's  header file as they're only needed
> > > >     by the driver itself  now...
> > > >
> > > >     Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > > 
> > >    Looks like in this case I had no choice since R8A7790 support for
> > > the 'sh_eth' driver will be added in 3.12 only, so if I merged these
> > > patches thru the shmobile tree, we'd have gotten an error in the
> > > driver...
> > >    I guess it's too early to fix this in any particular tree except
> > > for linux-next itself... let me know what I can do.
> > 
> > This patch ("ARM: shmobile: lager: enable Ether") is also targeted at v3.12.
> > So it seems to me that a fix for this could go through the shmobile tree
> > if it is acceptable to merge net-next into the base of a pull-request.
> > 
> > Kevin, Olof, could you give some guidance here.
> 
> I don't think we want to pull in net-next here just for this -- that is a
> massive branch.
> 
> There's no great solution to any of this, unfortunately.
> 
> I think easiest would be if we add a patch that fixes this up _only_ in
> for-next, and merge the same patch upstream as soon as net-next lands
> (if it lands after arm-soc, otherwise we include it in our branch),
> that might be the least painful way to do this.
> 
> That patch would just remove the assignment to register_type in the
> board file.

That is fine by me.

I think it would be easiest to supply the patch to you as
a patch in email rather than a pull request.

Does that work for you?
