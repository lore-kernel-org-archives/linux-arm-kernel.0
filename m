From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Nov 2013 11:21:11 -0800
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <5283CC3F.7030306@gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CACxGe6sMXjcsGNEiGQ923_yEKXwaAj_qfqZQPpXqHgh1znsF0Q@mail.gmail.com>
 <CAL_Jsq+hO_euGM4eBtpeFUaQdo5rDgmyD0HaU0GEHN=S27f0Vg@mail.gmail.com>
 <20131111173826.GA8809@quad.lixom.net> <5283CC3F.7030306@gmail.com>
Message-ID: <CAOesGMg7Mt+p8U7Z5sLQDqoFG-QEUi94Vt=pxXM0NqyefBLxVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 11:00 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 11/11/2013 11:38 AM, Olof Johansson wrote:
>> On Tue, Nov 05, 2013 at 08:34:56AM -0600, Rob Herring wrote:
>>> On Mon, Nov 4, 2013 at 5:36 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>>> On Sun, Nov 3, 2013 at 8:50 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>>
>>>>> As part of the effort to ultimately remove struct machine_desc, the
>>>>> machine name is not really needed. It is only used for /proc/cpuinfo
>>>>> "Hardware" field. Get this information from the DT instead and remove
>>>>> the name string in the machine descriptor for DT machine descriptors. The
>>>>> model or machine compatible property from the DT is used instead.
>>>>
>>>> I've obviously missed some discussions because I wasn't aware of the
>>>> plan to remove machine_desc. That's neither here not there, but for as
>>>> long as the structure still exists it is really useful to discover
>>>> which machine_desc the kernel chooses at boot time. If you're going to
>>>> remove this, then at the very least I would embed the filename or
>>>> something similar into the machine desc so it is available for
>>>> debugging. It can go away when the structure is removed.
>>>
>>> It's a very long term goal to remove it completely, but it is now
>>> optional for "simple" platforms with the default machine_desc and
>>> default init ptrs. You might want to look at the patches and the WIP
>>> branch I posted[1] which removes the machine_desc for highbank.
>>> There's some core boilerplate I'd like your opinion on. Also, I'm sure
>>> you are aware of the resistance to add a machine_desc to arm64, so I'm
>>> looking at this from that perspective as well. I'm sure there will be
>>> platforms which look very similar across arm and arm64.
>>>
>>> On boot, the model or compatible string from the DTB is printed out
>>> (that change is actually in my DT arch clean-up series, not this
>>> patch). This has made what is printed out on boot consistent across
>>> arches using DT. There is no good reason for this to be arch specific.
>>> Presumably the compatible string is unique and just as easily grepped
>>> for in the kernel source as the machine_desc name is. Adding a
>>> filename string here seems like useless bloat to me.
>>
>> I think I agree a bit with Grant's concern here.
>>
>> The compatible string is unique, but the machine descriptors might not
>> be -- a given device tree might match two of them (one more generic,
>> one more specific) -- it would be useful to know which one was used. Or,
>> if you missed to enable the platform support for your board so it booted
>> with the generic descriptor, but you still needed your own.
>
> I would push back on anyone having multiple machine descriptors for that
> purpose.
>
>> Matching it back to which devicetree the kernel was booted with shouldn't be
>> hard, I agree -- but knowing which machine entry was picked at boot time
>> is still useful information.
>
> We need to separate what we print on boot vs. what is in /proc/cpuinfo.
>
> One issue I'm trying to solve here is customers complain that Midway
> systems print "Calxeda Highbank" in /proc/cpuinfo. I don't think adding
> a machine desc only for adding a string for Midway would be right. Also,
> I'm close to removing the highbank machine descriptor altogether and
> printing out "Generic DT" from the default machine desc is not
> particularly useful. Do we at least have agreement that the "right"
> thing to print in cpuinfo is the model or compatible from DT?
>
> What is printed on boot is already changed to be based on DT, but that
> seems to be what you and Grant care about. Does something like this work
> for you? This will print either "Machine model: model string (matched
> compat)" or "Machine model: 1st compat str (matched compat)"


PowerPC prints both platform (which is the equivalent to machine
descriptor name on ARM), _and_ the /model property from the device
tree:


chitra:~# cat /proc/cpuinfo
processor : 0
cpu : PA6T, altivec supported
clock : 500.000000MHz
revision : 1.2 (pvr 0090 0102)

processor : 1
cpu : PA6T, altivec supported
clock : 500.000000MHz
revision : 1.2 (pvr 0090 0102)

timebase : 66666666
platform : PA Semi PWRficient
model : pasemi,chitra
chitra:~#

(Not sure why we chose "pasemi,chitra" instead of a clear-text model
name in this case :-)

Maybe that's the best of both worlds, to add a Model-equivalent entry
in /proc/cpuinfo? Ideally we'd like to rename the "Hardware" one to
"Platform", but since that's an ABI it'll be hard.

Perhaps it's better to use the /model string for Hardware:, and add a
"Machine type" under it? In your case the machine type would
(eventually) be "Generic DT", which should be acceptable.


-Olof
