From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 15 Sep 2016 11:41:55 +0100
Subject: [RESEND PATCH] arm64: kgdb: fix single stepping
In-Reply-To: <20160915075617.GJ16712@linaro.org>
References: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
 <20160914145850.GE19622@arm.com> <20160915075617.GJ16712@linaro.org>
Message-ID: <5fd52bac-a303-81c8-1b91-daa55d6cd53f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/16 08:56, AKASHI Takahiro wrote:
> On Wed, Sep 14, 2016 at 03:58:51PM +0100, Will Deacon wrote:
>> Hi Akashi,
>>
>> On Tue, Apr 21, 2015 at 02:13:13AM +0100, AKASHI Takahiro wrote:
>>> Could you please review my patch below?
>>> See also arm64 maintainer's comment:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313712.html
>>
>> -ETIMEDOUT waiting for the kdgb folk to comment. Ppeople have reported
>> that this patch is required for kgdb to work correctly on arm64, so I'm
>> happy to merge it.
>
> I'm happy, too.

I'll keep an eye out and FWIW see if I can throw in a review. I'm not  
really one of "kgdb folk" but did examine it fairly deeply in the early  
stages of the FIQ/NMI work (and which has since stopped focussing on kgdb).

I have some equally elderly, albeit rather less critical, kdb patches  
that I should have pushed harder for so I'm sympathetic here ;-)


Daniel.


>> However, as detailed in your comment log:
>>
>>> This patch
>>> (1) moves kgdb_disable_single_step() from 'c' command handling to single
>>>     step handler.
>>>     This makes sure that single stepping gets effective at every 's' command.
>>>     Please note that, under the current implementation, single step bit in
>>>     spsr, which is cleared by the first single stepping, will not be set
>>>     again for the consecutive 's' commands because single step bit in mdscr
>>>     is still kept on (that is, kernel_active_single_step() in
>>>     kgdb_arch_handle_exception() is true).
>>> (2) re-implements kgdb_roundup_cpus() because the current implementation
>>>     enabled interrupts naively. See below.
>>> (3) removes 'enable_dbg' in el1_dbg.
>>>     Single step bit in mdscr is turned on in do_handle_exception()->
>>>     kgdb_handle_expection() before returning to debugged context, and if
>>>     debug exception is enabled in el1_dbg, we will see unexpected single-
>>>     stepping in el1_dbg.
>>>     Since v3.18, the following patch does the same:
>>>       commit 1059c6bf8534 ("arm64: debug: don't re-enable debug exceptions
>>>       on return from el1_dbg)
>>> (4) masks interrupts while single-stepping one instruction.
>>>     If an interrupt is caught during processing a single-stepping, debug
>>>     exception is unintentionally enabled by el1_irq's 'enable_dbg' before
>>>     returning to debugged context.
>>>     Thus, like in (2), we will see unexpected single-stepping in el1_irq.
>>
>> this patch is doing *far* too much in one go. Could you please repost it
>> as a series of self-contained fixes with clear commit messages, so I can
>> queue them and cc stable where appropriate?
>
> Sure, but I need to refresh my memory here.
>
> -Takahiro AKASHI
>
>> Thanks,
>>
>> Will
