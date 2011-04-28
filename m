From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 28 Apr 2011 22:19:15 +0800
Subject: [PATCH 1/3] i2c: append hardware lock with bus lock
In-Reply-To: <BANLkTin6jguQue_0Y74jGPnmhCcvWLBjHg@mail.gmail.com>
References: <1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com>
	<20110428102212.2d8d607c@endymion.delvare>
	<BANLkTin6jguQue_0Y74jGPnmhCcvWLBjHg@mail.gmail.com>
Message-ID: <BANLkTikV1QdQO90DAyy045B38z9W7+bTLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 4:36 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Apr 28, 2011 at 4:22 PM, Jean Delvare <khali@linux-fr.org> wrote:
>> Hi Haojian,
>>
>> On Thu, 28 Apr 2011 12:02:36 +0800, Haojian Zhuang wrote:
>>> Both AP and CP are contained in Marvell PXA910 silicon. These two ARM
>>> cores are sharing one pair of I2C pins.
>>>
>>> In order to keep I2C transaction operated with atomic, hardware lock
>>> (RIPC) is required. Because of this, bus lock in AP side can't afford
>>> this requirement. Now hardware lock is appended.
>>
>> I have no objection to the idea, but one question: when using the
>> hardware lock, isn't the software mutex redundant? I would expect that
>> you call the hardware_lock/unlock functions _instead_ of
>> rt_mutex_lock/unlock, rather than in addition to it. Or do you still
>> need the rt_mutex to prevent priority inversion?
>>
>
> Jean,
>
> It's actually not redundant. The hardware lock is used to protect
> access to the same register regions between two processors (AP
> and CP so called), while the software lock is used to protect
> access from within the AP side.
>

Jean,

It's not redundant. Reading RIPC register will try to get the lock. We're always
using __raw_readl() API to read register. I think the read operation
couldn't be
atomic and finished in one instruction cycle. If two processes in AP
side try to
get the RIPC lock with __raw_readl(), it may result dead lock. If we fetch the
RIPC lock behind software bus lock, it's safe.

If process on AP try to get the RIPC lock and compete with CP, it won't be an
issue. It should always be atomic.
