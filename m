From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 14:48:22 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51C2EBCD.4070206@pengutronix.de>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
 <51C2D5EF.3040803@pengutronix.de> <20130620102856.GC18536@arm.com>
 <20130620111255.GD18536@arm.com> <51C2E917.9000708@pengutronix.de>
 <51C2EA04.4060701@pengutronix.de> <51C2EBCD.4070206@pengutronix.de>
Message-ID: <51C2FA16.2080807@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 01:47 PM, Marc Kleine-Budde wrote:
> On 06/20/2013 01:39 PM, Marc Kleine-Budde wrote:
>> On 06/20/2013 01:35 PM, Marc Kleine-Budde wrote:
>>> On 06/20/2013 01:12 PM, Catalin Marinas wrote:
>>>> On Thu, Jun 20, 2013 at 11:28:56AM +0100, Catalin Marinas wrote:
>>>>> We may need to place the preempt disable/enable at a higher level in the
>>>>> scheduler. My theory is that we have a context switch from prev to next.
>>>>> We get preempted just before finish_arch_post_lock_switch(), so the MMU
>>>>> hasn't been switched yet. The new switch during preemption happens to a
>>>>> thread with the same next mm, so the scheduler no longer switch_mm() and
>>>>> the TIF_SWITCH_MM isn't set for the new thread.
>>>>>
>>>>> I'll come back with another patch shortly.
>>>>
>>>> Here's another attempt (as before, only compile-tested):
>>>
>>> booting kernel from /image
>>> zImage: concatenated oftree detected
>>> booting Linux kernel with devicetree
>>>
>>> ...dead...
>>>
>>> Does every process have a "mm"? Even Kernel threads?
> 
> I've added a check for "mm". Boots now and my test runs stable for 3
> minutes now.
> 
> I'm not sure if we have to check for "mm" in
> check_and_switch_context(), too.
> 
> Thanks,
> Marc
> ---
> 
> From 306d84d5f0645a86e86d539be0546c4ac758d3d4 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 20 Jun 2013 12:12:55 +0100
> Subject: [PATCH] arm: Fix deferred mm switch on VIVT processors
> 
> As of commit b9d4d42ad9 (ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
> pre-ARMv6 CPUs), the mm switching on VIVT processors is done in the
> finish_arch_post_lock_switch() function to avoid whole cache flushing
> with interrupts disabled. The need for deferred mm switch is stored as a
> thread flag (TIF_SWITCH_MM). However, with preemption enabled, we can
> have another thread switch before finish_arch_post_lock_switch(). If the
> new thread has the same mm as the previous 'next' thread, the scheduler
> will not call switch_mm() and the TIF_SWITCH_MM flag won't be set for
> the new thread.
> 
> This patch moves the switch pending flag to the mm_context_t structure
> since this is specific to the mm rather than thread.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> [mkl: add check for mm]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

The test program works for 1 hour without problems. I'm going to push
the patch to our customer, if it fixes the problem there,  I'll add my
Tested-by.

regards,
Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/8f6986d1/attachment.sig>
