From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Feb 2011 17:09:04 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTinfWiRaGruP8cM44c62T8svVOKsFhi4Dmg8yzEa@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102221800.17196.arnd@arndb.de>
	<AANLkTinfWiRaGruP8cM44c62T8svVOKsFhi4Dmg8yzEa@mail.gmail.com>
Message-ID: <201102231709.05036.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 February 2011, Andrei Warkentin wrote:
> That sounds good! In fact, for any quirks enabled for a particular
> card, I'll expose the tuneables through sysfs attributes, something
> like /sys/block/mmcblk0/device/quirks/quirk-name/attr-names.
> 
> Quirks will have block intervals and access size intervals over which
> they are valid, along with any other quirk-specific parameter.
> Interval overlap will not be allowed for quirks in the same operation
> type (r/w/e). The goal here is to make the changes to issue_*_rq as
> small as possible, and not to pollute block.c at all with the quirks
> stuff. Quirks are looked up inside issue_*_rq based on req type and
> [start,end) interval. The resulting found quirks structure will
> contain a callback used inside issue_*_rq to modify mmc block request
> structures prior to generating actual MMC commands.
>
> Quirks consist of a callback called inside of mmc issue_*_rq,
> configurable attributes, and the sysfs interface. Quirk groups are
> defined per-card. At card insertion time, a matching quirk group is
> found, and is enabled. The quirk group enable function then enables
> the relevant quirks with the right parameters (adds them to per
> mmc_blk_data quirk interval tree). Some sane defaults for the tunables
> are used. If the tunables are modified through sysfs, care is taken
> that an interval overlap never happens, otherwise the tunable is not
> modified and a kernel error message is logged.
> 
> I hope I explained the tentative idea clearly... Thoughts?

I would hope that the quirks can be simpler than this still, without
the need to call any function pointers while using the device, or
quirk specific sysfs directories.

What I meant is to have a single function pointer that can get
called when detecting a specific known card. All this function
does is to set values and flags that we can export either through
common attributes of block devices (e.g. preferred erase size),
or attributes specific to mmc devices (e.g. the toshiba hack, as
a bool attribute).

An obvious attribute would be the minimum size of an atomic
page update. By default this could be 32KB, because any device
should support that (FAT32 cannot have larger clusters). A
card specific quirk can set it to another value, like 8KB, 16KB
or 64KB, and file systems or other tools like mkfs can optimize
for this value.

I would like the flags like "don't submit requests spanning
this boundary" and "make all writes below this size" to be defined
in terms of the regular sizes we already know about, like the
page size or the erase size.

	Arnd
