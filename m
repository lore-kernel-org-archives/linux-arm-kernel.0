From: longman@redhat.com (Waiman Long)
Date: Wed, 11 Oct 2017 10:03:11 -0400
Subject: [PATCH v2 4/5] arm64: locking: Move rwlock implementation over to
 qrwlocks
In-Reply-To: <20171011114905.GA27426@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <1507296882-18721-5-git-send-email-will.deacon@arm.com>
 <909c3e84-745c-20db-a071-f9e0f2cbe63a@redhat.com>
 <20171011114905.GA27426@arm.com>
Message-ID: <36af9f1f-6ca8-aff6-4b78-4b6a25816907@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 07:49 AM, Will Deacon wrote:
> Hi Waiman,
>
>>
>> Inlining is good for performance, but it may come with an increase in
>> kernel text size. Inlining unlock and unlock_irq are OK, but the other
>> inlines will increase the text size of the kernel. Have you measured how
>> much size increase will that be? Is there any concern about the
>> increased text size?
> Yes, I did look at the disassembly and bloat-o-meter results. Inlining
> these functions means that the fastpath sits entirely within a 64-byte
> cacheline and bloat-o-meter shows a relatively small increase in vmlinux
> size for a defconfig build with CONFIG_PREEMPT disabled:
>
> Total: Before=13800924, After=13812904, chg +0.09%
>
> (I also just noticed my typos in ARCH_INLINE_{READ.WRITE}_UNLOCK_IRQSAVE
> so I regenerated the numbers!)

The size increase looks small enough. That may largely due to the fact
that rwlocks aren't as frequently used as spinlocks, so the number of
call sites are not that many. Anyway, I am OK with that. I just want to
make sure that people are aware of this.

Cheers,
Longman
