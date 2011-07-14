From: ccross@google.com (Colin Cross)
Date: Thu, 14 Jul 2011 15:10:51 -0700
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
References: <20110705185758.GI8286@n2100.arm.linux.org.uk>
	<CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
	<20110714073453.GK23270@n2100.arm.linux.org.uk>
	<CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
Message-ID: <CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 12:58 AM, Colin Cross <ccross@google.com> wrote:
> On Thu, Jul 14, 2011 at 12:34 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Jul 13, 2011 at 11:52:21PM -0700, Colin Cross wrote:
>>> On Tue, Jul 5, 2011 at 11:57 AM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>> > Ensure that the meminfo array is sanity checked before we pass the
>>> > memory to memblock. ?This helps to ensure that memblock and meminfo
>>> > agree on the dimensions of memory, especially when more memory is
>>> > passed than the kernel can deal with.
>>> >
>>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>>
>>> This patch causes a regression in v3.0-rc7 when overlapping mem=
>>> options are passed to the kernel. ?On an OMAP4 board, I was
>>> accidentally using "mem=512M mem=920M" on the command line, which
>>> works fine in v3.0-rc6.
>>
>> I don't regard that as a regression. ?That's something which hasn't
>> been supported before the move to memblock, and it's not something
>> that was not intended to be supported.
>>
>
> Ok, works for me.
>

With CONFIG_CMDLINE_EXTEND, accidentally using two mem= options is
going to become more common (that's how I did it).  Would you accept a
patch for 3.1/3.2 that would make incorrect mem= handling more robust?

Investigating a little more, the problem happens in free_unused_memmap
when two banks ordered by bank_start have reverse order bank_end.
prev_bank_end gets set too low, and the area between bank_end of the
previous two banks gets freed when a third bank is processed.

I can either drop extra mem= options if they overlap with a previous
one, try to copy the memblock data back into meminit after memblock
has handled the overlapping case, or fix up free_unused_memblock to
only increase prev_bank_end.
