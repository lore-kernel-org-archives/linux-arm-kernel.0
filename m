From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 1 Oct 2018 17:57:04 +0200
Subject: [PATCH] ARM: dts: sun7i: Disable OOB IRQ for brcm wifi on
 Cubietruck and Banana Pro
In-Reply-To: <20180930150927.12076-1-hdegoede@redhat.com>
References: <20180930150927.12076-1-hdegoede@redhat.com>
Message-ID: <20181001155704.dcqp637vsp2myyph@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

It's been a while :)

On Sun, Sep 30, 2018 at 05:09:27PM +0200, Hans de Goede wrote:
> While doing some brcmfmac driver work I needed to test this also on some
> devicetree based boards. So I fired up the good old Cubietruck and when
> that would not work a Banana Pro.
> 
> With an unmodified 4.17 kernel both boards intermittently would come up
> with non working wifi with the following errors:
> 
>  brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>  brcmfmac: brcmf_bus_started: failed: -110
>  brcmfmac: brcmf_attach: dongle is not responding: err=-110
>  brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> 
> They would come up this way more often then with actual working wifi,
> once this problem happens it seems to require a power-cycle to fix.
> Once things work one can safely reboot without hitting the issue.
> 
> I've found that disabling OOB interrupts fixes this. This really is more
> of a workaround then a proper fix, but it makes the wifi reliable again
> and it does not have much of a downside.
> 
> Using an OOB IRQ instead of the sdio-IRQ mechanism is mostly important to
> allow the MMC controller to go into runtime-suspend which is not really an
> issue on these boards since they are (usually) not battery powered.
> 
> I've looked at recent brcmfmac and mmc-core changes which may explain this
> and I've not found anything. So the most likely culprit is the A20 external
> interrupt handling e.g. perhaps it is set to edge instead of level? Either
> way I do not have time to further investigate this.
> 
> BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908438
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Unfortunately, I'd really prefer if we were fixing this properly. You
were saying that the regression has been introduced between 4.17 and
4.18, have you been able to bisect which commit was actually creating
this regression?

As you suggested, one reason could be the runtime_pm
introduction. This can be pretty easily tested by adding a
pm_runtime_get_sync call in the probe.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
