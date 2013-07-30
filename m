From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 30 Jul 2013 14:03:08 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <51F7FCA6.6010909@wwwdotorg.org>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <51F7F914.6040709@wwwdotorg.org>
 <CAKON4Oy6hL9LzHdfq4vWcurbw6TU3HCK_jq14xwweA8dvOGtdw@mail.gmail.com>
 <51F7FCA6.6010909@wwwdotorg.org>
Message-ID: <CAKON4OzLgC-ahDhLnbYEYrSj7dbFRU0z7Do_D32XNqux2UhvXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 1:49 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/30/2013 11:45 AM, jonsmirl at gmail.com wrote:
>> On Tue, Jul 30, 2013 at 1:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 07/30/2013 11:29 AM, jonsmirl at gmail.com wrote:
>>>> On Tue, Jul 30, 2013 at 1:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>>>
>>>>> On 07/30/2013 07:14 AM, jonsmirl at gmail.com wrote:
>>>>>> On Tue, Jul 30, 2013 at 6:25 AM, Mark Brown <broonie@kernel.org> wrote:
>>>>>>> On Mon, Jul 29, 2013 at 08:30:29PM -0400, jonsmirl at gmail.com wrote:
>>>>>>>
>>>>>>>> This...
>>>>>>>> tx-dma-channel = <&pdma0 7>; /* preliminary */
>>>>>>>> rx-dma-channel = <&pdma0 6>; /* preliminary */
>>>>>>>
>>>>>>>> Probably should be
>>>>>>>> dmas = <&pdma0 7>,<&pdma0 6>;
>>>>>>>> dma-names = "tx", "rx";
>>>>>>>
>>>>>>> It should be - the latter is the generic DMA binding.  There's a lot of
>>>>>>> bindings in the kernel that predate that but people are currently
>>>>>>> working to transfer over, this is one of the examples of instability
>>>>>>> that everyone is talking about.
>>>>>>
>>>>>> Is something similar to this possible in device tree syntax?
>>>>>> dmas =  <"tx" &pdma0 7>,  <"rx"  &pdma0 6>;
>>>>>
>>>>> I /think/ you can physically write that in *.dts, or something very
>>>>> similar; with the strings outside the <>:
>>>>>
>>>>> dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;
>>>>>
>>>>> However, there's been strong push-back (i.e. doing that has not been
>>>>> allowed at all) on attempting to mix variable-length strings and
>>>>> fixed-length/alignment integer cells in the same property. This is
>>>>> primarily because you then can't ensure that the integer cell data is
>>>>> aligned in the DTB (dtc and/or the DTB format spec does/requires/allows
>>
>> The PowerPC FDT doc says that strings are indirected into a string
>> table. So they aren't variable length in the data structures.
>
> Do you have a link to the document; I'm not sure which one you mean.

So it looks like there is one indirection to get to the block, then
the strings are concatenated. The indirection must have been hidden
when the node structure was created.  I had thought that there was a
list of indirects each pointing to a string in the string block.

https://www.power.org/documentation/epapr-version-1-1/

8.5 Strings Block
The strings block contains strings representing all the property names
used in the tree. These null-
terminated strings are simply concatenated together in this section,
and referred to from the structure
block by an offset into the strings block.
The strings block has no alignment constraints and may appear at any
offset from the beginning of the
device tree blob.


>
>> I was wondering how dmas = "tx", "rx" was implemented. It is two
>> pointers into the indirect block. So this should work, there is no
>> variable length data to worry about in the structure.
>
> If you look at of_property_read_string_index() in drivers/of/base.c,
> you'll see that it expects the strings to just be packed together inline.
>
> What you say may be correct for node and property names, just not
> property values.



-- 
Jon Smirl
jonsmirl at gmail.com
