From: mh@glandium.org (Mike Hommey)
Date: Fri, 23 Sep 2011 13:57:21 +0200
Subject: I-cache/D-cache inconsistency issue with page cache
Message-ID: <20110923115721.GA7013@glandium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We've been hitting random crashes at startup with Firefox on tegras
(under Android), and narrowed it down to a I-cache/D-cache
inconsistency. A reduced testcase of the issue looks like the following
(compile as ARM, not Thumb):

-----------------8<--------------
#include <sys/mman.h>
#include <string.h>
#include <fcntl.h>

__asm__(
  ".text\n"
  ".align 4\n"
  ".type foo, %function\n"
  "foo:\n"
  "  bx lr\n"
);

static void foo() __attribute__((used));

int main(int argc, char *argv[]) {
  if (argc < 2)
    return 0;
  int fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0600);
  ftruncate(fd, 4096);
  void *m = mmap(NULL, 4096, PROT_WRITE, MAP_SHARED, fd, 0);
  memcpy(m, foo, 4);
  munmap(m, 4096);
  void *mx = mmap(NULL, 4096, PROT_EXEC, MAP_SHARED, fd, 0);
  void (*func)(void) = (void (*)(void)) mx;
  func();
  return 0;
}
----------------->8--------------

We've been able to reliably reproduce with the above reduced testcase on
tegras under both Android and Ubuntu (Maverick). It however doesn't seem
to happen on all kinds of ARM processors, though.

A corresponding real world use case is that we are (were) uncompressing
libraries in mmap()ed memory and dlopen()ing the resulting file. We have
been doing so for a long time, but only recently we got a library small
enough to trigger an actual problem.

Something along these lines has been discussed on this very list:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/001074.html

What happens in practice with the above code is that by the time we jump
into the copied function, RAM still has the zeroed out page, while the
actual content is still in D-cache. Execution thus happens on zeroes, up
to the point it reaches the next page, which in most cases would not be
mapped, thus a segmentation fault.

In our real world scenario, the execution would start on zeroes, up to
some point where memory would have actual content, at which time we
crash with SIGILL at a cache line boundary (adresses ending in 0x20,
0x40, 0x60 or 0x80), depending on how much D-cache would have been
flushed in between because there are various things happening between
the uncompression and the execution of init functions in the library.
This didn't happen until we had a library smaller than 4KB with an init
function.

Adding a cache flush in between does solve the problem. I however think
the kernel should mitigate by making sure the page cache backing PROT_EXEC
mappings is fresh.

Please note that I'm not expecting
 void *m = mmap(NULL, 4096, PROT_WRITE | PROT_EXEC, MAP_SHARED, fd, 0);
 memcpy(m, foo, 4);
 void (*func)(void) = (void (*)(void)) m;
 func();
to work, this would be unreasonable.

Cheers,

Mike

PS: Please Cc me, I'm not subscribed.
