From: arasv@magellan-technology.com (Aras Vaichas)
Date: Tue, 26 Oct 2010 09:48:40 +1100
Subject: cmpxchg() in recent kernels
In-Reply-To: <20101025151319.GA21105@n2100.arm.linux.org.uk>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
	<20101024214338.GB878@boggieman.bredbandsbolaget.se>
	<20101024220846.GA6041@n2100.arm.linux.org.uk>
	<AANLkTi=sRPzP+SJRpWY4QXtikVFqVVX3tizX5f+17e=B@mail.gmail.com>
	<20101025151319.GA21105@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimyOYEh0gCZTF3JsXeVT3UwoK1VcXgx+zscZmj1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 October 2010 02:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 25, 2010 at 12:33:49PM +1100, Aras Vaichas wrote:
>> On 25 October 2010 09:08, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >
>> > On Sun, Oct 24, 2010 at 11:43:38PM +0200, Kristoffer Ericson wrote:
>> > > Im seeing something similiar, using GCC 3.4.5
>> > > ARM HP Jornada 720, 2.6.36
>> snip ...
>> > > kernel/built-in.o(.text+0x1d038): In function `alloc_pid':
>> > > include/asm-generic/cmpxchg-local.h:42: undefined reference to `wrong_size_cmpxchg'
>> > > make: *** [.tmp_vmlinux1] Error 1
>> >
>> > Probably needs to be bisected, but I think in the long run we'll have
>> > to accept that gcc 4 will become the minimum compiler version.
>>
>> I just tested a build with GCC 4.2.3 and it linked correctly. The only
>> problem is that the kernel image size is now 3x as big.
>>
>>
>> Using gcc-3.4.4-glibc-2.3.5:
>>
>> * fails to link without patch to cmpxchg-local.h, but size is similar
>> to my previous builds
>>
>> Created: ? ? ?Mon Oct 25 11:59:04 2010
>> Image Type: ? ARM Linux Kernel Image (gzip compressed)
>> Data Size: ? ?1471354 Bytes = 1436.87 kB = 1.40 MB
>>
>>
>> Using gcc-4.2.3-glibc-2.7:
>>
>> * compiles and links correctly, but size is way too big
>>
>> Created: ? ? ?Mon Oct 25 11:48:26 2010
>> Image Type: ? ARM Linux Kernel Image (gzip compressed)
>> Data Size: ? ?4576155 Bytes = 4468.90 kB = 4.36 MB
>
> This sounds like a regression - can you please bisect to try and find
> which change caused tihs?

OK, problem solved. I had this problem:
http://lists.busybox.net/pipermail/buildroot/2008-June/021158.html

The fix for this problem was included as a patch for the kernel as shown here:
http://lists.busybox.net/pipermail/buildroot/2008-June/021162.html

But my U-Boot uImage build script does its own objcopy and thus didn't
get patched. I've added the extra objcopy arguments to my script and
my final image size is now 1.36MB.

For reference, this is my uImage make script:

make ARCH=arm CROSS_COMPILE=${CROSS_PATH} INSTALL_MOD_PATH=${FS_PATH} Image

${CROSS_PATH}objcopy -O binary -R .note -R .note.gnu.build-id -R
.comment -S vmlinux linux.bin

gzip -v9 linux.bin

${MKIMAGE} -A arm -O linux -C gzip -a 0x20008000 -e 0x20008000 -d
linux.bin.gz uImage


Aras
