From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 4 Sep 2012 04:27:27 +0000
Subject: Without MACH_ option Early printk (DEBUG_LL)
In-Reply-To: <alpine.LFD.2.02.1209032201451.1784@xanadu.home>
References: <5040D03B.2050304@ti.com>
 <20120831171336.GA6978@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A83EA9EC8B@DBDE01.ent.ti.com>
 <alpine.LFD.2.02.1208311422450.1784@xanadu.home>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC099@DBDE01.ent.ti.com>
 <alpine.LFD.2.02.1209032201451.1784@xanadu.home>
Message-ID: <79CD15C6BA57404B839C016229A409A83EAA06A9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 07:34:21, Nicolas Pitre wrote:
> On Mon, 3 Sep 2012, Mohammed, Afzal wrote:
> 
> > Hi,
> > 
> > On Fri, Aug 31, 2012 at 23:53:32, Nicolas Pitre wrote:
> > > On Fri, 31 Aug 2012, Hiremath, Vaibhav wrote:
> > > > On Fri, Aug 31, 2012 at 22:43:36, Russell King - ARM Linux wrote:
> > > > > On Fri, Aug 31, 2012 at 08:24:51PM +0530, Vaibhav Hiremath wrote:
> > 
> > > > > > AM335X EVM (based on AM33XX device) only supports DT boot mode and
> > > > > > doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
> > > > > > baseport submission we had aligned that, we won't create separate EVM
> > > > > > options, killing the board file all-together.
> > > > > > 
> > > > > > Having said that, the early printk option (DEBUG_LL) is broken, the
> > > > > > auto-generated file "./include/generated/mach-types.h" still refers to
> > > > > > CONFIG_MACH_AM335XEVM option,
> > > > > machine types are entirely meaningless for DT based systems.
> > > > > 
> > > > > > Can you comment on this? Based on that I will submit the patch.
> > > > > 
> > > > > Pointless.  You can't use machine_is_am335xevm() when you're using DT.
> > > > > 
> > > > 
> > > > They how do you recommend to resolve early prink issue (required during 
> > > > decompression)?
> > > 
> > > Right now the best you can do is to have empty stubs that display 
> > > nothing.
> > 
> > Won't having compile time selection of debug uart over machine based
> > runtime detection help here ?
> 
> It certainly would.  But then your kernel won't run on anything but the 
> specific machine for which the compile time UART selection was made.  As 
> soon as you have more than one possible UART config for the set of 
> machines you want your kernel binary to run on, you'll have to give up 
> on the early output during kernel decompression.
> 
> 

Yes, I understand that, here at this early stage things are very tricky and 
difficult to handle.

Yeah certainly we can ignore this and give up on early output, but just 
would like to make sure that we explore all options and drop it.

Isn't defining something below should solve the purpose, without breaking 
anything,

am335xevm        SOC_AM33XX          AM335XEVM         3589

It just says, AM33XX based machines (AM335XEVM, Bone and others) depends on
CONFIG_SOC_AM33XX. Does it break anything? May be I am missing something 
here.

Also, I was looking at some other platforms and architectures, some of them 
are trying to detect the uart port runtime, by checking for,

	- Which UART is enabled/clocked (most likely by bootloader)?
	- Does it configured or brought out of reset?

This brings-in more complexity at this early stage and not sure we really 
should go down to this patch, assuming the various flavors of devices and 
architectures we have currently.


Thanks,
Vaibhav
