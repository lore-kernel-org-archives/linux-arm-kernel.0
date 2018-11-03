From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 4 Nov 2018 00:07:30 +0100 (CET)
Subject: [PATCH] staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION
In-Reply-To: <20181103223027.26245-1-benwolsieffer@gmail.com>
References: <20181103223027.26245-1-benwolsieffer@gmail.com>
Message-ID: <101171304.143617.1541286450992@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> Ben Wolsieffer <benwolsieffer@gmail.com> hat am 3. November 2018 um 23:30 geschrieben:
> 
> 
> The compatibility ioctl wrapper for VCHIQ_IOC_AWAIT_COMPLETION assumes that
> the native ioctl always uses a message buffer and decrements msgbufcount.
> Certain message types do not use a message buffer and in this case
> msgbufcount is not decremented, and completion->header for the message is
> NULL. Because the wrapper unconditionally decrements msgbufcount, the
> calling process may assume that a message buffer has been used even when
> it has not.
> 
> This results in a memory leak in the userspace code that interfaces with
> this driver. When msgbufcount is decremented, the userspace code assumes
> that the buffer can be freed though the reference in completion->header,
> which cannot happen when the reference is NULL.
> 
> This patch causes the wrapper to only decrement msgbufcount when the
> native ioctl decrements it. Note that we cannot simply copy the native
> ioctl's value of msgbufcount, because the wrapper only retrieves messages
> from the native ioctl one at a time, while userspace may request multiple
> messages.
> 
> Fixes: 5569a12 ("staging: vchiq_arm: Add compatibility wrappers for ioctls")
> 
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>

thanks for sending this patch. Unfortunately you missed some necessary recipients from scripts/get_maintainters.pl:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
devel at driverdev.osuosl.org

Btw please add a link to your pull request into the commit log to provide more background info:

Link: https://github.com/raspberrypi/linux/pull/2703

Thanks
Stefan
