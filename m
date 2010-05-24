From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Mon, 24 May 2010 09:13:55 +0530
Subject: facing undefined inconsistent cache issues on cortex-a9
Message-ID: <4BF9F5FB.6020306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I am using linux-2.6.32 port on spear1300 platform, the port is largely based
on realview code.

SPEAr1300 has a Cortex A9 dual core, both cores configured as participating in
SMP, but we are currently configuring Linux in non SMP mode, running Linux on
the first core only, while second core is spinning  forever in a tight loop.

Linux is running with default configuration w.r.t. cache and other things on
core1. Since SMP is not enabled this means that SCU and local timers are off, L2
cache is also disabled.  While on core2 only instruction cache is on and both
MMU and Data cache is off.

We observed a crash while booting. Investigating on the crash we found that this
was caused by a wrong value read by the core.  Strangely enough, the new value
was written few instruction before, but the core was still reading the old one.

What happens is someting like this:

r0 = X ; /* X is the address of a Linux variable */

str r5, [r0]; /* write new value */
...  
ldr r5, [r0]; /* read back value - we get the old one (???) */

The value read here, just few lines later the new value was written, is the old
one. Obviously we are expecting to find the new one.

Moreover, using the jtag debugger it looks clear that the new value is indeed in
the memory, but surprisingly NOT in the data-cache. 
If we put a read of X, before the store in order to avoid the write miss when
doing 'str r5, [r0]', we see that the problem doesn't appear.

We are completely lost, any pointers would really help, thanks

regards
Shiraz
