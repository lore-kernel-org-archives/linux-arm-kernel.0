From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 9 Dec 2014 21:13:28 +0100
Subject: __hci_cmd_sync() not suitable for nokia h4p
In-Reply-To: <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
References: <20141209190210.GA15641@amd>
 <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
Message-ID: <20141209201328.GA18003@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Major problem with Nokia H4P driver was, that it uses custom functions
> > instead of __hci_cmd_sync().

>  the __hci_cmd_sync is for sending HCI commands and not low-level
> protocol transports like H:4 or similar. So you want to separate the
> actual transport of HCI from the firmware loading.

The TODO file says:

# > +
# > +     skb_queue_tail(&info->txq, fw_skb);
# > +     spin_lock_irqsave(&info->lock, flags);
# > +     hci_h4p_outb(info, UART_IER, hci_h4p_inb(info, UART_IER) |
# > +                     UART_IER_THRI);
# > +     spin_unlock_irqrestore(&info->lock, flags);
# > +}
# 
# and as I explained before, this crazy can not continue. Bluetooth drivers can provide a
# +hdev->setup callback for loading firmware and doing other setup details. You can just
# +bring up the HCI transport. We are providing __hci_cmd_sync for easy loading of the
# +firmware. Especially if the firmware just consists of HCI commands. Which is clearly the
# +case with the Nokia firmware files.

...so I take it you (and thus TODO) were wrong and __hci_cmd_sync is
not suitable after all?

But I don't understand what you want me to do at this point. I guess
skb_queue_tail+hci_h4p_outb should be moved to a helper function
(that's easy), and I already moved initialization to hci_setup().

nokia_core.c uses test_bit(HCI_RUNNING, &info->hdev->flags) to tell
between initialization and data traffic, but I guess that's fine?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
