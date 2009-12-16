From: chripell@gmail.com (christian pellegrin)
Date: Wed, 16 Dec 2009 18:38:47 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
References: <20091207175608.GE26821@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
	<cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
Message-ID: <cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2009 at 5:35 PM, christian pellegrin <chripell@gmail.com> wrote:

>
> I'm trying some more elaborate tests where just one case of
> inconsistency will stop the counting.
>

Here is the program that implements Russell's ideas (at least I think
so) but is easier to use. By giving the parameter 1 or -1 you can test
different kind of consistency issues (missing flush in r/w or
inconsistent mapping's cacheness). It is also quite fun to watch at
with the buggy kernel on an idle system: it looks like that every
couple of seconds the 256kb L2 cache get flushed anyway (so even on
the kernel without the patch every now and then you get some
progress). I had it running for tens of minutes on a patched kernel
without stops.

*** rt.sh:

#!/bin/sh

RT=./rta

dd if=/dev/zero of=rt count=1 bs=4k

$RT 0 $1 &
$RT 1 $1 &
$RT 2 $1 &

***  rt.c:
/*
arm-none-linux-gnueabi-gcc -Wall -o rta rt.c
*/
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[])
{
  int fd, dir;
  volatile unsigned int *s1, *s2;
  volatile int x;

  if (argc != 3) {
    printf("Usage: %s [0/1/2] [dir]\n", argv[0]);
    exit(1);
  }
  dir = atoi(argv[2]);

  fd = open("rt",O_RDWR);
    assert(fd != -1);

  switch(atoi(argv[1])) {
  case 0:
    x = 3000000;
    assert(lseek(fd, sizeof(unsigned int) * 128, SEEK_SET) ==
(sizeof(unsigned int) * 128));
    assert(write(fd, &x, sizeof(x)) == sizeof(x));
    while(1) {
      do {
	assert(lseek(fd, sizeof(unsigned int) * 128, SEEK_SET) ==
(sizeof(unsigned int) * 128));
	assert(read(fd, &x, sizeof(x)) == sizeof(x));
      } while(x % 3 != 0);
      printf("%d rw\n",x);
      x += dir;
      assert(lseek(fd, sizeof(unsigned int) * 128, SEEK_SET) ==
(sizeof(unsigned int) * 128));
      assert(write(fd, &x, sizeof(x)) == sizeof(x));
      if (dir > 0)
	assert(lseek(fd, 0, SEEK_SET) == 0);
      else
	assert(lseek(fd, sizeof(unsigned int) * 256, SEEK_SET) ==
sizeof(unsigned int) * 256);
      assert(write(fd, &x, sizeof(x)) == sizeof(x));
    }
    break;

  case 1:
    s1 = mmap(NULL, 4096, PROT_WRITE|PROT_READ, MAP_SHARED,
	      fd, 0);
    assert((long) s1 != -1);
    while(1) {
      while (s1[0] % 3 != 1);
      printf("%d 1map\n",s1[0]);
      s1[0] += dir;
      if (dir > 0)
	s1[256] = s1[0];
      else
	s1[128] = s1[0];
    }
    break;

  default:
    s1 = mmap(NULL, 4096, PROT_WRITE|PROT_READ, MAP_SHARED,
	      fd, 0);
    assert((long) s1 != -1);
    s2 = mmap(NULL, 4096, PROT_WRITE|PROT_READ, MAP_SHARED,
	      fd, 0);
    assert((long) s2 != -1);
    while (1) {
      while (s1[256] % 3 != 2);
      printf("%d 2map\n",s1[256]);
      s2[256] += dir;
      if (dir > 0)
	s2[128] =  s1[256];
      else
	s2[0] = s1[256];
    }
  }

  return 0;
}


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
