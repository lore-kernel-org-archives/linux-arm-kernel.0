From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Oct 2013 21:01:44 +0200
Subject: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in
 system manager
In-Reply-To: <525D41AA.7060503@gmail.com>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
 <201310151450.48650.arnd@arndb.de> <525D41AA.7060503@gmail.com>
Message-ID: <201310152101.44669.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 October 2013, Dinh Nguyen wrote:
> Hi Arnd,
> 
> On 10/15/13 7:50 AM, Arnd Bergmann wrote:
> > On Monday 14 October 2013, dinguyen at altera.com wrote:
> >> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel)
> >> +{
> >> +       u32 hs_timing;
> >> +
> >> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel);
> >> +       writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
> >> +}
> >> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);
> > This looks like the wrong approach. What are you trying to do? If you want to
> > set a clock, please use the clk API.
> I can't use the clk API because this function is setting up a clock 
> phase bit for the SD/MMC
> clock that is used to clock the card, not the IP. This register is 
> located outside the SD/MMC
> and the clock manager.
> 
> Just to refresh your memory on this topic:
> I tried to use the syscon approach that you suggested:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168470.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170423.html

Ah, thanks. I knew this problem had come up before, I just didn't remember
it was for socfpga.

> But this approach was rejected by Stephen Warren because we wanted to 
> the SD driver to be automonous
> of registers outside its IP:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/194014.html
> 
> So I went with the approach of exposing a platform API so that the 
> SD/MMC platform specific
> code can call it.
> 
> The system manager has a plethora of registers that controls other IPs 
> on the SOC, so I kinda thought
> syscon was the way to go with this. A driver for this IP did not make 
> sense to me.
> 
> Please advise if you know of another approach?

I don't remember the details of what we have gone through before, but
I think this should still work:

1 Create a "syscon" backend driver to control your "system manager", which
  lets other drivers hook into it without calling a private API.
2 Create a trivial clock driver that is independent of your existing
  clock driver and independent of the other drivers using the system
  manager, by using syscon as the low-level interface.
3 Make the sdmmc driver use the normal clock API and link its clock to the
  driver from step 2 in the device tree.

Is this what you have tried before?

	Arnd
