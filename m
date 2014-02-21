From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 21 Feb 2014 10:57:50 -0700
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <20140221031927.GA2654@localhost>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140218185703.GI29304@obsidianresearch.com>
 <20140218190212.GE7862@titan.lakedaemon.net>
 <20140219222103.GB17826@obsidianresearch.com>
 <20140221031927.GA2654@localhost>
Message-ID: <20140221175750.GB17611@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 12:19:28AM -0300, Ezequiel Garcia wrote:
> > Thanks, I tested v3 of the patchset.
> > 
> > It boots, but I can't do very much because the watchdog driver doesn't
> > build and my system is configured to watchdog timeout if there is no
> > watchdog driver.
> > 
> > Presumably the watchdog patchset needs to be a dependency for this? Is
> > there a git URL for it?
> > 
> 
> Andrew's v3 and the mvebu/watchdog branch merges without any conflicts:
> 
> https://github.com/lunn/linux/tree/v3.14-rc1-mvebu-v3
> 
> http://git.infradead.org/linux-mvebu.git/shortlog/refs/heads/mvebu/watchdog
> 
> And multi v5 works great here!

It is working now for me as well, I haven't noticed any strangeness at
least..

Ezequiel, after I applied your watchdog branch the .dtsi files
lacked the new 2nd register:

                wdt: watchdog-timer at 20300 {
                        compatible = "marvell,orion-wdt";
                        reg = <0x20300 0x28>;
                        interrupt-parent = <&bridge_intc>;
                        interrupts = <3>;
                        clocks = <&gate_clk 7>;
                        status = "okay";
                };

Which creates a nasty warn-on during boot - is that expected?

BTW, for both patche sets:
Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (on kirkwood)

Also, there seems to be some missing request_region in drivers (can
be fixedup later)

f1001418-f100141b : kirkwood_cpuidle
f1001500-f100151f : /mbus/internal at f1000000/mbus-controller at 20000
f1010030-f1010033 : /mbus/internal at f1000000/core-clocks at 10030
f1020000-f102007f : /mbus/internal at f1000000/mbus-controller at 20000
f1020104-f1020107 : kirkwood-cpufreq
f1020108-f102010b : /mbus/internal at f1000000/wdt at 20300
f102011c-f102011f : /mbus/internal at f1000000/clock-gating-control at 2011c
f1020128-f102012b : /mbus/internal at f1000000/l2-cache at 20128
f1020300-f102031f : /mbus/internal at f1000000/timer at 20300
f1040000-f1041fff : /mbus/pex at e0000000/pcie at 1,0
f1072000-f1075fff : /mbus/internal at f1000000/egiga0
  f1072004-f1072087 : /mbus/internal at f1000000/mdio at 72000
f4000000-f40003ff : /mbus/nand at f4000000/nand at 0

In general it should be:

f1012100-f10121ff : /mbus/internal at f1000000/serial at 12100  (<-- OF stanza)
  f1012100-f101211f : serial    (<-- Driver request region)

Jason
