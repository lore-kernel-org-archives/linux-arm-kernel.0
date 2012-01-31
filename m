From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 31 Jan 2012 13:04:33 +0530
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
 <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
 <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
 <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
 <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
Message-ID: <CAMQu2gyLgmbeqVevTbGazO3A+AkYPsPeWp9mp0eD_EwXs3SZ0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 12:57 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
>
>> On Tue, Jan 31, 2012 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
>> >
>> >> In this code the need is to clear only CPU and MPUPD, and hence they are
>> >> explicitly cleared since the pre/post transition calls can be moved to PM_DEBUG
>> >> in production kernels.
>> >>
>> >> But as you stated in current mainline kernel they are superfluous since the
>> >> pre/post calls are not under PM debug. So I am ok either way
>> >
>> > We're using the PM counters for the context restore skip optimization now
>> > in pwrdm_get_context_loss_count(), so they've suddenly become needed even
>> > when PM_DEBUG=n. ?But those counters are only needed when there are
>> > devices in the CPU* powerdomains to track that can lose logic context. ?I
>> > don't think that's the case on OMAP4, but you would probably know better
>> > than I.
>> >
>> Good point so the pre/post calls are must then. We should kill those extra calls
>> form OMAP4 code then.
>
> I wonder if we should track how many hwmods are present in a powerdomain?
> We could check that counter to determine if we could skip the access.
>
That's good idea since these calls are in critical patha nd faster we can do
better it is..

A week back I was discussing with Benoit and Tony about having some
infrastructure like "unused clocks" so that we can shutdown those
modules, and if possible some power domains. That way they get
removed at one single place and they the power domain calls
need not iterate over the once which are no longer needed.

Regards
Santosh
