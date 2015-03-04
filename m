From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 14:12:51 +0100
Subject: [PATCHv7 0/4] USB: gadget: atmel_usba_udc: PM driver improvements
In-Reply-To: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54F704D3.5020504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/02/2015 18:54, Sylvain Rochet a ?crit :
> Start clocks on rising edge of the Vbus signal, stop clocks on falling
> edge of the Vbus signal.
> 
> Add suspend/resume with wakeup support.

Hi Felipe,

I think this series by Sylvain is ready for inclusion. Are you able to
take it for the next cycle?

Thank, bye,


> Changes since v6:
>   * Removed single IRQ edge support, which was used to wake up only on 
>     device connection. We don't have yet a clean solution to handle IRQ
>     controller with (at91sam9x5) and without (at91rm9200) single edge 
>     support. Rework PATCH v6 4/5 removed, we don't need this one anymore.
> 
> Changes since v5:
>   * Some boards does not support configuring a GPIO interrupt on a specific
>     edge (rising only or falling only). As suggested added a config boolean
>     to distinguish between boards with and without support
>   * Added a missing mutex_lock()/unlock() in usba_udc_suspend(), we need to
>     protect usba_stop() because usba_start() and usba_stop() can still
>     be called by Vbus IRQ handler.
>   * Rebased the full series on linux-next
>   * Patch cleaning with the help of checkpatch.pl
> 
> Changes since v4:
>   * Now using IRQ_NOAUTOEN flag to remove the unused check for
>     udc->driver is not NULL in the Vbus IRQ.
>   * Reworked the start/stop of clocks on Vbus edges to prepare for
>     suspend/resume support, factorised start and stop procedures
>   * New patch, suspend/resume for USBA with wakeup support
> 
> Changes since v3:
>   * Added stable tag for the first patch
>   * As suggested, removed the unused check for udc->driver is NULL in
>     Vbus IRQ by requesting IRQ after udc->driver is set and by releasing
>     IRQ before udc->driver is cleared
>   * Rebased the core patch of this series against the just explained changes
> 
> Changes since v2:
>   * Use spin_lock_irqsave/unlock_irqrestore instead of spin_lock/unlock in
>     threaded interrupt because we are not in irq context anymore
>   * Removed useless and probably harmful IRQF_NO_SUSPEND from
>     devm_request_threaded_irq() flags
> 
> Changes since v1:
>   * Using a threaded irq and mutex instead of spinclock as suggested
>   * Moved a silently fixed bug in a separate patch (1/2)
> 
> Sylvain Rochet (4):
>   USB: gadget: atmel_usba_udc: Fixed vbus_prev initial state
>   USB: gadget: atmel_usba_udc: Request an auto disabled Vbus signal IRQ
>     instead of an auto enabled IRQ request followed by IRQ disable
>   USB: gadget: atmel_usba_udc: Start clocks on rising edge of the Vbus
>     signal, stop clocks on falling edge of the Vbus signal
>   USB: gadget: atmel_usba_udc: Add suspend/resume with wakeup support
> 
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 208 ++++++++++++++++++++++++--------
>  drivers/usb/gadget/udc/atmel_usba_udc.h |   4 +
>  2 files changed, 159 insertions(+), 53 deletions(-)
> 


-- 
Nicolas Ferre
