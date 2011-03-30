From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 12:59:28 +0200
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <17BF3847C06240EC921FB684D3120DEC@subhasishg>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<201103111628.57549.arnd@arndb.de>
	<17BF3847C06240EC921FB684D3120DEC@subhasishg>
Message-ID: <201103301259.28483.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2011, Subhasish Ghosh wrote:
> 
> >> +s32 pruss_disable(struct device *dev, u8 pruss_num)
> >> +{
> >> + struct da8xx_pruss *pruss = dev_get_drvdata(dev->parent);
> >> + struct da8xx_prusscore_regs *h_pruss;
> >> + struct pruss_map *pruss_mmap = (struct pruss_map *)pruss->ioaddr;
> >> + u32 temp_reg;
> >> + u32 delay_cnt;
> >
> > Can you explain the significance of pruss_num? As far as I
> > can tell, you always pass constants in here, so it should
> > be possible to determine the number from the device.
> 
> SG - The number is not programmed in the device, I need something to decide 
> which PRU to disable or enable.

I still don't understand. Please explain how the devices
relate to the multiple PRUs in hardware. 

> >> + for (loop = 0; loop < bytestowrite; loop++)
> >> + __raw_writeb(*pdatatowrite++, paddresstowrite++);
> >> +
> >> + return 0;
> >> +}
> >> +EXPORT_SYMBOL(pruss_writeb);
> >
> > I would recommend providing a simpler variant of your all I/O accessors,
> > which write a single word. Most of the users of these simply
> > pass bytestowrite=1 anyway, so the caller can become more readable.
> 
> SG - At some sections in the code I am using upto 8 bytescount.
>             If its ok, I would want to keep it as is.

You can of course have both, but I would recommend making the common
case simpler by providing a version that writes just one word.

	Arnd
