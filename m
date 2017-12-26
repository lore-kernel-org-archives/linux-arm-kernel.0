From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Tue, 26 Dec 2017 08:26:19 +0530
Subject: arm64 crashkernel fails to boot on acpi-only machines due to ACPI
 regions being no longer mapped as NOMAP
In-Reply-To: <20171226022807.GB8877@linaro.org>
References: <CAKv+Gu-gmbWdZ7rxp5qGrtSBQ7dM=3FqF-Pw=J0LaL=oKTMg4w@mail.gmail.com>
 <CACi5LpOscbcBecWaC3Q9P22kheRYc+M2Ynfusszk14fPY-cJ5A@mail.gmail.com>
 <20171221103440.GJ28046@linaro.org>
 <CACi5LpMUnUKxiALAHW9_PE2RYC8GNWLPGpdJ5ca53g=v3rNkfg@mail.gmail.com>
 <20171222083308.cy3vwlyhig22q5ee@fireball>
 <CACi5LpNF5i3Eo7nMLr_z9r4VVbXhDwSJCQoiOh-A_jB6hV0_2Q@mail.gmail.com>
 <20171225032500.GA8877@linaro.org>
 <CACi5LpMzYidDaC0_yfwgVOisH-FqcNViYj+Z54uKfUtHkJKKXA@mail.gmail.com>
 <20171226013217.GA2119@dhcp-128-65.nay.redhat.com>
 <20171226013517.GA2186@dhcp-128-65.nay.redhat.com>
 <20171226022807.GB8877@linaro.org>
Message-ID: <CACi5LpNRtXh-j9Y9HwRatDZwRMr++-ZeaSnk62vD3btpxsVv7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 7:58 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Tue, Dec 26, 2017 at 09:35:17AM +0800, Dave Young wrote:
>> [snip]
>> > > > Well, we may be able to change pr_warn() to pr_warn_once() here, but
>> > > > I hope that adding "numa=off" to kernel command line should also work.
>> > >
>> > > Hmm, adding "numa=off" to crashkernel bootargs works, and TBH it was
>> > > my initial thought process as well, but I am not sure if this will
>> > > cause any regressions on aarch64 systems which use crashdump feature.
>> >
>> > It should be fine since we use numa=off by default for all other arches
>> > ie. x86, ppc64 and s390. Actually disabling numa in kdump kernel can save
>> > mm component memory usage.
>> >
>>
>> Forgot to say I means in RHEL and Fedora we use numa=off for kdump..
>
> Thank you for the clarification.
> (It might be better to make numa off automatically if maxcpus == 0 (and 1?).)
>

Not sure if we can leave this to the distribution-specific kdump
scripts (as the crashkernel boot can be held up for sufficient time
and may appear stuck). The distribution scripts may be different (for
e.g. ubuntu and RHEL/fedora) across distributions and may have
different bootarg options.

So how about considering a kernel fix only which doesn't require
relying on changing the distribution-specific kdump scripts, as we
should avoid introducing a regression while trying to fix a regression
:)

Just my 2 cents.

Thanks,
Bhupesh
