From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Aug 2013 21:19:50 +0900
Subject: [PATCH 04/14] ARM: shmobile: sh73a0: Remove ->init_machine()
 special case
In-Reply-To: <1634183.WaD7XDSkzI@avalon>
References: <20130809094748.6530.16511.sendpatchset@w520>
 <1580455.O5Pubhdtgp@avalon>
 <CANqRtoT1a7Ge2dBvNhAFK+Fpv_xC3QE_O-y6MxajwQfnbaVYHA@mail.gmail.com>
 <1634183.WaD7XDSkzI@avalon>
Message-ID: <CANqRtoSrfUaMYqADNP9d5+ourtWuhgscvAVVW-nCVXFyYsCfFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Aug 28, 2013 at 9:08 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Wednesday 28 August 2013 15:40:50 Magnus Damm wrote:
>> On Fri, Aug 9, 2013 at 7:47 PM, Laurent Pinchart wrote:
>> > On Friday 09 August 2013 18:48:32 Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> No need to special case sh73a0 ->init_machine(),
>> >> so get rid of undesired cpufreq platform device
>> >> from the generic long term sh73a0 DT support code.
>> >>
>> >> For short term support on KZM9D the DT reference
>> >> implementation now adds a "cpufreq-cpu0" platform
>> >> device so that can be used for development.
>> >
>> > Doesn't this go against the spirit of the -reference platforms that don't
>> > use DT devices in board code ? I don't see an urgent need for this, how
>> > far along are the DT cpufreq-related bindings ?
>>
>> I'm not sure what the latest state of DT cpufreq bindings are. Actually, it
>> seems to me that the cpufreq platform device is a software policy that
>> shouldn't be described with DT. And to be honest, I can't really see how
>> this policy has anything to do with any particular SoC.
>
> I'm no cpufreq expert, but if we need to register the device in C code, I'm
> pretty uneasy with having that code in board files. One of the DT goals is to
> get rid of most board files.

I'm not sure if we actually _have_to_ register via the platform
device, or if it just happens to be like that today because no one has
bothered creating a better abstraction. It is a mystery to me that
both a platform device is used to select actual driver, and then DT is
used to provide frequency and voltage information.

The cpufreq software policy is neither board nor SoC specific. It must
be application specific. I can understand that putting it in a board
file seems odd, but putting it in a SoC file is IMO equally odd, and
with the added damage that people starting to write generic DT code
may assume that the SoC will keep on using the same cpufreq software
policy in the future.

Perhaps the cpufreq registration interface should be reworked somehow?

Cheers,

/ magnus
