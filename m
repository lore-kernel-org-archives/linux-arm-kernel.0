From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 26 Jul 2017 09:49:09 +0530
Subject: USB 3.0 is broken on Odroid Xu4 on latest kernel
In-Reply-To: <20170719202009.teh2nvsq47i5zpq4@kozik-lap>
References: <CANAwSgSoo7g=RN4wQ96+NJRYZYy2WeHwPA-xJ2JY7yt25irDfA@mail.gmail.com>
 <87zic0b8hi.fsf@linux.intel.com> <20170719202009.teh2nvsq47i5zpq4@kozik-lap>
Message-ID: <CANAwSgSrTaXZ4cT7NqqnnP_er4PkH7WiX7Qh2kfS50BV7Cq2bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof / Felipe,

On 20 July 2017 at 01:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Jul 19, 2017 at 09:13:29PM +0300, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Anand Moon <linux.amoon@gmail.com> writes:
>> > Hi Krzysztof,
>> >
>> > Today I tried to compile the latest kernel for Odroid xu4.
>> > using exynos_defconfig I build and loaded the kernel.
>> > but to my surprise usb 3.0 device and missing.
>> >
>> > odroid login: root
>> > Password:
>> > Last login: Wed Jul 19 14:01:44 UTC 2017 on ttySAC2
>> > Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.13.0-rc1-xu4ml-27846-g74cbd96 armv7l)
>>
>> Dude, you have 27 thousand patches on top of v4.13-rc1??? Try vanilla
>> v4.13-rc1 and try a git bisect.
>
> Hi Anand,
>
> Beside Felipe's comment, I do not have XU4. I cannot reproduce it on
> XU3-Lite (but there is difference in USB2 and USB3, AFAIR).
>
> $ uname -a
> Linux odroidxu3 4.13.0-rc1-00071-ge06fdaf40a5c #1051 SMP PREEMPT Wed Jul 19 22:07:41 CEST 2017 armv7l GNU/Linux
> $ lsusb
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast Ethernet Adapter
> Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp. SMC9514 Hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>
> Try to follow Felipe's advice of using vanilla kernel from Linus and
> bisecting it.
>
> Best regards,
> Krzysztof
>

I feel this is long standing issue with phy-exynos5-usbdrd.c
with following patch missing.

[0] https://patchwork.kernel.org/patch/5204471/

with some more updated to phy-exynos5-usbdrd.c
I was able to bring the phy up in cold boot.
but when I perform warm boot the issue persist.

root at odroidxu4q:~# uname -a
Linux odroidxu4q 4.13.0-rc2-xu4next-14488-g25f6a53-dirty #7 SMP
PREEMPT Tue Jul    25 20:04:02 UTC 2017 armv7l armv7l armv7l GNU/Linux
root at odroidxu4q:~# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
        |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
        |__ Port 2: Dev 4, If 1, Class=Video, Driver=uvcvideo, 5000M
        |__ Port 2: Dev 4, If 0, Class=Video, Driver=uvcvideo, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
root at odroidxu4q:~#

Best Regards
-Anand
