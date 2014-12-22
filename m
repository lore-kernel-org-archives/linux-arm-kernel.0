From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Mon, 22 Dec 2014 15:51:38 +0000
Subject: [PATCH v3 5/5] ASoC: dwc: Add documentation for I2S DT
In-Reply-To: <20141222142636.GT17800@sirena.org.uk>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <2842090b2c7a8a98aed0cfa02addcef0b2e8ec6b.1418826016.git.Andrew.Jackson@arm.com>
 <20141222142636.GT17800@sirena.org.uk>
Message-ID: <54983E0A.2050005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/14 14:26, Mark Brown wrote:
> On Fri, Dec 19, 2014 at 04:18:09PM +0000, Andrew Jackson wrote:
> 
>> Add documentation for Designware I2S hardware block.  The block requires
>> two clocks (one for audio sampling, the other for APB) and DMA channels
>> for receive and transmit.
> 
> You should generally include the binding before the code to parse it,
> both because the binding is required in order to tell if the code is
> doing the right thing and also because people will often not even look
> at code with a missing binding.

Fair enough: I'll reorder the (remaining) patches.

>> + - clocks : Pairs of phandle and specifier referencing the controller's clocks.
>> +   The controller expects two clocks, the clock used for the APB interface and
>> +   the clock used as the sampling rate reference clock sample.
>> + - clock-names : "apb_plck" for the clock to the APB interface, "i2sclk" for the sample
>> +   rate reference clock.
> 
> This is a name based lookup of clocks but the code doesn't use
> apb_pclk at all; it needs to or the binding needs to say that apb_pclk
> must be the first listed clock (which would not be good).

I can remove apb_pclk: I was modelling the device tree entry on 
various PLxxx examples (c.f. amba-pl011) which also reference an AMBA clock
but don't use it.  (The effect being to document what clock the block is
driven by.)

>> +	soc_i2s: i2s at 7ff90000 {
>> +		compatible = "snps,designware-i2s";
>> +		reg = <0x0 0x7ff90000 0x0 0x1000>;
>> +		clocks = <&scpi_i2sclk 0>, <&soc_refclk100mhz>;
>> +		clock-names = "i2sclk", "apb_pclk";
>> +		#sound-dai-cells = <0>;
>> +		dmas = <&dma0 5>;
>> +		dma-names = "tx";
>> +	};
> 
> This omits a lot of configurability that is in platform data and
> replaces it by reading back the parameters from the hardware.  If this
> is a viable approach to that configuration you should do this for both
> platform data and device tree rather than only device tree.  The point
> with keeping platform data is that it's not good to make the device DT
> only, improving the usability of platform data in a way that happens to
> also make the DT case easier is totally fine.  If we can determine how
> the IP is configured from the hardware that's both less work and more
> robust no matter how the device is instantiated.
> 

I agree.  I didn't do it like this originally because it wasn't clear
whether or not the original driver catered for some custom IP and I 
wanted to ensure that I didn't break the existing driver.  I'm happy to
switch both platform data and device tree to reading their parameters
from the hardware.

	Andrew
