From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 Mar 2011 17:23:15 -0800
Subject: CONFIG_ARM_DMA_MEM_BUFFERABLE and readl/writel weirdness
Message-ID: <4D6D9C03.2080906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Catalin,

In arch/arm/include/asm/io.h, we have the following piece of code:

#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
#define __iormb()               rmb()
#define __iowmb()               wmb()
#else
#define __iormb()               do { } while (0)
#define __iowmb()               do { } while (0)
#endif

#define readb(c)                ({ u8  __v = readb_relaxed(c); 
__iormb(); __v; })
#define readw(c)                ({ u16 __v = readw_relaxed(c); 
__iormb(); __v; })
#define readl(c)                ({ u32 __v = readl_relaxed(c); 
__iormb(); __v; })

#define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
#define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
#define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })

If I'm not missing some magic, this would mean that 
"CONFIG_ARM_DMA_MEM_BUFFERABLE" determines if readl(s)/writel(s) get to 
have a built in mb() or not.

The rest of the emails is under the assumption that my statement above 
is true.

This seems like a real bad thing to do.

There are so many other drivers that don't use or care about DMA and 
might still want to ensure some ordering constraints between their 
readl(s)/writel(s). They can't depend on readl/writel taking care of it 
for them since their code could be used in a kernel configuration that 
doesn't enable this config.

Firstly, I don't know how many people noticed this and realize they 
can't depend on readl/writel to take care of the mb()s for them. Seems 
like an unnecessary encouragement to make mistakes when it didn't need 
to be so.

Secondly, even if they realize they have to take care of it, they will 
have to continue using mb()s in to force ordering between their 
reads/writes. So, are we depending on the compiler to optimize these 
extra mb() out in the case where the config is enabled? I'm not sure it 
will be able to optimize out the extra mb()s in all cases.

Please let me know if I'm missing something and there is a good reason 
for writing the code as it is today. If there is not much of a reason 
for this, do you have any objections if I send a patch to split out the 
"readl/writel with built in mb()" as a separate config and 'select'ing 
it in ARM_DMA_MEM_BUFFERABLE?

Thanks,
Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
