From: bvantiel@gmail.com (Bas van Tiel)
Date: Fri, 30 Dec 2016 13:21:00 +0100
Subject: Unhandled level 2 translation fault (11) at 0x000000b8, esr
 0x92000046, rpi3 (aarch64)
In-Reply-To: <20161230151323.583b7ac5@xhacker>
References: <CAGDbNAD7-TM6+x0A3FebTOPYmqQqbm1w29ZwH+9qePaAvhxTKw@mail.gmail.com>
 <20161230151323.583b7ac5@xhacker>
Message-ID: <CAGDbNAAGqFqt7X+=XYRLAp=L_fTv9dAAe=wu4T_W-FCGqnYHHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Hi,
>>
>> when using a signal handler as a way to context switch between
>> different usercontexts a reproducible exception occurs on my rpi3 in
>> 64-bit mode. (https://gist.github.com/DanGe42/7148946)
>>
>> Running the context_demo program as a 32-bit ARM executable on a
>> 64-bit kernel is OK, running as a 32 || 64 bit executable on an x86
>> kernel is OK.
>>
>> In the first exception the PC doesn?t look correct, and the *pmd is 0.
>> The 2nd exception happens after running the program again, the PC is 0x0.
>>
>> A successful function trace was not possible -> complete kernel hangup
>> when enabling.
>>
>> Is there another way to gather more information about what is happening?
>
> I can reproduce Segmentation fault with your program on Marvell berlin SoCs
> my kernel version is 4.1, I didn't tested 4.9, 4.10-rc1 etc..
>
> Then I increased the STACKSIZE from 4096 to 8192 in context_demo.c,
> everything works fine now. Maybe arm64 need a bit larger signalstack?
>

yes, increased STACKSIZE to 8192 helps on 4.9/4,10-rc1 but after a
while the exception still occurs, although the message is different.
The *pmd is not 0 in this case.

to trigger this scenario:
- INTERVAL set to 500 [ns]
- kernel with maxcpus=0
- start a 'find /' command in the shell in parallel of the program
- stdout, stderr > redirected to file.

[  850.581983] a.out[173]: unhandled level 3 permission fault (11) at
0x004391f0, esr 0x8200000f
[  850.591833] pgd = ffffffc039311000
[  850.596725] [004391f0] *pgd=0000000039340003
[  850.602145] , *pud=0000000039340003
[  850.608352] , *pmd=000000003922c003
[  850.611963] , *pte=00e80000359c0f53
[  850.618111]
[  850.621102]
[  850.624032] CPU: 0 PID: 173 Comm: a.out Not tainted 4.9.0-v8+ #5
[  850.631314] Hardware name: Raspberry Pi 3 Model B (DT)
[  850.637925] task: ffffffc039a13100 task.stack: ffffffc039a14000
[  850.645314] PC is at 0x4391f0
[  850.649783] LR is at 0x4391f0
[  850.654035] pc : [<00000000004391f0>] lr : [<00000000004391f0>]
pstate: 60000000
[  850.662920] sp : 0000000000420da0
[  850.667516] x29: 00000000004391f0 x28: 0000000000000000
[  850.677145] x27: 0000000000000000 x26: 0000000000000000

When I taskset the context_demo program to other cores that are
completely isolated (CONFIG_NO_HZ_FULL, isolcpus=1,2,3) it will run
continuously with the modified STACKSIZE.

regards
Bas
