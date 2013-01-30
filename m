From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 30 Jan 2013 09:30:44 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <51086E86.8040705@gmail.com>
References: <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
Message-ID: <20130130083044.GA25688@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 01:51:18AM +0100, Sebastian Hesselbarth wrote:
> above using CLK_IGNORE_UNUSED on runit maybe is the best.
> >Fine with all of that. But: I am talking about 3.8 all the time. We
> >have three options for issues 2 and 3 from my point of view:
> >
> >1. We do proper fixes in 3.8 for issues 2 and 3.
> >
> >2. We fix this regression by not gating the clock in both the DT and
> >the non-DT case, preferably by using the correct clocks in
> >kirkwood_ge0[01]_init().  Additionally, Jason promises that all gets
> >well with the DT aware driver in 3.9.  ;-)
> >
> >3. Do nothing. Simply accept that we broke modular Ethernet for DT
> >because some code relies on two pointers being set.  When we
> >introduced a new code path for DT, we forgot about these pointers.
> >Bad luck, the solution was not nice anyway and we will do proper
> >fixes in 3.9.
> >
> >As should be clear by now, I think we should go for option 2.
> 
> Agreed, do you think all issues you are suffering will be solved with:
> 
> - [PATCH v2 2/2] clk: mvebu: Do not gate runit clock on Kirkwood
>   (no lockup for minimal kernel configs)
> 
> - [PATCH] NET: mv643xx: get smi clock from device tree
>   (no lockup for modular DT ethernet)
> 
> - Some patch that adds MV643XX_ETH_SHARED_NAME ".0" and ".1" clk aliases
>   (no lockup for modular non-DT ethernet)

I think your patch to get the smi clock is intended for device tree.
Thus, the driver won't use these aliases, right?
 
> - Some patch that adds clk_prepare_enable to ge0/ge1 clocks to
>   kirkwood_legacy_clk_init()
>   (retain MAC address for modular DT ethernet)

I like mine better, since it only enables the clocks of the
interfaces that are initialized in the init code.  I tested it with
non-DT as well.  But either is fine with me.
 
> I'll prepare the latter patches and post them.

Thanks!


- Simon
