From: slash.tmp@free.fr (Mason)
Date: Wed, 27 Jan 2016 11:36:51 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A4D13D.3030906@free.fr>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk> <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk> <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk> <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk> <56A3E84A.1000604@free.fr>
 <20160123235905.GE10826@n2100.arm.linux.org.uk> <56A4D13D.3030906@free.fr>
Message-ID: <56A89DC3.8010309@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/2016 14:27, Mason wrote:

> Our "software stack" provides the kernel API under discussion:
> 
>   {read,write}_data{8,16,32}
> 
> These 6 functions must be implemented, because they are part
> of the API we provide to customers. As the "page domain fault"
> underscores, my own implementation is incorrect. I am grateful
> for the implementation you suggested up-thread, and will test
> its performance on Monday.

For the record, I've now changed the implementation as follows.
I'll benchmark performance as soon as I fix the other bug in
the module.

#define DEFINE_BLOCK_READ(N)							\
static int read##N(void __user *dest, void *buf, void __iomem *io, size_t len)	\
{										\
	size_t i; u##N *temp = buf;						\
	for (i = 0; i < len; i += N/8) temp[i] = RD##N(io + i);			\
	return copy_to_user(dest, temp, len) ? -EFAULT : 0;			\
}

#define RD8	readb_relaxed
#define RD16	readw_relaxed
#define RD32	readl_relaxed

DEFINE_BLOCK_READ(8)
DEFINE_BLOCK_READ(16)
DEFINE_BLOCK_READ(32)

#define DEFINE_BLOCK_WRITE(N)							\
static int write##N(void __user *src, void *buf, void __iomem *io, size_t len)	\
{										\
	size_t i; u##N *temp = buf;						\
	if (copy_from_user(temp, src, len)) return -EFAULT;			\
	for (i = 0; i < len; i += N/8) WR##N(temp[i], io + i);			\
	return 0;								\
}

#define WR8	writeb_relaxed
#define WR16	writew_relaxed
#define WR32	writel_relaxed

DEFINE_BLOCK_WRITE(8)
DEFINE_BLOCK_WRITE(16)
DEFINE_BLOCK_WRITE(32)

#define TILE_SIZE (16u << 10)
typedef int fun_t(void __user *ua, void *buf, void __iomem *io, size_t len);

static int block_copy(void __user *ua, phys_addr_t pa, size_t bytes, fun_t *fun)
{
	int err = 0;
	size_t pos = 0;
	void *buf = kmalloc(TILE_SIZE, GFP_KERNEL);
	if (buf == NULL) err = -ENOMEM;

	while (pos < bytes && !err)
	{
		size_t tile = min(bytes-pos, TILE_SIZE);
		void __iomem *va = ioremap(pa + pos, tile);

		err = va ? fun(ua + pos, buf, va, tile) : -EFAULT;
		iounmap(va);
		pos += tile;
	}

	kfree(buf);
	return err;
}


and then the ioctl dispatcher calls e.g.
	block_copy(user_addr, phys_addr, count*4, read32);


IIUC, Arnd mentioned that there might be an issue using readl_relaxed
on a memory region with a big-endian kernel.


The access_ok() macro could be hoisted out of the inner functions,
into block_copy() => that would save about 350 bytes. (I'm not sure
it is worth it.)

   text	   data	    bss	    dec	    hex	filename
  18111	    188	  15036	  33335	   8237	kllad.o

   text	   data	    bss	    dec	    hex	filename
  17759	    188	  15036	  32983	   80d7	kllad.o


Regards.
