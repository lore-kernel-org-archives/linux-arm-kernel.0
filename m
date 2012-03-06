From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 6 Mar 2012 12:02:39 -0800
Subject: [RFC 00/14] Generic clk for Orion platforms.
In-Reply-To: <alpine.LFD.2.02.1203061439190.31242@xanadu.home>
References: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
 <20120306155840.GS5050@titan.lakedaemon.net> <20120306161743.GI24858@lunn.ch>
 <20120306172341.GU5050@titan.lakedaemon.net>
 <alpine.LFD.2.02.1203061439190.31242@xanadu.home>
Message-ID: <CAJOA=zO6wKPZ4LPusK=cPhH2AxN+piV7MGx=Lj8koXni2hMPFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 11:45 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 6 Mar 2012, Jason wrote:
>> On Tue, Mar 06, 2012 at 05:17:43PM +0100, Andrew Lunn wrote:
>> > On Tue, Mar 06, 2012 at 10:58:40AM -0500, Jason wrote:
>> > > I'm assuming the driver(s) will increment a reference, so when it
>> > > reaches zero, the framework would call a clk_gate hook.
>> >
>> > You missed an important point. No driver has claimed these, but u-boot
>> > has turned them on.
>>
>> This sounds like a bug in u-boot.
>>
>> > So we want linux to turn off all clocks for which
>> > there is no driver using them, in order to save power.
>> > kirkwood_clk_ctrl is dual purpose. It turns on needed clocks, but it
>> > also turns off unneeded clocks.
>>
>> This is creating a lot of complexity where the real answer seems to be
>> to get u-boot to shutoff all peripheral clocks before handing over
>> control to linux.
>
> No.
>
> Yes, u-Boot might be wrong. ?But the kernel should always distrust as
> much as possible from the bootloader. ?Instead of presuming some initial
> state from the bootloader, it is best to simply set that state up front.
>
> The fewer ties you have with any bootloaders, the fewer bugs you'll have
> in the end. ?Otherwise you might enter into a game of requiring a
> specific version of a specific bootloader to go with a given kernel, and
> that is far more complex to deal with than the complexity you are
> referring to above.

+1 to the above.

Let's not forget that the type of devices you would buy in a store
typically don't use u-boot, so having a u-boot-centric point of view
is simply too narrowly focused.  The greater the burden we add to
u-boot then the greater the burden we add to every bootloader out
there in the world.  The kernel should manage system resources, simple
as that.

The current clk series does have a flag that can be set per clk,
CLK_IGNORE_UNUSED, which allows platform clock data to NOT
automatically disable unused clocks.  Otherwise in a future revision
of the clock code there will be a late_initcall which walks the tree
disabling clocks that are enabled in hardware, but have prepare_count
== 0.  That didn't go in this time since I'm trying to get the current
stuff merged and adding features tends to slow that process down...

Regards,
Mike

>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
