From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Jun 2017 10:44:32 -0600
Subject: [PATCH 01/12] coresight replicator: Cleanup programmable
 replicator naming
In-Reply-To: <20170616180820.enc3hxpju2tfu3fg@rob-hp-laptop>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-2-git-send-email-suzuki.poulose@arm.com>
 <20170613165528.GA6392@xps15>
 <20170616180820.enc3hxpju2tfu3fg@rob-hp-laptop>
Message-ID: <CANLsYkzDMyhX_L5Aaf2p9+ze_qA=FCe+GdjEZcz03ZXaHXb46Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 June 2017 at 08:04, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 13, 2017 at 10:55:28AM -0600, Mathieu Poirier wrote:
>> On Mon, Jun 12, 2017 at 03:36:40PM +0100, Suzuki K Poulose wrote:
>> > The Linux coresight drivers define the programmable ATB replicator as
>> > Qualcom replicator, while this is designed by ARM. This can cause confusion
>> > to a user selecting the driver. Cleanup all references to make it
>> >  explicitly clear. This patch :
>> >
>> >  1) Adds a new compatible string for the same, retaining the old one for
>> >     compatibility.
>> >  2) Changes the Kconfig symbol (since this is not part of any defconfigs)
>> >      CORESIGHT_QCOM_REPLICATOR => CORESIGHT_DYNAMIC_REPLICATOR
>> >  3) Improves the help message in the Kconfig.
>> >  4) Changes the name of the driver :
>> >     coresight-replicator-qcom => coresight-dynamic-replicator
>> >
>> > Cc: Pratik Patel <pratikp@codeaurora.org>
>> > Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> > Cc: devicetree at vger.kernel.org
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> > Cc: Mark Rutland <mark.rutland@arm.com>
>> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Hi Suzuki,
>>
>> > ---
>> >  Documentation/devicetree/bindings/arm/coresight.txt     |  4 +++-
>> >  drivers/hwtracing/coresight/Kconfig                     | 10 +++++-----
>> >  drivers/hwtracing/coresight/Makefile                    |  2 +-
>> >  drivers/hwtracing/coresight/coresight-replicator-qcom.c |  2 +-
>> >  4 files changed, 10 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> > index fcbae6a..f77329f 100644
>> > --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> > @@ -34,7 +34,9 @@ its hardware characteristcs.
>> >             - Embedded Trace Macrocell (version 4.x):
>> >                     "arm,coresight-etm4x", "arm,primecell";
>> >
>> > -           - Qualcomm Configurable Replicator (version 1.x):
>> > +           - Coresight programmable Replicator (version 1.x):
>> > +                   "arm,coresight-dynamic-replicator", "arm,primecell";
>> > +                           OR
>> >                     "qcom,coresight-replicator1x", "arm,primecell";
>>
>> Rob, what's your view on keeping the old binding around?  We could simply change
>> the two occurences we find in the DTs (Juno and 410c) to the new name and be
>> done with the old one.
>
> Juno uses the Qcom string? We should keep the old string. You can switch
> the dts files, but the driver should support the old name.

When we first started working on CoreSight programmable replicators
were available but the documentation wasn't public.  As such when I
saw Qualcomm's design I mistakenly thought it was a custom IP block
and came up with a compatible string that reflected that reality.
Fast forward 3 years the documentation is available and Juno has used
the same IP block in their design.  Suzuki's patch rectifies history
by changing the programmable replicator naming convention to what it
should have been from the start.

That being said, we can keep the old compatible string around but it
won't change anything.  CoreSight devices are discovered on the AMBA
bus and don't use the compatible string - drivers are probed based on
AMBA IDs laid out in the drivers and device IDs found in HW ID
registers.

In light of the above let me know what you want to do.

Thanks,
Mathieu

>
> Acked-by: Rob Herring <robh@kernel.org>
