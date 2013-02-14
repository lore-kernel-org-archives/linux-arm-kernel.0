From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 10:36:41 +0100
Subject: Need advice: unable to mount filesystem
In-Reply-To: <511C751D.9090404@st.com>
References: <511B8729.8040908@st.com>
 <CACRpkdb=zgaWkzoMtaWbMZXe_wUyszwsjmRC=03iMPDpU90N4w@mail.gmail.com>
 <511C751D.9090404@st.com>
Message-ID: <CACRpkdaNL=y7Stgd2d=FLY9Zf4iSHjT8GMK+Ch8noe=De3cWfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 6:24 AM, Amit Virdi <amit.virdi@st.com> wrote:
> On 2/13/2013 6:44 PM, Linus Walleij wrote:
>> [Amit]
>>> I have even tried using initramfs (compiled kernel with busybox binary).
>>
>> And how does the boot log look when you try to do that?
>
> Almost the same:
>
> ---
> Kernel command line: console=ttyAMA0,115200
>
> <<snip>>
>
>
> Warning: unable to open an initial console.
> VFS: Cannot open root device "(null)" or unknown-block(0,0): error -14
>
> Please append a correct "root=" boot option; here are the available
> partitions:
> 1f00              64 mtdblock0  (driver?)
> 1f01             192 mtdblock1  (driver?)
> 1f02            2048 mtdblock2  (driver?)
> 1f03           14080 mtdblock3  (driver?)
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
>
> [<2000cb50>] (unwind_backtrace+0x0/0xf8) from [<2018655c>]
> (panic+0x8c/0x1d8)
> [<2018655c>] (panic+0x8c/0x1d8) from [<201f8d60>]
> (mount_block_root+0x1fc/0x2b8)
> [<201f8d60>] (mount_block_root+0x1fc/0x2b8) from [<201f90c8>]
> (prepare_namespace+0x160/0x1b8)
> [<201f90c8>] (prepare_namespace+0x160/0x1b8) from [<20185984>]
> (kernel_init+0x8/0xe4)
>
> [<20185984>] (kernel_init+0x8/0xe4) from [<20008e98>]
> (ret_from_fork+0x14/0x3c)

It looks like something is wrong with your initramfs. Check that
it is really added to the kernel image.

I usually use:

CONFIG_BLK_DEV_INITRD
CONFIG_INITRAMFS_SOURCE "your-ramdisk.cpio"
CONFIG_RD_GZIP
CONFIG_INITRAMFS_COMPRESSION_GZIP

Then pass root=/dev/ram0

But the last should not be necessary I think.

I have a precompiled ramfs here:
http://www.df.lth.se/~triad/krad/ux00/rootfs-u300.cpio

This is for ARM9 and uses ttyAMA0 as console so it
probably works with your system if you copy it to your
kernel build dir and state "rootfs-u300.cpio" as
initramfs source.

Yours,
Linus Walleij
