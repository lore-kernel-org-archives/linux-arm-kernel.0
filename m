From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 11 Feb 2016 19:17:13 -0800
Subject: [PATCH 4/7] serial: 8250_omap: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <1455145370-20301-5-git-send-email-tony@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-5-git-send-email-tony@atomide.com>
Message-ID: <20160212031713.GB10157@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 03:02:47PM -0800, Tony Lindgren wrote:
> Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind") introduced pm_runtime_reinit() that is used
> to reinitialize PM runtime after -EPROBE_DEFER. This allows shutting
> down the device after a failed probe.
> 
> However, for drivers using pm_runtime_use_autosuspend() this can cause
> a state where suspend callback is never called after -EPROBE_DEFER.
> On the following device driver probe, hardware state is different from
> the PM runtime state causing omap_device to produce the following
> error:
> 
> omap_device_enable() called from invalid state 1
> 
> And with omap_device and omap hardware being picky for PM, this will
> block any deeper idle states in hardware.
> 
> The solution is to fix the drivers to follow the PM runtime documentation:
> 
> 1. For sections of code that needs the device disabled, use
>    pm_runtime_put_sync_suspend() if pm_runtime_set_autosuspend() has
>    been set.
> 
> 2. For driver exit code, use pm_runtime_dont_use_autosuspend() before
>    pm_runtime_put_sync() if pm_runtime_use_autosuspend() has been
>    set.
> 
> Fixes: 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind")
> Cc: linux-serial at vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Greg & Peter, I'd like to merge this along with other related fixes
> via the ARM SoC tree if no objections, please review and ack if this
> look OK to you.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
