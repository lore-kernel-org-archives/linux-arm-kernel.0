From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 27 Mar 2013 12:39:16 +0200
Subject: [RFC 00/14] Add DT support to OMAPDSS
In-Reply-To: <5152BEB7.4060804@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
 <5152BEB7.4060804@ti.com>
Message-ID: <5152CC54.9020101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-03-27 11:41, Benoit Cousson wrote:
> + mturquette and Rajendra
> 
> On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
> 
> ...
> 
>> * ti,dsi-module-id
>>
>> There's a ti,dsi-module-id property in the dsi node. The reason for this
>> module-id property is that we have muxes in the dss_core that route clocks
>> to/from a particular DSI module. So we need some way to index the DSI modules.
>> Another option would be to have a list of DSI modules (phandles) in the
>> dss_core. Both options feel a bit wrong to me, but I went for the module-id
>> approach as that is already used when not using DT.
> 
> That's not a very nice representation. Ideally you should expose 1 clock
> node per DSI node, and enabling one will select the proper mux for you.

Afaik, we need the DSI module id for the following things:

1) DSI pad configuration (OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY).

2) Setting clk mux in dss_core to select input clock for DSI protocol
engine. The choice is between DSS_CLK from PRCM, or clock from a DSI
PLL. DSI1 module can only use DSI1 PLL clock, and DSI2 module can only
use DSI2 PLL clock.

3) Setting clk mux in dss_core to select input clock for LCD/DISPC. The
choice is between DSS_CLK from PRCM, or a clock from DSI PLL. DISPC can
use either DSI1 or DSI2 PLL, LCD1 can use DSI1 PLL clock, LCD2 can use
DSI2 PLL clock.

4) Selecting the video output from DISPC which is routed to the DSI
module. LCD1 output can go to DSI1, LCD2 output can go to DSI1 or DSI2.

All the above of course change between OMAP versions.

So managing all the above was easiest with a plain module-id assigned to
the DSI device.

I guess 1) could be somehow managed by having separate nodes in the dts
for the DSIPHY control, and a link from the DSI module to that DSIPHY node.

4) could possibly be managed by having each DSS output node having a
list of possible inputs from the DISPC. And, I guess, a link somehow to
a mux node in the dss_core. Or something...

All in all, I don't have any clear idea how these should be handled.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/fabd0acb/attachment.sig>
