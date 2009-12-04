From: hs@denx.de (Heiko Schocher)
Date: Fri, 04 Dec 2009 18:53:15 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091204163850.GC20386@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
Message-ID: <4B194C8B.7070505@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell King,

Russell King - ARM Linux wrote:
> On Fri, Dec 04, 2009 at 04:58:43PM +0100, Heiko Schocher wrote:
>> Hello Russell King,
>>
>> Russell King - ARM Linux wrote:
>>> On Fri, Dec 04, 2009 at 02:42:12PM +0100, Heiko Schocher wrote:
>>>> Hello Russell King,
>>>>
>>>> Russell King - ARM Linux wrote:
>>>>> On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
>>>>>> [4] Log from Demoprogramm, not working
>>>>> I think this is messed up - this is not from your first script but your
>>>>> second script which starts four independent read processes.
>>>>>
>>>>> I determined this because:
>>>>> (1) the read thread addresses are mostly the same
>>>>> (2) there are four "Read form in_msg" strings, which you only print
>>>>> once at the start of the program.
>>>> Ups, sorry for the confusion, here 2 logs with the right values:
>>> I don't remember whether 2.6.28 has highmem.  Can you check whether you're
>>> using highmem please?
>> No, there is no HIGHMEM in the defconfig, if you mean this config option.
>>
>> You can find the complete defconfig here:
>>
>> http://git.denx.de/?p=linux-2.6-denx.git;a=blob;f=arch/arm/configs/suen3_defconfig;h=905f9bc6a36c03ab41b97a292fca5b3a0011a2a0;hb=3dc3e4dc957f216ec5cdcd2a770f5c4b0cefca4a
> 
> Please apply this patch and re-run your program.  Expect a fair bit of
> output - the last 50 or so lines from the kernel messages should cover
> everything that's required.  Also useful would be the output from the
> program giving the addresses of the shm regions.

Thanks for your patch. I tried it and it gives with my testprogramm the
following output:

