From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 16 Jan 2017 20:31:48 +0100
Subject: [PATCH 0/4] ARM: dts: mt7623: Add initial Geek Force support
In-Reply-To: <3fecb422-8185-7ee0-c203-2bfdc4fd1393@phrozen.org>
References: <20170108133100.10428-1-afaerber@suse.de>
 <91f5ec74-1aa1-f2ad-24e9-14267cbe8498@phrozen.org>
 <d6bd3783-d124-9871-d3b4-93e366517895@suse.de>
 <3fecb422-8185-7ee0-c203-2bfdc4fd1393@phrozen.org>
Message-ID: <71841212-be03-5285-6ca6-b1fd9ce1d8db@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.01.2017 um 11:18 schrieb John Crispin:
> On 10/01/2017 10:48, Andreas F?rber wrote:
>> Am 10.01.2017 um 08:00 schrieb John Crispin:
>>> On 08/01/2017 14:30, Andreas F?rber wrote:
>>>>
>>>> Andreas F?rber (4):
>>>>   Documentation: devicetree: Add vendor prefix for AsiaRF
>>>>   Documentation: devicetree: arm: mediatek: Add Geek Force board
>>>>   ARM: dts: mt7623: Add Geek Force config
>>>>   MAINTAINERS: Extend ARM/Mediatek SoC support section
>>>>
>>>
>>> Hi,
>>>
>>> i need to NAK this series. the asiarf board is nothing more than the
>>> official MTK EVB with AsiaRF written on it. this board is already
>>> supported by linux (arch/arm/boot/dts/mt7623-evb.dts) please extend the
>>> EVB dts file nstead of adding a duplicate and letting the original
> bitrot.
>>
>> Well, I disagree.
> 
> reading the rest of the email you seem to be quite agro about this.

Please re-read your reply above and my comments and reconsider your
attitude when replying in the future. It's not about whether these
patches go in or not, it's about your wording. And that continues with
aggressively throwing around the term "agro" in two mails already. I
don't see anything aggressive or angry in my original cover letter that
would've prompted your reply and can only interpret that as your own
frustration with your mt7623 progress. Instead you should've taken the
time to explain a bit better what you really meant, then we could've
spared or shortened this lengthy discussion and have a v2 already.

>> First of all I'm not letting "the original" bitrot, because I have
>> nothing to do with that .dts! If anyone is to blame for letting it
>> bitrot since February 2016, pick your own nose:
>>
>>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/arch/arm/boot/dts/mt7623-evb.dts
> 
> what should i pick my nose about ?

Don't blame _me_ for "bitrot" of a file _you_ added almost a year ago
that did not see any updates since.

Nothing wrong with you not working on something, just don't blame me for
it then, especially when I don't (knowingly) have that hardware and have
never come in touch with it before. I am new to linux-mediatek and had
checked LAKML in vein for any mt7623 patches before sending mine.

[snip]
>> Third, by your argumentation we shouldn't be adding, e.g., Odroid .dts
>> files either because they were based on a Samsung SMDK, or .dts files
>> for Amlogic TV boxes because they're almost identical to reference
>> designs, etc.
>> Users need to know which .dts file to choose, so having a sane .dts
>> filename is warranted. Depending on how similar they are, one could
>> either #include the -evb.dts or factor out a shared .dtsi, but that
>> takes us back to the previous point of hardly anyone having access to
>> EVB information to identify such a subset. Therefore duplicating trivial
>> nodes is the method of choice for all practical purposes - mt7623.dtsi
>> is getting reused just fine.
>>
> 
> in that case add a dtsi file for the EVB and include it in your geek
> board.dts and only update the compat string.

The question that I am not in a position to answer is: Are those two
boards identical or just very similar? Paul in CC can hopefully clarify
this when he is back. Matthias as maintainer has also remained silent.

>> Comparing our two .dts files, mine has two more UART nodes enabled, the
>> U-Boot bootloader's baudrate set to actually get serial output, a
>> different board compatible string for identification, and I chose the
>> new dual-licensing header that is being requested for new DT files.
> 
> 1) at the time we adde this the uart support was not ready

> 2) the bootloader i am using is a custom built one hence the random baudrate

Well, did the _original_ bootloader use 115200? In that case we could
update -evb.dts with it, and you could still override it via console=
for your custom build.

Or maybe having source access you could even contribute to mainline
U-Boot, so we can all work on the same codebase? I read a BPi-R2 is
coming up with mt7623, so booting without appended .dtb and uImage will
come in handy for more people than just EVB owners and Geek Force
backers. I'd happily contribute to making bootefi command work.

> 3) you can just updae the license if you want to, no problem

OK, will gladly look into the feasibility.

>> For lack of schematics I figured out UART1 by testing - continuity tests
>> for GND, console=ttySx,115200n8 and trial-and-error for RX/TX. Obviously
>> I can't do that for a board I don't have access to.
>> UART2 and UART0 pins were clear, but only UART2 was obvious from ttyMT2.
> 
> you do have the EVB directly in front of you
> 
>> Do you actually have access to a Geek Force board yourself, or what are
>> you basing your claims on? Mine looks different from the Indiegogo
>> picture and thus has different identification from that on
>> https://wikidevi.com/wiki/AsiaRF_WS2977 (WS3301, MT7623N RFB_V10).
> 
> i dont need the geek board as i have the EVB and they are identical
> according to MTK
> 
>> If you confirm the EVB's baudrate I can happily send that part your way.
>> I've seen 921600 on the Helio X20 96board for instance.
> 
> see above

So... 4) add my UART nodes to your -evb.dts? Any nitpicks on the actual
patch 3/4?

>> Also, none of what you've said justifies NAK'ing patch 4/4, which
>> applies to any mt7* and arm64 .dts, including yours.
> 
> agreed, i never even mentioned 4/4

You replied to the cover letter 0/4 "i need to NAK this series" - and
series includes all four patches. Therefore my frustration with your
hip-shot reply. If you haven't read the patch, don't NAK it!

In fact still no one replied to it at all, even now that you're aware of
its existence.

>> While we're at it, I noticed that mainline has a "mediatek,mt7623-eth"
>> network driver but no corresponding .dtsi node. Talk about bitrot...
> 
> the idea is that we work together to make thins optimal. this is not a
> you or is right. this is about the FOSS peer review process. please dont
> be so agro.

See above, please reconsider your tone. Peer review is no excuse for
rude and destructive behavior towards contributors you don't know.

Had you looked at the lists and codebase you would know that I am not
new to FOSS.

And please stop writing "agro", it sounds like some pothead making a
peace sign; not helpful among professional software developers.

Taking the time to start your sentences with a capital letter would also
be a respectful gesture.

> to me it seems suboptimal to support 2 dts files for the same board.

If it is the identical board, then we are in violent agreement. I just
find all your replies to me offensive so far, I don't know you and thus
have no reason to trust your unsubstantiated claims about my board.

Regards,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
