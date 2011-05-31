From: andre@bluewatersys.com (Andre Renaud)
Date: Tue, 31 May 2011 14:14:46 +1200
Subject: Freescale i.mx25 SDIO/Libertas issue
In-Reply-To: <4DE2F84D.8080907@bluewatersys.com>
References: <4DE2F84D.8080907@bluewatersys.com>
Message-ID: <4DE44F16.8050407@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/11 13:52, Andre Renaud wrote:
> Hello,
> I am trying to use a Wi2Wi 802.11b/g (W2CBW009S) module attached to an
> i.MX25 cpu, specifically the i.MX25 PDK from freescale, although I've
> also tried it on a DeviceSolutions Topaz i.MX25. However it is unable to
> fully load the driver, leaving me with the following in the logs:
> [   30.149097] libertas_sdio mmc0:0001:1: (unregistered net_device):
> command 0x00a9 timed out
> [   30.153759] libertas_sdio mmc0:0001:1: (unregistered net_device):
> Timeout submitting command 0x00a9
> [   30.158843] libertas_sdio mmc0:0001:1: (unregistered net_device):
> PREP_CMD: command 0x00a9 failed: -110
> [   30.164126] libertas_sdio mmc0:0001:1: (unregistered net_device):
> CMD_FUNC_INIT cmd failed
> This wifi chip is based around the Marvell 8688 core.
> 
> I have also tried using an 8686 device, and in that case it is unable to
> even complete loading the firmware, failing with the following:
> [   14.753132] libertas_sdio: Firmware req_size: 17
> [   14.755713] libertas_sdio: failed to load firmware: -5
> [   14.759272] libertas_sdio: probe of mmc0:0001:1 failed with error -5
> Note: I added the 'req_size: ' debugging message in
> 
> Has anyone successfully used the i.MX25 SDIO controller with anything
> other than straight MMC cards (which seem to work fine in the setup that
> I have)?

If I enable the libertas debugging details, I get some more information:

libertas sdio: waiting for firmware to boot...
mmc0: starting CMD52 arg 10008000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008200 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008200 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008200 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 000010dc 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008200 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 000010fe 00000000 00000000 00000000
libertas sdio: Firmware loaded
mmc0: starting CMD52 arg 80022000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 80022201 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001001 00000000 00000000 00000000
mmc0: starting CMD52 arg 10008600 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001005 00000000 00000000 00000000
mmc0: starting CMD52 arg 9000080f flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 0000100f 00000000 00000000 00000000
libertas sdio: send function INIT command
libertas cmd: DNLD_CMD: command 0x00a9, seq 1, size 8
mmc0: starting CMD52 arg 10004000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001009 00000000 00000000 00000000
mmc0: starting CMD53 arg 9200000c flags 000001b5
mmc0:     blksz 12 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
mmc0: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc0:     12 bytes transferred: 0
libertas_sdio mmc0:0001:1: (unregistered net_device): command 0x00a9
timed out
libertas_sdio mmc0:0001:1: (unregistered net_device): Timeout submitting
command 0x00a9
libertas_sdio mmc0:0001:1: (unregistered net_device): PREP_CMD: command
0x00a9 failed: -110
libertas_sdio mmc0:0001:1: (unregistered net_device): CMD_FUNC_INIT cmd
failed

This seems to imply that the unit is correctly loading the firmware, and
then when it determines that the firmware has loaded, and tries to issue
the CMD_FUNC_INIT command, this times out.

Can anyone explain how I can begin debugging this, or confirm if they've
had this operate on the sdhci-esdhc-imx controller present in the i.MX25?

Regards,
Andre
