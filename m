From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 Jan 2011 16:57:42 +0000
Subject: Locking in the clk API
In-Reply-To: <20110112022546.GA2350@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<201101111744.59712.jeremy.kerr@canonical.com>	<20110111101314.GA774@linux-sh.org>	<201101111830.18597.jeremy.kerr@canonical.com>	<20110111121816.GB774@linux-sh.org>	<4D2D09E2.5030305@codeaurora.org>
	<20110112022546.GA2350@linux-sh.org>
Message-ID: <4D386986.3030506@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/11 02:25, Paul Mundt wrote:
> On Tue, Jan 11, 2011 at 05:54:42PM -0800, Saravana Kannan wrote:
>> On 01/11/2011 04:18 AM, Paul Mundt wrote:
>>> Again, you are approaching it from the angle that an atomic clock is a
>>> special requirement rather than the default behaviour. Sleeping for
>>> lookup, addition, and deletion are all quite acceptable, but
>>> enable/disable pairs have always been intended to be usable from atomic
>>> context. Anyone that doesn't count on that fact is either dealing with
>>> special case clocks (PLLs, root clocks, etc.) or simply hasn't bothered
>>> implementing any sort of fine grained runtime power management for their
>>> platform.
>>
>> Paul,
>>
>> I see you repeating this point a couple of times and I'm a bit confused 
>> how you handle the clock tree/dependencies.
>>
>> Does your clock driver NOT hide the details of what root clock/PLL a 
>> branch clock is sourced from? If you do hide the details of the root/PLL 
>> source, how do you get the branch clk_enable() to be done atomically if 
>> the root/PLL enables are not possible in atomic context?
>>
>> Is it simply a matter of your hardware having PLLs and root clocks that 
>> can be turned on/off quickly?
>>
> There are a few cases where PLL clocks would benefit from a clk_enable()
> that can sleep, but for us these are almost all in the device space. Most
> of the SoCs however have fairly straightforward clock topologies where
> the root clock in question is an external oscillator that can't be
> disabled, and anything chained below that sits behind a PLL divider or
> multiplier bank that can likewise be adjusted atomically. The vast
> majority of the clocks below that can likewise be trivially
> enabled/disabled from atomic context.

All the Samsung SoCs have multiple PLLs as the root of their clock
trees, with some muxing options to feed in oscillator inputs. Many
of the systems I've seen have a 48MHz source for the USB, 12MHz
as a PLL source and then generate a pile of different frequencies for
various peripherals via the PLLs...

this is especially important for the cases where you need very specific
frequencies such as audio playback of tv encoding.
