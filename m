From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Dec 2009 17:14:40 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
References: <20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
Message-ID: <20091215171440.GA15855@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 12:01:56PM +0100, christian pellegrin wrote:
> Thanks for your answers, unfortunately it turned out to be quite easy
> to write a program [0] that shows exactly what Russell described. :-(

Try this:

- create a 4K file
- create three programs:
  1. repeatedly uses read() and write() to increment the first word of
     this file
  2. uses one shared mmap of this file to increment the 256th word (offset
     1024)
  3. uses two shared mmaps of this file, reading the 128th word from one
     shared mmap, reads the 128th word from the other, increments the
     first value and writes it to the 128th word in the second map,
     printing the two values read.  It also reads the first and 256th
     word and prints the result

This should be an adequate test of most of the important scenarios: the
third program should show an increasing number for both locations.

If it doesn't, then the value is being cached somewhere.  I suspect
what you'll find is that on Feroceon, the only values you will see
increment is the 128th value.  The remainder will be static.

That means multiple shared mmaps on Feroceon are incoherent with:
1. file updates via read/write.
2. other shared mappings in other processes.

And because of (1) I expect that a read() followed by another read() of
the same file offset as being updated by (3) will not show updates - so
it should be both lost write()s and stale data on read()s (which will
mean PIO write-outs - eg swap out, file update - will be affected.)

> int main(int argc, char *argv[])
> {
>   int fd, fd1;
>   char *s1, *s2, *p;
>   volatile char x;

As a note, you want s1, s2 and p to be volatile, otherwise the compiler
can cache the result.

>   fd = open("prova", O_RDWR);
>   assert(fd);
> 
>   fd1 = open("prova", O_RDWR);
>   assert(fd1);
> 
>   p = mmap(NULL, 1024, PROT_WRITE|PROT_READ, MAP_PRIVATE,
> 	   fd1, 0);
>   assert((long) p != -1);
> 
>   x = *p;
> 
>   s1 = mmap(NULL, 1024, PROT_WRITE|PROT_READ, MAP_SHARED,
> 	     fd, 0);
>   assert((long) s1 != -1);
>   s2 = mmap(NULL, 1024, PROT_WRITE|PROT_READ, MAP_SHARED,
> 	     fd, 0);
>   assert((long) s2 != -1);
> 
>   fprintf(stderr,"s1 %p s2 %p p %p\n", s1, s2, p);
>   fprintf(stderr, "1: s1 %d s2 %d p %d\n", s1[0], s2[0], p[0]);
> 
>   s1[0] = 'a';
>   s2[0] = 'b';
> 
>   msync(s1, 1024, MS_SYNC);
>   msync(s2, 1024, MS_SYNC);

These msyncs should not be required for data via one shared mmap to be
visible via another mmap.

>   assert(lseek(fd1, SEEK_SET, 0) == 0);
>   assert(read(fd1, &x, 1) == 1);
>   fprintf(stderr, "2: s1 %d s2 %d p %d x %d\n", s1[0], s2[0], p[0], x);
> 
>   return 0;
> }
