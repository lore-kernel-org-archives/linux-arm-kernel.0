From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jul 2013 10:41:18 +0100
Subject: [PATCH] arm: update advice on kernel and FDT load address.
In-Reply-To: <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
References: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
 <20130729135000.GK32383@mudshark.cambridge.arm.com>
 <1375106635.12741.8.camel@kazak.uk.xensource.com>
 <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
Message-ID: <20130730094118.GF11527@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 04:05:06AM +0100, Nicolas Pitre wrote:
> On Mon, 29 Jul 2013, Ian Campbell wrote:
> >	Note that the kernel uses 16KiB of RAM below
> >       the image to store page tables.  The recommended placement is
> >         32KiB into RAM.
> 
> Well... not completely right.
> 
> You may load zImage anywhere in the first 128MB of RAM if you have 
> CONFIG_AUTO_ZRELADDR=y.  If CONFIG_AUTO_ZRELADDR=n then zImage may be 
> loaded anywhere. In the former case, the zImage code will automatically 
> determine the physical start of RAM.  In the later case the start of RAM 
> is hardcoded in the zImage binary.
> 
> Then, the zImage code will decompress the actual kernel image at an 
> offset of (in most cases) 32KB from start of RAM.  However, if the 
> decompressed kernel would overwrite the loaded zImage where the 
> decompressor code and data is located, then zImage will relocate itself 
> just after the end of the decompressed kernel area before proceeding to 
> the decompression.  This is where you need to be careful about 
> ramdisk/initrd and DTB load addresses.
> 
> The initial page table is therefore (in most cases again) just below the 
> decompressed kernel location i.e. either Ffrom 16KB from start of RAM, 
> or from 12KB if using LPAE.
> 
> You can therefore load everything (zImage, initrd, DTB) sequentially 
> from the 32MB mark in RAM and be safe.  By loading zImage that high, it 
> most certainly won't need to relocate itself (unless the decompressed 
> kernel is larger than 32MB which is very unlikely as I mentioned) and 
> that will also make the boot process slightly faster.

Hmm, how does that work with CONFIG_INITRAMFS_SOURCE, where the initramfs
is built into the zImage? Would this impose a 32MB uncompressed limit on the
size of the kernel + initramfs?

Will
