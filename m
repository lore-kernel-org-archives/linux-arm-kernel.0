From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 10 Jan 2017 10:48:47 +0100
Subject: [PATCH 0/4] ARM: dts: mt7623: Add initial Geek Force support
In-Reply-To: <91f5ec74-1aa1-f2ad-24e9-14267cbe8498@phrozen.org>
References: <20170108133100.10428-1-afaerber@suse.de>
 <91f5ec74-1aa1-f2ad-24e9-14267cbe8498@phrozen.org>
Message-ID: <d6bd3783-d124-9871-d3b4-93e366517895@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 10.01.2017 um 08:00 schrieb John Crispin:
> On 08/01/2017 14:30, Andreas F?rber wrote:
>>
>> Andreas F?rber (4):
>>   Documentation: devicetree: Add vendor prefix for AsiaRF
>>   Documentation: devicetree: arm: mediatek: Add Geek Force board
>>   ARM: dts: mt7623: Add Geek Force config
>>   MAINTAINERS: Extend ARM/Mediatek SoC support section
>>
> 
> Hi,
> 
> i need to NAK this series. the asiarf board is nothing more than the
> official MTK EVB with AsiaRF written on it. this board is already
> supported by linux (arch/arm/boot/dts/mt7623-evb.dts) please extend the
> EVB dts file nstead of adding a duplicate and letting the original bitrot.

Well, I disagree.

First of all I'm not letting "the original" bitrot, because I have
nothing to do with that .dts! If anyone is to blame for letting it
bitrot since February 2016, pick your own nose:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/arch/arm/boot/dts/mt7623-evb.dts

Second, I have no Mediatek documentation or even picture to identify any
similarities between my board and that Mediatek EVB, so no, I can't hack
on the -evb.dts file. I wrote my .dts from scratch, not even having
access to /proc/device-tree on its 3.10 kernel for comparison.

Third, by your argumentation we shouldn't be adding, e.g., Odroid .dts
files either because they were based on a Samsung SMDK, or .dts files
for Amlogic TV boxes because they're almost identical to reference
designs, etc.
Users need to know which .dts file to choose, so having a sane .dts
filename is warranted. Depending on how similar they are, one could
either #include the -evb.dts or factor out a shared .dtsi, but that
takes us back to the previous point of hardly anyone having access to
EVB information to identify such a subset. Therefore duplicating trivial
nodes is the method of choice for all practical purposes - mt7623.dtsi
is getting reused just fine.

Comparing our two .dts files, mine has two more UART nodes enabled, the
U-Boot bootloader's baudrate set to actually get serial output, a
different board compatible string for identification, and I chose the
new dual-licensing header that is being requested for new DT files.

For lack of schematics I figured out UART1 by testing - continuity tests
for GND, console=ttySx,115200n8 and trial-and-error for RX/TX. Obviously
I can't do that for a board I don't have access to.
UART2 and UART0 pins were clear, but only UART2 was obvious from ttyMT2.

Do you actually have access to a Geek Force board yourself, or what are
you basing your claims on? Mine looks different from the Indiegogo
picture and thus has different identification from that on
https://wikidevi.com/wiki/AsiaRF_WS2977 (WS3301, MT7623N RFB_V10).

If you confirm the EVB's baudrate I can happily send that part your way.
I've seen 921600 on the Helio X20 96board for instance.

Also, none of what you've said justifies NAK'ing patch 4/4, which
applies to any mt7* and arm64 .dts, including yours.

While we're at it, I noticed that mainline has a "mediatek,mt7623-eth"
network driver but no corresponding .dtsi node. Talk about bitrot...

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
