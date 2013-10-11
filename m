From: nm@ti.com (Nishanth Menon)
Date: Fri, 11 Oct 2013 01:30:52 -0500
Subject: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on,
 boot_on from smps10_out1
In-Reply-To: <52579723.6080209@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <20131010141949.GA13277@kahuna> <52579723.6080209@ti.com>
Message-ID: <CAGo_u6odWJ9UKwgaVu2YZzZKuYbveBoGDf99L=rJoK1-9KJ0SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 1:13 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>> regulator-boot-on indicates that PMIC enables it by default as part of
>> OTP or some internal behavior -> Looking at the measurements done on
>> uEVM and OTP information -> regulator-boot-on should be kept here.
>
> No. Actually I don?t want PMIC to enable it by default. I want the palmas-usb
> driver to handle it.
> Enabling it by default makes palmas-usb to detect VBUS interrupt. This should
> ideally be detected only when you connect a host cable.
> Btw I didn't exactly get why you want regulator-boot-on should be kept here.

binding description states:
- regulator-boot-on: bootloader/firmware enabled regulator
Further info: include/linux/regulator/machine.h
* @boot_on: Set if the regulator is enabled when the system is initially
*           started.  If the regulator is not enabled by the hardware or
*           bootloader then it will be enabled when the constraints are
*           applied.

What that means is that it is enabled by firmware/bootloader (in our
case One Time Program {OTP} inside Palmas) when the system switches on
even before the kernel starts. and we know SMPS10 is autoenabled by
Palmas OTP configuration even before first instruction in A15
executes.

I think you misunderstand this to mean that you'd like the regulator
to be *switched on* automatically at kernel boot by regulator
framework - there is no reasoning why we'd want such a binding since
we'd expect drivers to do their job of requesting and enabling
regulators on need..

Hope this helps. Let me know if I misunderstood something here.

Regards,
Nishanth Menon
