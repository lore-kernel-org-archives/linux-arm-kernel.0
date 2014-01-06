From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Mon, 6 Jan 2014 07:39:13 +0000
Subject: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <201401031350.59447.arnd@arndb.de>
References: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
 <3716216.GQHQhxMFvx@wuerfel>
 <bb5e14370ddb4ce2921140d147244097@BY2PR03MB505.namprd03.prod.outlook.com>
 <201401031350.59447.arnd@arndb.de>
Message-ID: <4966a79fc25647708b90d83295ffa1d8@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> 
> Adding Greg here to make sure we have a common understanding in the future.
> 
> ioread*() was indeed introduced for devices that can be both I/O and memory
> space, and is a bit slowed than readl() on architectures that don't have
> memory mapped I/O space (i.e. x86).
> 
> However, ioread32be is the only architecture-independent big-endian
> accessor function (some architectures have in_be32, but that doesn't
> work on ARM), and as mandated by Linus a couple of years ago when
> we wanted to take some shortcuts on powerpc, ioread32 has to be
> semantically the same as readl when used on pointers returned from
> ioremap() rather than ioport_map, and ioread32be is just the
> byte-swapped version of it.
> 
> We have a couple of drivers using ioread* because of the need for
> big-endian data access, and I would continue recommending that unless
> I hear a good argument against it.
> 
> > The big-endian supports is added at v7~v8 patch series.
> 
> Yes, that version looks fine and it avoids the above problem nicely,
> but I'd still like to make sure we come to a conclusion on the problem
> of big-endian I/O accessors.
> 
> 

How about the following ?
-----
+static inline u32 ftm_readl(struct fsl_pwm_chip *fpc, unsigned long reg)
+{
+       if (fpc->big_endian)
+               return ioread32be(fpc->base + reg);
+       else
+               return ioread32(fpc->base + reg);
+}
+
+static inline void ftm_writel(struct fsl_pwm_chip *fpc, u32 val,
+                             unsigned long reg)
+{
+       if (fpc->big_endian)
+               iowrite32be(val, fpc->base + reg);
+       else
+               iowrite32(val, fpc->base + reg);
+}
------

I'll send another version soon.
Does this patch series has other problems needed to fix or revise ?

Thanks,

Best Regards,
Xiubo
