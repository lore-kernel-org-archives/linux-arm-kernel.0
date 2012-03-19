From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 09:07:48 -0600
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <201203191501.10232.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120317104751.4F00E3E0910@localhost>
 <20120319130222.GC5705@sirena.org.uk> <201203191501.10232.arnd@arndb.de>
Message-ID: <4F674BC4.2070802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 09:01 AM, Arnd Bergmann wrote:
> On Monday 19 March 2012, Mark Brown wrote:
>> On Sat, Mar 17, 2012 at 10:47:51AM +0000, Grant Likely wrote:
>>
>>> After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
>>> I definitely prefer the fixed property name plus a separate names property.
>>> It is easier to use common code with that scheme, and easier to statically
>>> check for correctness.
>>
>> It's not a fantastic experience when using the bindings as the arrays
>> grow large, though - keeping things matched up isn't much fun especially
>> if any of the elements in the array are optional.
> 
> Maybe one can use named properties in a new device node in that case,
> like this:
> 
> 	bus {
> 		dma: dma-controller {
> 			#dma-cells = <1>;
> 		};
> 
> 		device {
> 			compatible = "device";
> 			channel: dma-channel {
> 				type = <0x1>;
> 				name = "foo";
> 				number = <23>;
> 				direction = <3>;
> 			};
> 			dma-requests = <&dma &channel>;
> 		};
> 	};

For reference, this is very similar to how the pinctrl bindings work,
except that they require the "channel" node to be a child of the DMA
controller, and hence "dma-requests" doesn't contain <&dma &channel>,
just <&channel>, since "dma" is the parent (or grand-parent) of "channel".
