From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2016 10:48:12 +0000
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A89DC3.8010309@free.fr>
References: <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk>
 <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk>
 <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk>
 <56A3E84A.1000604@free.fr>
 <20160123235905.GE10826@n2100.arm.linux.org.uk>
 <56A4D13D.3030906@free.fr> <56A89DC3.8010309@free.fr>
Message-ID: <20160127104811.GX10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 11:36:51AM +0100, Mason wrote:
> On 24/01/2016 14:27, Mason wrote:
> 
> > Our "software stack" provides the kernel API under discussion:
> > 
> >   {read,write}_data{8,16,32}
> > 
> > These 6 functions must be implemented, because they are part
> > of the API we provide to customers. As the "page domain fault"
> > underscores, my own implementation is incorrect. I am grateful
> > for the implementation you suggested up-thread, and will test
> > its performance on Monday.
> 
> For the record, I've now changed the implementation as follows.
> I'll benchmark performance as soon as I fix the other bug in
> the module.
> 
> #define DEFINE_BLOCK_READ(N)							\
> static int read##N(void __user *dest, void *buf, void __iomem *io, size_t len)	\
> {										\
> 	size_t i; u##N *temp = buf;						\
> 	for (i = 0; i < len; i += N/8) temp[i] = RD##N(io + i);			\
> 	return copy_to_user(dest, temp, len) ? -EFAULT : 0;			\
> }
> 
> #define RD8	readb_relaxed
> #define RD16	readw_relaxed
> #define RD32	readl_relaxed
> 
> DEFINE_BLOCK_READ(8)
> DEFINE_BLOCK_READ(16)
> DEFINE_BLOCK_READ(32)
> 
> #define DEFINE_BLOCK_WRITE(N)							\
> static int write##N(void __user *src, void *buf, void __iomem *io, size_t len)	\
> {										\
> 	size_t i; u##N *temp = buf;						\
> 	if (copy_from_user(temp, src, len)) return -EFAULT;			\
> 	for (i = 0; i < len; i += N/8) WR##N(temp[i], io + i);			\
> 	return 0;								\
> }
> 
> #define WR8	writeb_relaxed
> #define WR16	writew_relaxed
> #define WR32	writel_relaxed
> 
> DEFINE_BLOCK_WRITE(8)
> DEFINE_BLOCK_WRITE(16)
> DEFINE_BLOCK_WRITE(32)
> 
> #define TILE_SIZE (16u << 10)
> typedef int fun_t(void __user *ua, void *buf, void __iomem *io, size_t len);
> 
> static int block_copy(void __user *ua, phys_addr_t pa, size_t bytes, fun_t *fun)
> {
> 	int err = 0;
> 	size_t pos = 0;
> 	void *buf = kmalloc(TILE_SIZE, GFP_KERNEL);
> 	if (buf == NULL) err = -ENOMEM;
> 
> 	while (pos < bytes && !err)
> 	{
> 		size_t tile = min(bytes-pos, TILE_SIZE);
> 		void __iomem *va = ioremap(pa + pos, tile);
> 
> 		err = va ? fun(ua + pos, buf, va, tile) : -EFAULT;
> 		iounmap(va);
> 		pos += tile;
> 	}
> 
> 	kfree(buf);
> 	return err;
> }
> 
> 
> and then the ioctl dispatcher calls e.g.
> 	block_copy(user_addr, phys_addr, count*4, read32);
> 
> 
> IIUC, Arnd mentioned that there might be an issue using readl_relaxed
> on a memory region with a big-endian kernel.

I think you're confused there, or Arnd's comment was incorrect.

In any case, I'm even more pissed off with you.  Let me quote from
your earlier emails:

> The problem is that the kernel module's API is already set
> in stone, and it requires block copies with specific access
> sizes, e.g. block_copy8, block_copy16, block_copy32.

and:

> So, a little over a decade ago, someone decided that these
> functions would have the following prototype:
> 
> int read_data8  (u8  *user_addr, u8  *phys_addr, int count)
> int read_data16 (u16 *user_addr, u16 *phys_addr, int count)
> int read_data32 (u32 *user_addr, u32 *phys_addr, int count)
> 
> int write_data8 (u8  *user_addr, u8  *phys_addr, int count)
> int write_data16(u16 *user_addr, u16 *phys_addr, int count)
> int write_data32(u32 *user_addr, u32 *phys_addr, int count)

However, you've done away with those prototypes, and instead come up
with something that looks like:

int block_copy(void __user *ua, phys_addr_t pa, size_t bytes, fun_t *fun)

?

So, let me get this straight.  You demand that the API can't be changed,
and I provide you with a solution which results in very little change to
the API.

However, rather than testing the version I carefully created for you,
you've decided that you're not going to, instead coming up with your
own solution which breaks all your previous demands.

This is totally rediculous.  Why should I waste any more time with _any_
of your questions?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
