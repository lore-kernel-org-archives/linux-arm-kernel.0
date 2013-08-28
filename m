From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Aug 2013 15:40:50 +0900
Subject: [PATCH 04/14] ARM: shmobile: sh73a0: Remove ->init_machine()
 special case
In-Reply-To: <1580455.O5Pubhdtgp@avalon>
References: <20130809094748.6530.16511.sendpatchset@w520>
 <20130809094832.6530.9438.sendpatchset@w520>
 <1580455.O5Pubhdtgp@avalon>
Message-ID: <CANqRtoT1a7Ge2dBvNhAFK+Fpv_xC3QE_O-y6MxajwQfnbaVYHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Aug 9, 2013 at 7:47 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Friday 09 August 2013 18:48:32 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> No need to special case sh73a0 ->init_machine(),
>> so get rid of undesired cpufreq platform device
>> from the generic long term sh73a0 DT support code.
>>
>> For short term support on KZM9D the DT reference
>> implementation now adds a "cpufreq-cpu0" platform
>> device so that can be used for development.
>
> Doesn't this go against the spirit of the -reference platforms that don't use
> DT devices in board code ? I don't see an urgent need for this, how far along
> are the DT cpufreq-related bindings ?

I'm not sure what the latest state of DT cpufreq bindings are.
Actually, it seems to me that the cpufreq platform device is a
software policy that shouldn't be described with DT. And to be honest,
I can't really see how this policy has anything to do with any
particular SoC.

Regarding MACHINE_START on mach-shmobile I'd like to have 3 levels:

1) MACHINE_START in setup-xxxx.c

This is where we aim to be in the long term. We should be as
theoretically correct as ever possible here. I'd like to avoid all
platform devices here. Also, I'd like to avoid short term random
policy setting here.

2) MACHINE_START in board-xxx-reference.c

This is where we build DT support for the board. In case we don't have
DT bindings for a certain device then using platform device here is
acceptable. Other short term workarounds are also acceptable here.

3) MACHINE_START in board-xxx.c

This is the location of the C-based board support. Some SoC-specific
bits like CPU cores and interrupt controllers may be initialized via
DT. Otherwise platform devices are used.

Hope this clarifies my view!

Cheers,

/ magnus
