From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 03 Oct 2013 22:14:42 +0200
Subject: [PATCH v2 1/2] ARM: kirkwood: retain MAC address for DT ethernet
In-Reply-To: <20131003194449.GB30298@obsidianresearch.com>
References: <1380804294-13726-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1380826568-18587-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131003190201.GA2504@localhost>
 <20131003190437.GY31178@titan.lakedaemon.net>
 <20131003194449.GB30298@obsidianresearch.com>
Message-ID: <524DD032.4060308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2013 09:44 PM, Jason Gunthorpe wrote:
> On Thu, Oct 03, 2013 at 03:04:37PM -0400, Jason Cooper wrote:
>
>>> I'm wondering: is the clock really disabled if the device is not
>>> available (i.e. status == 'ok')? In other words: isn't the
>>> !of_device_is_available() test enough?
>>
>> Well, this stemmed from JasonG's scenario where the second iface is
>> shut off by the bootloader.  Although one could argue that the
>> bootloader should then update the dtb to mark that node as disabled...
>
> Right, that is what we do here, only the first eth is present in the
> dt, the second is gated and powered down (noting that Linux doesn't
> know how to power it up :()
>
> This check is only to prevent CPU lockup if the firmware has included
> a DT node for ethernet, not included the MAC address and turned off
> the clock.
>
> Sebastian, does __clk_enabled work properly for the mvebu clock
> provider? I don't see a clk_ops.is_enabled for mvebu.. (don't know
> much about clk)

(joint answer for all three above)

A node with status != "okay" means "hardware/board does not allow you
to use that port at all, i.e. no ethernet jack"; disabling the clock
just means "I don't expect _all_ users want to use this jack, but it
is connected". So there _is_ a difference here.

clk-gate, which is the underlying clk provider for our gates, does
provide .is_enabled and reads the register. I haven't tested this,
due to no KW hardware available right now, but it should test for
disabled clocks as expected.

> Also, I think you should move the pr_err above the clock test, or make
> a special pr_err for the clock test as well. Having the clock gated,
> no mac address and a dt node is still a fw bug.

Well, we have 4 cases here:
- status != "okay": skip
- of_get_mac_address() != NULL: skip (no registers read)
- !__clk_is_enabled(): skip and warn with FW_BUG about disabled
   clocks but no valid MAC address set.
- else, read registers, store MAC in DT, warn with FW_BUG about
   enabled clocks and no valid MAC address set.

Leaves missing public clk_is_enabled(), which I can provide a
patch for if Mike agrees (and I haven't missed anything without
really looking into CCF).

Sebastian
