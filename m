From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 Aug 2016 21:11:28 +0200 (CEST)
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <ac20c0e9-0cab-7e3f-4abf-75223538a816@synopsys.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
 <722dafcb-2f67-88c7-69df-d442c56c058f@synopsys.com>
 <263309088.290419.51598113-17aa-4db0-9dc0-6e58e3fafe07.open-xchange@email.1und1.de>
 <ac20c0e9-0cab-7e3f-4abf-75223538a816@synopsys.com>
Message-ID: <1270178266.398560.152fe5dd-527b-4ad6-b2fd-e4b0af6bc2a9.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> John Youn <John.Youn@synopsys.com> hat am 17. August 2016 um 00:07
> geschrieben:
> 
> 
> On 8/16/2016 12:58 PM, Stefan Wahren wrote:
> > Hi John,
> > ...
> > 
> > like in host mode i took the default values in otg mode for the last two
> > here
> > (please refer to the logs). The BCM2835 datasheet isn't very helpful.
> > 
> > Do you have any suggestions for valid values or how to get them?
> > 
> 
> The same values used in host-only mode should work.
> 
> It seems that the reset values for host-mode aren't being read
> correctly with dr_mode == otg. I suspect this is the core reset and
> force-mode delay problem.
> 
> Can you try with this patch series to see if you get the proper
> values?
> 
> http://marc.info/?l=linux-kernel&m=145921907525708
> 
> This series fixes known issues, but it also breaks at least one
> platform and I haven't had time to look at it properly yet.

thanks. Yes, that seems to fix host fifo sizes for bcm2835. Here the log after
applying patch 2 - 4 and removing all DT FIFO parameters (patch 1 has already
been merged):

Linux raspberrypi 4.7.0-rc7-next-20160719+ #23 Wed Aug 17 18:15:24 UTC 2016
armv6l

[    2.290723] dwc2_lowlevel_hw_init()
[    2.298123] dwc2_lowlevel_hw_enable()
[    2.305451] dwc2_get_dr_mode()
[    2.365040] dwc2_get_hwparams()
[    2.371785] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
[    2.371801] dwc2 20980000.usb: hwcfg1=00000000
[    2.371813] dwc2 20980000.usb: hwcfg2=228ddd50
[    2.371823] dwc2 20980000.usb: hwcfg3=0ff000e8
[    2.371833] dwc2 20980000.usb: hwcfg4=1ff00020
[    2.371843] dwc2 20980000.usb: grxfsiz=00001000
[    2.371853] dwc2 20980000.usb: Forcing mode to host
[    2.371869] dwc2 20980000.usb: gnptxfsiz=01001000
[    2.371880] dwc2 20980000.usb: hptxfsiz=02002000
[    2.371890] dwc2 20980000.usb: Forcing mode to device
[    2.423450] dwc2 20980000.usb: gnptxfsiz=00201000
[    2.423468] dwc2 20980000.usb: Detected values from hardware:
[    2.423480] dwc2 20980000.usb:   op_mode=0
[    2.423490] dwc2 20980000.usb:   arch=2
[    2.423500] dwc2 20980000.usb:   dma_desc_enable=0
[    2.423511] dwc2 20980000.usb:   power_optimized=0
[    2.423520] dwc2 20980000.usb:   i2c_enable=0
[    2.423530] dwc2 20980000.usb:   hs_phy_type=1
[    2.423540] dwc2 20980000.usb:   fs_phy_type=1
[    2.423550] dwc2 20980000.usb:   utmi_phy_data_width=0
[    2.423559] dwc2 20980000.usb:   num_dev_ep=7
[    2.423570] dwc2 20980000.usb:   num_dev_perio_in_ep=0
[    2.423579] dwc2 20980000.usb:   host_channels=8
[    2.423590] dwc2 20980000.usb:   max_transfer_size=524287
[    2.423601] dwc2 20980000.usb:   max_packet_count=1023
[    2.423611] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
[    2.423621] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
[    2.423631] dwc2 20980000.usb:   dev_token_q_depth=0x8
[    2.423641] dwc2 20980000.usb:   enable_dynamic_fifo=1
[    2.423651] dwc2 20980000.usb:   en_multiple_tx_fifo=1
[    2.423661] dwc2 20980000.usb:   total_fifo_size=4080
[    2.423671] dwc2 20980000.usb:   host_rx_fifo_size=4096
[    2.423681] dwc2 20980000.usb:   host_nperio_tx_fifo_size=256
[    2.423691] dwc2 20980000.usb:   host_perio_tx_fifo_size=512
[    2.423699] dwc2 20980000.usb:
[    2.423709] dwc2 20980000.usb: dwc2_set_parameters()
[    2.423723] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
[    2.423748] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
[    2.423760] dwc2 20980000.usb: Setting hibernation to 0
[    2.423777] dwc2_force_dr_mode()
[    2.430509] dwc2 20980000.usb: Clearing force mode bits
[    2.499028] dwc2_gadget_init()
[    2.505422] dwc2 20980000.usb: Specified GNPTXFDEP=1024 > 32
[    2.514502] dwc2 20980000.usb: EPs: 8, dedicated fifos, 4080 entries in SPRAM
[    2.542143] dwc2 20980000.usb: bound driver zero
[    2.550164] dwc2_hcd_init()
[    2.556602] dwc2 20980000.usb: DWC OTG Controller
[    2.564878] dwc2 20980000.usb: new USB bus registered, assigned bus number 1
[    2.575467] dwc2 20980000.usb: irq 33, io mem 0x00000000

# cat /sys/kernel/debug/20980000.usb/fifo
Non-periodic FIFOs:
RXFIFO: Size 4096
NPTXFIFO: Size 32, Start 0x00200000

Periodic TXFIFOs:
        DPTXFIFO 1: Size 512, Start 0x00001020
        DPTXFIFO 2: Size 512, Start 0x00001220
        DPTXFIFO 3: Size 512, Start 0x00001420
        DPTXFIFO 4: Size 512, Start 0x00001620
        DPTXFIFO 5: Size 512, Start 0x00001820
        DPTXFIFO 6: Size 768, Start 0x00001a20
        DPTXFIFO 7: Size 768, Start 0x00001d20
