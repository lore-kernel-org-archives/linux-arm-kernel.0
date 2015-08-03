From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sun, 2 Aug 2015 23:49:55 -0300
Subject: [PATCH v2 0/4] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <87wpxufw2v.fsf@belgarion.home>
References: <1436281707-20106-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150717134159.GC10608@kwain>
 <55A912F0.7080605@vanguardiasur.com.ar>
 <87h9p2is8e.fsf@belgarion.home>
 <CAAEAJfCcdioVQKZs9U3DP6H94BiuQ2qU21DsMKevS5+j+-XEKA@mail.gmail.com>
 <87wpxufw2v.fsf@belgarion.home>
Message-ID: <CAAEAJfB3caa+DmJN=Pa8brx0uGC11QA29KJb3NQdJjXTgw-yuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 July 2015 at 16:49, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> writes:
>
>> Here you go:
>>
>> http://git.infradead.org/users/ezequielg/linux/shortlog/refs/heads/pxa3xx-nand-timing-rework-v2
>
> Okay, I've tested this on cm-x300. The result is not bright :
>         nand: device found, Manufacturer ID: 0xec, Chip ID: 0xdc
>         nand: Samsung NAND 512MiB 3,3V 8-bit
>         nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
>         pxa3xx-nand pxa3xx-nand: ECC strength 1, ECC step size 512
>         Scanning device for bad blocks
>         random: nonblocking pool is initialized
>         Bad eraseblock 1037 at 0x0000081a0000
>         Creating 6 MTD partitions on "pxa3xx_nand-0":
>         0x000000000000-0x000000040000 : "OBM"
>         0x000000040000-0x000000080000 : "U-Boot"
>         0x000000080000-0x0000000c0000 : "Environment"
>         0x0000000c0000-0x000000200000 : "reserved"
>         0x000000200000-0x000000600000 : "kernel"
>         0x000000600000-0x000020000000 : "fs"
>
> The bad black is not bad normally.
> And then :
>         # dd if=/dev/mtd0 of=toto count=1
>         pxa3xx-nand pxa3xx-nand: Wait time out!!!
>         1+0 records in
>         1+0 records out
>         # ls -l toto
>         -rw-r--r--    1 root     root           512 Jan  1 00:02 toto
>         # hexdump-C toto
>         00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
>         *
>         00000200
>
> That's not possible, as it should have dumped the OBMI.
>
> And yet, I hesitate to incriminate this patchset, I will try without it. It wont
> be very fast, as my USB to serial converter just broke, and my order will take a
> couple of days to complete.
>

Just tested linux-next (hence *without* the patchset) and I see
the same "Wait time out". In other words, pxa3xx-nand is broken
on PXA :/

Interestingly, the culprit doesn't seem to be in pxa3xx-nand itself.
Reverting the recent commits on pxa3xx-nand doesn't help.

ce914e6 mtd: nand: pxa3xx: fix build on ARM64
afca11e mtd: nand: pxa3xx: Switch FIFO draining to jiffies-based timeout
e5860c1 mtd: pxa3xx_nand: cleanup wait_for_completion handling
7c2f717 mtd: pxa3xx_nand: initialiaze pxa3xx_flash_ids to 0
ed446cc Merge MTD updates into -next
e423c90 mtd: pxa3xx_nand: fix driver when num_cs is 0
2454225 mtd: pxa3xx-nand: handle PIO in threaded interrupt
8dad038 mtd: nand: pxa3xx: Fix PIO FIFO draining
b7e46062 mtd: pxa3xx_nand: make the driver work on big-endian systems
5b3e507 mtd: nand: pxa3xx: Use ECC strength and step size devicetree binding
eee0166 mtd: nand: pxa3xx: Clean pxa_ecc_init() error handling
17754ad mtd: nand: pxa3xx: Make of_device_id array const
e634ce5 mtd: nand: pxa3xx: Print actual ECC strength in error message

Yet v3.18 succeeds to pass a few NAND blocks on nandtest.

Robert: any ideas?
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
