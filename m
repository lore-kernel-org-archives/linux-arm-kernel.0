From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 02 Dec 2013 22:05:28 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
 <20131202103305.GB2466@localhost>
Message-ID: <87siubneuf.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

>> Here is the nandtest run:
>> 
>>   nandtest /dev/mtd4
>>   ECC corrections: 0
>>   ECC failures   : 0
>>   Bad blocks     : 8
>>   BBT blocks     : 0
>>   Bad block at 0x06700000
>>   Bad block at 0x06720000
>>   Bad block at 0x06740000
>>   Bad block at 0x06760000
>>   Bad block at 0x06780000
>>   Bad block at 0x067a0000
>>   Bad block at 0x067c0000
>>   Bad block at 0x067e0000
>>   
>>   Finished pass 1 successfully
>> 
>
> Hm, so something *is* working properly. Notice that mtd4 has its 8 last blocks
> marked 'bad' becuase it holds the bad block table.

I think I am missing something here: u-boot reports that the BBT are
located here:

  >>  Bad block table found at page 65472, version 0x01
  >>  Bad block table found at page 65408, version 0x01

which seems to indicate that they are each 64 pages (i.e. 128KB)
long. AFAICT, the log output seems to indicate that blocks are
128KB in size:

  >>   Bad block at 0x06700000
  >>   Bad block at 0x06720000
  >>   Bad block at 0x06740000
  >>   Bad block at 0x06760000
  >>   Bad block at 0x06780000
  >>   Bad block at 0x067a0000
  >>   Bad block at 0x067c0000
  >>   Bad block at 0x067e0000

which is also what mtdinfo reports:

  root at mood:~# mtdinfo /dev/mtd4
  mtd4
  Name:                           jffs2
  Type:                           nand
  Eraseblock size:                131072 bytes, 128.0 KiB
  Amount of eraseblocks:          832 (109051904 bytes, 104.0 MiB)
  Minimum input/output unit size: 2048 bytes
  Sub-page size:                  2048 bytes
  OOB size:                       64 bytes
  Character device major/minor:   90:8
  Bad blocks are allowed:         true
  Device is writable:             true
  
So unless I am missing something, *according* to u-boot there are 2 BBT
and each BBT is 1 block long. 

Additionally - and this is a point I would like to understand - the
reported location of this BBT is not after the 128MB of the chip but
before the end of those 128MB. This also means before the end of the
last partition. So the definition of the partition itsef gives the
impression that all the blocks in the partition are available when in
fact, the last two blocks cannot be used at all (or 8 if you are
right). Put in a different manner, if I nandwrite a 104.0 MiB image to
the last partition (/dev/mtd4), I am guaranteed to try and overwrite the
BBT. 

Do not hesitate to tell me what I am missing here or if it is
expected that the partition definition (start address and length)
*includes* the bbt pages/blocks.

> If you don't mind running a few more rounds, then it would be nice to do:
>
>   $ nandtest --passes {N}
>
> So we run the test a few more times, just to be sure.

root at mood:~# nandtest --passes 2 /dev/mtd4
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 8
BBT blocks     : 0
Bad block at 0x06700000
Bad block at 0x06720000
Bad block at 0x06740000
Bad block at 0x06760000
Bad block at 0x06780000
Bad block at 0x067a0000
Bad block at 0x067c0000
Bad block at 0x067e0000

Finished pass 1 successfully
Bad block at 0x06700000
Bad block at 0x06720000
Bad block at 0x06740000
Bad block at 0x06760000
Bad block at 0x06780000
Bad block at 0x067a0000
Bad block at 0x067c0000
Bad block at 0x067e0000

Finished pass 2 successfully

>>   root at mood:~# nandwrite -p /dev/mtd4 /tmp/toto
>>   ...
>>   Writing data to block 795 at offset 0x6360000
>>   Writing data to block 796 at offset 0x6380000
>>   Writing data to block 797 at offset 0x63a0000
>>   Writing data to block 798 at offset 0x63c0000
>>   Writing data to block 799 at offset 0x63e0000
>>   Writing data to block 800 at offset 0x6400000
>>   [ 1509.210395] pxa3xx-nand d00d0000.nand: Ready time out!!!
>>   libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 800, offset 0)
>>           error 5 (Input/output error)
> [..]
>
>>   [ 1513.810387] pxa3xx-nand d00d0000.nand: Ready time out!!!
>>   libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 823, offset 0)
>>           error 5 (Input/output error)
>>   Erasing failed write from 0x66e0000 to 0x66fffff
>
> Hm.. so you get errors when writing to mtd4 blocks from 800 to 823.
>
> Is that completely reproducible, IOW do you get always the error
> on those blocks?

Well, I did the same test again, and I think the answer is 'no':

root at mood:~# dd if=/dev/mtd4 of=/tmp/toto
212992+0 records in
212992+0 records out
109051904 bytes (109 MB) copied, 11.136 s, 9.8 MB/s

