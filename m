From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 04 Mar 2015 17:18:12 -0600
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>	<54EFE282.1090305@codeaurora.org>
 <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Message-ID: <54F792B4.3060600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2015 02:50 AM, Ard Biesheuvel wrote:
> Are you not seeing this on v4.0-rc1 without the patchset applied?
>
> Could the crash be inside the subsequent call to
> SetVirtualAddressMap() instead of inside ExitBootServices()?
>
> If so, you have a firmware bug: Mark Rutland spotted a similar bug in
> the AMD Seattle firmware, which has been fixed in the mean time.
> It has to do with the firmware dereferencing the virtual mapping as it
> is being installed, which violates the UEFI spec.

It looks like you are right.  We fixed the bug in our UEFI and now this 
patchset works.

So all 21 patches:

Tested-by: Timur Tabi <timur@codeaurora.org>


However, I did notice one thing.  Booting the kernel displays this line:

	[   69.424001] Failed to find cpu0 device node

That's because CONFIG_OF is still defined (part of "config ARM64"), and 
therefore cache_setup_of_node() attempts to get the cache information 
from the device tree.

Should CONFIG_OF still be defined?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
