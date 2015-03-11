From: agraf@suse.de (Alexander Graf)
Date: Wed, 11 Mar 2015 06:24:16 -0500
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <20141208101026.GD27367@arm.com>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <20141204182049.GB7749@arm.com> <54833BAF.1030405@suse.de>
 <20141208101026.GD27367@arm.com>
Message-ID: <550025E0.7030008@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08.12.14 04:10, Will Deacon wrote:
> On Sat, Dec 06, 2014 at 05:23:59PM +0000, Alexander Graf wrote:
>> On 04.12.14 19:20, Will Deacon wrote:
>>> On Thu, Dec 04, 2014 at 03:46:33PM +0000, Alexander Graf wrote:
>>>> With binutils 2.25 the default alignment for 32bit arm sections changed to
>>>> have everything 64k aligned. Armv7 binaries built with this binutils version
>>>> run successfully on an arm64 system.
>>>>
>>>> Since effectively there is now the chance to run armv7 code on arm64 even
>>>> with 64k page size, it doesn't make sense to block people from enabling
>>>> CONFIG_COMPAT on those configurations.
>>>
>>> Is there a distro available that is built with a recent enough binutils for
>>> this? I'd really like to run our regression tests to check that page-size
>>> assumptions don't exist for things like shm.
>>
>> So how much of a distro do you need? I could probably assemble a simple
>> very minimalistic rootfs with only bash if that helps.
> 
> I'd like to run LTP, so I'd probably need slightly more than that but I
> certainly don't need the whole world.

So after recompiling all of the distribution with newer binutils we now
have an openSUSE Factory tree that has 64k aligned 32bit binaries.

Unfortunately however, the 32bit glibc has a bogus mmap() implementation
that hard codes 4k page size.

With the patch below applied to glibc, I can successfully run 32bit user
space on Seattle with 64k PAGE_SIZE though. So I guess we'll need to fix
up glibc next.

Do you know of anyone who's fluent enough in 32bit ARM assembly to
convert the hard coded assumptions in there to instead use a variable
that takes the actual host page size into account?


Alex


Index: glibc-2.21/sysdeps/unix/sysv/linux/arm/mmap.S
===================================================================
--- glibc-2.21.orig/sysdeps/unix/sysv/linux/arm/mmap.S
+++ glibc-2.21/sysdeps/unix/sysv/linux/arm/mmap.S
@@ -36,7 +36,7 @@ ENTRY (__mmap)
 	/* convert offset to pages */
 	movs	ip, r5, lsl #20
 	bne	.Linval
-	mov	r5, r5, lsr #12
+	mov	r5, r5, lsr #16

 	/* do the syscall */
 	DO_CALL (mmap2, 0)
Index: glibc-2.21/sysdeps/unix/sysv/linux/arm/mmap64.S
===================================================================
--- glibc-2.21.orig/sysdeps/unix/sysv/linux/arm/mmap64.S
+++ glibc-2.21/sysdeps/unix/sysv/linux/arm/mmap64.S
@@ -43,9 +43,9 @@ ENTRY (__mmap64)
 	cfi_rel_offset (r4, 0)
 	cfi_remember_state
 	movs	r4, ip, lsl $20		@ check that offset is page-aligned
-	mov	ip, ip, lsr $12
+	mov	ip, ip, lsr $16
 	it	eq
-	movseq	r4, r5, lsr $12		@ check for overflow
+	movseq	r4, r5, lsr $16		@ check for overflow
 	bne	.Linval
 	ldr	r4, [sp, $8]		@ load fd
 	orr	r5, ip, r5, lsl $20	@ compose page offset
