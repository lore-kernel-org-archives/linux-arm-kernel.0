From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 19 Nov 2016 12:36:11 +0100 (CET)
Subject: Low network throughput on i.MX28
In-Reply-To: <1479512941.5577.1.camel@embedded.rocks>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
 <20161014081349.1afb22c6@ipc1.ka-ro>
 <1476521171.1670.2.camel@embedded.rocks>
 <2131339088.8778.d47a56f6-921e-4d6c-9a5c-2e77bfd5d281.open-xchange@email.1und1.de>
 <8C3BD5BA-252F-4A95-B938-50356A23974E@embedded.rocks>
 <2003579366.391192.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
 <1477696028.31471.3.camel@embedded.rocks>
 <1143135945.89173.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
 <1478074489.19127.7.camel@embedded.rocks>
 <ac897803-47e5-6b0b-5664-6dc165c56c23@i2se.com>
 <1478285097.26659.2.camel@embedded.rocks>
 <1783642995.185945.5e54a2af-ba2c-4901-93f6-1967dd432939.open-xchange@email.1und1.de>
 <1478299359.26659.5.camel@embedded.rocks>
 <963717394.159124.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <1478347610.353.2.camel@embedded.rocks> <1478349578.3405.5.camel@intel.com>
 <1478351681.353.5.camel@embedded.rocks>
 <1478360733.3405.17.camel@intel.com>
 <1479512941.5577.1.camel@embedded.rocks>
Message-ID: <1442387496.277549.fb1ea129-460b-466b-9575-ed6f40b78b7e.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rg,

> J?rg Krause <joerg.krause@embedded.rocks> hat am 19. November 2016 um 00:49
> geschrieben:
> 
> 
> Hi all,
> 
> [snip]
> 
> I did some time measurements on the wifi, mmc and dma driver to compare
> the performance between the vendor and the mainline kernel. For this I
> toggled some GPIOs and measured the time difference with an osci. I
> started measuring the time before calling sdio_readsb() in the wifi
> driver [1] and stopped the time when the call returns. Note that the
> time was only measured for a packet length of 1536 bytes.
> 
> The vendor kernel took about 250 us to return whereas the mainline
> kernel took about 325 us. To investigate where this additional time
> comes from I divided the whole procedure into seperate parts and
> compared their time consumed.
> 
> I noticed that the mainline kernel does took much longer to return
> after the DMA request is done, signalled in this case by calling
> mxs_mmc_dma_irq_callback() [2] in the mxs-mmc driver. From here it
> takes about 150 us to get back to sdio_readsb().
> 
> An example for consuming much more time is the mainline mmc driver
> where it hangs in?mmc_wait_done() [2] about 50 us just calling
> complete(), whereas the vendor mmc driver almost immediately returns
> here.
> 
> I wonder why this call to complete consumes so much time? Any ideas?

i don't know why, but how about putting the SDIO clk signal parallel to the
GPIOs at your osci? So could get a better view of the runtime behavior.

Btw you should also verify the necessary time between to 2 packets.

Stefan

> 
> [1] http://lxr.free-electrons.com/source/drivers/net/wireless/broadcom/
> brcm80211/brcmfmac/bcmsdh.c#L488
> 
> [2] http://lxr.free-electrons.com/source/drivers/mmc/host/mxs-mmc.c#L17
> 9
> 
> [3] http://lxr.free-electrons.com/source/drivers/mmc/core/core.c#L386
> 
> Best regards,
> J?rg Krause
