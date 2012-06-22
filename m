From: B29397@freescale.com (Chen Peter-B29397)
Date: Fri, 22 Jun 2012 00:03:20 +0000
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <4FE39EA2.8050809@wwwdotorg.org>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
 <4FD8C4DB.4020908@gmail.com>
 <20120614013343.GD29684@b20223-02.ap.freescale.net>
 <4FE1DE53.4070202@gmail.com> <4FE1EF26.9080401@wwwdotorg.org>
 <F281D0F91ED19E4D8E63A7504E8A649803BE3E73@039-SN2MPN1-023.039d.mgd.msft.net>
 <4FE39EA2.8050809@wwwdotorg.org>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BE45CD@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> That's a good point. We need those properties to be part of the device
> that controls the port/slot/connector, not the thing that plugs into it.
> Having each such binding and driver implement this themselves might not
> be a good idea though. Perhaps we can standardize on a mechanism for
> this; something vaguely like rfkill, but for arbitrary types of devices
> connected to ports.
> 
> For USB at least, where the power/reset/... GPIOs might affect just one
> port on a hub rather than the root USB host controller, the issue of
> representing these properties on a dynamically probed device still
> applies. Something like:
> 
> ehci {
>     /* The following node is dynamically detected, although the hub
>      * IC is physically soldered onto the board
>      */
>     hub {
>         hub { /* also dynamic */
>             port at 2 {
>                 child-supply = <&regulator>;
>                 reset-gpios = <&gpio 0 0>;
>             };
>         };
>     };
> };
> 
> But without knowing what might be connected to port at 2, how do we know
> how to sequence the power supply and reset GPIOs according to its
> requirements? I guess this is part of the specification of the port
> itself though, not the attached device, since anything that is allowed
> to plug in must conform to whatever sequencing the port is designed to
> give. If the connected device is known, the port at 2 node in DT can encode
> whatever sequencing requirements are associated with the known connected
> device.

In fact, for specific usb/sdio interface device, there should be a specific interface 
class driver for it, the best place is at that class driver, like wifi or 3g driver,
as it is chip/device specific.

But the generic 3G and HUB devices are special, there is only one common driver
for each of them (drivers/usb/core/hub.c & drivers/serial/option.c)   
