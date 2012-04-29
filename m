From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 29 Apr 2012 13:16:38 -0600
Subject: Tegra board file deprecation schedule
In-Reply-To: <1388911.4olGsS8Z0g@ax5200p>
References: <4F9B0E7C.1060408@wwwdotorg.org> <6014194.Op4vnW6Cge@ax5200p>
 <20120428213456.GD27792@n2100.arm.linux.org.uk> <1388911.4olGsS8Z0g@ax5200p>
Message-ID: <4F9D9396.9070009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2012 12:11 PM, Marc Dietrich wrote:
> On Saturday 28 April 2012 22:34:56 Russell King - ARM Linux wrote:
>> On Sat, Apr 28, 2012 at 06:09:32PM +0200, Marc Dietrich wrote:
>>> Another (maybe a bit off-topic) thing that puzzels me is the how to assign
>>> the clock to the nvec.
>>
>> What's the nvec?
> 
> it is the embedded controller used on many first gen tegra2 boards 
> (drivers/staging/nvec). Do you remember commit 55dc6ee7 ?
> 
>>> The device needs the clock (tegra-i2c.2) but there is no sane way to get
>>> it. I was thinking to add an device name alias (nvec = tegra-i2c.2) to
>>> the board file so I can use clk_get(&pdev->dev, NULL) instead of
>>> clk_get_sys which seems to be unwanted.
>>
>> clk_get() is preferred in drivers which have struct device's to get them.
>> And if you know the device name, then I see no problem with the aliasing
>> approach.
> 
> I'm just looking for a way to use clk_get if two devices, tegra-i2c and nvec 
> (or tegra-i2c-slave in the future) share the same clock. 

Oh, you mean the I2C controller clock.

The correct approach here is to remove all the I2C logic from the NVEC
driver and add I2C slave support to the real I2C driver. Then, NVEC
becomes just a protocol driver for the slave transactions. Then, there
is no clock to deal with.