root at mood:~# flash_erase /dev/mtd4 0 0
Erasing 128 Kibyte @ 66e0000 -- 98 % complete flash_erase: Skipping bad block at 06700000
flash_erase: Skipping bad block at 06720000
flash_erase: Skipping bad block at 06740000
flash_erase: Skipping bad block at 06760000
flash_erase: Skipping bad block at 06780000
flash_erase: Skipping bad block at 067a0000
flash_erase: Skipping bad block at 067c0000
flash_erase: Skipping bad block at 067e0000
Erasing 128 Kibyte @ 67e0000 -- 100 % complete 

root at mood:~# nandwrite -p /dev/mtd4 /tmp/toto
Writing data to block 0 at offset 0x0
Writing data to block 1 at offset 0x20000
Writing data to block 2 at offset 0x40000
Writing data to block 3 at offset 0x60000
Writing data to block 4 at offset 0x80000
Writing data to block 5 at offset 0xa0000
Writing data to block 6 at offset 0xc0000
Writing data to block 7 at offset 0xe0000
...
Writing data to block 818 at offset 0x6640000
Writing data to block 819 at offset 0x6660000
Writing data to block 820 at offset 0x6680000
Writing data to block 821 at offset 0x66a0000
Writing data to block 822 at offset 0x66c0000
Writing data to block 823 at offset 0x66e0000
Writing data to block 824 at offset 0x6700000
Bad block at 6700000, 1 block(s) from 6700000 will be skipped
Writing data to block 825 at offset 0x6720000
Bad block at 6720000, 1 block(s) from 6720000 will be skipped
Writing data to block 826 at offset 0x6740000
Bad block at 6740000, 1 block(s) from 6740000 will be skipped
Writing data to block 827 at offset 0x6760000
Bad block at 6760000, 1 block(s) from 6760000 will be skipped
Writing data to block 828 at offset 0x6780000
Bad block at 6780000, 1 block(s) from 6780000 will be skipped
Writing data to block 829 at offset 0x67a0000
Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
Writing data to block 830 at offset 0x67c0000
Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
Writing data to block 831 at offset 0x67e0000
Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
Writing data to block 832 at offset 0x6800000
libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
nandwrite: error!: /dev/mtd4: MTD get bad block failed
           error 22 (Invalid argument)
nandwrite: error!: Data was only partially written due to error
           error 22 (Invalid argument)
root at mood:~# 

Well, this time I don't get the "ready timeout" error I had last
time around block 800. I did the test a second time (flash_erase and
then nandwrite) and got the same result, i.e. no error before 824.


>>   Writing data to block 824 at offset 0x6700000
>>   Bad block at 6700000, 1 block(s) from 6700000 will be skipped
>>   Writing data to block 825 at offset 0x6720000
>>   Bad block at 6720000, 1 block(s) from 6720000 will be skipped
>>   Writing data to block 826 at offset 0x6740000
>>   Bad block at 6740000, 1 block(s) from 6740000 will be skipped
>>   Writing data to block 827 at offset 0x6760000
>>   Bad block at 6760000, 1 block(s) from 6760000 will be skipped
>>   Writing data to block 828 at offset 0x6780000
>>   Bad block at 6780000, 1 block(s) from 6780000 will be skipped
>>   Writing data to block 829 at offset 0x67a0000
>>   Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
>>   Writing data to block 830 at offset 0x67c0000
>>   Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
>>   Writing data to block 831 at offset 0x67e0000
>>   Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
>>   Writing data to block 832 at offset 0x6800000
>>   libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
>>   nandwrite: error!: /dev/mtd4: MTD get bad block failed
>>              error 22 (Invalid argument)
>>   nandwrite: error!: Data was only partially written due to error
>>              error 22 (Invalid argument)
>>   
>
> These 8 blocks (824-832) that has been skipped are the ones marked
> as 'bad' because they hold the bad block table.
>
>> This is the kind of errors I got last time but I think am starting to
>> understand the root cause now. Tell me if I get it right: what is
>> understood as bad blocks above (and in nandtest) is in fact the two bad
>> block tables reported during boot:
>> 
>>  NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
>>  NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
>>  Bad block table found at page 65472, version 0x01
>>  Bad block table found at page 65408, version 0x01
>> 
>
> Yes and no :-) The bad block table consists of 8 blocks at the end
> of the flash device. These blocks are marked as 'reserved' and nandtest
> or any other userspace writing/erasing tool will skip them.
>
> Hence, the bad block table is what explains the skipping of the group
> of blocks [824..832]. However, you're getting errors when writing
> data to [800..823], and it's a "Ready timeout" condition. I'm not sure
> exactly what's going on, but we can say that:
>
>   * Either the waiting time is not enough, or ...
>
>   * The commands (maybe some race) were badly issued so there's nothing
>     to wait at all.

As I can not reproduce previous behavior (I am on the exact same
kernel), I guess it's difficult to go any further yet.

Cheers,

a+
