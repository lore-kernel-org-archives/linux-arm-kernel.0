From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Dec 2011 14:47:29 -0600
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111205202125.GA32592@oksana.dev.rtsoft.ru>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <4EDD1897.4030208@gmail.com>
 <20111205202125.GA32592@oksana.dev.rtsoft.ru>
Message-ID: <4EDD2DE1.1050606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2011 02:21 PM, Anton Vorontsov wrote:
> On Mon, Dec 05, 2011 at 01:16:39PM -0600, Rob Herring wrote:
> [...]
>> At least for DT enabled platforms, we could force "no irq" to be 0 in
>> the DT irq code. Searching the dts files, I found 2 occurrences of IRQ0.
> 
> Please note that there are HW IRQ numbers and "Virtual" IRQ numbers.
> dev->irq and thus the thing that we pass into request_irq() is a
> virtual IRQ thing, a "cookie".
> 
> While in device tree you see real HW IRQ numbers.
> 
> Legal VIRQ is always > 0, while HW IRQ could be >= 0.
> 

If this was all true, then there would be no discussion.

This is what we are working towards, but irq_chips all over the arm tree
do not support any translation or have base fixed at compile time. Only
a few have been converted. And some ARM platforms may never get
converted to DT.

>> Prima2 has timer on IRQ0, and VersatileAB has watchdog on IRQ0. Prima2
>> should be fine currently as it doesn't use the of_irq_* functions to get
>> the timer irq, but that is an issue as it skips any translation.
>> VersatileAB should be okay with the VIC irqdomain support.
> 
> It shouldn't be an issue to use of_irq_*() functions for these IRQs.
> of_irq_*() will remap HW IRQ 0 to some other VIRQ. If it does not do
> this currently, then it's a bug and should be fixed.

I think that's what I'm saying. It's either a bug or incomplete DT
conversion for the platform. Either way, those should get fixed first.

Rob
