From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 26 Jul 2018 09:09:18 +0200
Subject: next/master boot: 171 boots: 6 failed, 162 passed with 3 offline
 (next-20180724)
In-Reply-To: <20180725161151.GA340@sirena.org.uk>
References: <5b5757ee.1c69fb81.411a5.52e2@mx.google.com>
 <20180725161151.GA340@sirena.org.uk>
Message-ID: <6b5a8c5c-8483-22f1-cc09-e12bd7740f10@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thanks for forwarding. Unfortunately i don't have the time for real 
investigation until next week, so here some remote diagnostics.


Am 25.07.2018 um 18:11 schrieb Mark Brown:
> On Tue, Jul 24, 2018 at 09:46:38AM -0700, kernelci.org bot wrote:
>
> For a little while now the RPi B has been failing to boot using the
> bcm2835 defconfig in -next:
>
>>      bcm2835_defconfig:
>>          bcm2835-rpi-b:
>>              lab-baylibre-seattle: failing since 5 days (last pass: next-20180718 - first fail: next-20180719)
>>          bcm2837-rpi-3-b:
>>              lab-baylibre: failing since 5 days (last pass: next-20180718 - first fail: next-20180719)
> It's working fine on arm64, whatever's going on appears to be specific
> to this config (it's not getting booted with any other 32 bit configs).
> Full info and boot logs for one of the boards here:
>
>     https://kernelci.org/boot/id/5b58416759b514139596baae/
>
> it looks like it hangs somewhere shortly after or during initializing
> MMC so never makes it to the console, the tail of the failing logs looks
> like:
>
> | 09:18:36.332120  [    1.459801] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> | 09:18:36.345711  [    1.467585] mmcblk0: mmc0:59b4 USD   7.51 GiB
> | 09:18:36.346169  [    1.474834]  mmcblk0: p1
> | 09:18:36.410184  [    1.539600] random: fast init done
> | 09:18:36.458065  [    1.578056] mmc1: new high speed SDIO card at address 0001
> | 09:20:39.745370  ShellCommand command timed out.: Sending # in case of corruption. Connection timeout 00:04:10, retry in 00:02:05
> | 09:20:39.846848  #
>
> but like I say the same -next boots with arm64 defconfig.
>

There is at least 1 difference between bcm2835_defconfig and arm64 
defconfig. bcm2835_defconfig uses DMA

[ 1.265671] sdhost-bcm2835 3f202000.mmc: loaded - DMA enabled (>1)

while arm64 defconfig uses PIO mode for SD interface mmc0 (please ignore 
mmc1 since it's the onboard wifi and it uses a different driver):

[ 1.907766] sdhost-bcm2835 3f202000.mmc: unable to initialise DMA 
channel. Falling back to PIO
[ 1.995407] sdhost-bcm2835 3f202000.mmc: loaded - DMA disabled

The reason for this output is expected, because the DMA driver isn't 
build-in for this config.

I think this issue is DMA related.

Regards Stefan
