From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 28 May 2018 08:41:31 +0200
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180528022652.GA3143@dragon>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
 <20180528022652.GA3143@dragon>
Message-ID: <20180528064131.y5burm5kakiazaq4@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 28, 2018 at 10:26:54AM +0800, Shawn Guo wrote:
> On Tue, Feb 27, 2018 at 11:17:12AM +0100, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Tue, Feb 27, 2018 at 09:10:34AM +0800, Shawn Guo wrote:
> > > On Mon, Feb 26, 2018 at 02:47:41PM +0100, Sebastian Reichel wrote:
> > > > On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> > > > > On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > > > > > On i.MX53 it is necessary to set the DBG_EN bit in the
> > > > > > platform GPC register to enable access to PMU counters
> > > > > > other than the cycle counter.
> > > > > > 
> > > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > > > > ---
> > > > > >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > > > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> > > > > > index 07c2e8dca494..658e28604dca 100644
> > > > > > --- a/arch/arm/mach-imx/mach-imx53.c
> > > > > > +++ b/arch/arm/mach-imx/mach-imx53.c
> > > > > > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> > > > > >  	mxc_set_cpu_type(MXC_CPU_MX53);
> > > > > >  }
> > > > > >  
> > > > > > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
> > > > > 
> > > > > The base address should be retrieved from device tree.
> > > > 
> > > > DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM Platform"
> > > > with 8 platform specific 32 bit registers. Do you think it's worth the trouble
> > > > adding a new binding? Do you have a suggestion for a compatible value?
> > > 
> > > Looking at it more closely, I feel that patching every single platform
> > > which needs to set up additional register for secure-reg-access support
> > > doesn't really scale.  Can we have pmu driver do it with a phandle in
> > > DT pointing to the register and bit that need to be configured?
> > 
> > The PMU driver used to have a feature for initialising platform
> > specific bits, but it is currently being removed to make the PMU
> > code more maintainable. My understanding is, that it's very uncommon
> > to require platform specific setup to get secure-reg-access working.
> > I.e. it is not needed for newer iMX platforms.
> 
> Are you saying this is a very specific setup required by i.MX53 only?

Yes, all other SoCs supported by Linux ARM PMU counters driver can
just use the registers without having to enable platform specific
bits first.

> In that case, I can live with it.

What about the DT node? I did not add it, since this is a i.MX53
specific workaround anyways.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180528/03b956df/attachment-0001.sig>
