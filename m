From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 03 Dec 2013 22:25:14 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
References: <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
 <20131202103305.GB2466@localhost> <87siubneuf.fsf@natisbad.org>
 <20131203002225.GA5333@localhost> <87ob4xbs8l.fsf@natisbad.org>
Message-ID: <87iov5aapx.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

arno at natisbad.org (Arnaud Ebalard) writes:

> So I guess, if you have any (non hardware destructive ;-) ) idea, I now
> have a platform on which the problem is reproducible. Meanwhile, I will
> try and do the same on my RN104 (should be the same as the RN102).

Well, on the RN104 (same chip, same kernel and same SoC as the RN102), I
have the following (I get the same with a patched driver to increase the
timeout):

root at humble:~# flash_erase /dev/mtd4 0 0 
Erasing 128 Kibyte @ 72e0000 -- 99 % complete flash_erase: Skipping bad block at 07300000
flash_erase: Skipping bad block at 07320000
flash_erase: Skipping bad block at 07340000
flash_erase: Skipping bad block at 07360000
flash_erase: Skipping bad block at 07380000
flash_erase: Skipping bad block at 073a0000
flash_erase: Skipping bad block at 073c0000
flash_erase: Skipping bad block at 073e0000
Erasing 128 Kibyte @ 73e0000 -- 100 % complete 

root at humble:~# nandwrite -p /dev/mtd4 mtd4ro 
Writing data to block 0 at offset 0x0
[  449.915173] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 00000000 to 0x01ffff
Writing data to block 1 at offset 0x20000
[  450.115172] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x020000 to 0x03ffff
Writing data to block 2 at offset 0x40000
[  450.315171] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x040000 to 0x05ffff
Writing data to block 3 at offset 0x60000
[  450.515171] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 3, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x060000 to 0x07ffff
Writing data to block 4 at offset 0x80000
[  450.715169] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 4, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x080000 to 0x09ffff
Writing data to block 5 at offset 0xa0000
[  450.915171] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 5, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0a0000 to 0x0bffff
Writing data to block 6 at offset 0xc0000
[  451.115171] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 6, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0c0000 to 0x0dffff
Writing data to block 7 at offset 0xe0000


So I then did the same test again on the RN102 by doing a flash_erase on
/dev/mtd4 and then a nandwrite: it worked as expected (errors only at
the end when trying to overwrite the reserved block for the BBT).

The only difference I can see between RN104/RN2120 and RN102 is the
debian: the three are jessie but the one on the RN102 I used is armel
when the ones on the RN104 and RN2120 are armhf (all kernels are
armel).

Cheers,

a+

ps: I can provide the config files for each device's kernel if you think
a specific option (debug or something else) may have an impact on how the
driver behave.
