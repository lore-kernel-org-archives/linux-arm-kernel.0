From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Apr 2017 10:04:33 +0200
Subject: [GIT PULL] ARM: SOC PM domain for 4.12
In-Reply-To: <58F81269.70207@ti.com>
References: <1491500546-6873-1-git-send-email-ssantosh@kernel.org>
 <CAK8P3a0jtLFgzB-u1Prhn1AvPH3OzLZ=uc--YP4fo9-7irikag@mail.gmail.com>
 <0358ac18-8d7a-84a6-356f-8c9e8840bc4d@oracle.com> <58F81269.70207@ti.com>
Message-ID: <CAK8P3a2EsEGc_VFPPQV2jwkpy5D7wxbtuUjhqkBSQm0ke3HJQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 3:44 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> On 04/19/2017 05:54 PM, santosh.shilimkar at oracle.com wrote:
>> On 4/19/17 12:56 PM, Arnd Bergmann wrote:

>>
>>> Since I was looking at it, I also took a closer look at the contents of the
>>> patch series. The driver itself looks fine, but for the record, I'm not that
>>> happy about seeing a header file duplicating the information from the
>>> data sheet: We only use dt-binding headers to establish an interface between
>>> the driver and the sources when there is well-defined fixed way to enumerate
>>> resources, but in this case there clearly is...
>>>
>
> I apologize but I'm not clear on exactly what your concern is? Currently we
> define a device ID which is associated to a "device" in the firmware's view of
> the world, however the firmware has no knowledge of what goes on in the kernel
> and vice-versa. The device ID is associated to that device only on that
> hardware, it could be a different ID on a different SoC making use of SCI. The
> only way a device is identified to the firmware is through this number, it will
> also be used by the ti-sci-clock [1] and ti-sci-reset [2] drivers to identify
> the device.
>
> I'm not sure what you mean by "We only use dt-binding headers to establish an
> interface between the driver and the sources when there is well-defined fixed
> way to enumerate resources."

More generally speaking, header files are used as interfaces when you want to
ensure that a number you pick, or a function prototype is the same between
two or more parts of a system.

For the reset handling and the pm domain, this is not the case: the header
only gets included by the dts files and the driver does not use it at all, so
you can simply remove the header and open-code the numbers in the
dts file, as you do in the same files for all other numbers (register addresses,
interrupts, gpio lines). Please remove these to save the pointless  indirection.

For the clk driver, this is a little less obvious as you do use the K2G_DEV_*
macros in both the dts files and in the driver. However, I think these still
fall in the same basic category, as the numbers are not picked arbitrarily
when writing the driver to describe the usual mess of register offsets in
a clock controller. Rather this one is apparently used for communicating
with the firmware using a proper interface, so you can simply move the
header file contents into the driver.

      Arnd
