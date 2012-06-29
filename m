From: zonque@gmail.com (Daniel Mack)
Date: Fri, 29 Jun 2012 20:34:53 +0200
Subject: Current state of AM33xx patches
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com>
Message-ID: <4FEDF54D.4030609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.06.2012 19:33, Hiremath, Vaibhav wrote:
> On Thu, Jun 28, 2012 at 20:39:08, Daniel Mack wrote:
>> On 27.06.2012 14:13, Hiremath, Vaibhav wrote:
>>
>>> Just to clarify from AM335x perspective,
>>>
>>> In case of AM335x, since the patches and complete BasePort support is still
>>> not present in the Mainline (neither in Linus's tree not in linux-omap), you 
>>> need to use my Repo (https://github.com/hvaibhav: Closely follows linux-
>>> omap/master) in order to test something on BeagleBone platform.
>>
>> Great, that is the information I've been looking for.
>>
>> Your am335x-upstream-staging branch works for me on a custom AM335x
>> based board using a custom DT config.
>>
>> I'll dig through the sources and come back once I know which parts are
>> missing.
>>
> 
> Great to hear that you could able to get this working on your board.
> Please let me know if you need any help.

I wonder about the way forward with regard to hwmod and DT. From what I
can currently see, resources are defined as hard-coded values, even
though that doesn't seem necessary as they're stored in the device tree
data already.

As an example, am33xx.dtsi yields

		uart1: serial at 44E09000 {
			compatible = "ti,omap3-uart";
			ti,hwmods = "uart1";
			clock-frequency = <48000000>;
		};

But the address of that hardware module is in fact ignored. Instead, the
reference to the "uart1" hwmod defines the address space and interrupt
sources the driver requires:

static struct omap_hwmod_addr_space am33xx_uart1_addr_space[] = {
        {
                .pa_start       = 0x44E09000,
                .pa_end         = 0x44E09000 + SZ_8K - 1,
                .flags          = ADDR_TYPE_RT,
        },
        { }
};

And that's the same for all the hardware modules.

Correct me if I'm mistaken, but this isn't really what DT was designed
for. In this context, it is used as a simple list of devices to probe,
not as a abstracted description of the hardware resources and their
interconnects.

The question is: is that the way things should be kept for OMAP/AM33xx?
Or should work be done to move all that hwmod stuff to proper
clk/irq/res definitions that can be used from DT generically? As there's
actually no need to care for legacy users at all (as no board support
for AM33xx is mainline), shouldn't things be done right in the first place?


Best regards,
Daniel
