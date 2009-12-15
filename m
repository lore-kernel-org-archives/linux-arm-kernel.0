From: chripell@gmail.com (christian pellegrin)
Date: Tue, 15 Dec 2009 12:01:56 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
References: <20091207114218.GA19348@n2100.arm.linux.org.uk>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
Message-ID: <cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 8:50 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> On Mon, Dec 14, 2009 at 10:14 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Mon, 14 Dec 2009, christian pellegrin wrote:
>>>
>>> Has someone a suggestion on how to write a test-case for this?
>>
>> I don't think there is any peripheral that runs in PIO mode on
>> Kirkwood... except the NAND flash.
> the sata can be configured to use pio instead of dma, this can be done
> by adding libata.force=pio to the command line.
>>

Thanks for your answers, unfortunately it turned out to be quite easy
to write a program [0] that shows exactly what Russell described. :-(

On the Ferocecon [1] sometimes *both* the read via private mapping and
via simple lseek/read give the wrong result. On another arm without L2
cache [2] it happens sometimes that private mapping gives the wrong
result (I'm not sure it's ok, but it seems reasonable because the
mapping is private) but the read via lseek/read is always ok.

[0]:
/*
  dd if=/dev/zero of=prova count=1 bs=1k
  before running this
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
  int fd, fd1;
  char *s1, *s2, *p;
  volatile char x;

  fd = open("prova", O_RDWR);
  assert(fd);

  fd1 = open("prova", O_RDWR);
  assert(fd1);

  p = mmap(NULL, 1024, PROT_WRITE|PROT_READ, MAP_PRIVATE,
	   fd1, 0);
  assert((long) p != -1);

  x = *p;

  s1 = mmap(NULL, 1024, PROT_WRITE|PROT_READ, MAP_SHARED,
	     fd, 0);
  assert((long) s1 != -1);
  s2 = mmap(NULL, 1024, PROT_WRITE|PROT_READ, MAP_SHARED,
	     fd, 0);
  assert((long) s2 != -1);

  fprintf(stderr,"s1 %p s2 %p p %p\n", s1, s2, p);
  fprintf(stderr, "1: s1 %d s2 %d p %d\n", s1[0], s2[0], p[0]);

  s1[0] = 'a';
  s2[0] = 'b';

  msync(s1, 1024, MS_SYNC);
  msync(s2, 1024, MS_SYNC);

  assert(lseek(fd1, SEEK_SET, 0) == 0);
  assert(read(fd1, &x, 1) == 1);
  fprintf(stderr, "2: s1 %d s2 %d p %d x %d\n", s1[0], s2[0], p[0], x);

  return 0;
}

[1]:
debian-armel:~/cachep# uname -a
Linux debian-armel 2.6.32-rc7-openrd #36 PREEMPT Tue Dec 15 11:07:00
CET 2009 armv5tel GNU/Linux
debian-armel:~/cachep# cat /proc/cpuinfo
Processor	: Feroceon 88FR131 rev 1 (v5l)
BogoMIPS	: 1196.03
Features	: swp half thumb fastmult edsp
CPU implementer	: 0x56
CPU architecture: 5TE
CPU variant	: 0x2
CPU part	: 0x131
CPU revision	: 1

Hardware	: Marvell OpenRD Base Board
Revision	: 0000
Serial		: 0000000000000000

[2]:
root at familiar:/var/tmp# uname -a
Linux familiar 2.6.23-dixe #58 PREEMPT Fri Dec 4 11:33:26 CET 2009
armv4tl unknown
root at familiar:/var/tmp# cat /proc/cpuinfo
Processor       : ARM920T rev 0 (v4l)
BogoMIPS        : 88.84
Features        : swp half thumb
CPU implementer : 0x41
CPU architecture: 4T
CPU variant     : 0x1
CPU part        : 0x920
CPU revision    : 0
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format A
Cache format    : Harvard
I size          : 16384
I assoc         : 64
I line length   : 32
I sets          : 8
D size          : 16384
D assoc         : 64
D line length   : 32
D sets          : 8

Hardware        : Atmel AT91RM9200-DK
Revision        : 0000
Serial          : 0000000000000000


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
