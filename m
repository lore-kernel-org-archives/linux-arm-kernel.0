From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Dec 2017 16:11:07 -0200
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171212173450.GD10595@n2100.armlinux.org.uk>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Dec 12, 2017 at 3:34 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> It's fundamentally unsafe.
>
> You need to test with CONFIG_BL_SWITCHER enabled - there's spinlocks
> in smp_call_function_single() path that are conditional on that symbol.
> If CONFIG_BL_SWITCHER is disabled, then the spinlocks are not present.

Ok, just tested with CONFIG_BL_SWITCHER=y on a imx6q-cubox-i:

# echo enabled > /sys/class/tty/ttymxc0/power/wakeup
# echo mem > /sys/power/state
[   10.503462] PM: suspend entry (deep)
[   10.507479] PM: Syncing filesystems ... done.
[   10.555024] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   10.564511] OOM killer disabled.
[   10.567760] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) d.
[   10.577420] Suspending console(s) (use no_console_suspend to debug)
[   10.657748] PM: suspend devices took 0.080 seconds
[   10.669329] Disabling non-boot CPUs ...
[   10.717049] IRQ17 no longer affine to CPU1
[   10.837141] Enabling non-boot CPUs ...
[   10.839386] CPU1 is up
[   10.840342] CPU2 is up
[   10.841300] CPU3 is up
[   11.113735] mmc0: queuing unknown CIS tuple 0x80 (2 bytes)
[   11.115676] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[   11.117595] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[   11.121014] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[   11.124454] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[   11.177299] ata1: SATA link down (SStatus 0 SControl 300)
[   11.181930] PM: resume devices took 0.330 seconds
[   11.243729] OOM killer enabled.
[   11.246886] Restarting tasks ... done.
[   11.253012] PM: suspend exit
