From: zlim.lnx@gmail.com (Z Lim)
Date: Wed, 14 Jan 2015 10:46:37 -0800
Subject: [PATCH boot-wrapper-aarch64 0/4] psci cleanups + simple v0.2
 implementation
In-Reply-To: <20150114115349.GE12069@leverpostej>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
 <20150114115349.GE12069@leverpostej>
Message-ID: <CABg9mcvYkX-1k3-1OrQHphL1+qLo-q5TtKySHc=OpNintT3XFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 3:53 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jan 13, 2015 at 02:15:00AM +0000, Zi Shen Lim wrote:
>> Hi Mark,
>
> Hi,
>
>> The first couple patches are cleanups.
>>
>> The third patch switches to using v0.2 function ID values for the
>> existing cpu_{on,off} implementations. This intermediate step is
>> arguably unnecessary given the next patch...
>>
>> The fourth patch provides a simple implementation of PSCI v0.2.
>> The deviations from spec (primarily cpu_suspend not supported)
>> is noted in code comment as well as in commit log.
>
> While I'm not opposed to implementing PSCI 0.2, the two major reasons
> for not having implemented it so far were simplicity and
> spec-compliance. Unless implementing PSCI 0.2 gains us something, I
> don't see the point in moving from PSCI 0.1.

I'm in full agreement here. I don't think we'd want boot-wrapper to
become overly complicated - at some point we might as well use ARM
Trusted Firmware.

>
> I think not having any supported CPU_SUSPEND states is fine. For spec

Okay :)

> compliance I'm more worried by the behaviour of AFFINITY_INFO (as this
> implementation seems to ignore the lowest_affinity_level parameter), and

The simple implementation of psci_affinity_info only supports
lowest_affinity_level==0.
Motivation: the known user of this (arch/arm64/kernel/psci.c) only
uses lowest_affinity_level=0.
Do we need something more complex?

> the behaviour of SYSTEM_{OFF,RESET} -- I wonder if these could be
> implemented via semihosting.

Good point. Haven't thought about that option.
I also wonder if linux will use PSCI for these functions.

>
> Given that SYSTEM_OFF and SYSTEM_RESET are effectively not implemented,
> the only thing that I see we gain from this PSCI 0.2 implementation is
> AFFINITY_INFO to close a race with CPU_OFF. Is PSCI 0.2 just a
> nice-to-have feature, or is there something it provides that you
> particularly want?

I'm currently using this as baseline for PSCI 0.2 related work.
I have other (non-FVP) platform-specific changes as well, but figured
at least the generic/common portions could be shared upstream.

>
> I occasionally need to use a new boot-wrapper with old kernels which
> only handle PSCI 0.1, so we also need to maintain compatiblity in the
> way the DT binding doc describes:
>
> psci {
>         compatible = "arm,psci-0.2", "arm,psci";
>         method = "smc";
>         cpu_on = < ... >;
>         cpu_off = < ... >;
> };

Ok. In that case, along with the DT compatibility above, we'll also
need patch 3.

>
> Thanks,
> Mark.
>
>>
>> Please consider merging.
>>
>> Thanks, z
>>
>> Zi Shen Lim (4): psci: use MPIDR_INVALID instead of -1 psci: remove
>> sentinel from id_table psci: use PSCI v0.2 function IDs psci:
>> implement PSCI v0.2
>>
>>  Makefile.am |   4 +- psci.S      | 170
>>  ++++++++++++++++++++++++++++++++++++++++++++++++++---------- 2 files
>>  changed, 143 insertions(+), 31 deletions(-)
>>
>> -- 2.1.0
>>
>>
