From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 May 2014 09:41:26 +0300
Subject: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
In-Reply-To: <20140513152626.GB16837@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com>
 <5370B222.7050702@ti.com> <20140512143934.GC31772@atomide.com>
 <5370DE42.2060607@ti.com> <20140513152626.GB16837@atomide.com>
Message-ID: <53731016.8020103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/14 18:26, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 07:45]:
>> On 12/05/14 17:39, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 04:36]:
>>>> On 09/05/14 17:37, Tony Lindgren wrote:
>>>>>
>>>>> This is just the 3730-evm with the Sharp VGA panel mentioned in
>>>>> this series.
>>>>
>>>> Hmm, well, those both look fine. The fck is well below the maximum,
>>>> which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher
>>>> with this patch, but that should affect the GFX overlay.
>>>>
>>>> So you're just booting, and there are no applications that use the
>>>> framebuffer? And there is no rotation or such configured?
>>>
>>> Right. The rotation is set to 3 though.
>>
>> Hmm, that's probably the issue then. VRFB rotation is very heavy on the
>> memory bandwidth, and is generally a very easy way to get sync lost errors.
> 
> I found another case without rotation where the error always triggers.
> By forcing 3730-evm LCD panel to QVGA mode it always seems to happen
> even without rotation.
> 
> Without this patch with errors and no image:
> 
> # cat /sys/kernel/debug/omapdss/clk 
> [   55.185729] DSS: dss_runtime_get
> [   55.189422] DSS: dss_runtime_put
> [   55.192810] DISPC: dispc_runtime_get
> [   55.196685] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) = 27000000
> - DISPC -
> dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
> fck             27000000        
> - LCD -
> LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
> lck             27000000        lck div 1
> pck             5400000         pck div 5
> 
> With this patch without errors and penguin showing:
> 
> # cat /sys/kernel/debug/omapdss/clk
> [   19.905792] DSS: dss_runtime_get
> [   19.909545] DSS: dss_runtime_put
> [   19.912933] DISPC: dispc_runtime_get
> [   19.916778] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) = 108000000
> - DISPC -
> dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
> fck             108000000       
> - LCD -
> LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
> lck             108000000       lck div 1
> pck             5400000         pck div 20
> 
> In this case the errors are different too:
> 
> DISPC: channel 0 xres 240 yres 320
> DISPC: pck 5400000
> DISPC: hsw 3 hfp 3 hbp 39 vsw 1 vfp 2 vbp 7
> DISPC: vsync_level 1 hsync_level 1 data_pclk_edge 1 de_level 0 sync_pclk_edge 0
> DISPC: hsync 18947Hz, vsync 57Hz
> DISPC: lck = 27000000 (1)
> DISPC: pck = 5400000 (5)
> APPLY: DISPC IRQ: 0x60: GFX_FIFO_UNDERFLOW 
> APPLY: DISPC IRQ: 0x4062: GFX_FIFO_UNDERFLOW SYNC_LOST 
> DISPC: dispc_runtime_get
> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay

I'm quite out of ideas... The pixel clock is so low that underflow
shouldn't really happen. I was trying to find 3730 documentation that
would describe the PRCM's multipliers and dividers for DSS (i.e. the
ones you change in this patch), but I didn't find anything.

Maybe the DSS clock's fixed multiplier has been changed for 3730. But in
that case our .dts files related to the clocks are wrong too. The clock
nodes related to this are dpll4_m4x2_mul_ck, which is corresponds to the
"dss_fck_multiplier" value in omapdss, and dpll4_m4_ck, which
corresponds to the "fck_div_max" value.

One thing to try out is, without this patch, change
CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK to force the dss func clock higher.
With QVGA mode, you could try, say, value of 19, which should make sure
the fck is at least 19 times higher than pck.

> Regarding rotation, it does look like that with VGA mode enabling
> rotation makes the error trigger quite often on 3730.
>  
>> will handle it fine with the clock rates and bandwidth usage you have
>> for your use cases.
> 
> I don't think it's all because of rotation. And rotating my head

No, probably not. The pixel clocks are so low that the rotation should
work fine. Except if there's something wrong the the VRFB or the memory
bus, which make the VRFB rotation not work even with low pixel clocks.

> makes my neck hurt!

You need to learn to hold the device a bit differently!

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/7846b469/attachment.sig>
