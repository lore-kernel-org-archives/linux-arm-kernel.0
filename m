From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Dec 2011 09:46:24 +0000
Subject: Is Pandaboard cpuhotplug working stably?
In-Reply-To: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
Message-ID: <20111221094624.GB3354@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 05:23:48PM +0800, Barry Song wrote:
> Hi guys,
> i tried cpuhotplug on pandaboard for both
> Pandroid_Froyo_L27.8.2_release_pkg and Linaro 11.11. It has failed to
> work stably.
> On Pandroid_Froyo_L27.8.2_release_pkg, unplugging cpu1 works well:
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> CPU1: shutdown
> 
> if i enable the cpu1 again by "echo 1 >
> /sys/devices/system/cpu/cpu1/online", the system will restore to 3
> random status: hang, normal, panic.
> 
> Using  Linaro 11.11 release, "echo 0 >
> /sys/devices/system/cpu/cpu1/online" will make system hang and the
> whole system will not be able to reset by pressing reset key, the only
> way to reset system is pulling out AV power.
> 
> i am sorry i can't get more time to debug and find more clues. just
> want to ask people whether this is a version the cpuhotplug works
> normal on?

cpu hotplug is basically totally buggered - the preconditions placed
upon the bringup code path are basically impossible to satisfy in any
shape or form at the moment.

There's the requirement that the secondary CPU is marked online and
active before interrupts are enabled for the thread migration stuff
to behave correctly.  However, this is incompatible with smp_call_function()
which will wait for online CPUs to respond to an IPI - which this one
won't because interrupts are disabled.

I think there was some discussion about how to fix this but I don't
recall the details.
