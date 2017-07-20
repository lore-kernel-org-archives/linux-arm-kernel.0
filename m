From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 20 Jul 2017 17:14:00 +0200
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
 <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
 <D24E577EA1E37B4788A3BFBC418F14A70759249B@wetsrvex01.loepfe.com>
 <20170720141528.kxrw5r4hpa2hebvd@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
Message-ID: <1500563640.26680.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 20.07.2017, 15:06 +0000 schrieb Vellemans, Noel:
> Hi  , 
[...]
> 
> ====BEGIN- Test-code=======================================================================================
> 
> #include <stdio.h>
> #include<stdlib.h>
> #include<string.h>
> #include<unistd.h>
> #include<fcntl.h>
> #include <time.h>
> #include <sys/times.h>
> 
> 
> 
> #define MS_TICKTIME2 ({\
> 				struct timespec tp;\
> 				clock_gettime(4, &tp);\
> 				(unsigned long)tp.tv_sec*1000+tp.tv_nsec/1000000;})

clock_gettime is one of the things which get optimized into "not a
syscall at all" if your kernel provides a VDSO. Are you sure your new
kernel configuration has CONFIG_VDSO enabled?

Regards,
Lucas
> 
> 
> int main(int argc, char* argv[])
> {
> 	unsigned long mainloopcount=20000000;
> 	unsigned long t2,t1;
> 	printf("TestCode-1\n");
> 	printf("Going to loop %ld times.\n",mainloopcount);
> 	t1=MS_TICKTIME2;
> 	do{
> 				/* just do some call to the kernel .. */
> 				volatile unsigned long t3=MS_TICKTIME2;
> 				t3++; /* whatever increment this as dummy operation*/
> 	}	while(--mainloopcount);
> 	t2=MS_TICKTIME2;
> 	printf("%ld-%ld = >%ld ms \n",t2,t1,((signed long)t2-(signed long)t1));
> 
> 	return 0;
> }
