From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Sep 2013 12:41:44 +0100
Subject: kmalloc memory slower than malloc
In-Reply-To: <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
Message-ID: <20130910114144.GB12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 11:54:03AM +0200, Thommy Jakobsson wrote:
> I changed the code in my testprogram and driver to do the same thing in 
> kernelspace as well. And now I don't understand the result. The result 
> stepping through and adding all bytes in a page sized buffer is about 4-5 
> times faster to do in the kernel. This is the times for looping through 
> the buffer 10000 times on a imx6:
> dma_alloc_coherent in kernel   4.256s (s=0)
> kmalloc in kernel              0.126s (s=86700000)
> dma_alloc_coherent userspace   0.566s (s=0)
> kmalloc in userspace          0.566s (s=86700000)
> malloc in userspace          0.566s (s=0)

How many times have you verified this result?

So, the obvious question is: does this kernel have kernel preemption
enabled?

The reason for asking that is that if you have kernel preemption
disabled, while your running your buffer sum, no other thread will get
use of the CPU, so you'll have all the CPU cycles (with the exception
of interrupt handling) to yourself.

That won't be true in userspace.

You may also like to consider giving people the full source to your
tests so that it can be run on other platforms as well.
