From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Sun, 10 Feb 2013 12:35:43 +0100
Subject: [PATCH RFC 1/7] platform: add a device node
In-Reply-To: <20130210093708.GL17852@n2100.arm.linux.org.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk>
 <20130210010246.GA1455@kroah.com> <5116FCA1.40703@collabora.co.uk>
 <20130210093708.GL17852@n2100.arm.linux.org.uk>
Message-ID: <CAAwP0s0fCJmUfTJweGhXj5bXsQ0Gov9JbUJtqYMwL7duNLZv_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 10:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Feb 10, 2013 at 02:49:21AM +0100, Javier Martinez Canillas wrote:
>> I knew this would be controversial and that's why I didn't mean it to be a patch
>> but a RFC :)
>>
>> The problem basically is that you have to associate the platform device with its
>> corresponding DT device node because it can be used in the driver probe function.
>
> When DT is being used, doesn't DT create the platform devices for you,
> with the device node already set correctly?
>

Well they usually do but not always just like usually you have a
platform_device in your board code and call platform_device_register().

But in some configurations you can't just define the platform_device
required resources (I/O memory, IRQ, etc) as static platform data.
In some cases you need a level of indirection.

In this particular case a SMSC ethernet chip is connected to an
OMAP3 processor through its General-Purpose Memory Controller.

You can't just define the I/O memory used by the device since you first
need to request that address to the GPMC. The same happens with the
IRQ line since a OMAP GPIO pin is used so you have to first configure
the GPIO line as input.

So in platform code you call to gpmc_smsc911x_init() passing all the
GPMC specific configurations (GPIO used for IRQ, GPMC chip select, etc)

Then gpmc_smsc911x_init() does all the needed setup, fills a platform_data
for the real platform_device and calls  platform_device_register_resndata().

>From the smsc911x platform_driver probe function point of view it just have
resources and doesn't know if it's I/O memory is directly mapped or is
through a memory controller as the GPMC. It also doesn't know if the IRQ is
a GPIO or not.

Another approach could be extending the current SMSC LAN DT binding with
GPMC-specific properties so the platform driver could do this setup when the
device node is found and the probe function is called.

> Manually creating platform devices and adding DT nodes to it sounds like
> the wrong thing to be doing.
> --

Yes, I don't like this approach to much either but I didn't find a better way to
do it. That was the main point of this RFC.

I'm still learning about Device Trees so I hope that someone with more
experience with DT or more familiarized with OMAP GPMC and the SMSC
driver could take a step forward and help me giving a better idea.

Thanks a lot for your feedback and best regards,
Javier
