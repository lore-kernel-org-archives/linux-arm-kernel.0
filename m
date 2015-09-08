From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 8 Sep 2015 16:16:35 +0200
Subject: [PATCH] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <20150907163859.GB3237@piout.net>
References: <1441639328-2615-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150907163859.GB3237@piout.net>
Message-ID: <20150908141635.GA31937@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 07, 2015 at 06:38:59PM +0200, Alexandre Belloni wrote:
> On 07/09/2015 at 17:22:08 +0200, Sylvain Rochet wrote :
> > Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
> > pullup only increase power consumption while transmitting with no value
> > added.
> > 
> > Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
> > floating and so consuming a useless extra amount of power if nothing is
> > externally connected to dbgu.
> 
> I would prefer dropping those useless (and sometimes wrong) comments
> when reworking the pinctrl. This is also valid for 2/2

I fully agree, will do.


> Else, the change makes sense.

Before sending v2, I noticed something which should be taken into 
account.

I am lucky enough to currently have on my desk a PCB with almost all 
SAMA5D31 muxed pins not connected to anything and here are my 
consumption measurement will "all" muxed pads set to GPIO in multiple 
configurations of direction and pull-down/pull-up:

Pads are set in a modified boot loader which doesn't do anything after 
setting the pads, clocks are still enabled as well as MPDDRC and 
Nandflash, so we are sure that we don't have peripherals on floating 
wires.

all 160 PIO output, set low,  pull up enabled:            76.57 mA
all 160 PIO output, set low,  pull down enabled:          76.56 mA  
all 160 PIO output, set high, pull down enabled:          76.72 mA
all 160 PIO output, set high, pull up enabled:            76.68 mA
all 160 PIO output, set low,  pull up and down disabled:  78.22 mA
all 160 PIO output, set high, pull up and down disabled:  78.60 mA
 ( all 160 PIO input, pull up enabled:                    77.78 mA )

(that's not exactly 160, that's 160 minus DRXD, DTXD, 4 leds clamped to
low, and ALE CLE nandflash pads clamped as well).

Those results are a bit surprising, we would expect a higher power 
consumption when output value and pull-something do not match of about 
160*3.3/70000 = 7.5 mA. We also would expect that disabling pull up and 
pull down will reduce current consumption on a push pull output instead 
of increasing. The PIO simplified schematics in datasheet does not have 
a clue that could explain this behavior.

Atmel guys, could you confirm that a pad currently driven with a 
push-pull output (either with peripheral or pio) stage automatically 
disengage any pull up or pull down set and could you confirm that 
manually disabling pull up and pull down on an output port actually 
increase (10 ?A/pad) power consumption ?

Sylvain
