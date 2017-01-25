From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jan 2017 16:46:35 -0600
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <588914F3.7050909@gmail.com>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
 <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
 <20170119145642.GC27312@n2100.armlinux.org.uk>
 <20170119161441.jcctgig7np4v7sam@pengutronix.de> <588914F3.7050909@gmail.com>
Message-ID: <CAL_JsqL4+OZo0JTU8gnTEHxqNgNoBRnuHr1i99n72BKG30V9Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 3:13 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 01/19/17 08:14, Uwe Kleine-K?nig wrote:
>> On Thu, Jan 19, 2017 at 02:56:42PM +0000, Russell King - ARM Linux wrote:
>>> On Thu, Jan 19, 2017 at 03:46:41PM +0100, Uwe Kleine-K?nig wrote:
>>>> On Thu, Jan 19, 2017 at 12:35:40PM -0200, Fabio Estevam wrote:
>>>>> Hi Uwe,
>>>>>
>>>>> On Thu, Jan 19, 2017 at 12:13 PM, Uwe Kleine-K?nig
>>>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>>
>>>>>> Would it be nice to add a comment about why this was added? Something to
>>>>>> prevent a cleanup like "remove empty nodes and invalid memory
>>>>>> configurations".
>>>>>
>>>>> Do you mean something like this?
>>>>>
>>>>> /* "chosen" and "memory" nodes are mandatory */
>>>>> chosen {};
>>>>> memory { device_type = "memory"; reg = <0 0>; };
>>>>
>>>> Not very helpful comment. Something like:
>>>>
>>>>     /*
>>>>      * The decompressor relies on a pre-existing chosen node to be
>>>>      * available to insert the command line and merge other ATAGS
>>>>      * info.
>>>>      */
>>>>
>>>> Is it difficult to fix the decompressor?
>>>
>>> ... and that comment would be wrong.  Yes, the decompressor relies on it,
>>> as do some uboot versions.
>>
>> Good that we talked about this, otherwise I would have removed that once
>> the decompressor is fixed. So the comment must be
>>
>>       /*
>>        * The decompressor and also some versions of U-Boot rely on a
>>        * pre-existing /chosen node to be available to insert the
>>        * command line and merge other ATAGS info.
>>        * Also for U-Boot there must be a pre-existing /memory node.
>>        */
>>
>>>> I didn't understood the breakage regarding the memory node good enough
>>>> to suggest a comment for that.
>>>
>>> A missing memory node appears to prevent some uboot versions supplying
>>> any kind of memory layout to the kernel, which then causes the kernel to
>>> crash very early during boot.
>>>
>>> Again, this is not using appended DTB - this is using a separately loaded
>>> DTB in uboot.  uboot fails to update the dtb if these nodes are missing.
>>>
>>> Frankly, I think the original change (removing the skeleton.dtsi include)
>>> was misguided and needs to be reverted - the change is imho built upon an
>>> incorrect assumption that nothing in skeleton.dtsi is required.  That's
>>> clearly false.
>>
>> I tend to agree as I assume it's not only U-Boot on i.MX but on all ARM
>> platforms.
>>
>> Best regards
>> Uwe
>>
>
> Adding back the chosen nodes is a bandaid that papers over the actual bug
> in the decompressor.
>
> A comment about Fabio's attempt to fix the decompressor noted a possible
> issue with the method taken to fix the problem, but then the discussion
> of fixing the decompressor was dropped and v3 of the patch to add chosen
> into a bunch of .dtsi files was applied by Shawn.
>
> Can someone please help Fabio to create a correct patch to fix the
> decompressor?
>
> Note that the ePAPR v1.1 does require at least one memory node in

We have a DT spec now, let's stop pointing people to ePAPR.

> section 3.1, so the portion of v3 of the patch that adds a memory
> node is valid in terms of following the standard, not just a U-boot
> requirement.

I'd have no issue making chosen be required. Any platform with a
serial console should be setting stdout-path anyway. Just add it to
the spec. :) We should also add a dtc check as well if we do that.

Rob
