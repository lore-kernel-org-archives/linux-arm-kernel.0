From: amit.virdi@st.com (Amit Virdi)
Date: Wed, 16 Oct 2013 10:55:17 +0530
Subject: Need advice: unable to mount filesystem
In-Reply-To: <511E222E.7050002@st.com>
References: <511B8729.8040908@st.com>
 <CACRpkdb=zgaWkzoMtaWbMZXe_wUyszwsjmRC=03iMPDpU90N4w@mail.gmail.com>
 <511C751D.9090404@st.com>
 <CACRpkdaNL=y7Stgd2d=FLY9Zf4iSHjT8GMK+Ch8noe=De3cWfQ@mail.gmail.com>
 <511E222E.7050002@st.com>
Message-ID: <525E233D.9060303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm using cortex-R4 in my SoC. I figured earlier that the support for 
MMU-less kernel was broken from Kernel v3.6 onwards. As a result, I was 
facing problem in mounting the filesystem. Using git bisect, I figured 
out that as a result of:

> ARM: 7449/1: use generic strnlen_user and strncpy_from_user functions

the file system was unable to mount on MMU-less kernel. Till date, I 
have been using the following local fix [1]:

---
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 479a635..e5d549f 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -190,7 +190,7 @@ static inline void set_fs(mm_segment_t fs)
  #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)

  #define user_addr_max() \
-	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
+	(segment_eq(get_fs(), KERNEL_DL) ? ~0UL : TASK_SIZE)

  /*
   * The "__xxx" versions of the user access functions do not verify the
---

However, I have realized that other people using MMU-less CPUs are happy 
(hopefully) with the latest kernel. So, this makes me think that there's 
something other than my local fix that I should be doing to get rid of 
the filesystem mounting problem.

Can anyone guide me how they are able to run the kernel on MMU-less 
system without facing FS mounting problem?

Regards
Amit Virdi

[1] The above fix works only till kernel v3.11-rc3
[2] The patch "ARM: move signal handlers into a vdso-like page" 
introduced in v3.11-rc4 generates Prefetch abort while booting kernel in 
MMU-less systems

On 2/15/2013 5:25 PM, Amit VIRDI wrote:
> Linus,
>
> I have some more findings...
>
>>> [<20185984>] (kernel_init+0x8/0xe4) from [<20008e98>]
>>> (ret_from_fork+0x14/0x3c)
>>
>> It looks like something is wrong with your initramfs. Check that
>> it is really added to the kernel image.
>>
>
> I copied a known good flat filesystem in the flash. Then I appled
> patches for my SoC code to Linux 3.3, build the kernel and executed.
> Everything went smooth and the kernel successfully mounted the filesystem.
>
> Then, I rebased on v3.4. The new kernel again successfully mounted the FS.
>
> I rebased again on v3.5, again everything went smoothly.
>
> However, when I rebased on v3.6 things started to break. The Kernel
> didn't boot at all. The processor generated Synchronous Data Abort
> exception because of alignment fault (during read operation). I debugged
> the code and noticed that start_kernel ran successfully till the end. It
> is the execution of rest_init that generated alignment fault.
>
> Same behavior was observed for v3.7.
>
> However, this problem didn't come with Kernel v3.8-rc6. So, the kernel
> execution proceeded further and all the devices were probed and their
> drivers loaded. As reported earlier, the Kernel couldn't mount the FS
> and is throwing the error:
> --
> VFS: Cannot open root device "mtdblock3" or unknown-block(31,3): error -14
> --
>
> So, as long as there's no compatibility change introduced in the newer
> Kernel, I do not suspect the filesystem as such.
>
> It seems something has been broken for MMUless processors.
>
>> I usually use:
>>
>> CONFIG_BLK_DEV_INITRD
>> CONFIG_INITRAMFS_SOURCE "your-ramdisk.cpio"
>> CONFIG_RD_GZIP
>
> I have verified these for initramfs and these are perfect.
>
>> CONFIG_INITRAMFS_COMPRESSION_GZIP
>>
>
> However, I'm not using this but this might not be necessary.
>
>> Then pass root=/dev/ram0
>>
>> But the last should not be necessary I think.
>>
>> I have a precompiled ramfs here:
>> http://www.df.lth.se/~triad/krad/ux00/rootfs-u300.cpio
>>
>> This is for ARM9 and uses ttyAMA0 as console so it
>> probably works with your system if you copy it to your
>> kernel build dir and state "rootfs-u300.cpio" as
>> initramfs source.
>>
>
> Didn't get chance to try these yet.
>
> Regards
> Amit Virdi
> .
>
