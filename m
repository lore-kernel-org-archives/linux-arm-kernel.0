From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Aug 2011 14:44:21 +0200
Subject: PB1176 broken in -rc1
In-Reply-To: <20110816095936.GE28656@e102144-lin.cambridge.arm.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
	<20110816092615.GC28656@e102144-lin.cambridge.arm.com>
	<CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
	<20110816095936.GE28656@e102144-lin.cambridge.arm.com>
Message-ID: <CACRpkdY3_1cnsNuxy2bYgFcrcxEegx_6eSGDSsU9mpQZePAMhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 11:59 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Aug 16, 2011 at 10:35:08AM +0100, Linus Walleij wrote:
>>
>> scripts/config --file $(realview_dir)/.config \
>> ? ? ? ? --enable BLK_DEV_INITRD \
>> ? ? ? ? --set-str INITRAMFS_SOURCE rootfs-u338.cpio \
>> ? ? ? ? --enable INITRAMFS_COMPRESSION_NONE \
>> ? ? ? ? --enable MISC_DEVICES \
>> ? ? ? ? --enable ARM_CHARLCD \
>> ? ? ? ? --enable DEBUG_LL \
>> ? ? ? ? --enable EARLY_PRINTK \
>> ? ? ? ? --enable ARM_TEST \
>> ? ? ? ? --enable ARM_TCM_TEST \
>> ? ? ? ? --set-str CMDLINE "root=/dev/ram0 console=ttyAMA0 earlyprintk mem=128M"
>> ? ? ? ? yes "" | make $(make_options) oldconfig
>
> The problem is with earlyprintk because your picking up multiple definitions
> of DEBUG_LL_UART_OFFSET as a result of basing your config on the defconfig.

Well doesn't cure it for me I'm afraid, I've added DEBUG_LL and
EARLY_PRINTK here just because it wasn't booting, in the hopes
of catching some early debug messages.

But I do realize I should config out the other platforms and build a
kernel only for the PB1176 when I wanna use that...

Some twiddling reveals that it's that initramfs that breaks it
and only if you use TCM at the same time (!)

The most probably cause being that the size of the combined
kernel+initramfs passed the magic limit where it simply breaks,
I wish we could handle that in some good way :-/

Oh well, no disastrous problem anyway, I'll have to start using
an NFS rootfs like everyone else.

>> - ? ? /* Allocate some TCM memory from the pool */
>> - ? ? tcmem = tcm_alloc(20);
>> - ? ? if (tcmem) {
>> - ? ? ? ? ? ? printk("TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
>> - ? ? ? ? ? ? tcmem[0] = 0xDEADBEEFU;
>> - ? ? ? ? ? ? tcmem[1] = 0x2BADBABEU;
>> - ? ? ? ? ? ? tcmem[2] = 0xCAFEBABEU;
>> - ? ? ? ? ? ? tcmem[3] = 0xDEADBEEFU;
>> - ? ? ? ? ? ? tcmem[4] = 0x2BADBABEU;
>
> Hmm, do you need a barrier here to (a) stop the compiler constant folding
> the tcm array and (b) force a read back from the TCM? Also, where does the
> TCM sit in relation to the L1 cache (yes, I should RTFM...).

Nope, the TCM is uncached, no problems. The Address and data
bus just go directly to the in-CPU memory.

>> + ? ? if (tcmem) {
>> + ? ? ? ? ? ? pr_info("CPU: TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
>> + ? ? ? ? ? ? tcmem[0] = CANARY1;
>> + ? ? ? ? ? ? tcmem[1] = CANARY2;
>> + ? ? ? ? ? ? tcmem[2] = CANARY3;
>> + ? ? ? ? ? ? tcmem[3] = CANARY1;
>> + ? ? ? ? ? ? tcmem[4] = CANARY2;
>
> And again here?

The above deletion from Documentation/. appears as an insertion here...

Thanks,
Linus Walleij
