From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Jan 2015 14:34:20 +0100
Subject: [PATCHv5 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
In-Reply-To: <1421619935-5022-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150118211728.GA21128@gradator.net>
 <1421619935-5022-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54BD07DC.6020802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/01/2015 23:25, Sylvain Rochet a ?crit :
> USB: host: Atmel OHCI and EHCI drivers improvements
> 
> Suspend/resume support for EHCI.
> struct dev_pm_ops for OHCI.
> Removed global variables from both.
> Fixed OHCI wake up support for STANDBY(wake-up enabled) and MEM(wake-up 
> disabled) sleep targets.

I'm okay with the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Alan,
It seems that Boris and Alexandre also add their tag to the series
already. Do you want us to collect them in a new series sent to you?

Sylvain,
Thanks a lot for this nice series built at a high pace ;-)
Even if I'm not sure to keep the separation between "slow clock" PM and
"normal" PM on AT91 but more likely to use the "slow clock" for all the
PM modes, let's go forward with this step for now. I mean, we will
certainly rework this at91_suspend_entering_slow_clock() aspect in the
future.

Bye,

> Changes since v4:
>   * Re-add at91_suspend_entering_slow_clock() to OHCI, we can't naively
>     remove this one, this device needs to be continuously clocked to
>     provide wake up support.
>     The removal of at91_suspend_entering_slow_clock() actually lighted up
>     an issue on wake up support, which is now fixed.
> 
> Changes since v3:
>   * Using struct dev_pm_ops instead of static struct platform_driver
>     resume and suspend bindings for both EHCI and OHCI
>   * Fixed inconsistency in patch subjects, _ intead of - for file names
>   * Patch cleaning with the help of checkpatch.pl, fixed lines over
>     80 characters
> 
> Changes since v2:
>   * Added patchs from an other submission, because this series
>     depended on this one
>     * EHCI: Move global variables to private struct
>     * OHCI: Move global variables to private struct
>   * Using ohci->priv and ehci->priv instead of hcd->hcd_priv,
>     which were not the right way to do that
> 
> Changes since v1:
>   * Don't use at91_suspend_entering_slow_clock() on EHCI,
>     we are trying to get read of this of this function
>   * Removed at91_suspend_entering_slow_clock() from OHCI
> 
> Sylvain Rochet (6):
>   USB: host: ehci-atmel: Add suspend/resume support
>   USB: host: ohci-at91: Use struct dev_pm_ops instead of struct
>     platform_driver
>   USB: host: ehci-atmel: Move global variables to private struct
>   USB: host: ohci-at91: Fix wake-up support
>   USB: host: ohci-at91: Move global variables to private struct
>   USB: host: ohci-at91: usb_hcd_at91_probe(), remove useless stack
>     initialisation
> 
>  drivers/usb/host/ehci-atmel.c | 102 ++++++++++++++++++++++++++---------
>  drivers/usb/host/ohci-at91.c  | 120 +++++++++++++++++++++++++-----------------
>  2 files changed, 150 insertions(+), 72 deletions(-)
> 


-- 
Nicolas Ferre
