From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 05 Sep 2014 22:49:58 +0200
Subject: [PATCH] ARM: MVEBU: Netgear RN102: Use Hardware BCH ECC
References: <1409898233-9273-1-git-send-email-klightspeed@killerwolves.net>
 <20140905154140.GA1377@arch.hh.imgtec.org>
Message-ID: <87ha0l23nt.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

> (Fixing Cc list: dropping devicetree guys, and adding Brian and MTD instead)
>
> On 05 Sep 04:23 PM, klightspeed at killerwolves.net wrote:
>> The bootloader on the Netgear ReadyNAS RN102 uses Hardware BCH ECC
>> (strength = 4), while the pxa3xx NAND driver by default uses 
>> Hamming ECC (strength = 1).
>> 
>
> Hm, I guess the device (Hynix H27U1G8F2BTR) does not support ONFI,
> and the kernel is just taking the legacy ECC. The flash specs makes no
> mention to ONFI, so probably no ONFI here.
>
>> This patch changes the ECC mode on these machines to match that
>> of the bootloader and of the stock firmware, so that for example
>> updating the kernel is possible without requiring a serial
>> connection.
>> 
>> This patch depends on commit 5b3e507 (mtd: nand: pxa3xx: Use ECC
>> strength and step size devicetree binding)
>> 
>> Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
>
> Looks good to me, since Arnaud reports this is the correct ECC scheme:
> http://natisbad.org/NAS2/index.html#hw-nand
>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> Thanks for the fix,

w/o the patch, you can write data to the flash using userland tools from
mtd-utils package (flash_erase and nandwrite); data can then be read
again using userland tools (say using dd). But - as reported by Ben - if
you nandwrite an uImage from userland, here is what you indeed get from
u-boot when you try and boot that image:

  root at humble:~# flash_erase /dev/mtd2 0 0
  Erasing 128 Kibyte @ 5e0000 -- 100 % complete 
  
  root at humble:~# nandwrite -p /dev/mtd2 /tmp/uImage-3.16.1.rn102
  Writing data to block 0 at offset 0x0
  Writing data to block 1 at offset 0x20000
  Writing data to block 2 at offset 0x40000
  Writing data to block 3 at offset 0x60000
  Writing data to block 4 at offset 0x80000
  
  ...
  
  reboot 
  
  ...
  
  Marvell>> nand read 0x1200000 0x200000 0x600000
  
  NAND read: device 0 offset 0x200000, size 0x600000
   6291456 bytes read: OK
  
  Marvell>> bootm 0x1200000
  ## Booting kernel from Legacy Image at 01200000 ...
     Image Name:   Linux-3.16.1.rn102
     Created:      2014-08-14  13:33:46 UTC
     Image Type:   ARM Linux Kernel Image (uncompressed)
     Data Size:    4423998 Bytes =  4.2 MB
     Load Address: 00008000
     Entry Point:  00008000
     Verifying Checksum ... Bad Data CRC
  ERROR: can't get kernel image!
  

Now, w/ the patch submitted by Ben, here is what you get:

  With the patch applied, this indeed works has 
  ## Booting kernel from Legacy Image at 01200000 ...
     Image Name:   Linux-3.16.1.rn102
     Created:      2014-09-05  20:25:34 UTC
     Image Type:   ARM Linux Kernel Image (uncompressed)
     Data Size:    4424067 Bytes =  4.2 MB
     Load Address: 00008000
     Entry Point:  00008000
     Verifying Checksum ... OK
     Loading Kernel Image ... OK
  OK
  
  Starting kernel ...

i.e. it works.  

So, thanks for reporting this, Ben. I must confess I got used to update
my kernels from u-boot and did not take enough attention to that
aspect when I updated the .dts to add access to NAND after Ezequiel
wrote the NAND driver. I will take a look at RN104 and RN2120 to check
if something similar is needed for those two.

FWIW, you can add my:

 Tested-by: Arnaud Ebalard <arno@natisbad.org>
 
Additionally, Ezequiel, would anything prevent pushing the patch to
stable team (nand entry in .dts was added in 3.14):

 Fixes: 92beaccd8b49 ("ARM: mvebu: Enable NAND controller in ReadyNAS 102 .dts file")

Cheers,

a+
