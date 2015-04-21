From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 22 Apr 2015 00:09:42 +0200
Subject: [rtc-linux] [PATCH 1/5] RTC/i.MX/DryIce: add some background
 info about the states the machine can be in
In-Reply-To: <1429002716-19821-2-git-send-email-jbe@pengutronix.de>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <1429002716-19821-2-git-send-email-jbe@pengutronix.de>
Message-ID: <20150421220942.GB8539@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2015 at 11:11:52 +0200, Juergen Borleis wrote :
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
> [rsc: got NDA clearance from Freescale]
> ---
>  drivers/rtc/rtc-imxdi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> index c666eab..8750477 100644
> --- a/drivers/rtc/rtc-imxdi.c
> +++ b/drivers/rtc/rtc-imxdi.c
> @@ -129,6 +129,49 @@ struct imxdi_dev {
>  	struct work_struct work;
>  };
>  
> +/* Some background:
> + *
> + * The DryIce unit is a complex security/tamper monitor device. To be able do
> + * its job in a useful manner it runs a bigger statemachine to bring it into
> + * security/tamper failure state and once again to bring it out of this state.
> + *
> + * This unit can be in one of three states:
> + *
> + * - "NON-VALID STATE"
> + *   always after the battery power was removed
> + * - "FAILURE STATE"
> + *   if one of the enabled security events have happend
                                 has happened ^
> + * - "VALID STATE"
> + *   if the unit works as expected
> + *
> + * Everything stops when the unit enters the failure state including the RTC
> + * counter (to be able to detect the time the security event happend).
                                                       happened ^
> + *
> + * The following events (when enabled) let the DryIce unit enter the failure
> + * state:
> + *
> + * - wire-mesh-tamper detect
> + * - external tamper B detect
> + * - external tamper A detect
> + * - temperature tamper detect
> + * - clock tamper detect
> + * - voltage tamper detect
> + * - RTC counter overflow
> + * - monotonic counter overflow
> + * - external boot
> + *
> + * If we find the DryIce unit in "FAILURE STATE" and the TDCHL cleared, we
> + * can only detect this state. In this case the unit is completely locked and
> + * must force a second "SYSTEM POR" to bring the DryIce into the
> + * "NON-VALID STATE" + "FAILURE STATE" where a recovery is possible.
> + * If the TDCHL is set in the "FAILURE STATE" we are out of luck. In this case
> + * a battery power cycle is required.
> + *
> + * In the "NON-VALID STATE" + "FAILURE STATE" we can clear the "FAILURE STATE"
> + * and recover the DryIce unit. By clearing the "NON-VALID STATE" as the last
> + * task, we bring back this unit into life.
> + */
> +
>  /*
>   * enable a dryice interrupt
>   */
> -- 
> 2.1.4
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
