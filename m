From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Jun 2012 16:22:26 -0600
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803BE3E73@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
 <4FD8C4DB.4020908@gmail.com>
 <20120614013343.GD29684@b20223-02.ap.freescale.net>
 <4FE1DE53.4070202@gmail.com> <4FE1EF26.9080401@wwwdotorg.org>
 <F281D0F91ED19E4D8E63A7504E8A649803BE3E73@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <4FE39EA2.8050809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 07:32 PM, Chen Peter-B29397 wrote:
>  
>> I haven't been following the thread, but just noticed it. Very similar
>> things (DT nodes for probed devices) are coming up quite a bit recently,
>> for example:
>>
>> Re: Where to power on the wifi device before loading the driver.
>> http://www.spinics.net/lists/arm-kernel/msg180368.html
>>
>> dt: rfkill-gpio: add bindings documentation
>> http://www.spinics.net/lists/linux-tegra/msg03977.html
>>
>> I wonder if there's any kind of infra-structure or standardized bindings
>> that would be useful here?
> 
> Hi Stephen,
> For your suggestion: 
> 
> sdhci at 78000000 {
> 	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
> 	reg = <0x78000000 0x200>;
> 	interrupts = <0 14 0x04>;
> 
> 	sdio-device {
> 		reset-gpios = <...>;
> 		enable-gpios = <...>;
> 	};
> };
> 
> I have a question, if reset-gpio or enable-gpio is not set, how bus (sd or usb) know
> it is a sdio device as the wifi is not powered on at the time, it will not response host's
> command,  the hub at usb bus is the same.

That's a good point. We need those properties to be part of the device
that controls the port/slot/connector, not the thing that plugs into it.
Having each such binding and driver implement this themselves might not
be a good idea though. Perhaps we can standardize on a mechanism for
this; something vaguely like rfkill, but for arbitrary types of devices
connected to ports.

For USB at least, where the power/reset/... GPIOs might affect just one
port on a hub rather than the root USB host controller, the issue of
representing these properties on a dynamically probed device still
applies. Something like:

ehci {
    /* The following node is dynamically detected, although the hub
     * IC is physically soldered onto the board
     */
    hub {
        hub { /* also dynamic */
            port at 2 {
                child-supply = <&regulator>;
                reset-gpios = <&gpio 0 0>;
            };
        };
    };
};

But without knowing what might be connected to port at 2, how do we know
how to sequence the power supply and reset GPIOs according to its
requirements? I guess this is part of the specification of the port
itself though, not the attached device, since anything that is allowed
to plug in must conform to whatever sequencing the port is designed to
give. If the connected device is known, the port at 2 node in DT can encode
whatever sequencing requirements are associated with the known connected
device.
