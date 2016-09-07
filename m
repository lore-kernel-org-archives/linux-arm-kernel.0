From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 17:06:04 +0200
Subject: [PATCH V2 1/4] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <1473255233-154297-2-git-send-email-yuanzhichang@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473255233-154297-2-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <3419224.SdRtVQMJCi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 9:33:50 PM CEST Zhichang Yuan wrote:
> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> +
> +typedef u64 (*inhook)(void *devobj, unsigned long ptaddr, void *inbuf,
> +                               size_t dlen, unsigned int count);
> +typedef void (*outhook)(void *devobj, unsigned long ptaddr,
> +                               const void *outbuf, size_t dlen,
> +                               unsigned int count);
> +
> +struct extio_ops {
> +       inhook  pfin;
> +       outhook pfout;
> +       void *devpara;
> +};
> +
> +extern struct extio_ops *arm64_simops __refdata;
> +
> +/*Up to now, only applied to Hip06 LPC. Define as static here.*/
> +static inline void arm64_set_simops(struct extio_ops *ops)
> +{
> +       if (ops)
> +               WRITE_ONCE(arm64_simops, ops);
> +}
> +
> +
> +#define BUILDIO(bw, type)                                              \
> +static inline type in##bw(unsigned long addr)                          \
> +{                                                                      \
> +       if (addr >= PCIBIOS_MIN_IO)                                     \
> +               return read##bw(PCI_IOBASE + addr);                     \
> +       return (arm64_simops && arm64_simops->pfin) ?                   \
> +               arm64_simops->pfin(arm64_simops->devpara, addr, NULL,   \
> +                                       sizeof(type), 1) : -1;          \
> +}                                                      \
> 

Hmm, the way this is done, enabling CONFIG_ARM64_INDIRECT_PIO at
compile time means that only the dynamically registered PIO support
is possible for I/O port ranges 0-0xfff.

I think the runtime check should better test if simops was defined
first and fall back to normal PIO otherwise, in order to allow
LPC implementations on a PCI-LPC bridge.

How about allowing an I/O port range to be defined along with
the operations and check against that?

u8 intb(unsigned long port)
{
	if (arm64_simops &&
	    (port >= arm64_simops->min) && 
	    (port <= arm64_simops->max))
		return arm64_simops->pfin(arm64_simops, port, 1);
	else
		return readb(PCI_IOBASE + addr);
}

The other advantage of that is that you can dynamically register
a translation for the LPC port range into the Linux I/O port range
like PCI hosts do.

We may also want to move the inb/outb definitions into a .c file
as they are getting rather big.

	Arnd
