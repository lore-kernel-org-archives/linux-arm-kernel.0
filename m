From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 18:01:00 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <5108F300.7000705@gmail.com>
References: <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
Message-ID: <20130130230100.GV7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 11:16:32AM +0100, Sebastian Hesselbarth wrote:
> On 01/30/2013 09:30 AM, Simon Baatz wrote:
> >On Wed, Jan 30, 2013 at 01:51:18AM +0100, Sebastian Hesselbarth wrote:
> >>- [PATCH v2 2/2] clk: mvebu: Do not gate runit clock on Kirkwood
> >>   (no lockup for minimal kernel configs)
> >>
> >>- [PATCH] NET: mv643xx: get smi clock from device tree
> >>   (no lockup for modular DT ethernet)
> >>
> >>- Some patch that adds MV643XX_ETH_SHARED_NAME ".0" and ".1" clk aliases
> >>   (no lockup for modular non-DT ethernet)
> >
> >I think your patch to get the smi clock is intended for device tree.
> >Thus, the driver won't use these aliases, right?
> 
> Actually, both patches above will not fix modular ethernet for 3.8-rc as
> shared driver is probed before core driver and not requesting any clk at
> all. The "NET: mv643xx: get smi clock from device tree" patch is based
> on Jason's attempt to separate shared driver.
> 
> If we need to fix modular ethernet now, we also need to add a clk_get
> to shared ethernet.
> 
> But yes, DT doesn't need any clock aliases.
> 
> >>- Some patch that adds clk_prepare_enable to ge0/ge1 clocks to
> >>   kirkwood_legacy_clk_init()
> >>   (retain MAC address for modular DT ethernet)
> >
> >I like mine better, since it only enables the clocks of the
> >interfaces that are initialized in the init code.  I tested it with
> >non-DT as well.  But either is fine with me.
> 
> I know the difference, but here it is not only about fixing an issue
> but have it cleanly removed later on. But I don't have a strong opinion
> on that and maybe Andrew or Jason should coordinate what must be fixed
> now and how we do it.

I agree that Simon's is nicer (per device disabling).  However,
Sebastian is correct, his is easier to remove later on once we have
proper DT bindings in mv643xx_eth.

As it stands, there are three patches to fix this issue:

ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency
ARM: kirkwood: provide ge clock aliases for shared smi
ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels

wrt to runit gating, the only case we are not covering is if of_serial
is a module (and so is everything else using the runit clk).  That's
*really* rare.  If someone embarks down that path, they get the
responsibility of not writing to all the deactivated registers. ;-)

wrt to ge losing mac addresses, both DT and non-DT booting are covered by
Sebastian's patches, for non-DT aware mv643xx_eth.

Once we add proper DT support to mv643xx_eth, the local-mac-address will
need to be defined in the dtb.  We should probably poke the other Jason
to see if there is a cooresponding u-boot patch to his local-mac-address
patch.

thx,

Jason.
