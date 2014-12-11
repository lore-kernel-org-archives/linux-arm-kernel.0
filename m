From: marcel@holtmann.org (Marcel Holtmann)
Date: Thu, 11 Dec 2014 13:58:09 +0100
Subject: __hci_cmd_sync() not suitable for nokia h4p
In-Reply-To: <20141210131519.GA14748@amd>
References: <20141209190210.GA15641@amd>
 <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
 <20141209201328.GA18003@amd>
 <7EFD3C33-E503-4FB6-BCCF-52836080ABD6@holtmann.org>
 <20141210131519.GA14748@amd>
Message-ID: <EE1A4B9D-30D5-4BD9-9A43-532619494A0C@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

>>> The TODO file says:
>>> 
>>> # > +
>>> # > +     skb_queue_tail(&info->txq, fw_skb);
>>> # > +     spin_lock_irqsave(&info->lock, flags);
>>> # > +     hci_h4p_outb(info, UART_IER, hci_h4p_inb(info, UART_IER) |
>>> # > +                     UART_IER_THRI);
>>> # > +     spin_unlock_irqrestore(&info->lock, flags);
>>> # > +}
>>> # 
>>> # and as I explained before, this crazy can not continue. Bluetooth drivers can provide a
>>> # +hdev->setup callback for loading firmware and doing other setup details. You can just
>>> # +bring up the HCI transport. We are providing __hci_cmd_sync for easy loading of the
>>> # +firmware. Especially if the firmware just consists of HCI commands. Which is clearly the
>>> # +case with the Nokia firmware files.
>>> 
>>> ...so I take it you (and thus TODO) were wrong and __hci_cmd_sync is
>>> not suitable after all?
>> 
>> __hci_cmd_sync is to be used in hdev->setup where you load the firmware. However when hdev->setup is run, we expect that the HCI transport is fully up and running and that the driver takes care of the transport. That is done via hdev->send and hci_recv_frame.
>> 
> 
> h4p changes uart speed again after load of the firmware, but I guess
> that's ok.

if you can do it the other way around it would result in a faster init. Depending on how many patches are actually required to be loaded.

>>> But I don't understand what you want me to do at this point. I guess
>>> skb_queue_tail+hci_h4p_outb should be moved to a helper function
>>> (that's easy), and I already moved initialization to hci_setup().
>>> 
>>> nokia_core.c uses test_bit(HCI_RUNNING, &info->hdev->flags) to tell
>>> between initialization and data traffic, but I guess that's fine?
>> 
>> I have no idea on how much more I can explain this. There should be code in the driver that handles the HCI transport. That means init of the transport and sending and receiving HCI frames. And then there is the piece to load the firmware etc. These are two independent things.
>> 
> 
> Ok, it looks like __hci_cmd_sync() is indeed good match for the
> firmware load.
> 
>> 
>> What needs to be done is the bring up of the device including the proper UART settings and speed and then just run the firmware downloads. All firmware files on the Nokia devices where just HCI commands with vendor specific details. Some from CSR, some from Broadcom and some from TI. You can actually decode them if you really want to. Shouldn't be that hard.
>> 
> 
> Speed changes at the end of firmware load, but I guess that's detail?
> Anyway, patch would look like this.

You should really look into providing hdev->setup() callback. That is normally the callback where you want to load the firmware.

Regards

Marcel
