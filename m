From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 11 Aug 2010 11:59:21 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
Message-ID: <4C627479.4060400@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Martin Fuzzey a ?crit :
> Hi all,

> So what is the correct fix for this problem?
> The options seem to be:
> 1) Remove skb_reserve() from usbnet
> But this will cause the ip header to be non aligned on platforms that
> don't have the DMA alignment requirement.
And cause lot's of unaligned access for the IP stack. This will slow 
down arm platform...

> 
> 2) Define NET_IP_ALIGN to 0 for ARM
> Seems a bit intrusive to me.
Again this will generate lot's of unaligned access.
> 
> 3) Change the HCD to copy if not aligned
> I'd like to avoid that.
> 
> 4) Change usbnet to use seperate buffers for the usb side and skb.
> Copy between them so both remain aligned
> Seems unlikely that the gain further up the stack from ensuring the ip
> header is aligned will offset the cost of the copy.
> 
> Any ideas?
I got the same problem on the gadget side : 
http://article.gmane.org/gmane.linux.usb.general/28700

A solution could be the hcd driver to tell it doesn't support unaligned 
transfert and in this case the usb stack/usb driver align it.

It is best to solve in usb driver, because for example in Asix case the 
driver already do copy (see asix_rx_fixup/asix_tx_fixup).


Matthieu

PS : what hcd driver do you use ?
