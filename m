From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 04 Aug 2014 16:27:49 +0200
Subject: [PATCH v3 4/4] can: flexcan: add vf610 support for FlexCAN
In-Reply-To: <cd33e1b365502ec0cb3b5bee6dc4fb61@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
 <ff2ea1726b13dc2ffa3519ce9244f3633cf1420d.1405428166.git.stefan@agner.ch>
 <53C5398F.2000005@pengutronix.de> <1b8a8ca03b4a160027a79b722f697e25@agner.ch>
 <601adb6fe47279c115c1cc607365a00e@agner.ch> <53D25C9D.5080803@pengutronix.de>
 <e88108c655e2c16dc9cf6c4194547e73@agner.ch> <53D67A46.3060202@pengutronix.de>
 <b815c5c1f7faed334d1ed5370d51c180@agner.ch> <53D8DB3D.7030403@pengutronix.de>
 <cd33e1b365502ec0cb3b5bee6dc4fb61@agner.ch>
Message-ID: <53DF9865.9060407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2014 03:43 PM, Stefan Agner wrote:
[...]

>> Thanks for the test, so far looks promising :) With this setup the other
>> CAN node repeats the CAN frame until it's ACKed. Because there is no
>> node with a compatible bitrate, there is no ACking CAN node.
>>
>> Can you add a third CAN node to the network. The second and third node
>> should use the same bitrate, while your vf610 uses a different one. With
>> the new setup it should take more than one frame until the vf610 goes
>> into error warning and even more frames to error passive. This way we
>> can see it the error warning interrupt is connected or not. The error
>> counters should increase with each "wrong" bitrate frame it sees, you
>> can check with:
>>
>>     ip -details link show can0
>>
>> The output looks like this:
>>
>>> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
>>>     link/can
>>>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>                               ^^^^^^^^^^^^^^^^^^^^^^
>>>     bitrate 1000000 sample-point 0.750
>>>     tq 125 prop-seg 2 phase-seg1 3 phase-seg2 2 sjw 1
>>>     sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>>>     clock 8000000
>>
>> When one of the berr-counter crosses 96 (and stays below 128) a warning
>> interrupt should be generated.
> 
> Ok, created this setup, could successfully communicate with all three
> nodes. I then set the Vybrid to half of the bitrate. When I send a frame
> from Vybrid, the berr-counter tx immediately ends up at 128 and the
> device is in ERROR-PASSIVE:

This is expected.

> root at colibri-vf:~# ip -details link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>     link/can  promiscuity 0 
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0 
>     bitrate 124990 sample-point 0.739 
>     tq 347 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 83368421
            ^^^^^^^^

BTW: the can core has a really weird clock rate, have a look at the
datasheet if you manage to route a 24 MHz clock (or another multiple of
8MHz) to the flexcan core. I had a quick glance at the datasheet, if I
understand it correctly the Fast OSC clock runs with 24 MHz.

> root at colibri-vf:~# cansend can1 1F334455#1122334455667788
> interface = can1, family = 29, type = 3, proto = 1
> root at colibri-vf:~# [  818.886664] flexcan_irq, esr=00062242
> [  818.890365] flexcan_irq, ctrl=1c3dac57
> 
> root at colibri-vf:~# ip -details link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>     link/can  promiscuity 0 
>     can state ERROR-PASSIVE (berr-counter tx 128 rx 0) restart-ms 0 
>     bitrate 124990 sample-point 0.739 
>     tq 347 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 83368421
> 
> 
> When I send the frames from another device on the bus, I can see the rx
> count incrementing by one on each frame I send. As you expected, the
> device changes to ERROR-WARNING when crossing the 96 frame boundary:

This is correct

> root at colibri-vf:~# ip -details link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>     link/can  promiscuity 0 
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 92) restart-ms 0 
>     bitrate 124990 sample-point 0.739 
>     tq 347 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 83368421
> root at colibri-vf:~# [  448.331150] flexcan_irq, esr=0005050a
> [  448.334851] flexcan_irq, ctrl=1c3dac57
> ip -details link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>     link/can  promiscuity 0 
>     can state ERROR-WARNING (berr-counter tx 0 rx 102) restart-ms 0 
>     bitrate 124990 sample-point 0.739 
>     tq 347 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 83368421

> However, once reaching 128, I don't get another interrupt and the device
> stays in ERROR-WARNING:

The contents of the esr reg would be interesting, especially the
FLT_CONF part.

> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>     link/can  promiscuity 0 
>     can state ERROR-WARNING (berr-counter tx 0 rx 128) restart-ms 0 
>     bitrate 124990 sample-point 0.739 
>     tq 347 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 83368421
> 
> Is this the expected behavior on receive?

No, it should go into error passive if one of the error counters have >
127. Maybe this is an error onthe vf610, maybe it's a general flexcan
problem.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/2e218810/attachment.sig>
