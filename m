From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 17 May 2013 13:58:34 +0200
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517133345.7c1368f5@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
Message-ID: <51961B6A.6020704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/13 13:33, Jean-Francois Moine wrote:
> On Thu, 16 May 2013 20:25:10 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> What follows is my DRM driver for Dove, which I've been working on with
>> the Solid-run Cubox, which only offers HDMI output via the TDA19988
>> chip.
...
> - device tree
>
>    Our driver depends on the DT and, by this way, it may be used for
>    various boards (Cubox, DB-MV88AP510 Development Board, CompuLab
>    CM-A510 Board..). Especially, in the Cubox, only a HDMI screen may be
>    connected, while the display controller permits connection of a smart
>    panel (port A) and a VGA screen (port B).
>    Also, the driver could be used for different chips as the Armada 160
>    which has quite the same LCD controller (but one LCD only and no
>    display controller - Sebastian's idea).

Jean-Francois,

as Russell already mentioned, he is not on DT yet. It's not a big deal
to add the binding parsing to his driver though. Basically, there is 
only one thing that bothers me with Russell's driver: integrating TDA
HDMI in the driver. But from what I have seen, it's almost equal to
our drm_slave_encoder stuff, so rebranding some functions should be
enough to allow any external encoder on lcdc.

> - module loading (si5351, tda998x)
>
>    As our driver is loaded by the Cubox DT, and as the auxilliary drivers
>    (external clock, HDMI transmitter) may also be modules, a
>    synchronization mechanism (inspired by the tegra drm driver) permits
>    the driver to start when all the other drivers are also started.

I agree on HDMI (when enabled through DT), but disagree on clock.
There is some clocks internally that should be exploited even if there
is no external clock available. This is actually something more general
with common clock as it does not handle dynamic clocks yet.

> - display controller
>
>    I implemented output port cloning (LCD 0 to port B) but it is not
>    tested (I just have a Cubox and I think that Sebastian did not have
>    time enough yet to do it).

Lack of time, sorry.
Would have to test on D2Plug which has both HDMI (also TDA) and VGA.

> - LCD handling
>
>    With our driver, the description of a smart panel (port A) may be
>    done by the DT.

In priciple, DT should support describing all possible panel modes. But
of course, let's start with what we can test. SmartPanel and VGA in
Jean-Francois and mine driver are just place holders. To mainline a
common driver, I suggest to take Russell's driver as a start and add
DT and stuff Russell agrees to.

> - LCD clocks
>
>    Each LCD may use one clock amongst 4 (AXI, LCD PLL and 2 external
>    clocks). In our driver, the choice of the clock is done on each video
>    mode change (Sebastian's idea).

This is because of the dynamic clock restriction above. Reprobing clocks
on each mode change will behave like dynamic clocks and should be
removed if common clock framework supports it someday.

Then there is a heuristic, that tries to find the best matching clock
starting with the current clock as lcdc itself can do integer division.

For Cubox with si5351 clock driver, it should be sufficient to rely on
si5351 providing the clock. That will allow all HD modes, except
1600x1200 at 60 and above which exceed 160MHz max output frequency
restriction of si5351.

> - screen rotation (IRE)
>
>    This feature is needed when the Dove SoC is used in a tablet and does
>    not exist in both drivers.

Again, let's implement what we can test - or is there anybody using
secretary mode on his TV? BTW, IRE is only available on Dove, while lcdc
controller can be reused on some PXAs.. try not to put too much Dove
dependency into lcdc if possible.

> - VGA DAC
>
>    This feature is needed to get the VGA screen parameters (mode,
>    dimensions) and does not exist in both drivers too.

Do I still have a VGA monitor to test? ;)

> What do you think about merging?

As said above, I'd prefer to take Russell's driver as a start and merge
ours (actually yours, as I just added stuff that slowed you down :P)

Sebastian
