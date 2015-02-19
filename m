From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 19 Feb 2015 08:51:16 -0800
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <54E61200.4010002@gmail.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <54E54586.5070602@gmail.com>
 <23825C6A-7FF1-4D06-8802-F6964F71B97C@konsulko.com>
 <54E61200.4010002@gmail.com>
Message-ID: <54E61484.1060209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/2015 8:40 AM, Frank Rowand wrote:
> On 2/19/2015 6:41 AM, Pantelis Antoniou wrote:
>> Hi Frank,
>>
>>> On Feb 19, 2015, at 04:08 , Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 2/18/2015 6:59 AM, Pantelis Antoniou wrote:
>>>> Implement a method of applying DT quirks early in the boot sequence.
>>>>
>>>> A DT quirk is a subtree of the boot DT that can be applied to
>>>> a target in the base DT resulting in a modification of the live
>>>> tree. The format of the quirk nodes is that of a device tree overlay.
>>>
>>> The use of the word "quirk" is a different mental model for me than what
>>> this patch series appears to be addressing.  I would suggest totally
>>> removing the word "quirk" from this proposal to avoid confusing the
>>> mental models of future generations of kernel folks.
>>>
>>
>> Naming things is hard to do. Suggestions?
> 
> You are inviting me to bikeshed.  I'll leave that to you.
> 
>>
>>> What this patch series seems to be proposing is a method to apply DT
>>> overlays as soon as unflatten_device_tree() completes.  In other words,
>>> making the device tree a dynamic object, that is partially defined by
>>> the kernel during boot.  Well, to be fair, the kernel chooses among
>>> several possible alternatives encoded in the DT blob.  So the device
>>> tree is no longer a static object that describes the hardware of the
>>> system.  It may not sound like a big deal, but it seems to me to be
>>> a fundamental shift in what the device tree blob is.  Something that
>>> should be thought about carefully and not just applied as a patch to
>>> solve a point problem.
>>>
>>
>> There is a fundamental shift going on about what hardware is. It is nowhere
>> as static as it used to be. It is time for the kernel to keep up.
> 
> Run time overlays do that.
> 
> The problem you seem to be dealing with here is that you want a single
> DT blob that can be installed on many different _physical_ boards.
> 
> 
>>
>>> The stated use of this proposal is to create dynamic DT blobs that can
>>> describe many similar variants of a given system instead of creating
>>> unique DT blobs for each different system.
>>>
>>
>> Yes.
>>
>>> I obviously have not thought through the architectural implications yet,
>>> but just a quick example.  One of the issues we have been trying to fix
>>> is device tree validation.  The not yet existent (except as a few proof
>>> of concept attempts) validator would need to validate a device tree
>>> for each dynamic variant.  Probably not a big deal, but an example of
>>> the ripple effects this conceptual change implies.
>>>
>>
>> I don?t see what the big problem with the validator is. The ?quirk?
>> are easily identified by the presence of the __overlay__ nodes and
>> the validator can apply each overlay and perform the validation check 
>> at each resultant tree.
> 
> I said "not a big deal".  I was trying to make people think about the
> bigger picture.  Defending that this is a non-issue for the validator
> is totally missing my point.  Step back and think architecturally
> about the big picture.  I do _not_ know if this is a problem, but
> they will be ripples from this proposal.

oops:  there will be ripples from this proposal.

> 
>>  
>>> A second function that this patch is proposing is a method to enable
>>> or disable devices via command line options.  If I understand
>>> correctly, this is meant to solve a problem with run time overlays
>>> that require disabling a device previously enabled by the DT blob.
>>> If so, it seems like it could easily be implemented in a simpler
>>> generic way than in the board specific code in this patch series.
>>>
>>
>> Disabling a device is the most common case, but other options are desired
>> too. For instance changing OPPs by a command line option, etc.
> 
> The device tree is supposed to describe what the hardware is.  Why would
> you want a command line option to change what OPPs are possible for the
> hardware?
> 
>>
>>> I share the concerns that Mark Rutland has expressed in his comments
>>> about this series.
>>>
>>> < snip >
>>>
>>> I have read through the patches and will have comments on the code
>>> later if this proposal is seen as a good idea.
>>>
>>
>> OK
>>
>>> -Frank
>>
>> Regards
>>
>> ? Pantelis
>>
>>
> 
