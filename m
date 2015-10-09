From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 20:55:26 +0200
Subject: [PATCH] nvme: fix 32-bit build warning
In-Reply-To: <20151009144221.GA12760@infradead.org>
References: <5851501.PBMrs03XFb@wuerfel> <20151009144221.GA12760@infradead.org>
Message-ID: <5008376.3nLbRZSJUc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 07:42:21 Christoph Hellwig wrote:
> On Tue, Oct 06, 2015 at 10:37:11PM +0200, Arnd Bergmann wrote:
> > Compiling the nvme driver on 32-bit warns about a cast from a __u64
> > variable to a pointer:
> > 
> > drivers/block/nvme-core.c: In function 'nvme_submit_io':
> > drivers/block/nvme-core.c:1847:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >     (void __user *)io.addr, length, NULL, 0);
> > 
> > The cast here is intentional and safe, so we can shut up the
> > gcc warning by adding an intermediate cast to 'unsigned long'.
> 
> It really should be a uintptr_t, which would also avoid the > 80
> character lines.  I wonder if we need a u64_to_ptr helper given these
> ioctl ABIs that pass pointers as a u64 seems to be everywhere these
> days.

I'll send a new version with uintptr_t for now, but having a proper
interface for this sounds like a good idea.

I've seen a couple of cases like this, and most but not
all actually want a __user pointer like this one. That seems
similar to the common ioctl use case where we want a user pointer
from an 'unsigned long', so we could use the same function for both,
like

static inline void __user *get_uptr(unsigned long arg)
{
	return (void __user *)arg;
}

With this definition, you can pass any scalar type (u64 or
unsigned long normally) and get the pointer, and we can
put that into include/linux/uaccess.h.

	Arnd
