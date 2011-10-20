From: Wernerp@cornelius-consult.de (Werner Cornelius)
Date: Thu, 20 Oct 2011 18:03:50 +0200
Subject: select consuming too much cpu time when changing from kernel
	2.6.29 to 2.6.34
In-Reply-To: <20111020113701.GA21648@n2100.arm.linux.org.uk>
References: <201110201332.50407.Wernerp@cornelius-consult.de>
	<20111020113701.GA21648@n2100.arm.linux.org.uk>
Message-ID: <201110201804.00090.Wernerp@cornelius-consult.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 20. Oktober 2011 schrieb Russell King - ARM Linux:
> On Thu, Oct 20, 2011 at 01:32:45PM +0200, Werner Cornelius wrote:

With strace some starnge behaviour could be recognized.
strace tells that the delay of the select syscll is in the corect range, but 
with the new kernel I get less calls per second than with the old kernel.

For example with an 1ms select call the old kernel results in about 400 calls 
in 4 seconds, the new one 2300 only whch can't be possible.
Same is true when using nanosleep as an alternative to select.

Except from that verification of the system timer interrupt rate and time of 
day update don't show any problems regarding this topic.

And the select call on the newer kernel uses much more system time per call 
than the old one additionally to the non matching number of syscalls.

For a test I changed the systick count HZ from 250 up to 1000, but the 
behaviour and results keeps the same and so does not have the reason in a too 
low scheduling resolution.

As far as I remember nanosleep uses the hires timer if available, select does 
not. But the results are the same for both versions.
Maybe the hr timer is not correctly implemented or the newer kernel rounds low 
time values to a higher one.

When I raise the timeout value to 10ms (10 times than before) I am getting a 
result which matches nearly correctly to the desired one.

When changing kernel tick rate from 250 to 1000Hz results remain unchanged 
again, so the problem seems not to be resolution related.



  
   

> > recently we changed from an older kernel 2.6.29 to a newer one 2.6.34 on
> > an ARM NXP LPC3250 platform.
> 
> strace is a wonderful program to monitor the kernel/user API activity -
> it would be good if you could strace your test program and confirm
> whether it's working as you expect.  (Note that it can measure the time
> spent inside a syscall.)
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 316 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111020/a907fafb/attachment.sig>
