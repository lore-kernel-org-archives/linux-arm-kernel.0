From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 12:00:26 +0200
Subject: [PATCH V2 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <57D11BE9.7010709@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <2175767.JxAh0qjf0L@wuerfel> <57D11BE9.7010709@hisilicon.com>
Message-ID: <74367472.RYBpLsaIy1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 4:06:01 PM CEST zhichang.yuan wrote:
> > 
> >> +struct lpc_io_ops {
> >> +    unsigned int periosz;
> >> +    int (*lpc_iord)(struct hisilpc_dev *pdev, struct lpc_cycle_para *para,
> >> +                            unsigned long ptaddr, unsigned char *buf,
> >> +                            unsigned long dlen);
> >> +    int (*lpc_iowr)(struct hisilpc_dev *pdev, struct lpc_cycle_para *para,
> >> +                            unsigned long ptaddr,
> >> +                            const unsigned char *buf,
> >> +                            unsigned long dlen);
> >> +};
> > 
> > The operations are not needed unless we also put the earlycon support
> > in, so maybe leave them out from the first patch and only add them
> > later (or drop the earlycon support if possible).
> 
> Do you want to remove the struct lpc_io_ops member from struct hisilpc_dev??
> I think we can not do that.
> 
> These two functions are essential rd/wr operation for Hip06 LPC. They will be fallen into
> when the upper layer drivers call their own IO in/out functions, such as serial_in/serial_out
> for 8250 serial.
> 
> I can define lpc_iord/lpc_iowr directly in struct hisilpc_dev and cancel the definition of
> struct lpc_io_ops. In my original idea, several LPC cycle types will be supported. Each cycle
> type has its specific ops. Now, only one cycle type is needed, the struct lpc_io_ops is not
> meaningful.

My point was that the indirect function calls are not needed at
until patch four, so you can call the functions directly here,
and make the logic for indirect function calls part of that
later patch.

What are the other LPC cycle types that could be supported?

	Arnd
