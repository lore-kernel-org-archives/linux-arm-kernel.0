From: asarkar@xilinx.com (Arindam Sarkar)
Date: Wed, 4 Apr 2018 08:58:03 +0000
Subject: i2c-cadence.c receive buffer overrun bug fix patches
In-Reply-To: <CA+Y=x3=vwp61x+iEJXe0+LBEaY+3uQ6n6j8+AbRN7=aTTOiziw@mail.gmail.com>
References: <CA+Y=x3=vwp61x+iEJXe0+LBEaY+3uQ6n6j8+AbRN7=aTTOiziw@mail.gmail.com>
Message-ID: <BLUPR0201MB185945134ED13AA1229D38A9CEA40@BLUPR0201MB1859.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

We appreciate the patches. We will validate the patches at our end and will get back to you on this.

Best Regards
Arindam Sarkar

-----Original Message-----
From: Andrew Worsley [mailto:amworsley at gmail.com] 
Sent: Tuesday, April 3, 2018 6:59 PM
To: Harini Katakam <harinik@xilinx.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.com>; Arindam Sarkar <asarkar@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>; linux-arm-kernel at lists.infradead.org; linux-i2c at vger.kernel.org
Subject: i2c-cadence.c receive buffer overrun bug fix patches

I just sent 2 patches to fix the buffer overrun bug I reported earlier.
They should apply against the current xilinx kernel i2c-cadence driver.

The first is the original patch which traps the overrun and aborts the transfer with out overruning the receive buffer.

The 2nd patch fixes the actual bug - so the first patch is perhaps just a safety measure and could be left out. But I would feel safer if it does check the transfer rather than trusting the hardware transfer register which was wrapping in the bug.

I have verified the fix on my hardware with over 60 faultless boot ups where before it would crash about 1 in three boot ups.

Below I show the trace of such a buffer over run prevented by the first patch with extra debug showing the outstanding bytes of the transfer (recv_count), CR (Control Register) and the transfer register size. It shows the transfer register size going down to zero and then wrapping and transfering another 16 bytes (256-16=240 ?) The 0x10 bit in the CR was set when the transfer size register was zero allowing further i2c data to be read in before it was detected and the transfer aborted with the message "buffer overruning..."

