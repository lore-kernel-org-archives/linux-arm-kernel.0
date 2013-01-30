From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 30 Jan 2013 15:53:19 +0100
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
Message-ID: <20130130145319.GA22332@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

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

Nitpicking here: For a DT aware driver on a DT board, the calls to
kirkwood_ge0[01]_init() need to be removed anyway (this is already
part of Jason's patches) and the clocks will not be enabled.  Thus,
there is not need to cleanup anything for DT when keeping the
clk_prepare_enable in those functions (beyond what we need to do
anyhow).

But now I will shut up. I fully agree that letting Jason/Andrew
decide what to do is the best way forward.

- Simon
