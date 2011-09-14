From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 14 Sep 2011 11:09:12 +0530
Subject: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
	include interconnect barriers.
In-Reply-To: <20110913202701.GF24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
	<20110913202701.GF24252@atomide.com>
Message-ID: <CAMQu2gzX8+i61=WY+5HchVt4z+G+aFg3d40-nP7Mm62CGW0giA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 1:57 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
>> On OMAP4 SOC intecronnects has many write buffers in the async bridges
>> and they can be drained only with stongly ordered accesses.
>
> This is not correct, strongly ordered access does not guarantee
> anything here. If it fixes issues, it's because it makes the writes
> to reach the device faster. Strongly ordered does not affect anything
> outside ARM, so the bus access won't change.
>
> The only real fix here is to do a read back of the device in question
> to guarantee the write got to the device.
>
>> There are two ports as below from MPU and both needs to be drained.
>> ? ? ? - MPU --> L3 T2ASYNC FIFO
>> ? ? ? - MPU --> DDR T2ASYNC FIFO
>>
>> Without the interconnect barriers, many issues have been observed
>> leading to system freeze, CPU deadlocks, random crashes with
>> register accesses, synchronization loss on initiators operating
>> on both interconnect port simultaneously.
>
> We had these issues for omap3 too. Adding a few read backs solved
> those kinds of issues.
>
No. Don't mix things. OMAP3 behaviour is a interconnect level and
it was single interconnect channel.

The issue here is a BUG in the asynchronous bridges and OMAp4 has
two separate channels at interconnect level form MPU side as mentioned
above.

Both of these patches I have passed it through Russell and Caralin before
including them here.

Regards
Santosh
