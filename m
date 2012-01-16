From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 16 Jan 2012 11:15:33 -0800
Subject: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF and
 DDR
In-Reply-To: <4F1087C9.6030908@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
 <4EEFC23A.30201@gmail.com> <20111219233559.GW6464@atomide.com>
 <4EF0671B.7090508@ti.com> <4EF0824A.9060208@ti.com> <4EF096C9.1070808@ti.com>
 <4F09D10B.7010807@ti.com>
 <CAOesGMjFmM=gXddvFzW+BYqOedySjPVZ6hjwsF-F40Wr9BvSLg@mail.gmail.com>
 <4F1087C9.6030908@ti.com>
Message-ID: <CAJOA=zNuVQ9zjhmA5Uc=ksOM2Q7AE4g9ddPDJ3e+QPnUfui4wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 11:36 AM, Aneesh V <aneesh@ti.com> wrote:
> Hi Olof,
>
>
> On Monday 09 January 2012 11:12 AM, Olof Johansson wrote:
>>
>> Hi,
>>
>> On Sun, Jan 8, 2012 at 9:23 AM, Aneesh V<aneesh@ti.com> ?wrote:
>>>
>>> Hi,
>>>
>>>
>>> On Tuesday 20 December 2011 03:08 PM, Aneesh V wrote:
>>>>
>>>>
>>>> Hi Benoit
>>>>
>>>> On Tuesday 20 December 2011 06:10 PM, Cousson, Benoit wrote:
>>>>>
>>>>>
>>>>> Hi Aneesh,
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>>>>> In general, is it really feasible to parse the DTB before DDR is
>>>>>>>> initialized?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Changing timings is still needed for DVFS during runtime.
>>>>>>>
>>>>>>> But we can boot to userspace with bootloader set timings, so I'm
>>>>>>
>>>>>>
>>>>>>
>>>>>> As far as I understand, in the current out-of-tree DVFS implementation
>>>>>> for OMAP, DVFS can start even before user-space.
>>>>>
>>>>>
>>>>>
>>>>> Maybe it is the case, but that does not mean it should.
>>>>> We can potentially delay the DVFS init until the user-space is started.
>>>>> This should not be considered as a big constraint.
>>
>>
>> Or at least until ramdisk is available, and store the tables there.
>> It's a matter of seconds, delaying DVFS initialization until then
>> shouldn't be the end of the world.
>
>
> It's not about power savings, here is what I understand from
> discussion with power management folks. In our current architecture
> drivers can set frequency constraints with clock framework and this may
> in turn initiate frequency scaling and this can happen before user
> space. Perhaps we could forbid this too. But I am not sure if the
> benefit is worth the trouble.

Jumping through these kinds of hoops causes me to really question what
it is we're trying to achieve.  There is already the case where clock
event code needs statically allocated clocks for setup before DT data
is available, and in this example at least some subset of mem timings
must be done in bootloader prior to DT data availability again.  Some
times these situations are unavoidable, but I feel uneasy about
splitting data up across multiple sources.  Hunting bugs in such data
is going to be painful.

And delaying DVFS (at least for the parts affecting mem) until
userspace is loaded doesn't seem great to me either.  We're basically
pushing back feature readiness (with respect to boot sequence) in the
name of organizing data in a pretty way... but it's not a pretty
solution since the data will have to be "split" as shown above.

Regards,
Mike
