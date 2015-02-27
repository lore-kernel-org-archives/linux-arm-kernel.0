From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Feb 2015 08:50:34 +0000
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <54EFE282.1090305@codeaurora.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <54EFE282.1090305@codeaurora.org>
Message-ID: <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2015 at 03:20, Timur Tabi <timur@codeaurora.org> wrote:
> On 02/25/2015 02:39 AM, Hanjun Guo wrote:
>>
>> Changes since v8:
>
>
> I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after calling
> the UEFI boot time services exit function.  That is, this line:
>
> status = sys_table->boottime->exit_boot_services(handle, mmap_key);
>
> in allocate_new_fdt_and_exit_boot() gets called, and then soon after it
> returns, the kernel crashes.  It's really early because the UEFI exception
> handler is called.
>
> I did not have this problem with v8 patchset on 3.19.
>

Are you not seeing this on v4.0-rc1 without the patchset applied?

Could the crash be inside the subsequent call to
SetVirtualAddressMap() instead of inside ExitBootServices()?

If so, you have a firmware bug: Mark Rutland spotted a similar bug in
the AMD Seattle firmware, which has been fixed in the mean time.
It has to do with the firmware dereferencing the virtual mapping as it
is being installed, which violates the UEFI spec.


>
> Also, you still have a couple whitespace problems in these patches:
>
> Applying: ARM64 / ACPI: additions of ACPI documentation for arm64
> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:607: new blank line at
> EOF.
> +
> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:844: new blank line at
> EOF.
> +
> warning: 2 lines add whitespace errors.
> Applying: Documentation: ACPI for ARM64
> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:517: new blank line at
> EOF.
> +
> warning: 1 line adds whitespace errors.
>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
