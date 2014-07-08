From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 08 Jul 2014 14:53:37 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140708121252.GK21766@n2100.arm.linux.org.uk>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140708053434.GH28931@quad.lixom.net>
 <20140708115727.GR23978@titan.lakedaemon.net>
 <20140708121252.GK21766@n2100.arm.linux.org.uk>
Message-ID: <53BBE9D1.9050109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 02:12 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 08, 2014 at 07:57:27AM -0400, Jason Cooper wrote:
>> Can you offer any suggestions as to how you would like this resolved?  I
>> thought when I voiced my opinion as above, and Russell didn't reply,
>> there was implied acknowledgement...
>
> I didn't reply probably because I didn't see the message and/or I'm busy
> with other stuff.
>
> I know that Sebastian asked Rabeeh on IRC yesterday whether the flash
> chip type could be used to detect the difference between the two, but
> has not yet received an answer.

Yeah, I asked him by mail too to give him more time to reply on it.
I looked through my emails and found a request to update kernel's
dove-cubox.dts for a different SPI flash type on 1G production.

My ES box has a Winbond W25Q32BV (compatible = "st,w25q32", obviously
wrong vendor prefix) and the request was to add "n25q032" to make
Linux MTD happy again.

The question I asked Rabeeh basically is, if above difference is true
for all production CuBoxes. If it is, we can use it to tell them apart
without user intervention.

As soon as I get a reply, I'll cook a patch for it (either compatible
fix or comment about indiscrimination).

> As the two DT descriptions are mutually incompatible, there isn't much
> choice.  And (afaik) there's no choice of updating the boot loader to
> a version which can deal with DT - yes it may be u-boot, but I've no
> idea if modern u-boot works on it, and I really would not like to try.

Most current MVEBU bootloader work is probably done on barebox. I have
currently pending patches for usb and sdhci on Dove, eth is supported
already. Let's say it is close to be considered as a replacement for
u-boot. Of course, some of the voltage optimization is missing. Anyway,
we cannot expect users to jump on barebox and update their boxes for
obvious reasons you stated below.

And yes, the two DT descriptions are mutually incompatible, but the
perceived impact may be low. I'd expect most users to have their
rootfs on SDHCI, so hot-plugging is not an option. Even if it is on
a different medium, the SD card slot is well hidden under the HDMI
jack.

Considering the low impact and given that most users will have a
production version, I copy Jason's statement. As said above, I'll
either add a comment or fix the SPI compatible in a follow-up patch.

> While SolidRun tried to make changing u-boot easy and recoverable, I've
> had personal experience of trying to help people restore their cuboxes.
> It's a total nightmare (mainly seems to be down to the wide variation
> in USB hardware which causes the on-board USB-serial for the console to
> be unreliable.)  That's why on their later iMX6 hardware (Cubox-i & HB)
> they decided to have zero on-board non-volatile storage.
>
> So, even if it was possible to detect the difference in u-boot between
> the Cubox models, getting the updated u-boot on the machine is far from
> trivial.

I agree that bootloader replacement isn't trivial, but compared to other
SoCs the UART boot button makes it quite easy to deal with. But it is no
fool-proof method of course.

The reason I was conservative about using any stored information on SPI
flash as indicator for CuBox revision was also driven by those issues
reported on IRC, i.e. if somebody erased the SPI MAC address, it would
have been identified as ES.

Sebastian
