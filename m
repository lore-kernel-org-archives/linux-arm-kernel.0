From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Thu, 20 Jul 2017 06:57:37 +0000
Subject: IMX53 on recent 4.4.x kernels
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
?
I'm facing a PERFORMANCE problem on recent ARM/IMX  kernels !
 ?
I have ported a recent kernel (4.4.x branch) to one of our custom ARM ( imx53-based ) boards.
This board has been running kernel 2.6.35.x for some years, and at this time we decided we needed newer kernel ( for wifi operation), so far so good.


When running this a NEW (recent) kernel 4.4.76  (or even newer 4.4.x Lets say) , I see a HIGH CPU load compared to the older 2.6.35 kernel.
( when running the same applications, 100% identical root fs, only and single change is the kernel !)
With the same 'applications' I get very big performance differences between both kernels .

Comparing systems is difficult I know.. but... What has been changed ? only the KERNEL ( same hardware, same gcc-compiler, same C-lib, same user-space applications) only the KERNEL has been upgraded (nothing else) , both boards I compare are identical .. running at the same clock-speed... same amount of ram / storage. ! 100% sure on this ! .
?
When comparing 2.6.35.x to 4.4.x kernels I see that a LARGE fraction of the CPU power is consumed into system itself  ( looking at TOP)

For a nearly empty system ... please look at the performance differences in HTOP/TOP.

====================================4.4.x=========================
Kernel 4.4.x
uname -a
Linux DU11 4.4.73 #3 PREEMPT Tue Jul 4 09:06:46

#top
Mem: 176076K used, 844800K free, 0K shrd, 44K buff, 44K cached
CPU: 0% usr 31% sys 0% nic 68% idle 0% io 0% irq 0% sirq Load average: 1.31 1.41 1.43 1/85 12125 PID PPID USER STAT VSZ %VSZ %CPU COMMAND
12125 21246 root R 1184 0% 23% top
12142 1 root S 3728 0% 0% /usr/sbin/mosquitto -c /etc/mosquitto/
 
# htop
CPU[##********** 40.0%] Tasks: 32, 0 thr; 1 running
Mem[|||||** 142/978MB] Load average: 7.20 7.18 7.12 Swp[ 0/0MB] Uptime: 16:22:48
PID USER PRI NI VIRT RES SHR S CPU% MEM% TIME+ Command
30886 root 20 0 1064 576 432 R 33.0 0.1 0:00.06 htop


====================================2.6.35=========================
Kernel 2.6.35
uname -a
Linux OLD 2.6.35.3 #1 PREEMPT Tue Jun 14 13:45:24


#top
Mem: 97064K used, 904376K free, 0K shrd, 0K buff, 46160K cached
CPU: 0% usr 0% sys 0% nic 99% idle 0% io 0% irq 0% sirq Load average: 1.41 1.27 1.26 2/70 18808 PID PPID USER STAT VSZ %VSZ %CPU COMMAND
18696 30503 root R 1176 0% 0% top
842 1 root S 3928 0% 0% /usr/sbin/mosquitto -c /etc/mosquitto/

#htop
CPU[#* 1.5%] Tasks: 32, 0 thr; 1 running
Mem[||||** 126/996MB] Load average: 1.21 1.23 1.30 Swp[ 0/0MB] Uptime: 2 days, 00:05:53
PID USER PRI NI VIRT RES SHR S CPU% MEM% TIME+ Command
13431 root 20 0 1076 772 628 R 1.0 0.1 0:00.66 htop

===================================================================


?I know that I moved couple of versions ( 2.6.35 -> 4.4.x is quite a big step there is no discussion about that, we all know that, and want to understand that )
?
BUT I did not expect the same 'application'  to use that MUCH CPU ( running on 100% the same hardware configuration ).
{ did not recompile any application, the only thing that has been upgraded is the kernel nothing else , same compiler, same Clib, etc..}
?
Whatever you seem to do on a 4.x kernel .. it seems to be using that much cpu very quickly, and due to this high cpu/kernel load all applications ( even bare basic system application like top/htop / watch .. etc ... ) are NOT running smooth !
?
?
Both system I compare have been stripped down to a 'bare' minimum required.

I have made a 10 C-code liner to show you the difference. ( When I do compare both , I make sure that both system have the same rootfs and the have the same process tree 100% sure both system have that same 'applications'  running))

For this SIMPLE test program I get:

for 2.6.35 => 18000 ms of runtime 

# uname -a
Linux OLD 2.6.35.3 #1 PREEMPT Tue Jun 14 13:45:24 CEST 2016 armv7l GNU/Linux
#
TestCode-1
Going to loop 20000000 times.
319456382-319438304 = >18078 ms

 
for 4.4.x => 61000 ms of runtime !

# uname -a
Linux DU11 4.4.76 #1 PREEMPT Fri Jul 14 08:19:47 CEST 2017 armv7l GNU/Linux
#
TestCode-1
Going to loop 20000000 times.
230307-169002 = >61305 ms  ==> what is 3.39 times ( or 339%)  slower ( and this was a lucky shot , most of the time it is even slower) ! 


The c-code is no rocket science ( just a simple loop probing for kernel time), it just shows you that the Newer Kernels (4.x ) are VERY SLOW compared to the 2.6.35.
( I've been experimenting with almost every kernel config option I can think of .. no drastic improvements on 4.x kernel in terms of speed/load improvement)


Best Regards,
Noel
