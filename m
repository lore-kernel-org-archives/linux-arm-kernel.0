From: olof@lixom.net (Olof Johansson)
Date: Tue, 9 Aug 2011 12:24:35 -0700
Subject: [PATCH 4/5 V2] ARM: tegra: paz00: add clocks required for usb
	operation
In-Reply-To: <201108092118.43724.marvin24@gmx.de>
References: <cover.1312735430.git.marvin24@gmx.de>
	<201108092029.17546.marvin24@gmx.de>
	<CAOesGMiV-jrcGFUXBf=5H__-gXvwgxUias7WGouYTvAy+k=oMg@mail.gmail.com>
	<201108092118.43724.marvin24@gmx.de>
Message-ID: <CAOesGMgGJM5v5dOruOAJLqNg8Geu-BtvSoyBSdgnZU-nu94aDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 12:18 PM, Marc Dietrich <marvin24@gmx.de> wrote:
> Hi Olof,
>
> On Tuesday 09 August 2011 20:30:47 Olof Johansson wrote:
>> On Tue, Aug 9, 2011 at 11:29 AM, Marc Dietrich <marvin24@gmx.de> wrote:
>> >
>> > These clocks are required for usb operation.
>> > ---
>> > ?arch/arm/mach-tegra/board-paz00.c | ? ?6 ++++++
>> > ?1 files changed, 6 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-
> paz00.c
>> > index 45111f6..89a3dda 100644
>> > --- a/arch/arm/mach-tegra/board-paz00.c
>> > +++ b/arch/arm/mach-tegra/board-paz00.c
>> > @@ -145,6 +145,12 @@ static __initdata struct tegra_clk_init_table
> paz00_clk_init_table[] = {
>> > ? ? ? ?/* name ? ? ? ? parent ? ? ? ? ?rate ? ? ? ? ? ?enabled */
>> > ? ? ? ?{ "uarta", ? ? ?"pll_p", ? ? ? ?216000000, ? ? ?true },
>> > ? ? ? ?{ "uartd", ? ? ?"pll_p", ? ? ? ?216000000, ? ? ?true },
>> > +
>> > + ? ? ? { "pll_p_out4", "pll_p", ? ? ? ?24000000, ? ? ? true },
>> > + ? ? ? { "usbd", ? ? ? "clk_m", ? ? ? ?12000000, ? ? ? true },
>> > + ? ? ? { "usb2", ? ? ? "clk_m", ? ? ? ?12000000, ? ? ? true },
>> > + ? ? ? { "usb3", ? ? ? "clk_m", ? ? ? ?12000000, ? ? ? true },
>>
>> Do they all have to be enabled here? Setting the parent and rate makes
>> sense, but you shouldn't have to enable them.
>
> usb also works with all three usb* clocks set to disabled (they are even not
> required to be listed there at all). Honestly, the whole clock setup is a little
> obscure to me.
>
> Can these clocks be safly disabled in the clock table and hope that the ehci
> host driver will enable them if required? Also independent to what the
> bootloader does, which I don't know? I'm asking because we may switch from the
> proprietary bootloader (fastboot?) to u-boot in the near future.


In general, the platform code needs to setup the parent/child
relationships, and in most cases the clock rates. But the individual
drivers will disable and enable clocks as needed. If you set them to
'true' in the table, that last enable will never be disabled, so the
clock will never be off. That might be suboptimal from a power
consumption point of view for your platform.

Unfortunately, u-boot does very little clock setup so the kernel has
to be able to do most of it. Fastboot is better at it, in some sense
of the word. We used to have some very large clock setup tables in the
chromeos board files, but we have recently pruned out most of it and
cut back to the bare minimum.

Note that you might have some issues with autosuspend and detecting
hotplugs, we have a chromeos patch for it that I should post sometime
soon.


-Olof
