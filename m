From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 04 Jun 2015 23:03:46 +0200
Subject: [PATCH 00/21] On-demand device registration
In-Reply-To: <CAF6AEGuOP-3sxDQcNOjVmfP4ue6LmY7KFrj9W75aHKuvZpTFMw@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAF6AEGuOP-3sxDQcNOjVmfP4ue6LmY7KFrj9W75aHKuvZpTFMw@mail.gmail.com>
Message-ID: <5570BD32.9020705@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.06.2015 um 23:12 schrieb Rob Clark:
> On Mon, May 25, 2015 at 10:53 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> Hello,
>>
>> I have a problem with the panel on my Tegra Chromebook taking longer than
>> expected to be ready during boot (St?phane Marchesin reported what is
>> basically the same issue in [0]), and have looked into ordered probing as a
>> better way of solving this than moving nodes around in the DT or playing with
>> initcall levels.
>>
>> While reading the thread [1] that Alexander Holler started with his series to
>> make probing order deterministic, it occurred to me that it should be possible
>> to achieve the same by registering devices as they are referenced by other
>> devices.
>>
>> This basically reuses the information that is already implicit in the probe()
>> implementations, saving us from refactoring existing drivers or adding
>> information to DTBs.
>>
>> Something I'm not completely happy with is that I have had to move the call to
>> of_platform_populate after all platform drivers have been registered.
>> Otherwise I don't see how I could register drivers on demand as we don't have
>> yet each driver's compatible strings.
>>
>> For machs that don't move of_platform_populate() to a later point, these
>> patches shouldn't cause any problems but it's not guaranteed that we'll avoid
>> all the deferred probes as some drivers may not be registered yet.
>>
>> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and these
>> patches were enough to eliminate all the deferred probes.
>>
>> With this series I get the kernel to output to the panel in 0.5s, instead of 2.8s.
> 
> So, complete drive-by comment (and I won't claim to be a DT expert,
> etc, etc, so take this with a few grains of salt), but why not push
> the problem to the DT compiler (or a pre-process step that could be
> run on existing DT blobs), which generates an optional DT node that is
> the recommended probe order?  That seems like it avoids adding
> complexity into the early boot code (which seems like a good thing)..

I've played with that approach too (as my patches for dtc do contain the
same code I've put into the kernel, but decided that it doesn't make
much sense. The sort algorithm is really small (some dozen lines), very
fast (around 3-5ms on a omap) and might be later used to sort necessary
module loading too. So there would be no advantage to put a sorted list
into the DT. And having the sort algorithm in the kernel, would make it
possible to use it for acpi or something else too, if they manage it to
provide the necessary dependencies.

Regards,

Alexander Holler
