From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Sun, 26 May 2013 21:01:53 +0200
Subject: [linux-sunxi] [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c
 driver
In-Reply-To: <20130526132120.GJ17847@lukather>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <51A1E9AA.4000008@schinagl.nl> <20130526132120.GJ17847@lukather>
Message-ID: <51A25C21.2060700@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/13 15:21, Maxime Ripard wrote:

>>> +static void sunxi_i2c_write(struct sunxi_i2c_dev *i2c_dev, u16 reg, u8 value)
>>> +{
>>> +	writel(value, i2c_dev->membase + reg);
>> Why writel? and why without (u32)value? I thought iowrite* where the
>> preferred calls and in this case, wouldn't we want writeb since
>> value is u8?
>
> You're right, value should be a u32 here, thanks for noticing.
>
> For the iowrite* vs write*, there's no consensus, and as such no
> preferred way. write* functions are doing an MMIO only access,
> while iowrite functions can do MMIO and port I/O accesses.
>
> Note that it doesn't change anything on ARM, since there's no port IO on
> ARM.
Ah I see, missinformation on my end. Sorry.

But why write 32 bits? The register is only 8 wide, with the rest being 
'reserved'. Then again, the register IS 32 bits wide and probably will 
haev 32 bits written to it? Correct?

>
>>> +}
>>> +
>>> +static u32 sunxi_i2c_read(struct sunxi_i2c_dev *i2c_dev, u16 reg)
>>> +{
>>> +	return readl(i2c_dev->membase + reg);
>> And here, readl does match the return of u32, but aren't we always
>> reading 8 bits since the TWI Data Register only uses the first 8
>> bits?
>> So wouldn't we want to return u8 and readb?
>
> They are meant to be general purpose accessors, so we shouldn't focus
> only on the data register.
Ah yes, of course.

>
>>
>>> +static int sunxi_i2c_probe(struct platform_device *pdev)
>>> +{
>>> +	struct sunxi_i2c_dev *i2c_dev;
>>> +	struct device_node *np;
>>> +	u32 freq, div_m, div_n;
>>> +	struct resource res;
>> I feel stupid for questioning this, since it only shows my lack of
>> knowledge, but
>> If you declare all the memory here, isn't all the data lost after
>> exiting the _probe function? we pass a pointer to this memory in the
>> of_address_to_resource() function so that fills it, right?
>>
>> Or does after devm_ioremap_resource it no longer matter, since that
>> function got what it needed and useless after?
>
> The struct resource is only there to declare the base address and the
> size of memory address. Once we have mapped it, we don't care about it
> anymore.
Thanks for clarifying that, I will adapt my driver to do the same.
>
> Maxime
>
