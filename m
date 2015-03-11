From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 20:26:53 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311175227.499612af@free-electrons.com>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
Message-ID: <55007ADD.6080505@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 19:52, Thomas Petazzoni ?????:
> Dear Stas Sergeev,
> No, this is not the right fix. The right fix is to upgrade your
> bootloader to a non-buggy one.
>
> Basically, the problem is that the memory information passed by the
> bootloader to the kernel is not consistent with the MBus base address
> which is the limit between RAM (below the MBus base address) and I/O
> registers (above the MBus base address).
>
> The bootloader tells the kernel that the RAM up to 0xf0000000 is
> usable, but sets the MBus base address to 0xe0000000. So whenever the
> kernel accesses 0xe0000000 -> 0xf0000000, it crashes, because you're
> not hitting RAM but MBus windows (and there are most likely no MBus
> window mapped in this space).
>
> Since kmalloc() relies on the identity mapping, it happens to mainly
> use pages at the beginning of the physical memory, which are OK. But
> vmalloc() happens to start using pages at the end of the physical
> memory (which are not part of the identity mapping), so that's why
> you're seeing this on the first access to a vmalloc()ed area.
>
> This problem has already been reported to Marvell and they have fixed
> it in their U-Boot. Please upgrade your bootloader, since there is not
> much the kernel can do about this: the bootloader is simply lying to
> the kernel about the amount of memory that is accessible.
Hello Thomas, thanks for that info!

Is there a quick way to test that?
I used memmap=0x20000000$0xe0000000 but nothing changed...
