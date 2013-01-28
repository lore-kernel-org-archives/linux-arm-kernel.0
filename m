From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 Jan 2013 23:31:48 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130127152431.GX1758@titan.lakedaemon.net>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
Message-ID: <20130128223148.GA10275@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Sun, Jan 27, 2013 at 10:24:31AM -0500, Jason Cooper wrote:
> On Sun, Jan 27, 2013 at 03:53:53PM +0100, Sebastian Hesselbarth wrote:
> > On 01/27/2013 03:46 PM, Jason Cooper wrote:
> > >>I _cannot_ confirm that gbe is loosing its MAC address on Dove. I will
> > >>post a follow-up patch to Jason's cleanup patches that will also
> > >>grab a clock for smi. With that patch insmod'ing/rmmod'ing mv643xx_eth
> > >>does work just fine here on Dove.
> > >
> > >I believe Simon's issue is that the mv643xx_eth driver is not loaded at
> > >boot, it's clocks get gated, then when he loads the driver, there is no
> > >mac address.  Is that correct Simon?  I don't think unloading the driver
> > >after boot will trigger this regression.
> > 
> > Loading and unloading the driver module hangs because of the missing
> > clk_prepeare_enable in shared driver part. This should be fixed by the
> > patch I sent you.
> > 
> > Dove and Kirkwood have the same gbe internally and I can boot into Dove
> > without mv643xx_eth, load, unload, reload the module and it always finds
> > its MAC address.
> > 
> > I just want Simon to confirm that Kirkwood's gbe is really loosing the
> > contents of its MAC address registers during gated clocks, which is from
> > a HW point of view very unlikely.
> 
> Ok, I just wanted to make sure we understood his problem correctly, and
> if possible, reproduce it.
> 
> Simon, can you give us some steps to reproduce this on our side so we
> can see exactly what's happening?

Nothing special here. My config originally based on a Debian config
for a Kirkwood kernel.  Thus, amongst other drivers, mv643xx_eth is
build as a module and is loaded from an initrd.
Because all relevant drivers are loaded as modules, I need my
runit patch to boot at all.

Here are my findings with various patches: ("non-DT" means booting
the IBNAS6210 with machine ID 1680 ???Marvell DB-88F6281-BP
Development Board???, which works reasonably well)

3.8-rc5 + runit patch:

DT: Hangs at boot (when loading mv643xx_eth)
non-DT: Boots ok

3.8-rc5 + runit patch + ge00/ge01 patch:

DT: Boots ok
non-DT: Boots ok

3.8-rc5 + runit + Sebastians get smi clock patch (modified to use
legacy clock names):

DT: Boots, but no MAC
non-DT: Boots ok

3.8-rc5 + runit + using Sebastians patch + clks not ticking at module
load:

DT: Boots, but no MAC
non-DT: Boots, but no MAC


hth,
  Simon
