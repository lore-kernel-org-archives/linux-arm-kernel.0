From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 18 Sep 2015 11:56:03 +0900
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <20150918002122.GC12858@verge.net.au>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
 <20150812012652.GH15957@verge.net.au>
 <55D790A5.1050008@cogentembedded.com>
 <55D7A3A1.9020009@cogentembedded.com>
 <20150902022936.GA18115@verge.net.au>
 <55EA2D8D.90004@cogentembedded.com>
 <20150918002122.GC12858@verge.net.au>
Message-ID: <CANqRtoSRZo_J1kV0EkYdVzg9YRJ5=Ha3eQRVPKeq9M=kAPLwpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Sep 18, 2015 at 9:21 AM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Sep 05, 2015 at 02:47:25AM +0300, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 09/02/2015 05:29 AM, Simon Horman wrote:
>>
>> >>>>>Define the SILK board dependent part of the SDHI1 (connected to micro-SD slot)
>> >>>>>device nodes along with the necessary voltage regulators.
>> >>>>>
>> >>>>>Based on the original patch by Vladimir Barinov
>> >>>>><vladimir.barinov@cogentembedded.com>.
>> >>>>>
>> >>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> >>>>>
>> >>>>>---
>> >>>>>This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of Simon Horman's
>> >>>>>'renesas.git' repo plus the R8A7794/SILK QSPI patches just re-posted. It needs
>> >>>>>the R8A7794 GPIO patches in order to compile.
>> >>>>>
>> >>>>>Changes in version 2:
>> >>>>>- removed not working SDHI0 stuff, renamed the patch;
>> >>>>>- replaced SDHI1's "wp-gpios" property with "disable-wp".
>> >>>>
>> >>>>I am wondering if you could explain the motivation for the "disable-wp"
>> >>>>update
>> >>>
>> >>>    Please see the comment in mmc_sd_get_ro().
>> >>>
>> >>>>and weather it is appropriate for other r8a779* dts files.
>> >>>
>> >>>    In case of micro-SD slots, yes.
>> >>
>> >>    The MMC binding document says it should only be specified if the
>> >>controller has WP detection logic. We, so far, seem to have been replying on
>> >>the GPIOs despite this logic is present (according to the R-Car gen2 SDHI
>> >>manuals I have). The driver will first call mmc_gpio_get_ro() and when that
>> >>fails due to "wp-gpios" not being specified, it proceeds to reading the
>> >>register but that is forbidden by TMIO_MMC_WRPROTECT_DISABLE flag set for
>> >>the R-Car gen1/2 chips, so 0 is always returned from tmio_mmc_get_ro().
>> >>There seems to be no point in going that far (and doing the runtime PM
>> >>dances) --
>>
>>    Alternatively, the driver could be fixed to check the flag before the RPM
>> call unlike what it does now.
>
> If the driver can be updated to do the right thing then that seems
> preferable to me. If so would it be the case that the presence of the
> "disable-wp" property would not have any run-time effect?
>>
>> >>and MMC_CAP2_NO_WRITE_PROTECT (set when "disable-wp" is specified) prohibits
>> >>doing that...
>> >
>> >That sounds reasonable to me.
>>
>>    I'm still wondering why TMIO_MMC_WRPROTECT_DISABLE is set for the R-Car
>> SoCs. Morimoto-san, any comments? Your change logs are too terse. :-)
>
> I will follow up on this.

I'd like to help you to clarify whatever issues you are having, but I
don't have anyhardware access or schematics for the Silk board.

So here is some generic information. In general with SD/MMC I can
imagine a couple of different types of devices.

1) Hotpluggable SD socket (with write protect)
2) Hotpluggable micro-SD socket (no write protect)
3) On-board SD/MMC/SDIO (no hotplug, no write protect)

Which type of device that happens to be used on a particular board is
a board specific property. So on one board SDHI1 may be micro-SD but
on a different board SDHI1 may be a soldered-on eMMC or a SDIO module
(case 3). The same SoC DTSI will contain on-chip information for SDHI1
while the board specific DTS may contain optional information about WP
and CD signals.

On R-Car Gen2 we default to assume case 3 above which means no WP and
CD signals. If a regular SD socket is used then the board specific
file needs to point out CD and WP signals. For micro-SD sockets there
is no WP signal so in such case only the CD pin is needed.

HIstorically with SDHI the availability of CD and WP signals vary
wildly depending on SoC and SDHI instance. Also, with power domains
and Runtime PM we would like to be able to power off the power domain
for the SDHI device and still be able to wake up, so assigning CD and
WP as GPIO signals will not only allow board-specific stuff to be
cleanly separated from the on-chip SDHI DTSI, it also allows for
easier review and better power management.

Now what is the issue that you guys are having?

>> >Some more questions from my side:
>>
>> >* What is the status of this patch
>>
>>    Tested, working.
>>
>> >* Can you prepare patches for r8a779* dts files for micro-SD slots?
>>
>>    Ugh, I probably can but won't promise anything.
>
> Likewise, ugh.

What needs to be updated for R-Car Gen1 again?

Thanks,

/ magnus
