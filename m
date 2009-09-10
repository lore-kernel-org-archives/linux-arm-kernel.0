From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Sep 2009 10:14:21 +0800
Subject: Collie/Simpad hacks in head-sa1100.S break booting on other
	machines
In-Reply-To: <20090909125420.GA13915@rainbow>
References: <20090909125420.GA13915@rainbow>
Message-ID: <f17812d70909091914y4c44a29j1204c67904143efd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2009 at 8:54 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> Hello!
>
> When trying to boot kernel with both CONFIG_SA1100_COLLIE and
> CONFIG_SA1100_H3600 compiled in on iPaq h3600, I suddenly have been
> bitten by this hack in arch/arm/boot/compressed/head-sa1100.S:
>
> #ifdef CONFIG_SA1100_COLLIE
> ? ? ? ? ? ? ? ?mov ? ? r7, #MACH_TYPE_COLLIE
> #endif
>
> Yes, it's silently sets machine ID to MACH_TYPE_COLLIE on _any_ SA1100 machine
> if CONFIG_SA1100_COLLIE is set. And there's also similar hack (or broken
> bootloader workaround, if you like) for Simpad.
>
> I don't know if these hacks are needed anymore (for Collie with stock
> bootloader probably yes, for Simpad I don't know as I don't have this
> hardware), but I think something should be done at least to prevent
> selecting other machines if CONFIG_SA1100_COLLIE or CONFIG_SA1100_SIMPAD
> selected. Please find not very elegant, but working patch in attahment.
> It just adds "depends on !SA1100_COLLIE && !SA1100_SIMPAD" to every other
> machine. Sadly, I'm not an expert in kconfig - maybe there's a better way
> to do that?
>

Sadly, this doesn't look like a correct approach. Remember that machines
can just be compiled into a single vmlinux all together without excluding
each other.

This is true on pxa25x/pxa27x with Sharp Zaurus due to their lack of a
compliant boot loader, so that dirty hack is there to detect which model
is.

A good fix would be to the bootloader to tell the kernel about the correct
machine ID, and if that's difficult, a compromised one would be a short
block of detection code which doesn't conflict with other machines.
