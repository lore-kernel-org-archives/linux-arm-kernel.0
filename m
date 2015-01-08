From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Jan 2015 11:15:23 -0600
Subject: [PATCH] USB: gadget: udc: atmel: fix possible oops when
 unloading module
In-Reply-To: <1419932967-2694-1-git-send-email-songjun.wu@atmel.com>
References: <1419932967-2694-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <20150108171523.GL31926@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 30, 2014 at 05:49:27PM +0800, Songjun Wu wrote:
> Executing the 'insmod g_hid.ko', then executing the
> 'rmmod g_hid.ko', the NULL pointer oops will be triggered.
> 
> When unloading the module 'g_hid.ko', the urb request will be
> dequeued and the completion routine will be excuted. If no urb
> packet, the urb request will not be added to the endpoint queue
> and the completion routine pointer in urb request is NULL.
> Accessing to the NULL function pointer will cause the oops issue.
> Add the code to check the urb request is in the endpoint queue
> or not.If the urb request is not in the endpoint queue, a negative
> error code will be returned.
> 
> This bug was introduced since the file 'atmel_usba_udc.c' was
> initialized. Fixes: 914a3f3b3754 (USB: add atmel_usba_udc driver)
> Cc: stable at vger.kernel.org # always been there...

this is not the way you write this. There are tons of examples in the
very git tree you're using of how to do this. Just run:

$ git log --grep "Fixes:"

Also have a read at Documentation/SubmittingPatches and search for
"Fixes" in that file. You might also want to look at
Documentation/stable-kernel-rules.txt to figure out how to properly Cc
stable.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/f33afffd/attachment.sig>
