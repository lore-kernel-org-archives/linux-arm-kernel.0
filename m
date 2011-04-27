From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 27 Apr 2011 18:48:54 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <20110427091252.GP17290@n2100.arm.linux.org.uk>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-2-git-send-email-subhasish@mistralsolutions.com>
	<4DB1A603.2090208@pengutronix.de>
	<EDC1056430EF4DA8A0D850CE1DEA28FC@subhasishg>
	<4DB7C5F7.3080103@pengutronix.de>
	<20110427091252.GP17290@n2100.arm.linux.org.uk>
Message-ID: <5BAE2D6F9E6047C19B6BE8FF26F7270B@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My problem is, I am doing something like this:

s32 pruss_writel_multi(struct device *dev, u32 offset,
                u32 *pdatatowrite, u16 wordstowrite)
{
        struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
        u32 __iomem *paddresstowrite;
        u16 i;

        paddresstowrite = pruss->ioaddr + offset;

        for (i = 0; i < wordstowrite; i++)
                iowrite32(*pdatatowrite++, paddresstowrite++);

        return 0;
}

So, if I make paddresstowrite as void, it will not work. 
The above implementation does not generate any sparse errors though.


> On Wed, Apr 27, 2011 at 09:29:59AM +0200, Marc Kleine-Budde wrote:
>> On 04/27/2011 08:39 AM, Subhasish Ghosh wrote:
>> > - Is it ok to have u32 etc for __iomem cookie ?
>> 
>> no - "void __iomem *" is "void __iomem *"
> 
> Actually, it is _provided_ you don't directly dereference it.  You can
> then do pointer arithmetic on it in the usual way - which is about the
> only valid thing to do with an __iomem pointer.  The voidness just acts
> as an additional check against direct dereferences of this.
> 
> The important thing though is that the code passes sparse checks. 
