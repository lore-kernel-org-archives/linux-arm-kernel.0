From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 14 Sep 2011 15:54:56 +0530
Subject: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
	include interconnect barriers.
In-Reply-To: <20110913202701.GF24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
	<20110913202701.GF24252@atomide.com>
Message-ID: <4E7080F8.9020302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011 01:57 AM, Tony Lindgren wrote:
> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110904 06:22]:
>> On OMAP4 SOC intecronnects has many write buffers in the async bridges
>> and they can be drained only with stongly ordered accesses.
>
> This is not correct, strongly ordered access does not guarantee
> anything here. If it fixes issues, it's because it makes the writes
> to reach the device faster. Strongly ordered does not affect anything
> outside ARM, so the bus access won't change.
>
What I said is the aync bridges WB and what is said is correct
from MPU accesses point of view.

It's not about faster or slower. With device memory the, writes
can get stuck into write buffers where as with SO, the write buffers 
will be bypassed.

The behaviours is limited to the MPU side async bridge boundary which
is the problem. The statement is not for l3 and l4 interconnect which
probably you mean.

There is always a hardware signal to communicate CPU at async bridges
to ensure that data is not stuck in these bridges before CPU
clock/voltage is cut. Unfortunately we have a BUG on OMAP44XX devices
and the dual channel makes it even worst since both pipes have the
same BUG. So what we are doing is issuing SO write/read accesses
on these pipes so that there is nothing stuck there before MPU
hits low power states and also avoids any race conditions when
both channels are used together by some initiators. The behaviour
is validated at RTL level and there is no ambiguity about it.

May be you have mistaken the L3 and L4 as the interconnect levels
in this case.

Regards
Santosh
