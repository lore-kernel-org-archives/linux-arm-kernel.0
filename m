From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 8 Nov 2018 10:10:19 -0700
Subject: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated
 from perf
In-Reply-To: <054f82c1-451f-3c82-d5ab-e156c50e0c10@arm.com>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
 <20181107032350.GH3983@leoy-ThinkPad-X240s>
 <054f82c1-451f-3c82-d5ab-e156c50e0c10@arm.com>
Message-ID: <CANLsYkyi_0hzJ5fXFfq6FrsebFMCATQP3oqeU6aBmAw6BTGuGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2018 at 02:49, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Leo,
>
> On 07/11/2018 03:23, leo.yan at linaro.org wrote:
> > Hi Mathieu,
> >
> > On Mon, Nov 05, 2018 at 03:26:30PM -0700, Mathieu Poirier wrote:
> >> This patch deals with the release of the CLAIM tag when the ETM is
> >> operated from perf.  Otherwise the tag is left asserted and subsequent
> >> requests to use the device fail.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> >> index fd5c4cca7db5..000796394662 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> >> @@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
> >>       */
> >>      etm_set_pwrdwn(drvdata);
> >>
> >> +    coresight_disclaim_device_unlocked(drvdata->base);
> >> +
>
>
> >
> > Just remind, this isn't consistent with the sequency in function
> > etm_disable_hw(), which has the reversed sequence between
> > etm_set_pwrdwn() and coresight_disclaim_device_unlocked().
> >
> > Not sure which one sequence is more suitable, at the first glance,
> > accessing register after pwrdwn related operation might have risk for
> > deadlock?
>
> Good point.
>
> I assume that the CLAIMSET/CLR registers are in the same power domain as
> the LAR (Software Lock Access register) accessed below. But I will
> confirm this with the architect. Based on the response, we could
> streamline both the sequences.

In this case etm_set_pwrdwn() sets bit 0 of ETMCR, which disables the
ETM.  That being said the Embedded Trace Macrocell Architecture
Specification (ID101211) mentions in section 3.5.1 that despite ETMCR
bit 0 being set to 1, it is always possible to write to the claim set
registers.  As such I moved the release of the claim tag in function
etm_disable_hw() below etm_set_pwrdwn() in the second revision of this
set [1].

[1]. https://lkml.org/lkml/2018/11/8/223

>
> Suzuki
>
> >
> > Thanks,
> > Leo Yan
> >
> >>      CS_LOCK(drvdata->base);
> >>   }
> >>
> >> --
> >> 2.7.4
> >>
