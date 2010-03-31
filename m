From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Thu,  1 Apr 2010 00:23:23 +0300
Subject: [RFC PATCH v4 0/3] ARM: VFP: Save / restore VFP state on the signal
	handler path
In-Reply-To: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
References: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
Message-ID: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
- Rebased against mainline v2.6.34-rc3, since some parts have already
  been applied there.

Note that this problem might affect more people than previously thought.
The CodeSourcery 2009q1-203 glibc_ports has some NEON optimized functions;
for example using memset or memcpy in a signal handler and floating point
in the main thread can corrupt the main thread's context. You can test this
by replacing the floating point ops in the signal handler below with some
dummy memset/memcpy.

I could only test these patches on a Cortex A8 UP system; it would be great
if someone with an SMP board could give it a go. The test app to reproduce
the problem (I've built it with -mfloat-abi=softfp -mfpu=neon):

#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#include <sys/time.h>

void handler(int signum)
{
	volatile float f;

	f = 50;
	f /= 2;
	f *= 2;
	if (f != 50) {
		printf("signal %3.3f\n", f);
		exit(-1);
	}
}

int main(int argc, char **argv)
{
	struct itimerval ival;

	if (signal(SIGALRM, handler) == SIG_ERR) {
		perror("signal");
		exit(-1);
	}

	memset(&ival, 0, sizeof(ival));
	ival.it_value.tv_usec = 1000;
	ival.it_interval.tv_usec = 10000;

	if (setitimer(ITIMER_REAL, &ival, NULL) < 0) {
		perror("setitimer");
		exit(-1);
	}

	while (1) {
		volatile float f = 30;

		f /= 3;
		f *= 3;
		if (f != 30) {
			printf("main %3.3f\n", f);
			exit(-1);
		}
	}
}
