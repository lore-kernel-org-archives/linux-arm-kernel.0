From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Sat, 26 Mar 2016 20:36:43 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <6653982.FK62mVSCZO@wuerfel>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <20160318154918.GA1595@yury-N73SV> <mvmoaa8dwre.fsf@hawking.suse.de>
 <6653982.FK62mVSCZO@wuerfel>
Message-ID: <56F6825B.7000906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

On 2016/3/21 17:43, Arnd Bergmann wrote:
> On Monday 21 March 2016 10:07:49 Andreas Schwab wrote:
>> This patch may fix a few LTP tests.
>>
>
> Thanks for analyzing.
>
>> diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h b/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
>> index 3631903..d1010db 100644
>> --- a/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
>> +++ b/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
>> @@ -25,18 +25,29 @@
>>   #define __O_NOFOLLOW	0100000
>>   #define __O_DIRECT	0200000
>>
>> -#define __O_LARGEFILE	0
>> +#ifdef __ILP32__
>> +# define __O_LARGEFILE	0400000
>> +#else
>> +# define __O_LARGEFILE	0
>> +#endif
>>
>
> I guess this means I screwed up when I said I'd merged the kernel patch
> that Yury did to fix it, sorry about that.
>
> We need the patch to make all new architecture in the kernel default to
> O_LARGEFILE, and not do this in user space. I'd suggest now to keep the
> patches as part of the ILP32 series after all, to make sure they are
> merged at the point when they are needed.

I am a little bit confuse about off_t. In "[PATCH 08/33] 32-bit
ABI: introduce ARCH_32BIT_OFF_T config option", it mentioned that all
the new 32bit architecture should use 64bit off_t.

Should we define off_t in aarch64(for both ilp32 and lp64) in
typesize.h as following?

diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h b/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
index 7073493..13b77c5 100644
--- a/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
+++ b/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
@@ -33,7 +33,7 @@
  #define __INO64_T_TYPE         __UQUAD_TYPE
  #define __MODE_T_TYPE          __U32_TYPE
  #define __NLINK_T_TYPE         __U32_TYPE
-#define __OFF_T_TYPE           __SLONGWORD_TYPE
+#define __OFF_T_TYPE           __SQUAD_TYPE
  #define __OFF64_T_TYPE         __SQUAD_TYPE
  #define __PID_T_TYPE           __S32_TYPE
  #define __RLIM_T_TYPE          __ULONGWORD_TYPE

Then we could remove the __USE_FILE_OFFSET64 in stat.h and fcnt.h in
aarch64. And truncate and ftruncate is same as truncate64 and
ftruncate64.

Otherwise we need to handle the pad like yury do it in
stat.h, and we need to handle the bigendian as well:

 From 61949bf70527b9cc450e7bbdba9182f7f120c5bd Sun March 26 00:00:00 2016
From: j00321192 <jijun2@huawei.com>
Date: Thu, 24 Mar 2016 22:10:25 +0800
Subject: [PATCH] Fix endian issue in struct stat and stat64

There is endian issue in the existence bits/stat.h in aarch64. Fix
it by add the __AARCH64EB__ with proper pad.

Tested in our arm64 hardware. It could fix all the *stat test cases.

Signed-off-by: Yongliang Gao <gaoyongliang@huawei.com>
Signed-off-by: Jun Ji <jijun2@huawei.com>
Signed-off-by: Yang Liu(Young) <young.liuyang@huawei.com>
Signed-off-by: Zhang Jian(Bamvor) <bamvor.zhangjian@huawei.com>
---
  sysdeps/unix/sysv/linux/aarch64/bits/stat.h | 38 +++++++++++++++++++++++++----
  1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/stat.h b/sysdeps/unix/sysv/linux/aarch64/bits/stat.h
