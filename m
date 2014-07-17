From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jul 2014 12:20:45 -0500
Subject: [RFC PATCH] usb: dwc3: core: allow vendor drivers to check probe
 status
In-Reply-To: <1405617213-27360-1-git-send-email-lee.jones@linaro.org>
References: <1405617213-27360-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140717172045.GM10459@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 17, 2014 at 06:13:33PM +0100, Lee Jones wrote:
> This patch provides mechanism for subordinate devices to check
> whether the DWC3 core probed successfully or otherwise.  Useful
> if PHYs are required to configure controllers, but aren't yet
> available.  The DWC3 core driver will defer probe if PHYs are
> unavailable, however subordinate DWC3 drivers currently do not
> have any visibility or means to check status - until now.

what's a subordinate DWC3 driver ?

> Another way to do this would be to *_phy_get*(), but if every
> driver did this it would create a high level of code
> duplication.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/dwc3/core.c | 12 ++++++++++++
>  drivers/usb/dwc3/core.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index eb69eb9..171ca52 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -47,6 +47,14 @@
>  
>  /* -------------------------------------------------------------------------- */
>  
> +static bool is_enabled = false;
> +
> +int dwc3_is_enabled(void)
> +{
> +	return is_enabled;
> +}
> +EXPORT_SYMBOL(dwc3_is_enabled);

no, no, no, no. Let me try that again, hello no! You _do_ realise there
are systems with more than one dwc3 instance, right ? And this is the
most fragile possible way of doing this.

You never explained what's a dwc3 subordinate driver, you don't show any
example of how this would be used and why/where does the PHY need to
poke into DWC3. Why isn't probe defer enough for you ? Which platform
are you working on ? what is the problem that you're trying to solve ?

>From this patch, all I can is NAK this patch with no mercy, sorry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/7fe3e7f3/attachment.sig>
