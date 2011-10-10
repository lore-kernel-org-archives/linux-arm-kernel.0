From: olof@lixom.net (Olof Johansson)
Date: Sun, 9 Oct 2011 22:32:47 -0700
Subject: [PATCH 0/14] Sparse fixes for tegra
In-Reply-To: <1578886.3aVd19SPzO@wuerfel>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1578886.3aVd19SPzO@wuerfel>
Message-ID: <CAOesGMhms2AWY2b9RZQ4XJfoqBmUsaMFQid0BWcFLQ1gm9ONWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 7, 2011 at 1:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 06 October 2011 19:54:10 Olof Johansson wrote:
>> Some trivial fixes removing sparse warnings on tegra code.
>
> Hi Olof,
>
> That's a very nice series. I had a go at this across platforms before,
> but had not finished it yet.
>
> One thing I would recommend instead of having a type cast in IO_ADDRESS
> is to change the definition of IO_{IRAM,CPU,PPSB,APB}_VIRT to be
> an iomem pointer from the start, so any calculation you do based on
> that automatically gets the right type.

That worked out pretty well but needed asm-conditional defines, since
some of the constants are used from assembly.

I'll post a new series shortly that includes the above change, drops
the first to IO_ADDRESS changes and includes a couple of more fixes
for cpu-tegra.c.

I kept IO_ADDRESS() even though it is now just a 1:1 wrapper to
IO_TO_VIRT(), mostly to not have to churn all drivers just for this --
see below for plans related to that.

Also, the arm-global map_desc uses an unsigned long to hold the
virtual address of the maps so I had to add explicit casts there.
Switching it requires some changes to the mm/map.c code, I'll do that
separately from this series.

> In the long run, I would hope to be able to get rid of basically
> all uses of IO_ADDRESS and IO_TO_VIRT in the tegra code and replace
> that with device tree lookups, but that is clearly a separate issue.

Yes, probably by moving to local ioremaps for most use -- address can
come from platform_device or device tree that way (but the platform
direction is device tree overall).


-Olof
