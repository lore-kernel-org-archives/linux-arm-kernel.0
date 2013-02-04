From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Mon, 4 Feb 2013 17:50:27 +0100
Subject: alsa usb-audio sound corruption caused by cached vmalloc mapping
Message-ID: <510FE6D3.9020904@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

on a armv5 soc, we have audio corruption while using a usb-audio sound card.
After analysis, it comes from alsa vmalloc mapping.

in the current kernel vmalloc mapping used by alsa are cached.

This cause coherency problem on armv5 architecture because the cache are VIVT :
- alsa kernel driver map a buffer with vmalloc. The memory attribute is cached
- userspace map vmalloc buffer.  The memory attribute is cached

But because the cache are VIVT, these two mapping don't share the same cache
line and won't see the same data.
This corruption can be hidden by context switch because cache are flushed on
context switch.

On x86 or armv7, the cache are PIPT and there is no such problem.



There was a commit "pcm - Call pgprot_noncached() for vmalloc'ed buffers"
(c32d977b8157bf67cdf47729ce7dd054a26eb534), that made the userspace mapping not
cached, but this caused issues because the kernel vmalloc mapping was still cached.

Instead of revering this commit, we could have made the kernel vmalloc noncached
(see attached patch). It fix the issue on armv5.

But on some architecture (armv7 for example) you can't have mapping for the same
physical memory cached (normal cached) and noncached (device memory).
So the vmalloc and userspace mapping will conflict with the kernel direct RAM
mapping.

A workaround could be to use writecombine protection instead of noncached.
This work because writecombine is mapped on armv7 as L_PTE_MT_BUFFERABLE (normal
uncached) that is compatible with cached memory (the same trick is used for
dmacoherent).
But that's architecture specific may not work on others architectures.



What's the best way the fix this issue on all architecture ?


Matthieu
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vmalloc_uncached.diff
Type: text/x-diff
Size: 740 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/72583e11/attachment.bin>
