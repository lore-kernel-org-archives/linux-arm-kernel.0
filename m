From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 04 Dec 2013 21:48:04 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131204142009.GB2486@localhost> (Ezequiel Garcia's message of
 "Wed, 4 Dec 2013 11:20:10 -0300")
References: <20131126124003.GA2344@localhost> <87zjopd240.fsf@natisbad.org>
 <87wqjtbm8r.fsf@natisbad.org> <20131128185040.GA13182@localhost>
 <87bo12kcyt.fsf@natisbad.org> <20131202103305.GB2466@localhost>
 <87siubneuf.fsf@natisbad.org> <20131203002225.GA5333@localhost>
 <87ob4xbs8l.fsf@natisbad.org> <87iov5aapx.fsf@natisbad.org>
 <20131204142009.GB2486@localhost>
Message-ID: <87haaogx6j.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

> Thanks a lot for the patience!

Well, if we let the machines win, it's over.


>> root at humble:~# nandwrite -p /dev/mtd4 mtd4ro 
>> Writing data to block 0 at offset 0x0
>> [  449.915173] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 00000000 to 0x01ffff
>> Writing data to block 1 at offset 0x20000
>> [  450.115172] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 0x020000 to 0x03ffff
>> Writing data to block 2 at offset 0x40000
>> [  450.315171] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 0x040000 to 0x05ffff
>> Writing data to block 3 at offset 0x60000
>> [  450.515171] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 3, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 0x060000 to 0x07ffff
>> Writing data to block 4 at offset 0x80000
>> [  450.715169] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 4, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 0x080000 to 0x09ffff
>> Writing data to block 5 at offset 0xa0000
>> [  450.915171] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 5, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 0x0a0000 to 0x0bffff
>> Writing data to block 6 at offset 0xc0000
>> [  451.115171] pxa3xx-nand d00d0000.nand: Ready time out!!!
>> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 6, offset 2048)
>>         error 5 (Input/output error)
>> Erasing failed write from 0x0c0000 to 0x0dffff
>> Writing data to block 7 at offset 0xe0000
>> 
>> 
>
> So, let me confirm this: you have systematically obtained a "Ready
> timeout" when writing to the device, on every single write to a page,
> correct?

yep, this is what I have on the RN2120.


> I'll prepare a patch against the branch we're working that adds lots of
> pr_info(). It'll be very annoying for you, but it's the only way I can
> think of, to get the driver's dirty inner sequence and to see *where*
> is failing.
>
> However, before that patch, please do a quick test for me. It's just a
> shot in the dark. The below diff removes the NDCB0_AUTO_RS flag from
> the PAGE_PROG command when the page size is 2048 byte (or less).
>
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index fd0ef93..038cf5d 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -831,7 +831,6 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
>  			}
>  		} else {
>  			info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
> -					| NDCB0_AUTO_RS
>  					| NDCB0_ST_ROW_EN
>  					| NDCB0_DBC
>  					| (NAND_CMD_PAGEPROG << 8)
>
> Please apply this diff, and then try to write at least one page. If at
> all possible you might try different approaches:
>
>   $ flash_erase /dev/mtd2 0 1
>   $ dd if=page.raw of=/dev/mtd2 bs=2048 count=1
>
>   $ flash_erase /dev/mtd2 0 1
>   $ nandwrite page.raw /dev/mtd2

That's very weird. With the patch applied (I did not redo the whole set
of tests below w/o the patch):

Let's erase the first block of /dev/mtd4

  root at thin:~# flash_erase /dev/mtd4 0 1
  Erasing 128 Kibyte @ 0 -- 100 % complete 
  
Create a 2048 byte file:

  root at thin:~# dd if=/dev/urandom of=/tmp/page.raw bs=2048 count=1
  1+0 records in
  1+0 records out
  2048 bytes (2.0 kB) copied, 0.00104352 s, 2.0 MB/s

dd that file to the first block

  root at thin:~# dd if=/tmp/page.raw of=/dev/mtd4 bs=2048 count=1
  1+0 records in
  1+0 records out
  2048 bytes (2.0 kB) copied, 0.0008344 s, 2.5 MB/s

Do the same with nandwrite:

  root at thin:~# flash_erase /dev/mtd4 0 1
  Erasing 128 Kibyte @ 0 -- 100 % complete 

  root at thin:~# nandwrite /dev/mtd4 /tmp/page.raw 
  Writing data to block 0 at offset 0x0

