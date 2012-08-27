From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 27 Aug 2012 13:06:29 -0700
Subject: [PATCH 2/6] brcmfmac: Handling the interrupt in ISR directly
 for non-OOB
In-Reply-To: <503B9F31.5050502@broadcom.com>
References: <1346063114-30361-1-git-send-email-wni@nvidia.com>
 <1346063114-30361-3-git-send-email-wni@nvidia.com>
 <503B9F31.5050502@broadcom.com>
Message-ID: <503BD345.6030501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2012 09:24 AM, Arend van Spriel wrote:
> On 08/27/2012 12:25 PM, Wei Ni wrote:
>> In case of inband interrupts, if we handle the interrupt in dpc thread,
>> two level of thread switching takes place to process wifi interrupts.
>> One in SDHCI driver and the other in Wifi driver. This may cause the
>> system
>> instability.
> 
> Looking into the sdhci/mmc code indeed shows that the brcmfmac irq
> handler is not called in true IRQ context. So the dpc thread may add
> unnecessary complexity, but to me there is not indication that there is
> a stability issue.
> 
>> Because the SDHCI calls sdio_irq_thread() to handle the irq, this
>> thread locks
>> mmc host and calls wifi handler. It expects WiFi handler to be quick and
>> enables sdio interrupt from card at end. If wifi handler defers this
>> work for
>> a different thread, sdio_irq_thread() will be stuck on next wifi
>> interrupt
>> since mmc lock is not freed.
> 
> Not sure if I can follow this explanation. The isr is called with host
> claimed (by sdio_irq_thread) and all it does is at a linked list member
> and signal the dpc thread. After doing this the host is released.

Is the issue something like the ISR handler or first level of threading
does:

* Trigger DPC
* Re-enable interrupt

So that the interrupt then fires again before the triggered DPC can run
to handle/clear it, thus causing an interrupt storm?

Whereas handling the interrupt directly prevents this race condition?
