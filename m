From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 21 Jan 2016 12:33:11 +0100
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <20160121111115.GJ6588@sirena.org.uk>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
Message-ID: <20160121123311.5346e40d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Thu, Jan 21, 2016 at 11:26:11AM +0100, Lothar Wa?mann wrote:
> > > On Thu, Jan 21, 2016 at 08:05:24AM +0100, Lothar Wa?mann wrote:
> > > > > On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa?mann wrote:
> 
> > > > > > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> > > > > > electronics TX48 module. Make the IRQ optional in the driver and use a
> > > > > > polling routine instead if no IRQ is specified in DT.
> > > > > > Otherwise the driver will continuously generate interrupts and make
> > > > > > the system unusable.
> 
> > > > > How will the driver generate interrupts if there is no interrupt
> > > > > physically present in the system?
> 
> > > > It's using timer interrupts to poll the LTC3589 state.
> 
> > > I know that is what your patch does, my question is why you say in your
> > > commit log that "Otherwise the driver will continuously generate
> > > interrupts and make the system unusable".
> 
> > Because the interrupt is level triggered and the polarity of the
> > EXTINT pin is inverted, the interrupt will be constantly active when
> > the IRQ pin of the LTC3589 is inactive.
> 
> So, to repeat my original question, how will that generate interrupts if
> there is no interrupt physically present in the system?
>
It won't. That's the whole purpose of this patch.
I'm afraid, I don't quite understand what you want to say...

Without this patch there will be a constantly active interrupt, which
will stall the system because the nNMI interrupt (on the EXTINTn pin) is
level triggered.
Since the polarity of the interrupt input is fixed, there is no way to
use it in our HW.


Lothar Wa?mann
