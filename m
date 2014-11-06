From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 06 Nov 2014 04:51:54 +0100
Subject: [PATCH 0/7] Pinctrl support for Zynq
In-Reply-To: <44de30f0237545c6b62871d6c0480a67@BY2FFO11FD050.protection.gbl>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <5459BC1C.3000807@suse.de>
 <44de30f0237545c6b62871d6c0480a67@BY2FFO11FD050.protection.gbl>
Message-ID: <545AF05A.1040300@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.11.2014 um 18:03 schrieb S?ren Brinkmann:
> On Wed, 2014-11-05 at 06:56AM +0100, Andreas F?rber wrote:
>> I've tracked down all 54 MIO pins of the Parallella and cooked up the
>> equivalent DT patch. [...] For testing purposes I've configured a
>> heartbeat trigger for the USER_LED (CR10).
>>
>> To my disappointment these pinctrl additions did not fix one issue:
>> Whenever a write access to be handled by the bitstream (0x808f0f04) is
>> performed, the board hangs and the heartbeat stops. Would a bug in the
>> bitstream allow this to happen, or are more drivers missing to actually
>> make use of the PL in general? With a downstream ADI/Xilinx 3.12 kernel
>> that problem does not surface.
> 
> This doesn't sound like being related to pinctrl at all.
> Devices in the PL are just memory mapped on the AXI bus. There is
> nothing needed to access those. Hangs do in most cases indicate that the
> IP does not respond (properly). In my experience this is mostly caused
> by 
>  - level shifters not enabled
>  - IP kept in reset
>  - IP is clock gated
> With the clock gating being the culprit in most cases. Did you check
> those things?

Figured it out: zynq-7000.dtsi sets fclk-enable = <0>, i.e., all PL
clocks are disabled by default. When overriding that tiny property with
0xf it suddenly works as expected! I'll send a patch later in the day.

Are boards expected to use clocks = <&clkc 15>, ...; on individual nodes
relying on the PL? Or does enabling those clocks require actually
loading a bitstream so that it is not being done by default?

It seems ranger dangerous to me that a single MMIO write can freeze the
system - as a software developer I would've expected this to be caught
and handled as a SIGBUS.

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/d0f54ffe/attachment.sig>
