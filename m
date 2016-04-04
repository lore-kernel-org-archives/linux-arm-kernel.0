From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 4 Apr 2016 15:45:57 +0300
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <20160402001753.GR9329@atomide.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com> <20160402001753.GR9329@atomide.com>
Message-ID: <57026205.6020105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 04/02/16 03:17, Tony Lindgren wrote:
> Hi,
> 
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160401 02:34]:
>> So what shall we do with the OMAP3 McBSP2/3 sidetone? It has been broken in DT
>> boot since the first time we booted OMAP3 with DT... Only in legacy mode we
>> can have properly working ST.
> 
> Grr.

Yes :(
The reason for this is that in DT boot we can not provide the
enable_st_clock() callback to the mcbsp driver stack. This is done for legacy
boot in mach-omap2/mcbsp.c

>> I have the second level of patches based on this set (I think I need to resend
>> this series since I might have changed it, can not recall) for both arch/arm
>> and ASoC to have working ST in legacy and DT boot. We will no longer have
>> warning regarding to broken hwmod data in DT boot.
>> But all is based on the assumption that we agree at some point that the ST
>> block is part of the McBSP module ;)
> 
> The sidetone module is a separate target from the McBSP on the interconnect
> but there are also direct lines between sidetone and McBSP devices :)
> Here's what I'm seeing looking at the AP table on dm3730 hardware.
> 
> McBSP target module:
> 0x49022000, ap 5 06.0, McBSP2
> 0x49024000, ap 7 08.0, McBSP3
> 
> Sidetone target modules:
> 0x49028000, ap 39 0a.0, mcbsp2_sidetone
> 0x4902a000, ap 41 12.0, mcbsp3_sidetone
> 
> And that seems to match TRM "21.6.4 SIDETONE Register Description",
> "Table 2-5. L4-Peripheral Memory Space Mapping", and "Table 9-114. Region
> Allocation for L4-Per Interconnect".

I'm aware of this, but even today we have one single driver to handle both
McBSP and the sidetone block.

>> If I need to write separate driver for the McBSP module's ST block, it would
>> mean some sort of API between the McBSP and ST driver. This is not straight
>> forward since there are registers both in McBSP block and ST block that needs
>> to be configured in specific order -> simple enable_st() would not work
>> (probably enable_st_stage1(), enable_st_stage2()) and callbacks from McBSP to
>> ST, ST to McBSP also going to be needed. As far as I can see it is going to be
>> a huge mess.
>
> The McBSP and sidetone don't have parent child relationship at the
> interconnect level. So I think the best option would be to have the McBSP
> driver implement mcbsp_sidetone_register/unregister() etc functions. That
> can then set up the necessary callbacks. Then the sidetone driver can call
> them on probe/exit and set up the necessary callbacks and whatever might
> be needed.
> 
> If they are currently handled in a single driver, you you need to
> pm_runtime_get both modules.

The ST does not have clocks coming from PRCM level, it only uses the McBSP
iclk when it is enabled (the McBSP block of the McBSP). As far as pm_runtime
goes I think the ST module should not use it. We can not tell hwmod to
enable/disable the McBSP2/3 iclk when we pm_runtime for the ST. It does not
help at all. We can have nop action for the ST when pm_runtime is used, but
then why would we have it?

> So having two separate drivers might make things a lot simpler.

Not really. It will make things way more complicated imho. How to handle
legacy boot as we still have that supported? When the McBSP driver is loaded
we must know if it has sidetone or not so we can create the needed audio
controls, sysfs entries. The sysfs and kcontrol registration could be moved
out to the new ST driver, true.
I actually started with two separate drivers approach first, but decided that
it does not worth the effort (legacy boot support, pm_runtime/hwmod hassle,
platform data, callback API design, etc).
I know, it is not rocket science but it is king of shoot out of cannon into
sparrows.
I'll think about it for a little while ;)

> If you don't treat the McBSP and sidetone as separate modules, things can
> easily fail. For example, doing a read-back to flush of posted write to
> sidetone registers flushes nothing for McBSP and the other way around.

I don't see problem with the need of flushing if we would need it. I don't
think we are doing anything proactively to flush writes in the driver today
and we do have at least one product using the ST (n900).

>> Other option would be to deprecate the ST support as such, but that would
>> leave the n900 guys in trouble as they need ST to be functional...
> 
> That does not sound like a nice option at all :(

I know. This has been bugging me for a long time. I want to fix this one
before my beagleboard-xm gives up and won't boot up anymore since after that I
will have no omap3 board to work with :(

-- 
P?ter
