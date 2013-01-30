From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Jan 2013 23:26:56 -0500
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
Message-ID: <20130130042655.GN7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 01:51:18AM +0100, Sebastian Hesselbarth wrote:
> On 01/30/2013 01:03 AM, Simon Baatz wrote:
> >On Tue, Jan 29, 2013 at 09:08:46PM +0100, Sebastian Hesselbarth wrote:
> >>Well, if there is no device/driver using runit it should be safe to disable
> >>it. If there is a driver using it, we need a clocks property for it. And
> >>as you already stated, serial is using it. And you want serial in every
> >>minimal kernel, don't you?
> >
> > From f479db4:
> >
> >  Marvell engineers tell us:
> >
> >  It seems that many units use the RUNIT clock.
> >  SPI, UART, NAND, TWSI, ...
> >  So it's not possible to clock gate it.
> >
> >  Currently the SPI, NAND and TWSI driver will clk_prepaure_enable()
> >  this clk, but since we have no idea what ... is, and turning this clk
> >  off results in a hard lock, unconditionally enable runit.
> >
> >
> >Thus, if we know better than that, that's fine, but please don't tell
> >me that this is "blindly" enabling clocks.

'blindly' is the correct term.  I'm sorry, I'm not trying to be
difficult, but I don't like applying a 'fix' because a 'Marvell
engineer' was too f'ing lazy to figure out wtf was going on with the
runit clock.

So what happens if runit is gated?  Here's what I did to find out:

######
$ git checkout -b runit v3.8-rc5
$ make kirkwood_defconfig
$ ./scripts/config -e COMMON_CLK_DEBUG -e NETCONSOLE \
	-d SERIAL_OF_PLATFORM -d ORION_WATCHDOG \
	-d SPI_ORION -d MTD_NAND_ORION -d I2C_MV64XXX

$ make uImage dtbs

# edit kernel cmdline in u-boot:

Marvell>> setenv bootargs 'console=null rootwait root=/dev/sda2 netconsole=@192.168.1.253/eth0, at 192.168.1.196/ff:ff:ff:ff:ff:ff'
Marvell>> boot

$ socat udp-recv:6666 -
<small pause here>
EXT3-fs (sda2): warning: maximal mount count reached, running e2fsck is recommended
EXT3-fs (sda2): using internal journal
<smaller pause here>>
Unable to handle kernel NULL pointer dereference at virtual address 00000000
#######

It boots all the way up to mounting the USB attached uSD card rootfs.

A few notes about this test setup:
 - the rootfs still has a getty on ttyS0 (could be causing above NULL?)
 - I haven't setup networking on it yet (I was just debugging
   mv643xx_eth gated clock issue).

All this tells me the kernel *does* boot with runit gated since all
drivers that would grab it are disabled.  Tomorrow I'll setup dhcp and
sshd and try to mount debugfs to see if runit is indeed disabled.
Unless someone gets to it before me ;-)

I'll get to the below tomorrow.

thx,

Jason.

> Hmm, should have seen that comment ealier. Based on your/Andrew's statement
> above using CLK_IGNORE_UNUSED on runit maybe is the best.
> 
> So I guess we take patch 2/2 and extend DT clock gating for .flags later?
> 
> >So, we have a statement from Marvell not to gate it, we know that it
> >is needed for "...", can we please not gate it?
> 
> Ack.


> 
> >>>>>3.8-rc5 + runit + Sebastians get smi clock patch (modified to use
> >>>>>legacy clock names):
> >>>>>
> >>>>>DT: Boots, but no MAC
> >>>>>non-DT: Boots ok
> >>>
> >>>This is the behavior originally found by Andrew. The clock patch
> >>>eliminates the lockup, but the hardware forgets its MAC address.
> 
> For the smi clock issue: DT is fixed by the smi clock patch, right?
> non-DT should be fixed in kirkwood_clk_init() with an orion_clkdev_add()
> alias for MV643XX_ETH_SHARED_NAME ".0" and ".1" respectively.
> 
> For the MAC address issue: non-DT doesn't need to be fixed, right?
> DT clock gates should be fixed in kirkwood_legacy_clk_init which will
> also save the clk_get_sys() call. We can easily remove it when mv643xx_eth
> catches the MAC address from either local-mac-address or ATAG.
> 
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

fix for v3.8-rc

> - [PATCH] NET: mv643xx: get smi clock from device tree
>   (no lockup for modular DT ethernet)
> 
> - Some patch that adds MV643XX_ETH_SHARED_NAME ".0" and ".1" clk aliases
>   (no lockup for modular non-DT ethernet)
> 
> - Some patch that adds clk_prepare_enable to ge0/ge1 clocks to
>   kirkwood_legacy_clk_init()
>   (retain MAC address for modular DT ethernet)
> 
> I'll prepare the latter patches and post them.
> 
> Sebastian
