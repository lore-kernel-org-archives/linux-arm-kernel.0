From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 17 Sep 2018 13:39:12 +0200
Subject: [PATCH v3 0/4] Improve VCHIQ cache line size handling
In-Reply-To: <1537172544-104852-1-git-send-email-phil@raspberrypi.org>
References: <1537172544-104852-1-git-send-email-phil@raspberrypi.org>
Message-ID: <f1e38c0c-0702-5df2-7f7c-40bbb93115b2@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phil,

Am 17.09.2018 um 10:22 schrieb Phil Elwell:
> Both sides of the VCHIQ communications mechanism need to agree on the cache
> line size. Using an incorrect value can lead to data corruption, but having the
> two sides using different values is usually worse.
>
> In the absence of an obvious convenient run-time method to determine the
> correct value in the ARCH=arm world, the downstream Raspberry Pi trees used a
> Device Tree property, written by the firmware, to configure the kernel driver.
> This method was vetoed during the upstreaming process, so a fixed value of 32
> was used instead, and some corruptions ensued. This is take 2 at arriving at
> the correct value.
>
> Add a new compatible string - "brcm,bcm2836-vchiq" - to indicate an SoC with
> a 64-byte cache line. Document the new string in the binding, and use it on
> the appropriate platforms.
>
> The final patch is a (seemingly cosmetic) correction of the Device Tree "reg"
> declaration for the device node, but it doubles as an indication to the
> Raspberry Pi firmware that the kernel driver is running a recent kernel driver
> that chooses the correct value. As such it would help if the DT patches are
> not merged before the driver patch.
>
> v3: Builds without errors, tested on multiple Raspberry Pi models.
> v2: Replaced ARM-specific logic used to determine cache line size with
>     a new compatible string for BCM2836 and BCM2837.
>
> Phil Elwell (4):
>   staging/vc04_services: Use correct cache line size
>   dt-bindings: soc: Document "brcm,bcm2836-vchiq"
>   ARM: dts: bcm283x: Correct vchiq compatible string
>   ARM: dts: bcm283x: Correct mailbox register sizes

since my pull requests are out, would it be okay to apply patch #1 for
4.20 and the DT stuff for 4.21 (with the assumption Rob is okay with
these patches)?
