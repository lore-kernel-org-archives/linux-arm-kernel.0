From: saeed.bishara@gmail.com (saeed bishara)
Date: Thu, 5 May 2011 10:08:59 +0300
Subject: [PATCH v2] kirkwood: add dir-665 support
In-Reply-To: <BANLkTikhFn--4WVGjATZL=0cCiz8qmo=jw@mail.gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<1304496346-13557-1-git-send-email-camhirundo@gmail.com>
	<20110504081627.GY19806@kw.sim.vm.gnt>
	<BANLkTim6J-wpp+=xsaaxwjmr4XLe-Aa8KA@mail.gmail.com>
	<BANLkTikhFn--4WVGjATZL=0cCiz8qmo=jw@mail.gmail.com>
Message-ID: <BANLkTinJJrrOjawXM_1OWQyk7yeh_1s1Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 3:20 AM, Hirundo Cam <camhirundo@gmail.com> wrote:
> Hi Saeed and Nicolas,
>
> 2011/5/4 saeed bishara <saeed.bishara@gmail.com>:
>> On Wed, May 4, 2011 at 11:16 AM, Simon Guinot <simon@sequanux.org> wrote:
>>> Hi Hirundo,
>>>
>>> On Wed, May 04, 2011 at 04:05:46PM +0800, Hirundo Cam wrote:
>>>> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
>>>> LEDs, GPIO, Buttons remains unknown.
>> Hirundo,
>
>> ? if this board is very similar to mv88f6281gtw_ge, you should use
>> the same board setup file. it will be great if you specify the
>> differences between the two boards.
>
> I have no mv88f6281gtw_ge board on hand.
> However, After I've looked into the setup file of mv88f6281gtw_ge.
> I've found that the NOR flash, ddr2 DRAM, switch chip, ethernet port define
> are differ from mv88f6281gtw_ge.
the spi_slave_info in your patch is identical to the one in the
mv88f6281_gtw_ge. the board setup has nothing to do with ddr2.
regarding ethernet, and the other thinks that differ between the two
boards can be probed depending on the machine type.
>
> I have no idea if we could use #if define to distinguish the different
> boards use
> the same SoC. While I want also made this adaptable in OpenWrt.
you don't need to use #ifdef, you can use the machine_is_xxx()
function to distinguish between boards.
>
>> ? please have a look at sheevaplug-setup.c to see how multiple boards
>> supported in same setup file.
>> saeed
>>
>
> Hum, I think Kernel will rely on the mach-type ID in u-boot to check
> which board is in booting. If the original u-boot has changed
> mach-type ID, I don't think us the same configuration file with
> mv88f6281gtw_ge is good. At least I've tried kernel image compiled
> with mv88f6281gtw_ge option but it seems kernel cannot be booted and
> hanged in very early stage. Just like the mach-type ID doesn't match.
you shouldn't use the mach ID of mv88f6281_gtw_ge, you should have
your own one. eventually the mv88f6281gtw_ge-setup.c will include the
MACHINE_START(MV88F6281_DIR665, "Marvell 88F6281 DIR665 Board")
structure besides to the MV88F6281GTW_GE, and the two boards will
share
the same init function, the machine_is_mv88f6281gtw_ge() and
machine_is_mv88f6281_dir665() will be used to check which board is
running (in runtime).

anyway, I hope you can do it using the device tree as Nico suggested.
saeed
should have
>
> Regards,
> Hirundo Cam
>
