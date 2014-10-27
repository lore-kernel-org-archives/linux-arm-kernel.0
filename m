From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Oct 2014 11:45:44 -0500
Subject: [PATCH v3] rtc: omap: add support for pmic_power_en
In-Reply-To: <1414397368-26480-1-git-send-email-johan@kernel.org>
References: <1413913086-12730-1-git-send-email-johan@kernel.org>
 <1414397368-26480-1-git-send-email-johan@kernel.org>
Message-ID: <20141027164544.GI14253@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 09:09:28AM +0100, Johan Hovold wrote:
> Add new property "ti,system-power-controller" to register the RTC as a
> power-off handler.
> 
> Some RTC IP revisions can control an external PMIC via the pmic_power_en
> pin, which can be configured to transition to OFF on ALARM2 events and
> back to ON on subsequent ALARM (wakealarm) events.
> 
> This is based on earlier work by Colin Foe-Parker and AnilKumar Ch. [1]
> 
> [1] https://www.mail-archive.com/linux-omap at vger.kernel.org/msg82127.html
> 
> Tested-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes since v2:
>  - add two-second delay to allow alarm to trigger before returning
> 
> Andrew, can you replace just this patch in the series that you already
> have in your tree, or do you prefer I resend the whole series (with
> Felipe's Tested-by tags)?
> 
> Thanks,
> Johan
> 
> 
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  9 +-
>  drivers/rtc/rtc-omap.c                             | 95 ++++++++++++++++++++++
>  2 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index 5a0f02d34d95..750efd40c72e 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -5,11 +5,17 @@ Required properties:
>  	- "ti,da830-rtc"  - for RTC IP used similar to that on DA8xx SoC family.
>  	- "ti,am3352-rtc" - for RTC IP used similar to that on AM335x SoC family.
>  			    This RTC IP has special WAKE-EN Register to enable
> -			    Wakeup generation for event Alarm.
> +			    Wakeup generation for event Alarm. It can also be
> +			    used to control an external PMIC via the
> +			    pmic_power_en pin.
>  - reg: Address range of rtc register set
>  - interrupts: rtc timer, alarm interrupts in order
>  - interrupt-parent: phandle for the interrupt controller
>  
> +Optional properties:
> +- ti,system-power-controller: whether the rtc is controlling the system power

isn't there a discussion going on to drop the vendor prefix ? I wonder
if we should just use the final binding to avoid supporting this for
rtc-omap too. OTOH, all of that can be hidden under
of_is_system_power_controller() itself.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/213f7a3f/attachment.sig>
