From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 08 Dec 2013 00:02:45 +0100
Subject: [REGRESSION,BISECTED] DMA mask issue on ReadyNAS 102 w/ 3.13.0-rc3
Message-ID: <87haakfene.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just pulled 3.13.0-rc3 and was unable to make it boot on my ReadyNAS
102 (Armada 370 based): it kernel panics w/ a missing root fs, because
my sata disk is no more seen. Looking at the log, I get the following:

[   71.855367] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[   71.863498] ahci 0000:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[   71.871650] ahci 0000:01:00.0: Coherent DMA mask 0xffffffffffffffff is larger than dma_addr_t allows
[   71.880806] ahci 0000:01:00.0: Driver did not use or check the return value from dma_set_coherent_mask()?
[   71.890395] ahci 0000:01:00.0: failed to start port 0 (errno=-12)

...

[   72.134901] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   72.140188] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[   72.147631] xhci_hcd 0000:02:00.0: Coherent DMA mask 0xffffffffffffffff is larger than dma_addr_t allows
[   72.157136] xhci_hcd 0000:02:00.0: Driver did not use or check the return value from dma_set_coherent_mask()?
[   72.167072] xhci_hcd 0000:02:00.0: Couldn't initialize memory
[   72.172851] xhci_hcd 0000:02:00.0: can't setup: -12
[   72.177741] xhci_hcd 0000:02:00.0: USB bus 2 deregistered
[   72.183181] xhci_hcd 0000:02:00.0: init 0000:02:00.0 fail, -12
[   72.189031] xhci_hcd: probe of 0000:02:00.0 failed with error -12

3.13.0-rc2 worked just fine so I decided to git-bisect the issue and
ended up on 11a5aa32562e (ARM: dma-mapping: check DMA mask against
available memory).

If it has already been reported and fixed, sorry for the noise.

Cheers,

a+