index 3d50e7a..4c6e072 100644
--- a/sysdeps/unix/sysv/linux/aarch64/bits/stat.h
+++ b/sysdeps/unix/sysv/linux/aarch64/bits/stat.h
@@ -35,12 +35,21 @@ struct stat
    {
      __dev_t st_dev;			/* Device.  */
  #ifdef __ILP32__
+
+#if !defined(__AARCH64EB__)
      unsigned int __st_ino_pad;
+#endif
+
  # ifndef __USE_FILE_OFFSET64
      __ino_t st_ino;			/* File serial number.	*/
  # else
      __ino_t __st_ino;			/* 32bit file serial number.	*/
  # endif
+
+#if defined(__AARCH64EB__)
+    unsigned int __st_ino_pad;
+#endif
+
  #else
  # ifndef __USE_FILE_OFFSET64
      __ino_t st_ino;			/* File serial number.	*/
@@ -55,10 +64,17 @@ struct stat
      __dev_t st_rdev;			/* Device number, if device.  */
      __dev_t __pad1;
  #ifndef __USE_FILE_OFFSET64
+
+#if defined(__ILP32__) && defined(__AARCH64EB__)
+    int __st_size_pad;
+#endif
+
      __off_t st_size;			/* Size of file, in bytes.  */
-# ifdef __ILP32__
+
+#if defined(__ILP32__) && !defined(__AARCH64EB__)
      int __st_size_pad;
-# endif
+#endif
+
  #else
      __off64_t st_size;			/* Size of file, in bytes.  */
  #endif
@@ -66,10 +82,17 @@ struct stat
      int __pad2;

  #ifndef __USE_FILE_OFFSET64
+
+#if defined (__ILP32__) && defined(__AARCH64EB__)
+    int __st_blocks_pad;
+#endif
+
      __blkcnt_t st_blocks;		/* Number 512-byte blocks allocated. */
-# ifdef __ILP32__
+
+#if defined (__ILP32__) && !defined(__AARCH64EB__)
      int __st_blocks_pad;
-# endif
+#endif
+
  #else
      __blkcnt64_t st_blocks;		/* Number 512-byte blocks allocated. */
  #endif
@@ -94,7 +117,7 @@ struct stat
      __time_t st_ctime;			/* Time of last status change.  */
      unsigned long int st_ctimensec;	/* Nsecs of last status change.  */
  #endif
-#if !defined __ILP32__ || !defined __USE_FILE_OFFSET64
+#if !defined (__ILP32__) || !defined __USE_FILE_OFFSET64
      int __glibc_reserved[2];
  #else
      __ino64_t st_ino;			/* File serial number.	*/
@@ -106,8 +129,13 @@ struct stat64
    {
      __dev_t st_dev;			/* Device.  */
  # ifdef __ILP32__
+    #if !defined(__AARCH64EB__)
      unsigned int __st_ino_pad;
+    #endif
      __ino_t __st_ino;			/* 32bit file serial number.	*/
+    #if defined(__AARCH64EB__)
+    unsigned int __st_ino_pad;
+    #endif
  # else
      __ino64_t st_ino;			/* File serial number.	*/
  # endif
-- 
1.8.4.5

Regards

bamvor


>> +#ifndef __ILP32__
>>   # define F_GETLK64	5
>>   # define F_SETLK64	6
>>   # define F_SETLKW64	7
>> +#endif
>>
>>   struct flock
>>     {
>>       short int l_type;	/* Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK.	*/
>>       short int l_whence;	/* Where `l_start' is relative to (like `lseek').  */
>> +#ifndef __USE_FILE_OFFSET64
>>       __off_t l_start;	/* Offset where the lock begins.  */
>>       __off_t l_len;	/* Size of the locked area; zero means until EOF.  */
>> +#else
>> +    __off64_t l_start;	/* Offset where the lock begins.  */
>> +    __off64_t l_len;	/* Size of the locked area; zero means until EOF.  */
>> +#endif
>>       __pid_t l_pid;	/* Process holding the lock.  */
>>     };
>
> This looks like there is another bug as well, but I think this is in
> libc, not in the kernel. I'm sure we had discussed this at some point
> but I forgot what the outcome was. Defining 'struct flock' to have a
> 32-bit l_start and l_len member cannot be right if the kernel only
> supports 64-bit offsets.
>
> My guess is that the libc should either not define __off_t at all for
> ILP32, and always use __off64_t in struct flock, or __off_t should
> be defined as __kernel_loff_t a.k.a. long long so the #ifdef can be
> avoided.
>
> What exactly do you need to define F_GETLK64 for on LP64?
>
> 	Arnd
>
