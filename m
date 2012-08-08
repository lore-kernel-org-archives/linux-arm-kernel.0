From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Aug 2012 12:40:38 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120808094952.GH16861@opensource.wolfsonmicro.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
 <20120808080411.GB4728@gmail.com>
 <20120808094952.GH16861@opensource.wolfsonmicro.com>
Message-ID: <20120808114037.GB8227@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 10:49:52AM +0100, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 09:04:12AM +0100, Lee Jones wrote:
> 
> > During non-DT boot:
> >  - Platform data is passed, which contains an IRQ base
> >  - If an IRQ base is requested we use it to register a Legacy IRQ Domain
> >  - MFD adds the IRQ base to the hwirq and registers it as a virq
> 
> Just don't do this step - the only reason to do it is for mapping back
> into a linear domain but if you're going to do this...
> 
> >  - AB8500 child devices use *_get_virq() to convert virq to virq - *ERROR*
> 
> ...then it's redundant.  The mapping functions in the domain code
> replace this functionality.

No, the other way round. This is now required all the time.

Now we force the use of hwirq, the driver needs to convert that into a
virq before requesting the resource. So we need to put *_get_virq()'s into
every child device that requests an IRQ.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
