From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 30 Mar 2015 08:33:59 +0200
Subject: [PATCH 3/4] net/macb: fix capabilities configuration
In-Reply-To: <20150328000235.30337361@bbrezillon>
References: <cover.1427469791.git.nicolas.ferre@atmel.com>	<bd7194896b4e4517a7675ae02fe7bed01f19a02d.1427469791.git.nicolas.ferre@atmel.com>
 <20150328000235.30337361@bbrezillon>
Message-ID: <5518EE57.8050808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/03/2015 00:02, Boris Brezillon a ?crit :
> Hi Nicolas,
> 
> On Fri, 27 Mar 2015 16:34:11 +0100
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
>> Capabilities configuration by macb_configure_caps() was moved far too late by
>> 421d9df0628b (net/macb: merge at91_ether driver into macb driver) which would
>> lead to badly configured hardware.
> 
> Indeed, the macb_configure_caps function is called a bit too late,
> but ...
> 
>> So, move this function to early probe and modify its prototype to re-gain its
>> original behavior.
>> DT data retrieval is also moved to simplify the probe code flow.
> 
> ... I'm not happy with these changes.
> I tried to keep  specific init steps of macb and at91_ether separated
> and you're moving macb_configure_caps call (not required on at91_ether
> HW) into macb_probe (the common probe part).

Well, this function is about configuring the capabilities of the
hardware both from the configuration registers and the device tree
entries (this last source applies to all flavors of hardware).

I only see advantages to set these flags early (Cf. above).

> How about moving macb_configure_caps a bit earlier in the macb_init
> function [1] ?

No, it won't be sufficient. The very first function needing the
capabilities set is macb_get_hwaddr() which is pretty early in macb_probe().


Bye,

> Best Regards,
> 
> Boris
> 
> [1]http://code.bulix.org/8gyi6b-88141
> 


-- 
Nicolas Ferre
