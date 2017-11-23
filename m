From: jgg@mellanox.com (Jason Gunthorpe)
Date: Thu, 23 Nov 2017 08:04:39 -0700
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123095456.lkc4nkuzsd2q26mm@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
Message-ID: <20171123150439.GB18754@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 10:54:56AM +0100, Alexandre Belloni wrote:

> So I'm discovering that this patch made it upstream silently. While it
> somewhat solves the issue for some RTCs, it is not a proper solution for
> most.

It was cc'd all the right lists?

> With this patch, set_offset_nsec will be hardcoded in the driver and
> this basically work for the mc146818 but many RTCs are connected on a
> slow bus (let's say i2c) and that bus may have various latencies
> depending on the platform so the value actually depends on the platform
> rather than on the RTC itself.

The intention of the patch is for the actual RTC driver to set the
value to what it needs.

If some RTCs are dealing with variable latency busses then they should
do an bus IO to measure their bus latency then tweak their value.

In any event, having the correct offset for the RTC chip (eg 0.5 vs 0)
is a big improvement, even if there are some small I2C latencies.

> I really think that we should simply consider dropping hctosys,
> systohc and update_persistent_clock. Most distributions have been

Like Russell has said already, the kernel is the only place that could
actually have all the information needed. User space would have to use
some kind of trail and error approach to figure out what the offset
should be.

You can't really measure the offset without doing a time set, many
embedded RTCs do not hook up interrupts, etc.

Jason
