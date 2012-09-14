From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 09:51:31 -0600
Subject: [PATCH V4 1/5] ARM: add infra-structure for BCM2835 and Raspberry
 Pi
In-Reply-To: <201209140750.44039.arnd@arndb.de>
References: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
 <201209140750.44039.arnd@arndb.de>
Message-ID: <50535283.9040905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2012 01:50 AM, Arnd Bergmann wrote:
> On Friday 14 September 2012, Stephen Warren wrote:
>> From: Simon Arlott <simon@fire.lp0.eu>
>>
>> The BCM2835 is an ARM SoC from Broadcom. This patch adds very basic
>> support for this SoC.
>>
>> http://www.broadcom.com/products/BCM2835
>> http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pd
> 
> Just looked at that document. Funny how they actually put details about
> the kernel implementation (the static mapping address) into a hardware
> manual.

Yes. I keep hoping they'll fix this and re-issue the document. Dom, what
do you think that chances are of that?

>> Note that the documentation in the latter .pdf assumes the MMU setup
>> that's used on the "VideoCore" companion processor, and does not document
>> physical peripheral addresses. Subtract 0x5e000000 to obtain the physical
>> addresses.
> 
> This had escaped me so far. I think we should put this into the device tree
> so that the representation of devices in the .dts file matches the one in
> the manual, like this
> 
> 	vc-bus {
> 		compatible = "simple-bus";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges = <0x20000000 0x7e000000 0x02000000>;
> 
> 		other devices {
> 
> 		};
> 	};

I guess I can see the advantage of having the .dts reg values match the
documentation. I just worry that doing so is more about matching the
documentation rather than describing the true HW. Still, I suppose with
the ranges property, it's clear what the true physical addresses are..
It also introduces a completely fake bus just to perform the address
re-writing; I wonder if putting the ranges property at the top-level
node work instead?.

So  now that almost everything is ack'd, how should this get into the
tree - will you take (an updated version of) these patches and apply
them directly to arm-soc, or should I commit them and send a pull
request? (For the latter, I'd have to look up how to create a new k.org
git repo).

Thanks for the reviews.
