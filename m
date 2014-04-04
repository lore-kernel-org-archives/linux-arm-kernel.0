From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 4 Apr 2014 15:42:37 +0000
Subject: mach header files
In-Reply-To: <5297747.kWEjnPz8MW@wuerfel>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <4379667.784l7DtcMU@wuerfel>
 <0bbbadf628a64ee5be8ede870d421a57@SIXPR06MB173.apcprd06.prod.outlook.com>
 <5297747.kWEjnPz8MW@wuerfel>
Message-ID: <9970caa86d5c454d840c489901d3ca91@SIXPR06MB173.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 04 April 2014 16:31, Arnd wrote:
> On Friday 04 April 2014 13:52:53 Phil Edworthy wrote:
> > On 04 April 2014 14:24, Arnd wrote:
> > > We still make the occasional exception for adding code in the mach-*
> > > directory, but we are getting pretty close to the state where this
> > > is not needed for new platforms, and all the existing uses are for
> > > things that can eventually get cleaned up.
> > > If you think you need an exception here, please explain what you
> > > are doing, and we can see if there is a better way to do that already.
> >
> > Ok, that's what I suspected about the mach header files.
> >
> > I didn't realise about the expectation that there is no
> > arch/arm/mach-* for new platforms. At the moment I have only a
> > small amount of platform code:
> > 1. SMP holding pen code (as there is no power control for the second
> > core), though I have recently seen patches to provide a generic solution
> > for this.
> 
> Proper platforms should not be using the holding pen, that is only
> done on systems that don't have real hardware support for CPU
> power management. Ideally you should be implementing PSCI in the
> firmware, and then you won't need any code for SMP.
> 
> > 2. Firmware calls (via struct firmware_ops) for set_cpu_boot_addr
> >  and cpu_boot. This falls back to directly accessing registers in
> > the system control block, if the firmware fails. This is useful when
> > developing the system when no firmware exists yet.
> 
> Same thing.
Ok, something to look into. How the hardware will work is complicated by the fact that we don't have silicon for this device yet, just a simulator.  As for the firmware, I am not sure I will see that. Our customer is implementing it and responsible for creating the firmware calls from Linux, hence the fall backs.


> > 3. A write to a system control register to switch the pl011 uart
> > from DMA single requests, to DMA burst requests.
> 
> Do you need to do this at run-time, or is it something that could
> be done in the bootloader before Linux starts up?
I might be able to get it into the boot loader, but this is implemented by the customer. One question is whether it should be in the boot loader. The behaviour is specify to the Linux port, whereas the boot loader can be used for a number of different OS.

Thanks
Phil