As it seems to work, let's now try with a complete image:
    
  root at thin:~# flash_erase /dev/mtd4 0 0
  Erasing 128 Kibyte @ 72e0000 -- 99 % complete flash_erase: Skipping bad block at 07300000
  flash_erase: Skipping bad block at 07320000
  flash_erase: Skipping bad block at 07340000
  flash_erase: Skipping bad block at 07360000
  flash_erase: Skipping bad block at 07380000
  flash_erase: Skipping bad block at 073a0000
  flash_erase: Skipping bad block at 073c0000
  flash_erase: Skipping bad block at 073e0000
  Erasing 128 Kibyte @ 73e0000 -- 100 % complete 

  root at thin:~# nandwrite /dev/mtd4 mtd4ro 
  Writing data to block 0 at offset 0x0
  [  421.406929] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
          error 5 (Input/output error)
  Erasing failed write from 00000000 to 0x01ffff
  Writing data to block 1 at offset 0x20000
  [  421.606928] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
          error 5 (Input/output error)
  Erasing failed write from 0x020000 to 0x03ffff
  Writing data to block 2 at offset 0x40000
  [  421.806928] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
          error 5 (Input/output error)
  Erasing failed write from 0x040000 to 0x05ffff
  Writing data to block 3 at offset 0x60000
  [  422.006928] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 3, offset 2048)
          error 5 (Input/output error)
  Erasing failed write from 0x060000 to 0x07ffff
  Writing data to block 4 at offset 0x80000
  [  422.206928] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 4, offset 2048)
          error 5 (Input/output error)
  Erasing failed write from 0x080000 to 0x09ffff
  Writing data to block 5 at offset 0xa0000
  ^C[  422.406926] pxa3xx-nand d00d0000.nand: Ready time out!!!

So let's try again with a single page:
  
  root at thin:~# flash_erase /dev/mtd4 0 1
  Erasing 128 Kibyte @ 0 -- 100 % complete 

  root at thin:~# nandwrite /dev/mtd4 /tmp/page.raw 
  Writing data to block 0 at offset 0x0
  
