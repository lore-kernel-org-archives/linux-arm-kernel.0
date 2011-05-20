From: zonque@gmail.com (Daniel Mack)
Date: Fri, 20 May 2011 08:38:46 +0200
Subject: PXA3xx NAND controller support broken in 2.6.39
In-Reply-To: <BANLkTim+Ndafbs6Cram6FpHUcJ1yxtXuRw@mail.gmail.com>
References: <BANLkTimos3-Ds4Y8FDfDZegqAhH7nSS4PA@mail.gmail.com>
	<BANLkTim+Ndafbs6Cram6FpHUcJ1yxtXuRw@mail.gmail.com>
Message-ID: <BANLkTinU277aSu4_p61qEBskHSTyfYYCfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On Fri, May 20, 2011 at 6:21 AM, Lei Wen <adrian.wenl@gmail.com> wrote:
>> On a raumfeld board (which has its board support code in mainline),
>> the effect is:
>>
>> [ ? ?1.803796] Wait time out!!!
>> [ ? ?2.003795] Wait time out!!!
>> [ ? ?2.203780] Wait time out!!!
>> [ ? ?2.403779] Wait time out!!!
>> [ ? ?2.406643] No NAND device found.
>> [ ? ?2.409939] pxa3xx-nand pxa3xx-nand: failed to scan nand
>> [ ? ?2.418850] UBI error: ubi_init: UBI error: cannot initialize UBI, error -19
>>
>>
>> With the code in 2.6.38, it works just fine. Any detailed debug output
>> you want me to provide in order to fix it?
>>
> Please try the patch I just send out.
> MTD: pxa3xx_nand: fix nand detection issue

Thank for the quick response. Your patch fixes the detection, but read
operations won't succeed now:

[    1.602733] NAND device: Manufacturer ID: 0x20, Chip ID: 0xa1 (ST
Micro NAND 128MiB 1,8V 8-bit)
[    1.611426] Scanning device for bad blocks
[    1.870669] Creating 4 MTD partitions on "pxa3xx_nand-0":
[    1.876099] 0x000000000000-0x0000000a0000 : "Bootloader"
[    1.885350] 0x0000000a0000-0x0000000c0000 : "BootloaderEnvironment"
[    1.895608] 0x0000000c0000-0x000000120000 : "BootloaderSplashScreen"
[    1.905996] 0x000000120000-0x000008000000 : "UBI"
[    1.916999] UBI: attaching mtd3 to ubi0
[    1.920835] UBI: physical eraseblock size:   131072 bytes (128 KiB)
[    1.927165] UBI: logical eraseblock size:    126976 bytes
[    1.932553] UBI: smallest flash I/O unit:    2048
[    1.937227] UBI: VID header offset:          2048 (aligned 2048)
[    1.943215] UBI: data offset:                4096
[    1.950080] UBI error: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 0:2048, read 2048 bytes
[    2.041030] UBI error: ubi_io_read: error -74 (ECC error) while
reading 126976 bytes from PEB 0:4096, read 126976 bytes
[    2.053445] UBI error: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 1:2048, read 2048 bytes
[    2.144350] UBI error: ubi_io_read: error -74 (ECC error) while
reading 126976 bytes from PEB 1:4096, read 126976 bytes

(continues forever)

The same NAND content is readable just fine with 2.6.38. Is there a
similar bug for the timing parameters maybe?


Daniel
