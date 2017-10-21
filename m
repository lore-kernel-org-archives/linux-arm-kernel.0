From: mihailescu2m@gmail.com (Marian Mihailescu)
Date: Sat, 21 Oct 2017 17:54:31 +1030
Subject: [PATCH] ARM: dts: exynos: add cpu perf counters to Exynos54xx
 boards
In-Reply-To: <e2b87fe2-bc04-242d-8f4f-9cd21743e3aa@arm.com>
References: <CAM3PiRxi8sxf6T990K8rd7UsOLd2D5TaLciF=c_wF=9gmpLKYg@mail.gmail.com>
 <e2b87fe2-bc04-242d-8f4f-9cd21743e3aa@arm.com>
Message-ID: <CAM3PiRyEdXX26aBfuS=3rQK3k7ovR=HeeoF8Qcz0Dt-zdiXuww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Apologies, I did not really check which cluster is described for the
5410 (since 5422 boots from the A7).

Should I define both pmu nodes (w/o interrupt affinity) in the
exynos54xx,dtsi, and set the status property to "disabled"?
And then add the interrupt affinity to the SoC variant, and enable
them as required...

The problem that I see however is that, while 5410 is easy to deal
with (it has the cpus defined in exynos5420.dtsi for all boards), 542x
variants have the cpus included in the board dts. So there would be
the same pmu nodes with interrupt affinity copied in all 542x and 5800
boards dts (and there are several of them), instead of being included
in exynos542x.dtsi...

Any thoughts about this?

Thanks,
Marian

Either I've been missing something or nothing has been going on. (K. E. Gordon)


On Sat, Oct 21, 2017 at 2:45 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 20/10/17 13:09, Marian Mihailescu wrote:
>> Hi,
>>
>> This patch enables support for ARM Performance Monitoring Units
>> available in Cortex-A7
>> and Cortex-A15 CPU cores for Exynos54xx SoCs (5410, 5420 and 5422/5800).
>>
>> Exynos5410 currently has only Cortex-A7 nodes defined in the device tree,
>> so the Cortex-A15 PMU is defined in the exynos5420 device tree file.
>
> Huh? 5410 only has the *A15* cluster described (and for whatever reason
> mainline cannot bring up the A7 cluster even if you do add it).
>
> Also*, the interrupt affinity properties are bogus as presented - those
> will need to be delegated to the SoC-variant-specific dtsi files in the
> same manner as the "cpus" nodes, to cope with the different CPU numberings.
>
> Robin.
>
> *I'd like to have made this comment inline in the patch, but I can't :(
>
>> Tested with perf on Odroid XU4 (Exynos5422):
>> armv7_cortex_a7 PMU driver: 5 counters available
>> armv7_cortex_a15 PMU driver: 7 counters available
>>
>> Regards,
>> Marian
>>
>> --
>> Either I've been missing something or nothing has been going on. (K. E. Gordon)
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
