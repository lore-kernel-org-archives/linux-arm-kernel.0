From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jul 2014 17:30:03 +0200
Subject: [GIT PULL][for 3.17] pull request for hisilicon soc
In-Reply-To: <53D1F2B0.1020603@hisilicon.com>
References: <53D1F2B0.1020603@hisilicon.com>
Message-ID: <19341047.6Jx15lyPBg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 July 2014 14:01:20 xuwei wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Resend it again and add arm at kernel.org into the CC list.
> Please help to merge pull request for hisilicon soc. 
> 

I pulled this at first and was planning to complain about
individual problems, but then decided to undo the pull, after
the mistakes outweigh the good parts in this pull request:
> 
> The following changes since commit f753b5db43e3819e02354a638ea31e332e08ac3a:
> 
>   ARM: hisi: store reboot reg in global variable (2014-07-03 19:29:15 +0800)

We have not actually merge commit f753b5db43e3819e yet, and you effectively
left it out of the pull request, but it is of course present in the branch.

This commit also seems completely wrong and should be reverted: There
is no need to avoid parsing DT in the restart function, and instead of
adding another callback, the code should be changed to move the restart
handling into a separate driver in drivers/power/reset/.

> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-for-3.17
> 
> for you to fetch changes up to 5354cf5f6026b5d16caf0001886c06ab9ca42dff:
> 
>   ARM: hisi: enable L2 driver (2014-07-04 14:07:17 +0800)
> 
> ----------------------------------------------------------------
> enable hisilicon terminal SoC based on 3.16-rc1
> 

This description doesn't seem to reflect the contents of the
branch, and is much too short. I actually starting writing
a proper changeset text to help you but dropped that now.

> ----------------------------------------------------------------
> Haifeng Yan (3):
>       ARM: debug: Rename Hi3716 to HI5XHD2

This one had me confused for a while, because it seems like
you are breaking support for hi3xxx, but instead it's just
a different name for the same chip if I see this right.

An easier approach would actually be to remove DEBUG_HI3716_UART
completely: the setting is exactly the same for
HI3716, HI3620 and HIX5HD2, so you can simply keep the name
for the oldest chip here and change the help text to reflect
which products it works on.

>       ARM: hisi: enable hix5hd2 SoC

Here you introduce a device node with compatible="hisilicon,cpuctrl",
which is a far too generic name, as it seems to imply that this is
the only "CPU control" part that ever came out of hisilicon. The
binding should be documented in
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
and reviewed on the mailing list. From the use of the code, it
seems that this should really be a reset controller with a
device driver in drivers/reset, but that is not clear without
knowing more about the hardware.

Also, it would be nice to use the CPU_METHOD_OF_DECLARE() macro here.

Finally, it's not clear why you need a new Kconfig symbol. It seems
that all code you have is compiled independent of these, except for
the dtb files and the DEBUG_LL setting.

>       ARM: dts: Add hix5hd2-dkb dts file.

This is ok.

> Haojian Zhuang (4):
>       ARM: debug: add HiP04 debug uart

This patch seem correct, but it is completely useless
because support for HiP04 is not available. You effectively
just add dead code.

>       ARM: hisi: add ARCH_HISI

This is ok, except for the "hisilicon,cpuctrl" node mentioned
above.

>       ARM: config: add ARCH_HIX5HD2 in hi3xxx_defconfig

I'd prefer to see the defconfig changes in a separate pull
request. Also, please enable all drivers you need in
multi_v7_defconfig.

>       ARM: hisi: enable L2 driver

This one should also be done differently. Instead of adding
an .init_machine function, you should set the l2x0 aux value
in the machine descriptor directly.

If you can fix up the problems I mention above quickly, I can
consider a new pull request.

What happened to HiP04 support? I thought that would arrive
in time for 3.17.

	Arnd