-bash-3.2# ./shtest2.sh
Run shmtest2
shmtest2:348: c6c0bea8 c723bf98 0 40000000 7404
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 0 40000000 7404
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 1 40001000 7403
shmtest2:349: aliases 0
-bash-3.2# shmtest2:348: c6c0bea8 c723bf98 1 40001000 7403
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c721cee8 1b 40023000 7410
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 16 40016000 740e
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c7217700 1b 40023000 7410
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 8 40008000 7422
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 13 40013000 7425
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 16 40016000 740e
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 14 40014000 7424
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 15 40015000 7409
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 8 40008000 7422
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 2 40002000 741b
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 3 40003000 741a
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 13 40013000 7425
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 9 40009000 7421
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 a 4000a000 7420
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 14 40014000 7424
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 19 40019000 7412
shmtest2:348: aliases 0
shmtest2:348: c6ccff08 c7217338 0 8000 64d0
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 7 40007000 741c
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 15 40015000 7409
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 2 40002000 741b
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 1a 4001a000 7411
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 3 40003000 741a
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 17 40017000 7414
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 e 4000e000 7423
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 9 40009000 7421
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 b 4000b000 741f
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 c 4000c000 741e
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 a 4000a000 7420
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 d 4000d000 741d
shmtest2:348: aliases 0
shmtest2:348: c6c0bea8 c723bf98 5 40005000 7418
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 19 40019000 7412
shmtest2:349: aliases 0
shmtest2:349: c6ccff08 c723bee8 0 8000 64d0
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 7 40007000 741c
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 6 40006000 7417
shmtest2:348: aliases 0
shmtest2:348: c6c94d08 c722c498 12 4003f000 69bd
shmtest2:348: aliases 0
shmtest2:348: c6c94d08 c722ce38 0 40025000 6991
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 1a 4001a000 7411
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 3 40028000 69cd
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 17 40017000 7414
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 10 40010000 7428
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226230 111 4015c000 7435
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 e 4000e000 7423
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 b 4000b000 741f
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 0 40043000 742f
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 c 4000c000 741e
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 d 4000d000 741d
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 10 40053000 7446
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 5 40005000 7418
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 6 40006000 7417
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 4 40004000 7419
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c128 12 4003f000 69bd
shmtest2:349: aliases 0
shmtest2:349: c6c94d08 c722c0d0 0 40025000 6991
shmtest2:349: aliases 0
shmtest2:348: c6c0bea8 c723bf98 f 4000f000 7429
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c0d0 3 40028000 69cd
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 10 40010000 7428
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c230 111 4015c000 7435
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 11 40054000 744c
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 0 40043000 742f
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 10 40053000 7446
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226230 110 4015b000 7436
shmtest2:348: aliases 0
shmtest2:349: c6c0bea8 c721c968 4 40004000 7419
shmtest2:349: aliases 0
shmtest2:349: c6c0bea8 c721c968 f 4000f000 7429
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 12 40055000 744b
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 11 40054000 744c
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c230 110 4015b000 7436
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 13 40056000 744a
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 12 40055000 744b
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 13 40056000 744a
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 14 40057000 7449
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 14 40057000 7449
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 5 40048000 7450
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 1 40044000 742e
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 5 40048000 7450
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 8 4004b000 7459
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 f 40052000 7440
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 1 40044000 742e
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 2 40045000 7453
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 3 40046000 7452
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 8 4004b000 7459
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 b 4004e000 7444
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 4 40047000 7451
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 f 40052000 7440
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 a 4004d000 7445
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 c 4004f000 7443
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 2 40045000 7453
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 6 40049000 7454
shmtest2:348: aliases 0
shmtest2:348: c6c94d08 c722ce38 1 40026000 69b0
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 3 40046000 7452
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 2 40027000 69ce
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 9 4004c000 743f
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 b 4004e000 7444
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 7 4004a000 745a
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 d 40050000 7442
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 4 40047000 7451
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 e 40051000 7441
shmtest2:348: aliases 0
shmtest2:348: c6c94d08 c722ce38 4 40029000 69cc
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 a 4004d000 7445
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 10 40035000 69bf
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 6d 400b0000 746a
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 c 4004f000 7443
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 e 40033000 69ba
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 6 40049000 7454
shmtest2:349: aliases 0
shmtest2:349: c6c94d08 c722c0d0 1 40026000 69b0
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 6e 400b1000 7470
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c0d0 2 40027000 69ce
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 9 4004c000 743f
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 b5 400f8000 7458
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 7 4004a000 745a
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 d 40050000 7442
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 8d 400d0000 749e
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 e 40051000 7441
shmtest2:349: aliases 0
shmtest2:349: c6c94d08 c722c0d0 4 40029000 69cc
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 b6 400f9000 7457
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c0d0 10 40035000 69bf
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 6d 400b0000 746a
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 f1 40134000 7508
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c0d0 e 40033000 69ba
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 6e 400b1000 7470
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 c9 4010c000 7511
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 b5 400f8000 7458
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 8d 400d0000 749e
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 bc 400ff000 745d
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 b6 400f9000 7457
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 f1 40134000 7508
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 6c 400af000 746b
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 c9 4010c000 7511
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 bc 400ff000 745d
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 2c 4006f000 747e
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 6c 400af000 746b
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 2c 4006f000 747e
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 29 4006c000 747a
shmtest2:349: aliases 0
shmtest2:349: c6ccff08 c723bee8 1 9000 64cf
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 29 4006c000 747a
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 57 4009a000 74a5
shmtest2:349: aliases 0
shmtest2:348: c6ccff08 c7217338 1 9000 64cf
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 58 4009b000 74a4
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 61 400a4000 74af
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 57 4009a000 74a5
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 58 4009b000 74a4
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 62 400a5000 74b5
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 61 400a4000 74af
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 55 40098000 74cb
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 62 400a5000 74b5
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 ad 400f0000 7492
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 55 40098000 74cb
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 af 400f2000 7490
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 ad 400f0000 7492
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 b9 400fc000 7460
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 af 400f2000 7490
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 63 400a6000 74b4
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 b9 400fc000 7460
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 f2 40135000 7507
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 ae 400f1000 7491
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 63 400a6000 74b4
shmtest2:348: aliases 0
Read from in_msgshmtest2:349: c6c0b848 c722c180 2b 4006e000 7478

shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 2d 40070000 7484
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 f2 40135000 7507
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 2e 40071000 7483
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 f5 40138000 7504
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 ae 400f1000 7491
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 101 40144000 74f0
shmtest2:349: aliases 0
shmtest2:349: c6c94d08 c722c0d0 6 4002b000 69ca
shmtest2:349: aliases 0
Write to in_msgshmtest2:348: c6c0b848 c7226e38 2b 4006e000 7478

shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 43 40086000 751e
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 2d 40070000 7484
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 2e 40071000 7483
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 3b 4007e000 74b8
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 f5 40138000 7504
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 101 40144000 74f0
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 3c 4007f000 74b7
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 6 4002b000 69ca
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 43 40086000 751e
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 54 40097000 74c5
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 3b 4007e000 74b8
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c0d0 c 40031000 69ae
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 102 40145000 74ef
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 3c 4007f000 74b7
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 39 4007c000 74ba
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 3d 40080000 74bd
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 54 40097000 74c5
shmtest2:348: aliases 0
Creating thread shmtest2:349: c6c0b848 c722c180 3f 40082000 74c2
0
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 3e 40081000 74c3
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 c 40031000 69ae
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 be 40101000 7462
shmtest2:349: aliases 0
Shared memory Idshmtest2:349: c6c94d08 c722c0d0 5 4002a000 69cb
:0
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 102 40145000 74ef
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 6a 400ad000 746d
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 39 4007c000 74ba
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 3d 40080000 74bd
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 69 400ac000 746e
shmtest2:349: aliases 0
Creating thread shmtest2:348: c6c0b848 c7226e38 3f 40082000 74c2
0
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 65 400a8000 74b2
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 66 400a9000 7463
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 3e 40081000 74c3
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 f0 40133000 7509
shmtest2:349: aliases 0
shmtest2:349: c6c94d08 c722c0d0 7 4002c000 69c9
shmtest2:349: aliases 0
shmtest2:348: c6c94d08 c722ce38 5 4002a000 69cb
shmtest2:348: aliases 0
shmtest2:349: c6c94d08 c722c0d0 9 4002e000 69d5
shmtest2:349: aliases 0
shmtest2:349: c6c94d08 c722c0d0 8 4002d000 69cf
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 6a 400ad000 746d
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 68 400ab000 746f
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 67 400aa000 7469
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 69 400ac000 746e
shmtest2:348: aliases 0
shmtest2:349: c6c0b848 c722c180 ba 400fd000 745f
shmtest2:349: aliases 0
shmtest2:349: c6c0b848 c722c180 bd 40100000 745c
shmtest2:349: aliases 0
shmtest2:348: c6c0b848 c7226e38 65 400a8000 74b2
shmtest2:348: aliases 0
attach shared meshmtest2:350: c6c0b848 c722c180 c8 4010b000 750b
m:40961000
shmtest2:350: aliases 0
shmtest2:348: c6c0b848 c7226e38 66 400a9000 7463
shmtest2:348: aliases 0
shmtest2:348: c6c0b848 c7226e38 f0 40133000 7509
shmtest2:348: aliases 0
Start Read Threashmtest2:350: c7220140 c7217968 0 40961000 64a1
shmtest2:350: aliases 0

Creating thread shmtest2:348: c6c94d08 c722ce38 7 4002c000 69c9
1
Shared memoryshmtest2:348: aliases 0
 Id:0
