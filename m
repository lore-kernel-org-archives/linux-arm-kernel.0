From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 01 Dec 2017 17:03:54 +0100
Subject: SCPI regressions in v4.15-rc1 on Amlogic SoCs.
In-Reply-To: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
References: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
Message-ID: <1512144234.12869.4.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-11-30 at 16:21 -0800, Kevin Hilman wrote:
> Hi Sudeep,
> 
> There's been a pretty major regression in v4.15-rc1 compared to v4.15
> in SCPI causing warning splats on amlogic SoCs when cpufreq starts up
> and tries to set the OPP for the first time[1].
> 
> I ran out of time to narrow it down further since there have been
> quite a few changes since v4.14, but simply reverting
> drivers/firmware/arm_scpi.c to its v4.14 state gets things working
> again.

Same thing for me. One of my early libretech-cc gets completely stuck during
boot with v4.15-rc1

reverting drivers/firmware/arm_scpi.c to v4.14 fixes the problem.

On the u-art, we see traces that appear to be coming from the FW:
> domain-0 init dvfs: 4 

My platform gets stuck on one of these traces with v4.15-rc1

> 
> This has been happening for awhile, and we should've caught it sooner
> in kernelCI.org, however this warning splat still allows the kernel to
> finish booting, so it still resulted in a PASS for the boot test.
> That combined with the fact that we've been tracking some other
> regressions, we didn't notice it until now.
> 
> Also, is this the expected result for the pre-1.0 firmware:
> 
>     scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
> 
> Kevin
> 
> [1] Here are a few boot logs from v4.15-rc1 with the splat:
> 
> https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-bay
> libre-seattle/boot-meson-gxl-s905x-khadas-vim.html
> 
> https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-bay
> libre-seattle/boot-meson-gxbb-p200.html
> 
> https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-bay
> libre-seattle/boot-meson-gxl-s905d-p230.html
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
