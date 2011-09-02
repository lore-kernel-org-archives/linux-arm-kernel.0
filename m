From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 02 Sep 2011 16:16:03 +0100
Subject: [PATCH 5/5] mach-ux500: add a SoC ID (serial) callback for the
	u8500
In-Reply-To: <201109021622.50591.arnd@arndb.de>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<1314880043-22517-5-git-send-email-lee.jones@linaro.org>
	<201109021622.50591.arnd@arndb.de>
Message-ID: <4E60F333.1010902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/11 15:22, Arnd Bergmann wrote:
> On Thursday 01 September 2011, Lee Jones wrote:
>> +static const char *db8500_get_soc_id(void)
>> +{
>> +       void __iomem *uid_base;
>> +       char buf[1024];
>> +       ssize_t sz = 0;
>> +       int i;
>> +
>> +       uid_base = __io_address(U8500_BB_UID_BASE);
>> +       for (i = 0; i < U8500_BB_UID_LENGTH; i++) {
>> +               sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
>> +       }
>> +       return kasprintf(GFP_KERNEL, "%s", buf);
>> +}
> 
> You will get a warning from the stack checker here, about putting a 1024 byte string
> on the stack. Also, I still think it's bad to just access the U8500_BB_UID_BASE
> from a compile-time constant. Since this gets called from a function that knows
> the base address of the DB8500 register area, better pass the device in there
> so that you end up with something like
> 
> static void __devinit db8500_read_soc_id(struct db8500_dev *dev)
> {
> 	u32 __iomem *uid = dev->base + U8500_BB_UID_OFFSET;
> 	snprintf(dev->soc_id, sizeof (dev->soc_id), "%08x%08x%08x%08x%08x",
> 		readl(uid[0]), readl(uid[1]), readl(uid[2]), readl(uid[3]), readl(uid[4]));
> }

No problem.

Where did you get dev->base from though?

> The style you use here is preexisting in the db8500 code, but you should
> not keep adding more of that crap. 

Not meaning to pass the buck at all, but this isn't my code.

It's remnant from when I took this over (starting to wish I hadn't ;))

> All the code like 
> #define db8500_add_i2c0(pdata) \
>         dbx500_add_i2c(0, U8500_I2C0_BASE, IRQ_DB8500_I2C0, pdata)
> #define db8500_add_i2c1(pdata) \
>         dbx500_add_i2c(1, U8500_I2C1_BASE, IRQ_DB8500_I2C1, pdata)
> 
> should never really have been there. What you want to do for this is
> to call this from the code that initializes the db8500 controller, and
> pass the board specific pdata into the db8500 init function, along
> with the i2c client data.

Not my domain. Speak to Linus W. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
