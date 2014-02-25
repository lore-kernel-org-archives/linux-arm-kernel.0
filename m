From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 25 Feb 2014 12:14:04 +0900
Subject: [GIT PULL 00/21] Renesas ARM based SoC Board Updates for v3.15
In-Reply-To: <20140220082316.GE19089@quad.lixom.net>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
 <20140220082316.GE19089@quad.lixom.net>
Message-ID: <CANqRtoQj8CNn=pNP5HkVbaSSc=PbZEoOD3wGa9sXF9nXraTVeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 5:23 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Feb 06, 2014 at 03:17:08PM +0900, Simon Horman wrote:
>> Hi Olof, Hi Kevin, Hi Arnd,
>>
>> please consider these Renesas ARM based SoC board updates for v3.15.
>>
>>
>> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
>>
>>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.15
>>
>> for you to fetch changes up to 235cda29e4d5047622ff9b82b1f0b4cb6cf95f6c:
>>
>>   ARM: shmobile: Remove Lager USBHS UDC ifdefs (2014-02-04 14:28:33 +0900)
>>
>> ----------------------------------------------------------------
>> Renesas ARM based SoC Board Updates for v3.15
>>
>> * r8a7791 (R-Car M2) based Koelsch board
>>   - Fix error return code check from clk_get()
>>   - Add SATA0 support
>>   - Conditionally select MICREL_PHY for Multiplatform
>>
>> * r8a7790 (R-Car H2) based Lager board
>>   - Add USBHS support
>>   - Fix error return code check from clk_get()
>>   - Add SATA support
>>   - Make spi_flash_data const
>>   - Add VIN1 SoC camera support
>>   - Conditionally select CONFIG_MICREL_PHY
>>
>> * r8a7778 (R-Car M1) based Bock-W board
>>   - Add USB Func DMAEngine support
>>   - Use HPBIF DMAEngine for sound
>>   - Use SSI DMAEngine for sound
>>
>> * emev2 (Emma Mobile EV2) based kzm9d board
>>   - Use common clock framework
>>
>> * r8a773a0 (SH-Mobile AG5) based kzm9g board
>>   - Add zboot support
>>
>> * Many boards
>>   - Conditionally select SMSC_PHY
>
> Simon,
>
> I've pulled this into next/boards (as renesas/boards), but I'd like to get an
> understanding of how much more legacy board code you expect to add. I'd like to
> see it slow down to nearly nothing as things move over to device tree, and I'm
> a little confused that we've still got this much coming in.

Hi Olof,

Thanks for your email. I agree that the number of board file commits
is definitely larger than zero so some clarification is in order.

As you probably recall, we earlier agreed on not adding any new board
files. That part is clear I believe so I will skip that.

Regarding the legacy board code, we have quite ok hardware support
coverage as it is now, but some devices drivers are of course still
under development. This means that in some cases integration is on
going or has not happened yet. You may see those kind of changes as
significant commits in the pull requests for board support.

In general we want to use upstream to host our continued incremental
development efforts. We do however often prioritize hardware support
over DT binding design in an early stage of driver development. This
to learn about the hardware and see what kind of abstractions that
need to be done. Once when we feel that the driver has good enough
hardware coverage then we commit to DT bindings.

In the Legacy Lager/Koelsch board code the following devices are
supported as platform devices:

ETHER, SCIF, DU, I2C, SATA*, USB*, MSIOF*, SDHI*, QSPI*, MMCIF,
Audio*, VIN*, Thermal, IRQC, PFC, CMT

* Platform device support under development in v3.15-pre

In the Multiplatform DT for Lager/Koelsch the following devices have DT support:

ETHER, SCIF**, I2C, SATA, MSIOF, SDHI, QSPI, MMCIF, Thermal, IRQC, PFC, CMT**

** Driver DT binding development on-going but integration not finalized

In Multiplatform DT for Lager/Koelsch the following devices lack DT bindings:

DU (drm/kms)
USB (host/function/phy)
Audio (alsa-soc + dmac)
VIN (v4l2 + camera sensor)

Our plan is to migrate over to the DT Multiplatform code base as soon
as ever possible, but at the same time we do not want to commit long
term support of potentially premature DT bindings. Our short term
solution to that is to use platform devices for a limited number of
devices together with DT Multiplatform.

If you would like use to adjust our way forwards please let me know!

Thanks,

/ magnus