shmtest2:350: c6c0b848 c722c180 8b 400ce000 74a0
shmtest2:350: aliases 0
shmtest2:348: c6c94d08 c722ce38 9 4002e000 69d5
shmtest2:348: aliases 0
shmtest2:348: c6c94d08 c722ce38 8 4002d000 69cf
shmtest2:348: aliases 0
attach shared meshmtest2:351: c7220140 c72179c0 0 41170000 64a1
m:41170000
Starshmtest2:351: vma c7217968 addr 40961000 pte 064a13cf
shmtest2:351: modified 064a13c7
t Read Thread adshmtest2:351: aliases 1
dr:41170000
shmtest2:351: vma c72179c0 addr 41170000 pte 064a13cf
shmtest2:351: modified 064a13c7
shmtest2:348: c6c0b848 c7226e38 68 400ab000 746f
shmtest2:348: aliases 0
Creating thread shmtest2:352: c7220140 c7217548 0 4197f000 64a1
2
Shared memoryshmtest2:352: vma c7217968 addr 40961000 pte 064a13c7
shmtest2:352: vma c72179c0 addr 41170000 pte 064a13c7
 Id:0
attach shshmtest2:352: aliases 2
ared mem:4197f00shmtest2:352: vma c7217548 addr 4197f000 pte 064a13cf
0
Start Read Thshmtest2:352: modified 064a13c7
read addr:4197f0shmtest2:348: c6c0b848 c7226e38 67 400aa000 7469
00
shmtest2:348: aliases 0
Creating thread shmtest2:348: c6c0b848 c7226e38 ba 400fd000 745f
3
Shared memoryshmtest2:348: aliases 0
 Id:0
shmtest2:348: c6c0b848 c7226e38 bd 40100000 745c
shmtest2:348: aliases 0
shmtest2:353: c6c0b848 c7226e38 be 40101000 7462
shmtest2:353: aliases 0
attach shared meshmtest2:354: c7220140 c7217650 0 4218e000 64a1
m:4218e000
Starshmtest2:354: vma c7217968 addr 40961000 pte 064a13c7
shmtest2:354: vma c72179c0 addr 41170000 pte 064a13c7
shmtest2:354: vma c7217548 addr 4197f000 pte 064a13c7
t Read Thread adshmtest2:354: aliases 3
dr:4218e000
shmtest2:354: vma c7217650 addr 4218e000 pte 064a13cf
shmtest2:354: modified 064a13c7
Shared memory Idshmtest2:353: c6c0b848 c7226e38 c8 4010b000 750b
:0
shmtest2:353: aliases 0
attach shared meshmtest2:353: c7220140 c7217288 0 40961000 64a1
m:40961000
Starshmtest2:353: aliases 0
t Write Thread 0shmtest2:353: c6c0b848 c7226e38 8c 400cf000 749f
shmtest2:353: aliases 0

348: write new mshmtest2:353: c6c0b848 c7226e38 8b 400ce000 74a0
esg: 0
shmtest2:353: aliases 0
shmtest2:350: c6c0b848 c722c180 8c 400cf000 749f
shmtest2:350: aliases 0
349 Read from entry in_msg=0, out_msg=1000, addr=40961000
349 Read from entry in_msg=1000, out_msg=1000, addr=41170000
349 Read from entry in_msg=2000, out_msg=1000, addr=4197f000
349 Read from entry in_msg=3000, out_msg=1000, addr=4218e000
348: write new mesg: 1000
349 Read from entry in_msg=4000, out_msg=1000, addr=40961000
349 Read from entry in_msg=5000, out_msg=1000, addr=41170000
349 Read from entry in_msg=6000, out_msg=1000, addr=4197f000
349 Read from entry in_msg=7000, out_msg=1000, addr=4218e000
348: write new mesg: 2000
349 Read from entry in_msg=8000, out_msg=1000, addr=40961000
349 Read from entry in_msg=9000, out_msg=1000, addr=41170000
349 Read from entry in_msg=10000, out_msg=1000, addr=4197f000
349 Read from entry in_msg=11000, out_msg=1000, addr=4218e000
348: write new mesg: 3000
349 Read from entry in_msg=12000, out_msg=1000, addr=40961000
349 Read from entry in_msg=13000, out_msg=1000, addr=41170000
349 Read from entry in_msg=14000, out_msg=1000, addr=4197f000
349 Read from entry in_msg=15000, out_msg=1000, addr=4218e000
348: write new mesg: 4000

If you want a log without the printfs from the userspaceprg., I can make it.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
