From: Wernerp@cornelius-consult.de (Werner Cornelius)
Date: Thu, 20 Oct 2011 13:32:45 +0200
Subject: select consuming too much cpu time when changing from kernel 2.6.29
	to 2.6.34
Message-ID: <201110201332.50407.Wernerp@cornelius-consult.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

recently we changed from an older kernel 2.6.29 to a newer one 2.6.34 on an 
ARM NXP LPC3250 platform.
Everything worked after driver mods, but now we got some problems when using 
select inside userspace.

The following simple program is executed:

#include <stdio.h>
#include <sys/time.h>
#include <sys/select.h>

void wait()
{
  timeval t2;
  t2.tv_sec=0;
  t2.tv_usec=1000;
  select(1,0,0,0,&t2);
}

int main(int argc, const char *argv[])
{
  while (1)
    wait();

  return 0;
}

On the linux 2.6.29 kernel it works without any significant CPU load, but on 
the 2.6.34 we get an load of about 5% CPU usage for that test program.

This time is nearly completely reported as system time, even it should be 
expected that using select as portable delay should work in the same way and 
performance as before.
As the problem seems to have the reason inside the kernel perhaps someone else 
has watched such problems too and might have ideas or knowledge what the 
reason is.
I don't know if its related to the ARM platform only or its an general 
behaviour/problem of the kernel.

Unfortunately this behaviour is not acceptable for us, as there are severla 
processes waiting with select and so the CPU load increases for nothing.

Any ideas ?

Regards

Werner
 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 316 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111020/1901fcb4/attachment.sig>
