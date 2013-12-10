From: Tal.Mussayoff@harmonicinc.com (Tal Mussayoff)
Date: Tue, 10 Dec 2013 01:43:25 -0800
Subject: Problem with exception handling - program counter is corrupted
Message-ID: <42728CC26C41854B83AAA6BAA14B2B6F6FEB439CAE@EXCH-CMS.hlit.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Is there any update? Do you need more information? 

Here is a brief description of my problem:

We've recently encountered a problem in the kernel, where the program counter is corrupted, when handling SIGSEGV exception, that has been caused on the user space. We've checked this under kernel version 3.10 (3.12 is not stable).

I've simulated an exception on the code using the following piece of code:
 
                 UINT32* pD = NULL;
                 memset(pD, 0, 10);
 

With the help of traces I've got the following log:

>  2013-10-01T18:09:53.508501+00:00 zodiac kernel: Pid: 890, comm:      InputPortManage
> 2013-10-01T18:09:53.520828+00:00 zodiac kernel: CPU: 0    Tainted: G           O  (3.9.0-0.1.0.0.16xilinx-zynq-g3f7c2d5 #94)
> 2013-10-01T18:09:53.528178+00:00 zodiac kernel: PC is at 0x76a2f790
> 2013-10-01T18:09:53.535436+00:00 zodiac kernel: LR is at 0x3d23ad
> 2013-10-01T18:09:53.549813+00:00 zodiac kernel: pc : [<76a2f790>]    lr : [<003d23ad>]    psr: 20000010
> 2013-10-01T18:09:53.549836+00:00 zodiac kernel: sp : 767feb58  ip : 
> 00000000  fp : 00000000
> 2013-10-01T18:09:53.559259+00:00 zodiac kernel: r10: 76ff5000  r9 : 
> 00000000  r8 : 00000001
> 2013-10-01T18:09:53.570065+00:00 zodiac kernel: r7 : 767feb60  r6 : 
> 00000001  r5 : 00000001  r4 : 00451e04
> 2013-10-01T18:09:53.580802+00:00 zodiac kernel: r3 : 00000000  r2 : 
> 00002708  r1 : 00000000  r0 : 00000000
> 2013-10-01T18:09:53.592253+00:00 zodiac kernel: Flags: nzCv  IRQs on 
> FIQs on  Mode USER_32  ISA ARM  Segment user
> 2013-10-01T18:09:53.602230+00:00 zodiac kernel: Control: 18c5387d
> Table: 0cd6804a  DAC: 00000015
> 2013-10-01T18:09:53.610594+00:00 zodiac kernel: ~~~~~~ DUMP BACKTRACE
> 1 ~~~~~~
> 2013-10-01T18:09:53.619764+00:00 zodiac kernel: ~~~~~~~~~ UNWIND BACKTRACE 4 ~~~~~~~~~~~
> 2013-10-01T18:09:53.629694+00:00 zodiac kernel: unwind_backtrace(regs =   (null) tsk =   (null))
> 2013-10-01T18:09:53.636168+00:00 zodiac kernel: ~~~TSK~~~
> 2013-10-01T18:09:53.647228+00:00 zodiac kernel: ~~~ frame.fp 896c9dd4, 
> sp 896c9da8, lr 80018168, pc 80013c94
> 2013-10-01T18:09:53.660499+00:00 zodiac kernel: [<80013c94>]
> (unwind_backtrace+0x0/0x154) from [<80018168>]
> (__do_user_fault+0x60/0xdc)
> 2013-10-01T18:09:53.673678+00:00 zodiac kernel: [<80018168>]
> (__do_user_fault+0x60/0xdc) from [<800184ac>]
> (do_page_fault+0x2c8/0x350)
> 2013-10-01T18:09:53.686627+00:00 zodiac kernel: [<800184ac>]
> (do_page_fault+0x2c8/0x350) from [<800083f8>] (do_DataAbort+0x34/0x98)
> 2013-10-01T18:09:53+00:00 zodiac IRP: ConfDeamon: error [Transport 
> endpoint is not connected] sending message total_size=167
> sent_bytes=-1
> 2013-10-01T18:09:53.699161+00:00 zodiac kernel: [<800083f8>] (do_DataAbort+0x34/0x98) from [<8000e034>] (__dabt_usr+0x34/0x40)
>      2013-10-01T18:09:53.708400+00:00 zodiac kernel: Exception stack(0x896c9fb0 to 0x896c9ff8)
> 2013-10-01T18:09:53.720865+00:00 zodiac kernel: 9fa0:                                     00000000 00000000 00002708 00000000
> 2013-10-01T18:09:53.733238+00:00 zodiac kernel: 9fc0: 00451e04
> 00000001 00000001 767feb60 00000001 00000000 76ff5000 00000000
> 2013-10-01T18:09:53.744067+00:00 zodiac kernel: 9fe0: 00000000
> 767feb58 003d23ad 76a2f790 20000010 ffffffff
 

 The resulted PC, is invalid one.
 
 For some unknown reason, when I've modified my code to:

                 *pD = 328;


 The problem disappears, and the following logs are printed:

> 2013-10-01T18:11:38.209091+00:00 zodiac kernel: Pid: 810, comm:      InputPortManage
> 2013-10-01T18:11:38.221395+00:00 zodiac kernel: CPU: 0    Tainted: G           O  (3.9.0-0.1.0.0.16xilinx-zynq-g3f7c2d5 #92)
> 2013-10-01T18:11:38.228583+00:00 zodiac kernel: PC is at 0x3d23a2
> 2013-10-01T18:11:38.235841+00:00 zodiac kernel: LR is at 0x3d2395
> 2013-10-01T18:11:38.250218+00:00 zodiac kernel: pc : [<003d23a2>]    lr : [<003d2395>]    psr: 00000030
> 2013-10-01T18:11:38.250241+00:00 zodiac kernel: sp : 7676ab60  ip : 
> 76a0602c  fp : 00000000
> 2013-10-01T18:11:38.259918+00:00 zodiac kernel: r10: 76f45000  r9 : 
> 00000000  r8 : 00000001
> 2013-10-01T18:11:38.270471+00:00 zodiac kernel: r7 : 7676ab60  r6 : 
> 00000001  r5 : 00000001  r4 : 00451dfc
> 2013-10-01T18:11:38.281208+00:00 zodiac kernel: r3 : 00000000  r2 : 
> 00000148  r1 : 00000001  r0 : 00000000
> 2013-10-01T18:11:38.292866+00:00 zodiac kernel: Flags: nzcv  IRQs on 
> FIQs on  Mode USER_32  ISA Thumb  Segment user
> 2013-10-01T18:11:38.302820+00:00 zodiac kernel: Control: 18c5387d
> Table: 034d804a  DAC: 00000015
> 2013-10-01T18:11:38.320353+00:00 zodiac kernel: ~~~~~~ DUMP BACKTRACE
> 1 ~~~~~~
> 2013-10-01T18:11:38.320376+00:00 zodiac kernel: ~~~~~~~~~ UNWIND BACKTRACE 4 ~~~~~~~~~~~
> 2013-10-01T18:11:38.330284+00:00 zodiac kernel: unwind_backtrace(regs =   (null) tsk =   (null))
> 2013-10-01T18:11:38.336758+00:00 zodiac kernel: ~~~TSK~~~
> 2013-10-01T18:11:38.347818+00:00 zodiac kernel: ~~~ frame.fp 86f53ddc, 
> sp 86f53db0, lr 80018158, pc 80013c94
> 2013-10-01T18:11:38.361066+00:00 zodiac kernel: [<80013c94>]
> (unwind_backtrace+0x0/0x154) from [<80018158>]
> (__do_user_fault+0x50/0xbc)
> 2013-10-01T18:11:38+00:00 zodiac IRP: DecrMngr-ENGINE: Dispatch: 
> Illegal Msg opcode 0x7 received
> 2013-10-01T18:11:38.374337+00:00 zodiac kernel: [<80018158>]
> (__do_user_fault+0x50/0xbc) from [<8001848c>]
> (do_page_fault+0x2c8/0x350)
> 2013-10-01T18:11:38.387194+00:00 zodiac kernel: [<8001848c>]
> (do_page_fault+0x2c8/0x350) from [<800083f8>] (do_DataAbort+0x34/0x98)
> 2013-10-01T18:11:38.399705+00:00 zodiac kernel: [<800083f8>]
> (do_DataAbort+0x34/0x98) from [<8000e034>] (__dabt_usr+0x34/0x40)
> 2013-10-01T18:11:38.408967+00:00 zodiac kernel: Exception stack(0x86f53fb0 to 0x86f53ff8)
> 2013-10-01T18:11:38.421409+00:00 zodiac kernel: 3fa0:                                     00000000 00000001 00000148 00000000
> 2013-10-01T18:11:38.433804+00:00 zodiac kernel: 3fc0: 00451dfc
> 00000001 00000001 7676ab60 00000001 00000000 76f45000 00000000
> 2013-10-01T18:11:38.444656+00:00 zodiac kernel: 3fe0: 76a0602c
> 7676ab60 003d2395 003d23a2 00000030 ffffffff In this case the PC value is valid.
	


Thanks,
Tal.

-----Original Message-----
From: Tal Mussayoff 
Sent: Wednesday, December 04, 2013 11:50
To: 'linux-arm-kernel at lists.infradead.org'
Cc: 'Michal Simek'
Subject: Kernel Problem

Hi,
We've recently encountered a problem in the kernel, where the program counter is corrupted, when handling SIGSEGV exception, that has been caused on the user space. We've checked this under kernel version 3.10 (3.12 is not stable). Please find more information below. 

We'll appreciate any help you can supply, Regards, Tal.

-----Original Message-----
From: Michal Simek [mailto:michal.simek at xilinx.com]
Sent: Thursday, November 28, 2013 16:10
To: Tal Mussayoff
Cc: michal.simek at xilinx.com; git at Xilinx.com
Subject: Re: Kernel Problem

Hi,

please use git at xilinx.com for questions like this.
But anyway this behaviour is not xilinx specific and should be discussed on arm mailing list.
Also I would recommend you to try this on 3.12 and if you see the same problem send it to the arm mailing list.

Thanks,
Michal

On 11/28/2013 02:52 PM, Tal Mussayoff wrote:
> Hi Michal,
> I'm Tal, and I'm working on a project which includes kernel version 3.9, on Harmonic Inc. We've encountered a problem with the exceptions handling, which led to a failure of receiving stack backtrace. I've simulated an exception on the code (SIGSEGV signal) using the following piece of code:
> 
>                 UINT32* pD = NULL;
>                 memset(pD, 0, 10);
> 
> ). With the help of traces I've got the following log:
>      2013-10-01T18:09:53.508501+00:00 zodiac kernel: Pid: 890, comm:      InputPortManage
> 2013-10-01T18:09:53.520828+00:00 zodiac kernel: CPU: 0    Tainted: G           O  (3.9.0-0.1.0.0.16xilinx-zynq-g3f7c2d5 #94)
> 2013-10-01T18:09:53.528178+00:00 zodiac kernel: PC is at 0x76a2f790
> 2013-10-01T18:09:53.535436+00:00 zodiac kernel: LR is at 0x3d23ad
> 2013-10-01T18:09:53.549813+00:00 zodiac kernel: pc : [<76a2f790>]    lr : [<003d23ad>]    psr: 20000010
> 2013-10-01T18:09:53.549836+00:00 zodiac kernel: sp : 767feb58  ip : 
> 00000000  fp : 00000000
> 2013-10-01T18:09:53.559259+00:00 zodiac kernel: r10: 76ff5000  r9 : 
> 00000000  r8 : 00000001
> 2013-10-01T18:09:53.570065+00:00 zodiac kernel: r7 : 767feb60  r6 : 
> 00000001  r5 : 00000001  r4 : 00451e04
> 2013-10-01T18:09:53.580802+00:00 zodiac kernel: r3 : 00000000  r2 : 
> 00002708  r1 : 00000000  r0 : 00000000
> 2013-10-01T18:09:53.592253+00:00 zodiac kernel: Flags: nzCv  IRQs on 
> FIQs on  Mode USER_32  ISA ARM  Segment user
> 2013-10-01T18:09:53.602230+00:00 zodiac kernel: Control: 18c5387d
> Table: 0cd6804a  DAC: 00000015
> 2013-10-01T18:09:53.610594+00:00 zodiac kernel: ~~~~~~ DUMP BACKTRACE
> 1 ~~~~~~
> 2013-10-01T18:09:53.619764+00:00 zodiac kernel: ~~~~~~~~~ UNWIND BACKTRACE 4 ~~~~~~~~~~~
> 2013-10-01T18:09:53.629694+00:00 zodiac kernel: unwind_backtrace(regs =   (null) tsk =   (null))
> 2013-10-01T18:09:53.636168+00:00 zodiac kernel: ~~~TSK~~~
> 2013-10-01T18:09:53.647228+00:00 zodiac kernel: ~~~ frame.fp 896c9dd4, 
> sp 896c9da8, lr 80018168, pc 80013c94
> 2013-10-01T18:09:53.660499+00:00 zodiac kernel: [<80013c94>]
> (unwind_backtrace+0x0/0x154) from [<80018168>]
> (__do_user_fault+0x60/0xdc)
> 2013-10-01T18:09:53.673678+00:00 zodiac kernel: [<80018168>]
> (__do_user_fault+0x60/0xdc) from [<800184ac>]
> (do_page_fault+0x2c8/0x350)
> 2013-10-01T18:09:53.686627+00:00 zodiac kernel: [<800184ac>]
> (do_page_fault+0x2c8/0x350) from [<800083f8>] (do_DataAbort+0x34/0x98)
> 2013-10-01T18:09:53+00:00 zodiac IRP: ConfDeamon: error [Transport 
> endpoint is not connected] sending message total_size=167
> sent_bytes=-1
> 2013-10-01T18:09:53.699161+00:00 zodiac kernel: [<800083f8>] (do_DataAbort+0x34/0x98) from [<8000e034>] (__dabt_usr+0x34/0x40)
>      2013-10-01T18:09:53.708400+00:00 zodiac kernel: Exception stack(0x896c9fb0 to 0x896c9ff8)
> 2013-10-01T18:09:53.720865+00:00 zodiac kernel: 9fa0:                                     00000000 00000000 00002708 00000000
> 2013-10-01T18:09:53.733238+00:00 zodiac kernel: 9fc0: 00451e04
> 00000001 00000001 767feb60 00000001 00000000 76ff5000 00000000
> 2013-10-01T18:09:53.744067+00:00 zodiac kernel: 9fe0: 00000000
> 767feb58 003d23ad 76a2f790 20000010 ffffffff
> 
> The resulted PC, is invalid one.
> 
> For some unknown reason, when I've modified my code to:
>                 *pD = 328;
> The problem disappears, and the following logs are printed:
> 2013-10-01T18:11:38.209091+00:00 zodiac kernel: Pid: 810, comm:      InputPortManage
> 2013-10-01T18:11:38.221395+00:00 zodiac kernel: CPU: 0    Tainted: G           O  (3.9.0-0.1.0.0.16xilinx-zynq-g3f7c2d5 #92)
> 2013-10-01T18:11:38.228583+00:00 zodiac kernel: PC is at 0x3d23a2
> 2013-10-01T18:11:38.235841+00:00 zodiac kernel: LR is at 0x3d2395
> 2013-10-01T18:11:38.250218+00:00 zodiac kernel: pc : [<003d23a2>]    lr : [<003d2395>]    psr: 00000030
> 2013-10-01T18:11:38.250241+00:00 zodiac kernel: sp : 7676ab60  ip : 
> 76a0602c  fp : 00000000
> 2013-10-01T18:11:38.259918+00:00 zodiac kernel: r10: 76f45000  r9 : 
> 00000000  r8 : 00000001
> 2013-10-01T18:11:38.270471+00:00 zodiac kernel: r7 : 7676ab60  r6 : 
> 00000001  r5 : 00000001  r4 : 00451dfc
> 2013-10-01T18:11:38.281208+00:00 zodiac kernel: r3 : 00000000  r2 : 
> 00000148  r1 : 00000001  r0 : 00000000
> 2013-10-01T18:11:38.292866+00:00 zodiac kernel: Flags: nzcv  IRQs on 
> FIQs on  Mode USER_32  ISA Thumb  Segment user
> 2013-10-01T18:11:38.302820+00:00 zodiac kernel: Control: 18c5387d
> Table: 034d804a  DAC: 00000015
> 2013-10-01T18:11:38.320353+00:00 zodiac kernel: ~~~~~~ DUMP BACKTRACE
> 1 ~~~~~~
> 2013-10-01T18:11:38.320376+00:00 zodiac kernel: ~~~~~~~~~ UNWIND BACKTRACE 4 ~~~~~~~~~~~
> 2013-10-01T18:11:38.330284+00:00 zodiac kernel: unwind_backtrace(regs =   (null) tsk =   (null))
> 2013-10-01T18:11:38.336758+00:00 zodiac kernel: ~~~TSK~~~
> 2013-10-01T18:11:38.347818+00:00 zodiac kernel: ~~~ frame.fp 86f53ddc, 
> sp 86f53db0, lr 80018158, pc 80013c94
> 2013-10-01T18:11:38.361066+00:00 zodiac kernel: [<80013c94>]
> (unwind_backtrace+0x0/0x154) from [<80018158>]
> (__do_user_fault+0x50/0xbc)
> 2013-10-01T18:11:38+00:00 zodiac IRP: DecrMngr-ENGINE: Dispatch: 
> Illegal Msg opcode 0x7 received
> 2013-10-01T18:11:38.374337+00:00 zodiac kernel: [<80018158>]
> (__do_user_fault+0x50/0xbc) from [<8001848c>]
> (do_page_fault+0x2c8/0x350)
> 2013-10-01T18:11:38.387194+00:00 zodiac kernel: [<8001848c>]
> (do_page_fault+0x2c8/0x350) from [<800083f8>] (do_DataAbort+0x34/0x98)
> 2013-10-01T18:11:38.399705+00:00 zodiac kernel: [<800083f8>]
> (do_DataAbort+0x34/0x98) from [<8000e034>] (__dabt_usr+0x34/0x40)
> 2013-10-01T18:11:38.408967+00:00 zodiac kernel: Exception stack(0x86f53fb0 to 0x86f53ff8)
> 2013-10-01T18:11:38.421409+00:00 zodiac kernel: 3fa0:                                     00000000 00000001 00000148 00000000
> 2013-10-01T18:11:38.433804+00:00 zodiac kernel: 3fc0: 00451dfc
> 00000001 00000001 7676ab60 00000001 00000000 76f45000 00000000
> 2013-10-01T18:11:38.444656+00:00 zodiac kernel: 3fe0: 76a0602c
> 7676ab60 003d2395 003d23a2 00000030 ffffffff In this case the PC value is valid.
> 
> The problem is pretty much consistent when using memset.
> I'm not sure if this is relevant, but the PSR has consistent value for each scenario (0x20000010 when the problem occurs, and 0x00000030 when it doesn't).
> 
> We'll appreciate any help,
> Thanks,
> Tal Mussayoff.
> 
> P.S.
> As you may have understand, I'm the one who posted a question on the Xilinx forum :).
> 
