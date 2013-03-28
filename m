From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Thu, 28 Mar 2013 22:27:28 +0000 (GMT)
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <20130328083306.3c2a23de@skate>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
 <20130321184641.GB13280@titan.lakedaemon.net>
 <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
 <20130328083306.3c2a23de@skate>
Message-ID: <alpine.DEB.2.02.1303282223430.28248@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, 28 Mar 2013, Thomas Petazzoni wrote:

> Dear Neil Greatorex,
>
> On Thu, 28 Mar 2013 01:32:11 +0000, Neil Greatorex wrote:
>
>> This set of patches seems to break the mvsdio driver (and hence
>> mwifiex_sdio) on the Globalscale Mirabox. I believe this is because
>> mvsdio.c contains a function mv_conf_mbus_windows that seems to
>> conflict with the new mbus driver. I don't understand enough about the
>> hardware (without the datasheets anyway) to be able to understand the
>> exact problem, but I hope that this is enough to point you (or someone
>> else) to it!
>
> Thanks for reporting this problem. As Ryan Press said in reply to your
> e-mail, it is well known that the mvsdio driver doesn't handle DMA
> properly with SDIO devices that are not SD cards, and this, regardless
> of whether the mvebu-mbus driver patches are applied or not.
>
> Therefore, are you sure that this problem is really introduced by the
> mvebu-mbus driver, and doesn't exist without applying the patches?
>
> The mv_conf_mbus_windows() function of the mvsdio driver doesn't
> conflict with the mvebu-mbus driver. What the mvsdio driver does is
> request the list of DRAM chip-selects using mv_mbus_dram_info(), and
> configure the SDIO unit with those informations in
> mv_conf_mbus_windows(). But yes, the list of DRAM chip-selects is
> provided by mv_mbus_dram_info() and this function has changed by the
> introduction of the mvebu-mbus driver.
>
> I'm on the move right now, so I don't have hardware around to test
> this. Would it be possible for you to test the Mirabox with the
> following patch applied on mvsdio, and do a run with and without the
> patch series that introduces mvebu-mbus? The idea is that the
> informations listed should be identical. If not, then indeed there is
> potentially a problem with the mvebu-mbus driver.
>

Thanks for your information. I have managed to track down the bug. It 
seems that two crucial lines were missed in the conversion to the 
mvebu-mbus driver - the lines that set the hw_io_coherency flag if a 
marvell,coherency-fabric compatible node is in the device tree. This leads 
to the differences below that I found using your printk patch:

Before mvebu-mbus patches:

[SD] root at mirabox:~# modprobe mvsdio
[  134.595899] mvsdio: CS[0], base = 0x0, size = 0x20000000, mbus_attr = 
0x1e
[  134.602821] mvsdio: CS[1], base = 0x20000000, size = 0x20000000, 
mbus_attr = 0x1d
[  134.643933] mmc0: mvsdio driver initialized, lacking card detect (fall 
back to polling)
[  134.660814] mmc0: new high speed SDIO card at address 0001

After mvebu-mbus patches:

[SD] root at mirabox:~# modprobe mvsdio
[  107.462881] mvsdio: CS[0], base = 0x0, size = 0x20000000, mbus_attr = 
0xe
[  107.469766] mvsdio: CS[1], base = 0x20000000, size = 0x20000000, 
mbus_attr = 0xd
[  107.516219] mmc0: mvsdio driver initialized, lacking card detect (fall 
back to polling)
[  107.533029] mmc0: new high speed SDIO card at address 0001

Here is a patch that restores the behaviour to how it was before the mbus 
patches, but it obviously needs testing on other hardware than the 
Mirabox. It has been based on your marvell-mvebu-mbus-v3 branch from 
Github:

-- >8 --
Subject: [PATCH] bus: mvebu-mbus: Restore checking for coherency fabric
  hardware

The new mvebu-mbus driver was not checking the device tree for
coherency fabric hardware and hence was not setting the hw_io_coherency
flag in mbus_state. This prevented the mvsdio driver from operating
correctly. This patch restores the check.
---
  drivers/bus/mvebu-mbus.c |    3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 586d03e..a0250c6 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -858,6 +858,9 @@ int __init mvebu_mbus_init(const char *soc, 
phys_addr_t mbuswins_phys_base,
  		return -ENOMEM;
  	}

+	if (of_find_compatible_node(NULL, NULL, 
"marvell,coherency-fabric"))
+		mbus->hw_io_coherency = 1;
+
  	for (win = 0; win < mbus->soc->num_wins; win++)
  		mvebu_mbus_disable_window(mbus, win);

-- 
1.7.10.4

I hope that works for you on the Mirabox and the other platforms...

<Thomas' patch snipped>

Cheers,
Neil
