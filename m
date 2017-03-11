From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 19:29:09 +0200
Subject: [PATCH v2 2/8] watchdog: s3c2410: Fix infinite interrupt in soft
 mode
In-Reply-To: <20170311172527.16368-3-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-3-krzk@kernel.org>
Message-ID: <20170311172909.5brghl4szwijumtt@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 07:25:21PM +0200, Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  However the interrupt itself was not cleared thus on
> first hit, the system enters infinite interrupt handling loop.
> 
> On Odroid U3 (Exynos4412), when booted with s3c2410_wdt.soft_noboot=1
> argument the console is flooded:
> 	# killall -9 watchdog
> 	[   60.523760] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
> 	[   60.536744] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
> 
> Fix this by writing something to the WTCLRINT register to clear the
> interrupt.  The register WTCLRINT however appeared in S3C6410 so a new
> watchdog quirk and flavor are needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt    |  9 +++++----
>  drivers/watchdog/s3c2410_wdt.c                      | 21 ++++++++++++++++++---
>  2 files changed, 23 insertions(+), 7 deletions(-)
>

This can be ignored, already applied.


Best regards,
Krzysztof
