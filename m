From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Thu, 28 Mar 2013 01:32:11 +0000
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <20130321184641.GB13280@titan.lakedaemon.net>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
 <20130321184641.GB13280@titan.lakedaemon.net>
Message-ID: <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

This set of patches seems to break the mvsdio driver (and hence
mwifiex_sdio) on the Globalscale Mirabox. I believe this is because
mvsdio.c contains a function mv_conf_mbus_windows that seems to
conflict with the new mbus driver. I don't understand enough about the
hardware (without the datasheets anyway) to be able to understand the
exact problem, but I hope that this is enough to point you (or someone
else) to it!

For reference, here is the dmesg output when I try to insert the
mwifiex_sdio module with this series of patches applied:

root at mirabox:~# modprobe mwifiex_sdio
[  131.500945] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[  131.673630] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem (1)
failed: -110
[  132.687086] mvsdio d00d4000.mvsdio: FIFO_EMPTY bit missing
[  132.697084] [sched_delayed] sched: RT throttling activated
[  132.859950] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem (2)
failed: -110
[  133.876487] mvsdio d00d4000.mvsdio: FIFO_EMPTY bit missing
[  134.049343] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem (3)
failed: -110
[  134.056784] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed
[  167.860538] hub 1-1:1.0: cannot reset port 2 (err = -110)
[  168.870536] hub 1-1:1.0: cannot reset port 2 (err = -110)
[  169.879536] hub 1-1:1.0: cannot reset port 2 (err = -110)
[  170.889019] hub 1-1:1.0: cannot reset port 2 (err = -110)
[  171.898509] hub 1-1:1.0: cannot reset port 2 (err = -110)
[  171.903922] hub 1-1:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
[  172.918005] hub 1-1:1.0: cannot disable port 2 (err = -110)
[  173.927496] hub 1-1:1.0: cannot reset port 2 (err = -110)
[  174.936997] hub 1-1:1.0: cannot reset port 2 (err = -110)

After that the USB ports fail, and I start to get some serious errors
as I'm running with my root filesystem on an SD card (which is
connected via USB in the Mirabox).

I hope this helps someone come up with a patch to fix it. If you need
any further testing / debugging done, please let me know.

Cheers,
Neil Greatorex

On Thu, Mar 21, 2013 at 6:46 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Thu, Mar 21, 2013 at 05:30:23PM +0000, Arnd Bergmann wrote:
>> On Thursday 21 March 2013, Thomas Petazzoni wrote:
>> > Changes since v2:
>> >
>> >  * Remove the DT binding, and use the mvebu_mbus_init() function call
>> >    in all Marvell EBU SoC families. Requested by Arnd Bergmann.
>> >
>> >  * Fix the MV78xx0 code, after reports of issues by Gregory Clement
>> >    when testing on this platform.
>> >
>> >  * Remove the 3 patches that have been merged by Arnd in
>> >    arm-soc/mvebu-cleanup.
>> >
>>
>> Thanks for the update
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> And thanks for turning this around so quickly Thomas, I'll pull it in
> tonight or tomorrow.  Hopefully pcie goes smoothly as well.
>
> thx,
>
> Jason.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
