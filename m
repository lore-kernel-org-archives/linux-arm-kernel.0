From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 11 Jan 2011 17:41:24 +0530
Subject: Locking in the clk API
In-Reply-To: <20110111091607.GI12552@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikUT6ds6+omkmr2rgUipq=nmEd6GRPngK0+qUZ4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 2:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 11, 2011 at 10:16:42AM +0800, Jeremy Kerr wrote:
>> At present, we can satisfy these with:
>>
>> * clk_enable: may sleep
>
> I object to this as one of the purposes behind the clk API is to allow
> power savings to be made, and unless we can perform clk enable/disable
> from atomic contexts, the best you can do is enable the clock when the
> device is probed and disable it when it's released.
>
> For a lot of systems, modules are loaded at boot, and devices are probed
> at boot time. ?They're never unloaded.
>
> This means that clocks will be enabled at boot time and never turned off.
>
> If you're lucky, there may be open/release methods which can be used to
> enable/disable the clock, which reduces the 'clock on' period down to
> the point where userspace opens/closes the device. ?That's still
> insufficient and in some cases there aren't calls for this.
>
> Sometimes the only point that you know you need the clock enabled is when
> your driver has already been called in an atomic context.
>
> If such a requirement is imposed, it means that a driver would either have
> to leave the clock always on, or would have to drop such calls if the
> clock wasn't already enabled.

Perhaps we should factor the conventional clk_enable into two parts (say) :-
 a)  clk_setup  : Which does exactly what can't be done in atomic context.
                         Like setting PLLs i.e, if that needs to sleep.
b)  clk_enable : Everything else that gets the clock signals running.

The drivers could do clk_setup in probe/open and clk_enable right before the
the actual need of the clock. That way, drivers don't have to bother
with platform/clock
peculiarities while trying their best to save power.
Of course, power that can't be saved now, won't be saved then.
