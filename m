From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Jan 2016 16:54:07 -0700
Subject: [PATCH V7 02/24] coresight: associating path with session rather
 than tracer
In-Reply-To: <20160116135423.GA29682@debian>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-3-git-send-email-mathieu.poirier@linaro.org>
 <20151220152939.GA11552@debian>
 <CANLsYkwhC0fSqrZrHH+P68Dev1j6n19o=2g8kJpZfzBMTbcNdA@mail.gmail.com>
 <20160105131505.GA32528@debian>
 <CANLsYkwN=SOnfDfd8oF-2Z5Ef8oTPao6H_auQhoMpVAnokYkrg@mail.gmail.com>
 <20160110154326.GB13903@debian>
 <CANLsYkz2t1ytWUiV-i2tfe4J1Yfuyg6fiWL0nrNGA9QCph-XWQ@mail.gmail.com>
 <20160116135423.GA29682@debian>
Message-ID: <CANLsYkxSchGRuAqB=-F6UsdsgO_ke=de4V3ur1Zipk4J-80bjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2016 at 06:54, Rabin Vincent <rabin@rab.in> wrote:
> On Wed, Jan 13, 2016 at 02:47:10PM -0700, Mathieu Poirier wrote:
>> On 10 January 2016 at 08:43, Rabin Vincent <rabin@rab.in> wrote:
>> >   - There is no reference taken for the csdev when it is assigned as
>> >     some other device's child_dev in coresight_orphan_match()
>>
>> The only time a device shouldn't be removed is when it is part of an
>> active trace session, something that shouldn't happen due to the
>> static nature of the coresight devices.
>
> # echo 1 > /sys/bus/coresight/devices/54162000.etb/enable_sink
> # echo 1 > /sys/bus/coresight/devices/5414c000.ptm/enable_source
> [   22.853637] coresight-etb10 54162000.etb: ETB enabled
> [   22.859069] coresight-funnel 54164000.funnel: FUNNEL inport 0 enabled
> [   22.865814] coresight-replicator 44000000.ocp:replicator: REPLICATOR enabled
> [   22.873260] coresight-funnel 54158000.funnel: FUNNEL inport 0 enabled
> [   22.880187] coresight-etm3x 5414c000.ptm: ETM tracing enabled
> # echo 44000000.ocp\:replicator > /sys/bus/platform/drivers/coresight-replicator/unbind
> # echo 0 > /sys/bus/coresight/devices/5414c000.ptm/enable_source
> [   37.261840] coresight-etm3x 5414c000.ptm: ETM tracing disabled
> [   37.268066] Unable to handle kernel NULL pointer dereference at virtual address 0000023c
> [   37.276611] pgd = ec60c000
> [   37.279571] [0000023c] *pgd=ac5d6831, *pte=00000000, *ppte=00000000
> [   37.286163] Internal error: Oops: 817 [#1] SMP ARM
> [   37.291198] Modules linked in:
> [   37.294403] CPU: 0 PID: 857 Comm: sh Not tainted 4.4.0-rc8-00063-g15ed5a7c725c #196

That is a problem of a totally different nature - no amount of
refcount management will prevent this splat.  As you highlighted here
the framework is not ready to deal with devices disappearing from a
path - I need to ponder on that.

Mathieu
