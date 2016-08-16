From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 16 Aug 2016 22:09:40 +0200 (CEST)
Subject: [PATCH V2 RFC 1/6] usb: dwc2: core: Avoid nonsense error in
 gadget mode
In-Reply-To: <69b9522a-ca23-cc32-ec90-8d59f63e4e03@synopsys.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-2-git-send-email-stefan.wahren@i2se.com>
 <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
 <2008594325.331112.5842a41f-9d6d-4b55-baac-1529d6cae164.open-xchange@email.1und1.de>
 <69b9522a-ca23-cc32-ec90-8d59f63e4e03@synopsys.com>
Message-ID: <167107178.290535.51598113-17aa-4db0-9dc0-6e58e3fafe07.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

> John Youn <John.Youn@synopsys.com> hat am 16. August 2016 um 21:20
> geschrieben:
> 
> 
> On 8/16/2016 9:44 AM, Stefan Wahren wrote:
> > Hi John,
> > 
> >> John Youn <John.Youn@synopsys.com> hat am 16. August 2016 um 03:30
> ...
> > [    2.476378] dwc2 20980000.usb: dwc2_set_parameters()
> > [    2.476391] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
> > [    2.476418] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
> > [    2.476429] dwc2 20980000.usb: Setting hibernation to 0
> > [    2.476449] dwc2 20980000.usb: 0 invalid for host_rx_fifo_size. Check HW
> > configuration.
> > [    2.491704] dwc2 20980000.usb: Setting host_rx_fifo_size to 4096
> > [    2.491727] dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size.
> > Check
> > HW configuration.
> > [    2.507853] dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
> > [    2.507875] dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size.
> > Check
> > HW configuration.
> > [    2.524246] dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
> 
> Thanks for the logs.
> 
> It looks like if dr_mode == peripheral, dwc2 doesn't populate the
> following host-only values from the reset values of the registers.
> 
> * hw_params->host_nperio_tx_fifo_size
> * hw_params->host_perio_tx_fifo_size
> 
> Thus when it goes to set the core_params based on the hw_params you
> get the error. As peripheral-only, they are never used so it's fine.
> 
> To get rid of the error we can skip setting the host-only parameters
> if dr_mode == peripheral.

sorry the subject is imprecise. According to the logs if dr_mode == otg we also
get

[    2.569573] dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size. Check
HW configuration.
[    2.585354] dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0

You already said in 6/6 that's faulty, but i only want to point it out.

Stefan
