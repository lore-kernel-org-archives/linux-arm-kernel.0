From: public_filter@yahoo.com (P F)
Date: Mon, 13 Sep 2010 12:58:41 -0700 (PDT)
Subject: [RFC] mmaping with VIVT cache
Message-ID: <210713.63745.qm@web120207.mail.ne1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please excuse the pseudonym.

I have recently encountered a problem in the context of the UVC (webcam)
driver.  The driver maintainer, Laurent, suggested that we bring the
thread to linux-arm-kernel for wider discussion.  See here for reference:
http://lists.berlios.de/pipermail/linux-uvc-devel/2010-August/005864.html

The problem I encountered was this: using an ARM926EJ-S with OHCI USB host,
I noticed intermittent graphical corruption of frames captured by several
different webcams, both UVC and non-UVC.

I was able to isolate the corruption down to one specific instance.  In
this instance, I collected three images:
1A.jpg - collected from host, prior to corruption
2A.jpg - collected from host, demonstrating corruption
2B.jpg - collected from inline USB analyzer, same image as 2A

Images 1A and 2A are in sequence, i.e., 2A immediately follows 1A.  2B is
not corrupted, and a binary diff between 2A and 2B shows two 32-byte
chunks have been changed.  A binary diff between 2A and 1A shows that
these same two chunks match.  Therefore, it seems there is some
contamination of the second image by the first.

As I described in the linked message, I found a workaround for this issue
by adding
  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot)
in the UVC driver's mmap() function, but Laurent explained that this was
invalid.

Does anybody have ideas for a proper fix?  I can reproduce this corruption
easily, and would be happy to test proposed patches.

Best regards


      
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 1A.jpg
Type: image/jpeg
Size: 10109 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100913/147ad402/attachment-0003.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2A.jpg
Type: image/jpeg
Size: 11660 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100913/147ad402/attachment-0004.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2B.jpg
Type: image/jpeg
Size: 11660 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100913/147ad402/attachment-0005.jpg>
