From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 10 Nov 2018 17:41:03 +0100 (CET)
Subject: [PATCH v2] staging: vchiq_arm: fix compat
 VCHIQ_IOC_AWAIT_COMPLETION
In-Reply-To: <20181103233219.13685-1-benwolsieffer@gmail.com>
References: <101171304.143617.1541286450992@email.ionos.de>
 <20181103233219.13685-1-benwolsieffer@gmail.com>
Message-ID: <1826039258.174149.1541868063434@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ben Wolsieffer <benwolsieffer@gmail.com> hat am 4. November 2018 um 00:32 geschrieben:
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
> See https://github.com/raspberrypi/linux/pull/2703 for more discussion of
> this patch.
> 
> Fixes: 5569a12 ("staging: vchiq_arm: Add compatibility wrappers for ioctls")
> 
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
