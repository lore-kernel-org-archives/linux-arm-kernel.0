From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 10 Mar 2015 20:23:03 +0800
Subject: [PATCH v9 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY
 if ACPI is enabled on ARM64
In-Reply-To: <20150306174715.GA26888@e102568-lin.cambridge.arm.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-19-git-send-email-hanjun.guo@linaro.org>
 <20150306174715.GA26888@e102568-lin.cambridge.arm.com>
Message-ID: <54FEE227.4000808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?07? 01:47, Lorenzo Pieralisi wrote:
> On Wed, Feb 25, 2015 at 08:39:58AM +0000, Hanjun Guo wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> ACPI reduced hardware mode is disabled by default, but ARM64
>> can only run properly in ACPI hardware reduced mode, so select
>> ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.
>
> Agreed. This will remove unneeded acpica code. I think though,
> you should also check the FADT flag HW_REDUCED_ACPI at boot to
> make sure that the tables are HW reduced compliant. I am flagging

Agreed, I will add that check on top of this patch set. We explicitly
stated that we are using hardware reduced mode on ARM64 in the doc, so, 
how about print some warning message and go on with the boot if we
got the wrong flag HW_REDUCED_ACPI at boot?

> this up because I noticed code in core code (not guarded by
> ifdef) that checks:
>
> acpi_gbl_reduced_hardware
>
> and if it is not set it goes on instantiating fixed HW devices.
>
> drivers/acpi/scan.c:2567
>
> It is just a heads up, I think it is harmless, but one thing is
> removing acpica code on ACPI HW reduced only, the other is to make
> sure the kernel does not try to use ACPI HW features that acpica
> can't support.

I agree, need some cleanups for the ACPICA code I think, and this
was raised about 1 and half years ago and Intel folks need more
consideration on that [1].

[1]: http://comments.gmane.org/gmane.linux.acpi.devel/63844

Thanks
Hanjun