[    9.963519] hostname kernel: cdns_i2c_process_msg: transfer from 0x29 len=35
[    9.963524] hostname kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET) #6
[    9.964924] hostname kernel: cdns_i2c_isr: status 0x2 1352ns
recv_count=35 xfer_size=21 CR=0x321f
[    9.966189] hostname kernel: cdns_i2c_isr: status 0x2 2594ns
recv_count=21 xfer_size=7 CR=0x321f
[    9.966840] hostname kernel: cdns_i2c_isr: status 0x1 3230ns
recv_count=7 xfer_size=0 CR=0x320f
[    9.966898] hostname kernel: cdns_i2c_process_msg: cnt=349 Rd 29
len=35 completed 3369426ns
[    9.966904] hostname kernel: cdns_i2c_process_msg: err_status=0x0 - ok
[    9.966922] hostname kernel: cdns_i2c_process_msg: transfer from 0x29 len=142
[    9.966931] hostname kernel: cdns_i2c_mrecv:cdns_i2c_writereg(142,
CDNS_I2C_XFER_SIZE_OFFSET) #6
[    9.977951] hostname kernel: cdns_i2c_isr: status 0xa 10752ns
recv_count=142 xfer_size=126 CR=0x321f
[    9.985414] hostname kernel: cdns_i2c_isr: status 0xa 18043ns
recv_count=126 xfer_size=110 CR=0x321f
[    9.992783] hostname kernel: cdns_i2c_isr: status 0xa 25237ns
recv_count=110 xfer_size=94 CR=0x321f
[   10.000158] hostname kernel: cdns_i2c_isr: status 0xa 32439ns
recv_count=94 xfer_size=78 CR=0x321f
[   10.007547] hostname kernel: cdns_i2c_isr: status 0xa 39657ns
recv_count=78 xfer_size=62 CR=0x321f
[   10.015016] hostname kernel: cdns_i2c_isr: status 0xa 46950ns
recv_count=62 xfer_size=46 CR=0x321f
[   10.022488] hostname kernel: cdns_i2c_isr: status 0xa 54247ns
recv_count=46 xfer_size=30 CR=0x321f
[   10.023779] hostname kernel: cdns_i2c_isr: status 0x2 55507ns
recv_count=30 xfer_size=16 CR=0x321f
[   10.034019] hostname kernel: cdns_i2c_isr: status 0xa 65503ns
recv_count=16 xfer_size=0 CR=0x321f
[   10.041025] hostname kernel: cdns_i2c_isr: status 0x22 72344ns
recv_count=0 xfer_size=240 CR=0x320f
[   10.041039] hostname kernel: cdns_i2c_isr: buffer overrunning !!!-
transfer-size=240 ctrl=0x320f status=0xa0=>Overflow<= int-status=0x0
[   10.041042] hostname kernel: cdns_i2c_isr:Aborting transfer...
[   10.981934] hostname kernel: cdns_i2c_process_msg: cnt=350 Rd 29
len=142 completed 1014997572ns
[   10.981947] hostname kernel: cdns-i2c e0004000.i2c: timeout waiting
on completion
[   10.981970] hostname kernel: tpm tpm0: i2c_atmel_recv reread(buf=00
c4 00 00 00 8e 00 00 00 00 00 00 00 80 d6 19 c3 0a 3b ff b5 2e 13 20 7d 51 56 0e 40 c7 7c d6 c7 07 e2 79 2f 5e 0a d9 f5 80 92 35 8b 71 bf 6d 26 7d ac 95 40 25 cc 60 55 5f 94 e2 64 bf c4 d2 count=92) expected_len=142-> ret=-110
[   10.981978] hostname kernel: **buf:da151d06: 00 c4 00 00 00 8e 00
00 00 00 00 00 00 80 d6 19  ................
[   10.981983] hostname kernel: **buf:da151d16: c3 0a 3b ff b5 2e 13
20 7d 51 56 0e 40 c7 7c d6  ..;.... }QV. at .|.
[   10.981987] hostname kernel: **buf:da151d26: c7 07 e2 79 2f 5e 0a
d9 f5 80 92 35 8b 71 bf 6d  ...y/^.....5.q.m
[   10.981991] hostname kernel: **buf:da151d36: 26 7d ac 95 40 25 cc
60 55 5f 94 e2 64 bf c4 d2  &}..@%.`U_..d...
[   10.981996] hostname kernel: **buf:da151d46: 21 5d 20 e8 a4 2b aa
79 63 ae 3d 88 4d a9 2b 7c  !] ..+.yc.=.M.+|
[   10.982000] hostname kernel: **buf:da151d56: b2 c9 c7 0e b1 5f f0
3c 32 b8 85 4f 3f 2a 07 06  ....._.<2..O?*..
[   10.982004] hostname kernel: **buf:da151d66: 30 ea b0 fc 53 ec 13
d6 18 73 f1 81 41 f8 5e fb  0...S....s..A.^.
[   10.982008] hostname kernel: **buf:da151d76: a8 77 c4 9b 7e 28 ee
27 74 6a d6 ed f6 db 83 a7  .w..~(.'tj......
[   10.982012] hostname kernel: **buf:da151d86: 2e 9a c1 fa 2a 4d c6
bc 4a 6b e8 1e 76 9d 38 dd  ....*M..Jk..v.8.
[   10.982016] hostname kernel: **buf:da151d96: 22 c0 03 00 00 00 02
00 00 00 00 00 00 00 d0 1e  "...............
[   10.982020] hostname kernel: **buf:da151da6: 15 da 01 00 00 00 00
00 00 00 04 05 57 3e        ............W>
[   10.982030] hostname kernel: CPU: 1 PID: 283 Comm: rngd Tainted: G
         O    4.9.25-zynq+ #45
[   10.982033] hostname kernel: Hardware name: Xilinx Zynq hostname
[   10.982066] hostname kernel: [<c0110374>] (unwind_backtrace) from
[<c010b80c>] (show_stack+0x10/0x14)
[   10.982085] hostname kernel: [<c010b80c>] (show_stack) from
[<c03bd97c>] (dump_stack+0x88/0x9c)
