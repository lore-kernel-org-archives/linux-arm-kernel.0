From: Claudiu.Beznea@microchip.com (Claudiu Beznea)
Date: Thu, 21 Jun 2018 16:16:24 +0300
Subject: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
In-Reply-To: <5b66cafe-782e-43a9-c221-cf0a1528f382@gmail.com>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <20180618114920.654647c0@bbrezillon>
 <8474a744-5552-932f-7ba8-85b7d95368ea@gmail.com>
 <0be344a2-9878-2b92-9436-bc2f4d4fd6e0@microchip.com>
 <5b66cafe-782e-43a9-c221-cf0a1528f382@gmail.com>
Message-ID: <e0259cda-2334-946f-fc3f-25c64a4f721b@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 19.06.2018 04:28, Marek Vasut wrote:
> On 06/18/2018 02:00 PM, Claudiu Beznea wrote:
>>
>>
>> On 18.06.2018 12:53, Marek Vasut wrote:
>>> On 06/18/2018 11:49 AM, Boris Brezillon wrote:
>>>> Hi Claudiu,
>>>>
>>>> The subject prefix should be "mtd: spi-nor: atmel-quadspi: ". No need
>>>> to send a new version just for that, I'll fix it when applying the
>>>> patch.
>>>>
>> Hi Boris,
>>
>> Thank you!
>>
>>>> Looks good otherwise. Marek, any objection? If not, can you add your
>>>> Acked-by?
>>>
>>> Will this work if you have ie. ubifs mounted on that QSPI NOR and you
>>> suspect and resume during IO ? I think it would, but just curious if
>>> there could be some problem.
>>
>> Hi Marek,
>>
>> I tested only with read/writes while suspending, simple scripts, but not
>> having ubifs mounted on QSPI NOR. I will double check also with ubifs
>> mounted on QSPI NOR and come back with the results.
> 
> Thanks. I think it's gonna be OK, but let's just be sure.
> Make sure to disable 4K sector support when fiddling with UBI/UBIFS on
> QSPI NOR.

I did the following to test this patch with ubifs:
1. disabled CONFIG_MTD_SPI_NOR_USE_4K_SECTORS and build kernel

2. create a ubifs image:
mkfs.ubifs -r /mnt/ubifs-sama5d2-rootfs -m 1 -e 65408 -c 3739 \
 -o /mnt/sama5d2-xplained-ubifs.img

3. boot the board and check partitions:
cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00010000 00010000 "at91bootstrap"
mtd1: 00010000 00010000 "bootloader env"
mtd2: 00050000 00010000 "bootloader"
mtd3: 00010000 00010000 "device tree"
mtd4: 00380000 00010000 "kernel"
mtd5: 01c00000 00010000 "rootfs"
mtd6: 00400000 00010000 "spi32766.0"

4. ubiformat /dev/mtd5
5. ubiattach -p /dev/mtd5
6. ubimkvol /dev/ubi0 -N test -s 28910336
7. ubiupdatevol /dev/ubi0_0 /sama5d2-xplained-buildroot-ubifs.img
8. mount -t ubifs ubi0:test /mnt
9. cd /mnt/; ls /mnt/
bin      lib      media    proc     sbin     usr
dev      lib32    mnt      root     sys      var
etc      linuxrc  opt      run      tmp

10. Create a file with dd on ubifs partition:
dd if=/dev/urandom of=test.bin bs=1024 count=8K

11. compute md5sum on this file:
md5sum test.bin > test.md5

12. Measure how much will take to copy that file (to be sure the copy
operation is not done before suspending):

date; cp test.bin test-pm.bin; date
Wed Jun 20 13:20:34 UTC 2018
Wed Jun 20 13:21:14 UTC 2018

13. Copy, sync, and switch to suspend-to-mem:

cp test.bin test-pm.bin &
sync &
echo mem > /sys/power/state

14. Check md5sum of test-pm.bin and compare it with md5sum of test.bin:
md5sum test-pm.bin > test-pm.md5
cat test.md5
b5338647572b9665f24c61db98601522  test.bin
cat test-pm.md5
b5338647572b9665f24c61db98601522  test-pm.bin

Please let me know if this is enough!

Thank you,
Claudiu Beznea
