From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Tue, 31 May 2016 05:15:10 +0000
Subject: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <CAKfKVtF1hOn9QwiqtjqqPYtUz5PscTBs4kBC1zRH6FY-4vVoUA@mail.gmail.com>
References: <1464626798-1334-1-git-send-email-navam@xilinx.com>
 <CAKfKVtF1hOn9QwiqtjqqPYtUz5PscTBs4kBC1zRH6FY-4vVoUA@mail.gmail.com>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26CEF0EF@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

	
	Thanks for the review...

> >  /**
> > + * xudc_write64 - write 64bit value to device registers
> > + * @ep: pointer to the usb device endpoint structure.
> > + * @offset: register offset
> > + * @val: data to be written
> > + **/
> > +static void xudc_write64(struct xusb_ep *ep, u32 offset, u64 val) {
> > +       struct xusb_udc *udc = ep->udc;
> > +
> > +       udc->write_fn(udc->addr, offset, lower_32_bits(val));
> > +       udc->write_fn(udc->addr, offset+0x04, upper_32_bits(val));
> 
> can we move this to a single 64 bit write?

Initially I sent the patches with writeq() ,lo_hi_writeq()  later we decided to replace with write_fun().
The reason for this is lo_hi_writeq() always assumes a little-endian register, so it's broken if anyone builds this device with big-endian registers.
So replaced the 64bit calls with write_fun() as suggested by Arnd Bergmann. Hope it clears your query.
Please refer to the below thread

	http://lkml.iu.edu/hypermail/linux/kernel/1604.2/02046.html 


Regards,
Navakishore.
