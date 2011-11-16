From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Nov 2011 08:50:44 -0600
Subject: [PATCH 1/3] ARM: omap_device: handle first time activation of
 console device
In-Reply-To: <1321441346-19591-2-git-send-email-rnayak@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com>
 <1321441346-19591-2-git-send-email-rnayak@ti.com>
Message-ID: <4EC3CDC4.7000108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2011 05:02 AM, Rajendra Nayak wrote:
> console device on OMAP is never reset or idled by hwmod post
> initial setup, early during boot, for obvious reasons not to
> break early debug prints thrown on console.
> This leaves the console device enabled at boot and the first activation
> of it using hwmod needs to be handled in such a way that a disable is
> called followed by an enable of the hwmod, the subsequent activations
> can then use the default activation technique.
> 
> To handle this add a new binding to identify a hwmod which is used as
> the console device.
> 
> This patch is based on the what is done in serial.c for non-DT builds.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |    1 +
>  arch/arm/plat-omap/omap_device.c                   |   33 +++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index dbdab40..46ffd41 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -21,6 +21,7 @@ Required properties:
>  Optional properties:
>  - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
>    during suspend.
> +- ti,console_hwmod: boolean, identifies the hwmod used as console device
>  

This doesn't seem right. Which console is not a h/w property. Why can't
you use aliases like other platforms are doing?

Also, it's not clear in the documentation where this (and
ti,no_idle_on_suspend) should go in the DT. Both seem like they should
be kernel cmdline params.

Rob
