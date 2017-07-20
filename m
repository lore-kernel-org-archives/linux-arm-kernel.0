From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Thu, 20 Jul 2017 15:06:27 +0000
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <20170720141528.kxrw5r4hpa2hebvd@pengutronix.de>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
 <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
 <D24E577EA1E37B4788A3BFBC418F14A70759249B@wetsrvex01.loepfe.com>
 <20170720141528.kxrw5r4hpa2hebvd@pengutronix.de>
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  , 

>> I can't imagine any good reason why 4.x should be significantly slower than your old kernel. How did you measure that?

Dito I can't imagine this too..... .. but... .. read on.

Long story , it all stared ( some weeks ago) I started to measure because I had some performance issues on the NEW-kernels ( I've been porting a recent kernel to our own custom/designed hardware)  { ive been running 2.6.35 a couple of years... on this hardware... so I'm not new into this)

Comparing systems is difficult I know.. but... What has been changed ? only the KERNEL ( same hardware, same gcc-compiler, same C-lib, same user-space applications) only the KERNEL has been upgraded (nothing else) , both boards I compare are identical .. running at the same clock-speed... same amount of ram / storage. ! 100% sure on this ! .


How did I measure ( really measure) ?

First of all I have IDENTICAL hardware ( 100% sure on this )

2nd: I did BUILD the same rootfs  on  both compares ( identical hardware's , I' m  running identical rootfs - 100% sure) THE ONLY AND SINGLE DIFFERENCE is the KERNEL ! ( all the rest is identical 100% sure, even everything is built with the SAME compiler ! )

3-thrid: - 2 options here  
3.a: I did look at TOP HTOP for both system RUNNING IDENTICAL ROOTFS ( 4.4.x) vs ( 2.6.35) 
-> I did look at TOP / HTOP and 4.4.x has WAY MORE CPU LOAD ( HTOP SHOW KERNEL LOADS VERY HIGH COMPARED TO 2.6.35)
HTOP itself used most of the CPU time (0a1% on 2.6.35) while the SAME HTOP showed ( +30a40% load on 4.4.x)

If you take a look with TOP and/or HTOP on 2 identical systems ... ( 2.6.35 vs 4.4.x) ( with only the kernel being changed) and you see 
On the one system ( 2.6.35)  kernel times less than 10% , and on the 4.4.x system you see kernel times of +60% ( or higher) then there is a difference.. ( there is no doubt about that)

3.b: stripped ROOTFS to minimum on BOTH ( running the same STRIPPED rootfs)
And I did build a small TEST-tool that was probing for kernel time ( looping X times) as test result of this small test tool , I measured execution times on both Kernels ( it's a simple stupid loop probing for kernel time in a loop)

The measured  RUNTIMES on 2.6.35 are in the 18000 ms range
The measured  RUNTIMES on 4.4.x  are in the 61000 ms range ( see below)  { for the same TEST tool } 

As said before , same  hardware, same bootloader, identical rootfs, ONLY and SINGLE difference is the KERNEL ! 


For this SIMPLE TEST-tool  I get:

for 2.6.35 => 18000 ms of runtime 
# uname -a
Linux OLD 2.6.35.3 #1 PREEMPT Tue Jun 14 13:45:24 CEST 2016 armv7l GNU/Linux #
TestCode-1
Going to loop 20000000 times.
319456382-319438304 = >18078 ms

 
for 4.4.x => 61000 ms of runtime !
# uname -a
Linux DU11 4.4.76 #1 PREEMPT Fri Jul 14 08:19:47 CEST 2017 armv7l GNU/Linux #
TestCode-1
Going to loop 20000000 times.
230307-169002 = >61305 ms  ==> what is 3.39 times ( or 339%)  slower ( and this was a lucky shot , most of the time it is even slower) ! 

The c-code is no rocket science ( just a simple loop probing for kernel time), it just shows you that the Newer Kernels (4.x ) are VERY SLOW compared to the 2.6.35.
( I've been experimenting with almost every kernel config option I can think of .. no drastic improvements on 4.x kernel in terms of speed/load improvement)





====BEGIN- Test-code=======================================================================================

#include <stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<fcntl.h>
#include <time.h>
#include <sys/times.h>



#define MS_TICKTIME2 ({\
				struct timespec tp;\
				clock_gettime(4, &tp);\
				(unsigned long)tp.tv_sec*1000+tp.tv_nsec/1000000;})



int main(int argc, char* argv[])
{
	unsigned long mainloopcount=20000000;
	unsigned long t2,t1;
	printf("TestCode-1\n");
	printf("Going to loop %ld times.\n",mainloopcount);
	t1=MS_TICKTIME2;
	do{
				/* just do some call to the kernel .. */
				volatile unsigned long t3=MS_TICKTIME2;
				t3++; /* whatever increment this as dummy operation*/
	}	while(--mainloopcount);
	t2=MS_TICKTIME2;
	printf("%ld-%ld = >%ld ms \n",t2,t1,((signed long)t2-(signed long)t1));

	return 0;
}


_______________________
Noel Vellemans
BMS bvba
-----Original Message-----
From: Robert Schwebel [mailto:r.schwebel at pengutronix.de] 
Sent: Thursday, July 20, 2017 4:15 PM
To: Vellemans, Noel
Cc: sales at pengutronix.de
Subject: Re: IMX53 on recent 4.4.x kernels

Hi,

On Thu, Jul 20, 2017 at 01:57:17PM +0000, Vellemans, Noel wrote:
> In short... I did a QUICK test on the 4.12 kernel as well ( but need 
> to add lots of custom drivers ) in order to get it running on the same 
> roofs.
> 
> But,  I believe FABIO ESTEVAM ( who was trying to give me some first 
> aid 'help' ) did some test on a 4.12 kernel ( for the performance
> issue) .. and it seems it is in the ALLMOST SAME SPEED range as the 
> 4.4.x kernel ( there was  small improvement ) but it was certainly not 
> at the same speed as the 2.6.35 kernel .
> 
> ( for the test program that looped for the Kernel time)
> 
> Regards Noel
> 
> NOTE: I'll try to get 4.12 ( or 4.13 ) running ( but needs a lot of 
> patches.. that require manual rework if I want to run then om our
> hardware)

I can't imagine any good reason why 4.x should be significantly slower than your old kernel. How did you measure that?

In case you need commercial help, please drop me a note. We do embedded Linux support and help customers with similar problems.

Regards,
Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
