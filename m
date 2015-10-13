From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Oct 2015 16:21:41 -0500
Subject: [PATCH v6 0/22] On-demand device probing
In-Reply-To: <CAAObsKDffo935Ae3wEPVAFyqBDR+d6LKmh0ORfmYGnu2DN7YEw@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <5606E120.3070305@kernel.org>
 <CAAObsKDffo935Ae3wEPVAFyqBDR+d6LKmh0ORfmYGnu2DN7YEw@mail.gmail.com>
Message-ID: <CAL_JsqLhHm4k8uS56qRGoNyLFKZh_e6U3PL-cu=fcWgVv54v=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 2:57 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 26 September 2015 at 20:17, Rob Herring <robh@kernel.org> wrote:
>> On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
>>> Hello,
>>>
>>> I have a problem with the panel on my Tegra Chromebook taking longer
>>> than expected to be ready during boot (St?phane Marchesin reported what
>>> is basically the same issue in [0]), and have looked into ordered
>>> probing as a better way of solving this than moving nodes around in the
>>> DT or playing with initcall levels and linking order.
>>>
>>> While reading the thread [1] that Alexander Holler started with his
>>> series to make probing order deterministic, it occurred to me that it
>>> should be possible to achieve the same by probing devices as they are
>>> referenced by other devices.
>>>
>>> This basically reuses the information that is already implicit in the
>>> probe() implementations, saving us from refactoring existing drivers or
>>> adding information to DTBs.
>>>
>>> During review of v1 of this series Linus Walleij suggested that it
>>> should be the device driver core to make sure that dependencies are
>>> ready before probing a device. I gave this idea a try [2] but Mark Brown
>>> pointed out to the logic duplication between the resource acquisition
>>> and dependency discovery code paths (though I think it's fairly minor).
>>>
>>> To address that code duplication I experimented with Arnd's devm_probe
>>> [3] concept of having drivers declare their dependencies instead of
>>> acquiring them during probe, and while it worked [4], I don't think we
>>> end up winning anything when compared to just probing devices on-demand
>>> from resource getters.
>>>
>>> One remaining objection is to the "sprinkling" of calls to
>>> of_device_probe() in the resource getters of each subsystem, but I think
>>> it's the right thing to do given that the storage of resources is
>>> currently subsystem-specific.
>>>
>>> We could avoid the above by moving resource storage into the core, but I
>>> don't think there's a compelling case for that.
>>>
>>> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip and
>>> OMAP SoCs, and these patches were enough to eliminate all the deferred
>>> probes (except one in PandaBoard because omap_dma_system doesn't have a
>>> firmware node as of yet).
>>>
>>> Have submitted a branch [5][6][7] with these patches on top of today's
>>> linux-next (20150921) to kernelci.org and I don't see any issues that
>>> could be caused by them.
>>>
>>> With this series I get the kernel to output to the panel in 0.5s,
>>> instead of 2.8s.
>>
>> I think we're pretty close other than some minor comments. I would like
>> to see ack's from Greg and some reviewed-bys from others. The subsystem
>> changes are minor and there has been plenty of chance to comment, so I
>> don't think acks from all subsystems are needed.
>
> Hi Rob,
>
> I'm not sure we are going to get much more feedback by just waiting or
> resending what has been sent so many times.

Agreed.

> Did you have in mind specific people you wanted to see reviewed-bys from?

Mainly Greg.

Please send me a pull req. I want to get this into -next and can
always drop it if there is further review.

Rob
