From: amit.virdi@st.com (Amit Virdi)
Date: Fri, 15 Feb 2013 17:25:26 +0530
Subject: Need advice: unable to mount filesystem
In-Reply-To: <CACRpkdaNL=y7Stgd2d=FLY9Zf4iSHjT8GMK+Ch8noe=De3cWfQ@mail.gmail.com>
References: <511B8729.8040908@st.com>
 <CACRpkdb=zgaWkzoMtaWbMZXe_wUyszwsjmRC=03iMPDpU90N4w@mail.gmail.com>
 <511C751D.9090404@st.com>
 <CACRpkdaNL=y7Stgd2d=FLY9Zf4iSHjT8GMK+Ch8noe=De3cWfQ@mail.gmail.com>
Message-ID: <511E222E.7050002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

I have some more findings...

>> [<20185984>] (kernel_init+0x8/0xe4) from [<20008e98>]
>> (ret_from_fork+0x14/0x3c)
>
> It looks like something is wrong with your initramfs. Check that
> it is really added to the kernel image.
>

I copied a known good flat filesystem in the flash. Then I appled 
patches for my SoC code to Linux 3.3, build the kernel and executed. 
Everything went smooth and the kernel successfully mounted the filesystem.

Then, I rebased on v3.4. The new kernel again successfully mounted the FS.

I rebased again on v3.5, again everything went smoothly.

However, when I rebased on v3.6 things started to break. The Kernel 
didn't boot at all. The processor generated Synchronous Data Abort 
exception because of alignment fault (during read operation). I debugged 
the code and noticed that start_kernel ran successfully till the end. It 
is the execution of rest_init that generated alignment fault.

Same behavior was observed for v3.7.

However, this problem didn't come with Kernel v3.8-rc6. So, the kernel 
execution proceeded further and all the devices were probed and their 
drivers loaded. As reported earlier, the Kernel couldn't mount the FS 
and is throwing the error:
--
VFS: Cannot open root device "mtdblock3" or unknown-block(31,3): error -14
--

So, as long as there's no compatibility change introduced in the newer 
Kernel, I do not suspect the filesystem as such.

It seems something has been broken for MMUless processors.

> I usually use:
>
> CONFIG_BLK_DEV_INITRD
> CONFIG_INITRAMFS_SOURCE "your-ramdisk.cpio"
> CONFIG_RD_GZIP

I have verified these for initramfs and these are perfect.

> CONFIG_INITRAMFS_COMPRESSION_GZIP
>

However, I'm not using this but this might not be necessary.

> Then pass root=/dev/ram0
>
> But the last should not be necessary I think.
>
> I have a precompiled ramfs here:
> http://www.df.lth.se/~triad/krad/ux00/rootfs-u300.cpio
>
> This is for ARM9 and uses ttyAMA0 as console so it
> probably works with your system if you copy it to your
> kernel build dir and state "rootfs-u300.cpio" as
> initramfs source.
>

Didn't get chance to try these yet.

Regards
Amit Virdi
