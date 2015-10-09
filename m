From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 9 Oct 2015 07:42:21 -0700
Subject: [PATCH] nvme: fix 32-bit build warning
In-Reply-To: <5851501.PBMrs03XFb@wuerfel>
References: <5851501.PBMrs03XFb@wuerfel>
Message-ID: <20151009144221.GA12760@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 10:37:11PM +0200, Arnd Bergmann wrote:
> Compiling the nvme driver on 32-bit warns about a cast from a __u64
> variable to a pointer:
> 
> drivers/block/nvme-core.c: In function 'nvme_submit_io':
> drivers/block/nvme-core.c:1847:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     (void __user *)io.addr, length, NULL, 0);
> 
> The cast here is intentional and safe, so we can shut up the
> gcc warning by adding an intermediate cast to 'unsigned long'.

It really should be a uintptr_t, which would also avoid the > 80
character lines.  I wonder if we need a u64_to_ptr helper given these
ioctl ABIs that pass pointers as a u64 seems to be everywhere these
days.
