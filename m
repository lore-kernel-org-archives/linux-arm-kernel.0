From: thommyj@gmail.com (Thommy Jakobsson)
Date: Tue, 10 Sep 2013 14:54:49 +0200 (CEST)
Subject: kmalloc memory slower than malloc
In-Reply-To: <20130910114144.GB12758@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <20130910114144.GB12758@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1309101442400.1305@kelly.ryd.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 10 Sep 2013, Russell King - ARM Linux wrote:

> On Tue, Sep 10, 2013 at 11:54:03AM +0200, Thommy Jakobsson wrote:
> > I changed the code in my testprogram and driver to do the same thing in 
> > kernelspace as well. And now I don't understand the result. The result 
> > stepping through and adding all bytes in a page sized buffer is about 4-5 
> > times faster to do in the kernel. This is the times for looping through 
> > the buffer 10000 times on a imx6:
> > dma_alloc_coherent in kernel   4.256s (s=0)
> > kmalloc in kernel              0.126s (s=86700000)
> > dma_alloc_coherent userspace   0.566s (s=0)
> > kmalloc in userspace          0.566s (s=86700000)
> > malloc in userspace          0.566s (s=0)
> 
> How many times have you verified this result?
I havent done any scientific study, but at least 20 times with restarts in 
between. I got a similar result on another hw as well, but haven't checked 
what kernel or config I was running there. So might not be the same thing. 
Also each buffer is looped 10000 times, which I assume would remove the 
most severe randomness a least.

> So, the obvious question is: does this kernel have kernel preemption
> enabled?
> 
> The reason for asking that is that if you have kernel preemption
> disabled, while your running your buffer sum, no other thread will get
> use of the CPU, so you'll have all the CPU cycles (with the exception
> of interrupt handling) to yourself.
> 
> That won't be true in userspace.

It should be enabled
zcat /proc/config.gz | grep PREEM
CONFIG_TREE_PREEMPT_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y

I wouldn't be surprised if doing things in the kernel are quicker, its 
just the amount that surprise me.

> 
> You may also like to consider giving people the full source to your
> tests so that it can be run on other platforms as well.
>
Sure thing, I didn't include it in the mail to avoid cluttering it down to 
much. One can find it here:
https://github.com/thommyj/buf-speedtest


Thanks,
Thommy 
