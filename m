From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 21 Mar 2013 23:26:17 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321214132.GB8431@obsidianresearch.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com> <20130321221523.7ede6ccc@skate>
 <20130321214132.GB8431@obsidianresearch.com>
Message-ID: <514B8909.7090201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 10:41 PM, Jason Gunthorpe wrote:
> On Thu, Mar 21, 2013 at 10:15:23PM +0100, Thomas Petazzoni wrote:
>> Dear Jason Gunthorpe,
>>
>> On Thu, 21 Mar 2013 14:55:45 -0600, Jason Gunthorpe wrote:
>>
>>> Or, better, locate all the internal registers above 8G and use
>>> contiguous DRAM mapping from 0 ->  8GB
>>
>> I see two potential issues with this idea:
>>
>>   *) It only works when LPAE is enabled, so we would have to have
>>      different internal register addresses depending on whether LPAE is
>>      enabled or not. Probably not impossible, but not very
>>      straightforward either.
>
> Ideally the internal register space address would come from the DT -
> we are getting very close to that on Marvell, I think.. Things like
> earlyprintk should ideally early parse the DT, harder I know :(
>
>>   *) It would require Linux to change the internal registers address
>>      (for now the kernel relies on the bootloader). The problem is that
>>      we can't do it early enough to preserve the earlyprintk
>>      functionality. Maybe you have suggestions on how to achieve that?
>
> I can't forsee how Linux could do this reprogramming - not only do you
> have to move the registers, you'd also have to reprogram the DRAM
> bases, while running from the DRAM. Not only does that have to be done
> early, but the DT would need to describe the DRAM ranks, and the code
> would have to parse it.. On top of that it would have to be very
> careful not to wack any DRAM that has already been touched by the
> kernel.. Tricky stuff :)

Jason, Lior,

at least for Dove you are missing one important fact:

The Internal Registers Base Address register is within ... the internal
registers. You can't even look it up without knowing where it is.

That doesn't mean we can parse the DT for the current register base
address and move it to where we expect it. But for DRAM, I suggest not
to mess with it. The boot loader is there for a reason.

Sebastian
