From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 05 Dec 2013 21:42:25 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87haaogx6j.fsf@natisbad.org> (Arnaud Ebalard's message of "Wed,
 04 Dec 2013 21:48:04 +0100")
References: <20131126124003.GA2344@localhost> <87zjopd240.fsf@natisbad.org>
 <87wqjtbm8r.fsf@natisbad.org> <20131128185040.GA13182@localhost>
 <87bo12kcyt.fsf@natisbad.org> <20131202103305.GB2466@localhost>
 <87siubneuf.fsf@natisbad.org> <20131203002225.GA5333@localhost>
 <87ob4xbs8l.fsf@natisbad.org> <87iov5aapx.fsf@natisbad.org>
 <20131204142009.GB2486@localhost> <87haaogx6j.fsf@natisbad.org>
Message-ID: <87d2lbrpvy.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

arno at natisbad.org (Arnaud Ebalard) writes:

> Could you try and dump the block to another flash. As I don't think I can
> attach a binary blob to this email, can you drop the following in a
> python shell:
>
> l = ["55 42 49 23 01 00 00 00  00 00 00 00 00 00 00 02",
>      "00 00 08 00 00 00 10 00  16 9a 76 a5 00 00 00 00",
>      "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00",
>      "00 00 00 00 00 00 00 00  00 00 00 00 65 9c 26 3a",
>      "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00"*0x7b,
>      "00 00 00 00 00 00 00 00  00 00 00 02 00 00 00 00",
>      "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff",
>      "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff"*0x1f7f]
>
> open("/tmp/block.raw", "w").write("".join(l).replace(' ', '').decode("hex"))
>
> FWIW, you should have the following sha256 for the file:
> d3e5534e054f2ab1220194c434d90fbfe9580459de887016db8e308739aa3a7b
>
> If you have any additional idea, I am interested. I have no more time
> this evening to test the other debug patch you sent but I will
> definitely give it a try tomorrow.

I reused the block above to test on the kernel w/ your debug patch
applied:

root at thin:~# python
Python 2.7.6 (default, Nov 19 2013, 18:53:23) 
[GCC 4.8.2] on linux2
Type "help", "copyright", "credits" or "license" for more information.
l = ["55 42 49 23 01 00 00 00  00 00 00 00 00 00 00 02",
     "00 00 08 00 00 00 10 00  16 9a 76 a5 00 00 00 00",
     "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00",
     "00 00 00 00 00 00 00 00  00 00 00 00 65 9c 26 3a",
     "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00"*0x7b,
     "00 00 00 00 00 00 00 00  00 00 00 02 00 00 00 00",
     "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff",
     "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff"*0x1f7f]

>>> l = ["55 42 49 23 01 00 00 00  00 00 00 00 00 00 00 02",
...      "00 00 08 00 00 00 10 00  16 9a 76 a5 00 00 00 00",
...      "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00",
...      "00 00 00 00 00 00 00 00  00 00 00 00 65 9c 26 3a",
...      "00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00"*0x7b,
...      "00 00 00 00 00 00 00 00  00 00 00 02 00 00 00 00",
...      "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff",
...      "ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff"*0x1f7f]
>>>
>>> open("/tmp/block.raw", "w").write("".join(l).replace(' ', '').decode("hex")) root at thin:~#

root at thin:/sys/kernel/debug/dynamic_debug# flash_erase /dev/mtd4 0 1
Erasing 128 Kibyte @ 0 -- 100 % complete 

root at thin:/sys/kernel/debug/dynamic_debug# nandwrite /dev/mtd4 /tmp/block.raw 
Writing data to block 0 at offset 0x0
[  784.543390] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 00000000 to 0x01ffff
Writing data to block 1 at offset 0x20000
[  784.743391] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x020000 to 0x03ffff
Writing data to block 2 at offset 0x40000
[  784.943390] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x040000 to 0x05ffff
Writing data to block 3 at offset 0x60000
[  785.143391] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 3, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x060000 to 0x07ffff
Writing data to block 4 at offset 0x80000
[  785.343388] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 4, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x080000 to 0x09ffff
Writing data to block 5 at offset 0xa0000
[  785.543390] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 5, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0a0000 to 0x0bffff
Writing data to block 6 at offset 0xc0000
[  785.743390] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 6, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0c0000 to 0x0dffff
Writing data to block 7 at offset 0xe0000

And here is what I get in kernel logs:

[  766.262816] Command0 0x810070
[  766.262827] Command1 0x0
[  766.262833] Command2 0x0
[  766.262838] Command3 0x0
[  766.262853] Command0 0x24bd060
[  766.262858] Command1 0x1800
[  766.262863] Command2 0x0
[  766.262868] Command3 0x0
[  766.263617] Status: ready
[  766.263937] Waiting for device to be ready
[  766.263945] Device is ready
[  784.345577] Command0 0x810070
[  784.345588] Command1 0x0
[  784.345594] Command2 0x0
[  784.345599] Command3 0x0
[  784.345626] Command0 0x62c1080
[  784.345632] Command1 0x18000000
[  784.345637] Command2 0x0
[  784.345642] Command3 0x0
[  784.345960] Status: ready
[  784.345976] Waiting for device to be ready
[  784.345981] Device is ready
[  784.346006] Command0 0x810070
[  784.346012] Command1 0x0
[  784.346017] Command2 0x0
[  784.346022] Command3 0x0
[  784.346044] Waiting for device to be ready
[  784.543390] pxa3xx-nand d00d0000.nand: Ready time out!!!
[  784.548850] Command0 0x810070
[  784.548857] Command1 0x0
[  784.548863] Command2 0x0
[  784.548868] Command3 0x0
[  784.548888] Command0 0x24bd060
[  784.548893] Command1 0x1800
[  784.548898] Command2 0x0
[  784.548903] Command3 0x0
[  784.549648] Status: ready
[  784.549661] Waiting for device to be ready
[  784.549667] Device is ready
[  784.549701] Command0 0x810070
[  784.549707] Command1 0x0
[  784.549712] Command2 0x0
[  784.549716] Command3 0x0
[  784.549736] Command0 0x62c1080
[  784.549742] Command1 0x18400000
[  784.549747] Command2 0x0
[  784.549751] Command3 0x0
[  784.550074] Status: ready
[  784.550087] Waiting for device to be ready
[  784.550093] Device is ready
[  784.550109] Command0 0x810070
[  784.550115] Command1 0x0
[  784.550119] Command2 0x0
[  784.550124] Command3 0x0
[  784.550146] Waiting for device to be ready
[  784.743391] pxa3xx-nand d00d0000.nand: Ready time out!!!
[  784.748780] Command0 0x810070
[  784.748786] Command1 0x0
[  784.748792] Command2 0x0
[  784.748797] Command3 0x0
[  784.748815] Command0 0x24bd060
[  784.748821] Command1 0x1840
[  784.748826] Command2 0x0
[  784.748831] Command3 0x0
[  784.749575] Status: ready
[  784.749589] Waiting for device to be ready
[  784.749595] Device is ready
[  784.749628] Command0 0x810070
[  784.749634] Command1 0x0
[  784.749639] Command2 0x0
[  784.749644] Command3 0x0
[  784.749663] Command0 0x62c1080
[  784.749669] Command1 0x18800000
[  784.749674] Command2 0x0
[  784.749679] Command3 0x0
[  784.749995] Status: ready
[  784.750007] Waiting for device to be ready
[  784.750013] Device is ready
[  784.750028] Command0 0x810070


So let's now do the same with a fully random block:

root at thin:/# dd if=/dev/urandom of=/tmp/block.random bs=131072 count=1
1+0 records in
1+0 records out
131072 bytes (131 kB) copied, 0.0406636 s, 3.2 MB/s

root at thin:~# flash_erase /dev/mtd4 0 1
Erasing 128 Kibyte @ 0 -- 100 % complete 

root at thin:~# nandwrite /dev/mtd4 /tmp/block.random 
Writing data to block 0 at offset 0x0

In the log, I get the following:

[ 1422.296953] Command0 0x810070
[ 1422.296965] Command1 0x0
[ 1422.296970] Command2 0x0
[ 1422.296975] Command3 0x0
[ 1422.296990] Command0 0x24bd060
[ 1422.296996] Command1 0x1800
[ 1422.297001] Command2 0x0
[ 1422.297006] Command3 0x0
[ 1422.297752] Status: ready
[ 1422.297767] Waiting for device to be ready
[ 1422.297773] Device is ready
[ 1488.147298] Command0 0x810070
[ 1488.147310] Command1 0x0
[ 1488.147316] Command2 0x0
[ 1488.147321] Command3 0x0
[ 1488.147340] Command0 0x62c1080
[ 1488.147345] Command1 0x18000000
[ 1488.147350] Command2 0x0
[ 1488.147355] Command3 0x0
[ 1488.147673] Status: ready
[ 1488.147689] Waiting for device to be ready
[ 1488.147695] Device is ready
[ 1488.147720] Command0 0x810070
[ 1488.147725] Command1 0x0
[ 1488.147730] Command2 0x0
[ 1488.147735] Command3 0x0
[ 1488.147754] Command0 0x62c1080
[ 1488.147759] Command1 0x18010000
[ 1488.147764] Command2 0x0
[ 1488.147769] Command3 0x0
[ 1488.148085] Status: ready
[ 1488.148098] Waiting for device to be ready
[ 1488.148103] Device is ready
[ 1488.148125] Command0 0x810070
[ 1488.148130] Command1 0x0
[ 1488.148135] Command2 0x0
[ 1488.148140] Command3 0x0
[ 1488.148158] Command0 0x62c1080
[ 1488.148164] Command1 0x18020000
[ 1488.148169] Command2 0x0
[ 1488.148174] Command3 0x0
[ 1488.148490] Status: ready
[ 1488.148503] Waiting for device to be ready
[ 1488.148508] Device is ready
[ 1488.148537] Command0 0x810070
[ 1488.148543] Command1 0x0
[ 1488.148548] Command2 0x0
[ 1488.148553] Command3 0x0
[ 1488.148567] Command0 0x62c1080
[ 1488.148572] Command1 0x18030000
[ 1488.148577] Command2 0x0
[ 1488.148582] Command3 0x0
[ 1488.148955] Status: ready
[ 1488.148968] Waiting for device to be ready
[ 1488.148973] Device is ready
[ 1488.148995] Command0 0x810070
[ 1488.149001] Command1 0x0
[ 1488.149006] Command2 0x0
[ 1488.149011] Command3 0x0
[ 1488.149029] Command0 0x62c1080
[ 1488.149035] Command1 0x18040000
[ 1488.149039] Command2 0x0
[ 1488.149044] Command3 0x0
[ 1488.149417] Status: ready
[ 1488.149429] Waiting for device to be ready
[ 1488.149434] Device is ready
[ 1488.149456] Command0 0x810070
[ 1488.149462] Command1 0x0
[ 1488.149466] Command2 0x0
[ 1488.149471] Command3 0x0
[ 1488.149486] Command0 0x62c1080
[ 1488.149491] Command1 0x18050000
[ 1488.149496] Command2 0x0
[ 1488.149501] Command3 0x0
[ 1488.149817] Status: ready
[ 1488.149830] Waiting for device to be ready
[ 1488.149835] Device is ready
[ 1488.149857] Command0 0x810070
[ 1488.149863] Command1 0x0
[ 1488.149867] Command2 0x0
[ 1488.149872] Command3 0x0
[ 1488.149891] Command0 0x62c1080
[ 1488.149896] Command1 0x18060000
[ 1488.149901] Command2 0x0
[ 1488.149906] Command3 0x0
[ 1488.150279] Status: ready
[ 1488.150292] Waiting for device to be ready
[ 1488.150297] Device is ready
[ 1488.150319] Command0 0x810070
[ 1488.150325] Command1 0x0
[ 1488.150330] Command2 0x0
[ 1488.150334] Command3 0x0
[ 1488.150353] Command0 0x62c1080
[ 1488.150359] Command1 0x18070000
[ 1488.150363] Command2 0x0
[ 1488.150368] Command3 0x0
[ 1488.150685] Status: ready
[ 1488.150697] Waiting for device to be ready
[ 1488.150702] Device is ready

If you had the time to test the offending block on another device, did
you manage to reproduce what I get?

Cheers,

a+
