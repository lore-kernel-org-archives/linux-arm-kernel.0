From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 May 2014 14:36:02 +0300
Subject: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
In-Reply-To: <20140509143703.GA17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com>
Message-ID: <5370B222.7050702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/14 17:37, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 00:39]:
>> On 30/04/14 02:52, Tony Lindgren wrote:
>>> Otherwise we can get often errors like the following and the
>>> display won't come on:
>>>
>>> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>>> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
>>> the output with video overlays disabled
>>>
>>> There are some earlier references to this issue:
>>>
>>> http://www.spinics.net/lists/linux-omap/msg59511.html
>>> http://www.spinics.net/lists/linux-omap/msg59724.html
>>
>> Those don't sound like the same issue, but it's hard to say. What kind
>> of clock rates do you get? Cat you paste debugfs/omapdss/clk, with and
>> without this patch?
> 
> Without this patch:
> # cat /sys/kernel/debug/omapdss/clk 
> [   24.833831] DSS: dss_runtime_get
> [   24.837554] DSS: dss_runtime_put
> [   24.840972] DISPC: dispc_runtime_get
> [   24.844757] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) = 57600000
> - DISPC -
> dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
> fck             57600000        
> - LCD -
> LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
> lck             57600000        lck div 1
> pck             19200000        pck div 3
> 
> 
> With this patch:
> # cat /sys/kernel/debug/omapdss/clk 
> [   34.580688] DSS: dss_runtime_get
> [   34.584197] DSS: dss_runtime_put
> [   34.587768] DISPC: dispc_runtime_get
> [   34.591552] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) = 108000000
> - DISPC -
> dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
> fck             108000000       
> - LCD -
> LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
> lck             108000000       lck div 1
> pck             18000000        pck div 6
>  
>> What resolution do you have? If it's a very high resolution (say, DVI
>> output to a monitor), it could just be an issue of
>> not-enough-memory-bandwidth.
> 
> This is just the 3730-evm with the Sharp VGA panel mentioned in
> this series.

Hmm, well, those both look fine. The fck is well below the maximum,
which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher
with this patch, but that should affect the GFX overlay.

So you're just booting, and there are no applications that use the
framebuffer? And there is no rotation or such configured?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/3157340d/attachment.sig>
