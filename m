From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 09:46:59 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <8430D2C750334C98B8E8D1469F2023C7@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<4DB81B9E.3000401@pengutronix.de>
	<8430D2C750334C98B8E8D1469F2023C7@subhasishg>
Message-ID: <201104280946.59789.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011 09:22:49 Subhasish Ghosh wrote:
> On 04/27/2011 03:18 PM, Subhasish Ghosh wrote:
> > My problem is, I am doing something like this:
> >
> > s32 pruss_writel_multi(struct device *dev, u32 offset,
> >                u32 *pdatatowrite, u16 wordstowrite)
> > {
> >        struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
> >        u32 __iomem *paddresstowrite;
> >        u16 i;
> >
> >        paddresstowrite = pruss->ioaddr + offset;
> >
> >        for (i = 0; i < wordstowrite; i++)
> >                iowrite32(*pdatatowrite++, paddresstowrite++);
> >
> >        return 0;
> > }
> >
> > So, if I make paddresstowrite as void, it will not work. The above
> > implementation does not generate any sparse errors though.
> 
> Yes, that why I can work with readb_multi even if I have void __iomen *.
> 
> But, how do I solve this problem. In the above function, I must use u32 
> __iomem * 
> 

I believe you were talking about different things. The code you cited
above looks correct to me. For clarity, I would write the loop as

       for (i = 0; i < wordstowrite; i++)
               iowrite32(pdatatowrite[i], &paddresstowrite[i]);

but your version is just as correct, and I would not complain about it.

It is absolutely valid to pass either a 'void __iomem *' or a 'u32 __iomem *'
into iowrite32(). What is not valid is to cast between a 'void __iomem *'
and a plain 'u32' (no pointer). While that may work in most cases, there
are a lot of reasons why that is considered bad style and you should never
write code like that. I believe that is what Marc was referring to, but you
don't do it in your code.

The initial comments that Marc made were about the return value of the
accessor functions that always return success. Just make those return
void instead. Again, this is unrelated to the pointer types.

	Arnd