FWIW, the version of nandwrite I have on my armhf debian is the
following (no specific bug report related to that version of
mtd-utils):

  root at thin:~# nandwrite --version
  nandwrite 1.5.0
  
  Copyright (C) 2003 Thomas Gleixner 
  
  nandwrite comes with NO WARRANTY
  to the extent permitted by law.
  
  You may redistribute copies of nandwrite
  under the terms of the GNU General Public Licence.
  See the file `COPYING' for more information.

Ok, so let's see if the problem appears if we write more than 1 block:
  
  root at thin:/tmp# flash_erase /dev/mtd4 0 3
  Erasing 128 Kibyte @ 40000 -- 100 % complete 
  
  root at thin:/tmp# dd if=/dev/urandom of=/tmp/3-blocks.raw bs=128K count=3
  3+0 records in
  3+0 records out
  393216 bytes (393 kB) copied, 0.120255 s, 3.3 MB/s
  
  root at thin:/tmp# nandwrite /dev/mtd4 /tmp/3-blocks.raw 
  Writing data to block 0 at offset 0x0
  Writing data to block 1 at offset 0x20000
  Writing data to block 2 at offset 0x40000
  
Now, I am starting to wonder if nandwrite does not try and do something
smart depending on the content of the file. So let's try and replace
our "mtd4ro" file by a file of same size filled with random:
  
  root at thin:~# ls -l mtd4ro 
  -rw-r--r-- 1 arno root 121634816 Dec  3 20:30 mtd4ro
  
  root at thin:~# dd if=/dev/urandom of=/tmp/whole.raw bs=128K count=928
  928+0 records in
  928+0 records out
  121634816 bytes (122 MB) copied, 37.1333 s, 3.3 MB/s
  
  root at thin:~# flash_erase /dev/mtd4 0 1
  Erasing 128 Kibyte @ 0 -- 100 % complete 
  
  
  root at thin:~# nandwrite /dev/mtd4 /tmp/whole.raw 
  Writing data to block 0 at offset 0x0
  ...
  Writing data to block 916 at offset 0x7280000
  Writing data to block 917 at offset 0x72a0000
  Writing data to block 918 at offset 0x72c0000
  Writing data to block 919 at offset 0x72e0000
  Writing data to block 920 at offset 0x7300000
  Bad block at 7300000, 1 block(s) from 7300000 will be skipped
  Writing data to block 921 at offset 0x7320000
  Bad block at 7320000, 1 block(s) from 7320000 will be skipped
  Writing data to block 922 at offset 0x7340000
  Bad block at 7340000, 1 block(s) from 7340000 will be skipped
  Writing data to block 923 at offset 0x7360000
  Bad block at 7360000, 1 block(s) from 7360000 will be skipped
  Writing data to block 924 at offset 0x7380000
  Bad block at 7380000, 1 block(s) from 7380000 will be skipped
  Writing data to block 925 at offset 0x73a0000
  Bad block at 73a0000, 1 block(s) from 73a0000 will be skipped
  Writing data to block 926 at offset 0x73c0000
  Bad block at 73c0000, 1 block(s) from 73c0000 will be skipped
  Writing data to block 927 at offset 0x73e0000
  Bad block at 73e0000, 1 block(s) from 73e0000 will be skipped
  Writing data to block 928 at offset 0x7400000
  libmtd: error!: bad eraseblock number 928, mtd4 has 928 eraseblocks
  nandwrite: error!: /dev/mtd4: MTD get bad block failed
             error 22 (Invalid argument)
  nandwrite: error!: Data was only partially written due to error
             error 22 (Invalid argument)
  
  I don't believe it! It works as expected. As said previously, the
content of my "mtd4ro" is a simple a backup of the partition via
dd (a ubi fs):

  root at thin:~# hexdump -C mtd4ro | less
  00000000  55 42 49 23 01 00 00 00  00 00 00 00 00 00 00 02  |UBI#............|
  00000010  00 00 08 00 00 00 10 00  16 9a 76 a5 00 00 00 00  |..........v.....|
  00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  00000030  00 00 00 00 00 00 00 00  00 00 00 00 65 9c 26 3a  |............e.&:|
  00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  000007f0  00 00 00 00 00 00 00 00  00 00 00 02 00 00 00 00  |................|
  00000800  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
  *
  00020000  55 42 49 23 01 00 00 00  00 00 00 00 00 00 00 02  |UBI#............|
  00020010  00 00 08 00 00 00 10 00  16 9a 76 a5 00 00 00 00  |..........v.....|
  00020020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  00020030  00 00 00 00 00 00 00 00  00 00 00 00 65 9c 26 3a  |............e.&:|
  00020040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  000207f0  00 00 00 00 00 00 00 00  00 00 00 02 00 00 00 00  |................|
  00020800  55 42 49 21 01 01 00 00  00 00 00 00 00 00 00 00  |UBI!............|

Just to be sure, I did the test three times for each input file: mtd4ro,
whole.raw, mtd4ro, whole.raw, mtd4ro, whole.raw:

 - whole.raw: no error the three times
 - mtd4ro: errors each time

Let's now try with the first block only:

  root at thin:~# dd if=mtd4ro of=/tmp/oneblock bs=128K count=1
  1+0 records in
  1+0 records out
  131072 bytes (131 kB) copied, 0.00126152 s, 104 MB/s

  root at thin:~# flash_erase /dev/mtd4 0 1
  Erasing 128 Kibyte @ 0 -- 100 % complete 

  root at thin:~# nandwrite /dev/mtd4 /tmp/oneblock 
  Writing data to block 0 at offset 0x0
  [ 3860.346928] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
          error 5 (Input/output error)
  Erasing failed write from 00000000 to 0x01ffff
  Writing data to block 1 at offset 0x20000
  [ 3860.546928] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
          error 5 (Input/output error)
  
AFAICT, it seems someone in the process does not like the UBI fs dump I
provide: nandwrite, your driver, mtd base code or the chip.

I took a very quick look at nandwrite code and it has some options to do
smart stuff but they seem to be all disabled by default when no cmd line
option is passed.

Could you try and dump the block to another flash. As I don't think I can
attach a binary blob to this email, can you drop the following in a
python shell:

l = ["55 42 49 23 01 00 00 00  00 00 00 00 00 00 00 02",
     "00 00 08 00 00 00 10 00  16 9a 76 a5 00 00 00 00",
     "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00",
     "00 00 00 00 00 00 00 00  00 00 00 00 65 9c 26 3a",
     "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00"*0x7b,
     "00 00 00 00 00 00 00 00  00 00 00 02 00 00 00 00",
     "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff",
     "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff"*0x1f7f]

open("/tmp/block.raw", "w").write("".join(l).replace(' ', '').decode("hex"))

FWIW, you should have the following sha256 for the file:
d3e5534e054f2ab1220194c434d90fbfe9580459de887016db8e308739aa3a7b

If you have any additional idea, I am interested. I have no more time
this evening to test the other debug patch you sent but I will
definitely give it a try tomorrow.

If I did something stupid in the process, do not hesitate!

Cheers,

a+
