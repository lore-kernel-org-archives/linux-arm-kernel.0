From: agraf@suse.de (Alexander Graf)
Date: Thu, 14 Jul 2016 08:38:56 +0200
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <20160714010812.GA17138@e103986-lin>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
 <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
 <578668D3.6010406@suse.de> <20160714010812.GA17138@e103986-lin>
Message-ID: <837E6456-4718-45D7-8EE7-E28E11DB8BD3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 14 Jul 2016, at 03:08, Steve Capper <steve.capper@arm.com> wrote:
> 
> Hi Alex,
> 
> Thanks for posting this.
> 
> On Wed, Jul 13, 2016 at 06:14:11PM +0200, Alexander Graf wrote:
>> On 07/13/2016 05:59 PM, Ard Biesheuvel wrote:
>>> On 13 July 2016 at 17:42, Alexander Graf <agraf@suse.de> wrote:
>>>> Some user space applications are known to break with 48 bits virtual
>>> known by whom? At least I wasn't aware of it, so could you please
>>> share some examples?
>> 
>> Sure! Known to me so far are:
>> 
>>  * mozjs17
>>  * mozjs24
>>  * mozjs38
>>  * js-1.8.5
>>  * java-1.7 (older JITs, fixed in newer ones)
>> 
>> I'm not sure if there are more, but the fact that I've run into this
>> problem more than once doesn't make me incredibly happy :).
>> 
> 
> I came across this too: on bootup via polkitd (which pulled in mozJS) :-(.

Yup, that?s where I stumbled over it first. Gnome uses mozjs too, as do Firefox and Thunderbird obviously.

> 
>>> 
>>>> address space. As interim step until the world is healed and everyone
>>>> embraces correct code, this patch allows to only expose 47 bits of
>>>> virtual address space to user space.
>>>> 
>>> Is this a code generation/toolchain issue?
>> 
>> mozjs uses a single 64bit value to combine doubles, ints and
>> pointers into a single variable. It is very smart and uses the upper
>> 17 bits for metadata such as "which type of variable is this".
>> Coincidentally those bits happen to overlap the "double is an
>> infinite number" bits, so that you can also express a NaN with it.
>> When using such a value, the upper 17 bits get masked out.
>> 
>> That one was fixed upstream by force allocating the javascript heap
>> starting at a fixed location which is below 47 bits.
>> 
>> js-1.8.5 has the same as above, but also uses pointers to .rodata as
>> javascript pointers, so it doesn't only use the heap, it also uses
>> pointers to the library itself, which gets mapped high up the
>> address space. I don't have a solution for that one yet.
> 
> Is this Spidermonkey 1.8.5? I wasn't aware of this issue.

Exactly. If you?re interested in fixing it, be my guest :).

> 
>> 
>> IcedTea for java-1.7 had a bug where it incorrectly caused an
>> overflow when trying to calculating a relative adrp offset from
>> <address high up> to <address really low>, so that the resulting
>> pointer had the upper bits set as 1s. That one is long fixed
>> upstream, we only ran into it because we used an ancient IcedTea
>> snapshot.
> 
> I would recommend updating the sources used for OpenJDK anyway as there
> have been a few other stability and performance fixes put in over the
> last year to my knowledge.

Sure, that?s what we?ve done of course. I mostly mentioned it to answer the question where I had seen problems with 48 bits VA.

> 
>> 
>> My main concern however is with code that I do not know is broken today.
>> 
> 
> I think if we set the 47-bit VA we are just ignoring the fundamental
> problem and even allowing the problem to get worse (as future code may
> adopt unsafe pointer tagging); thus I agree with Mark Rutland's NAK.

Yeah, I?m torn on that one. I agree that we do allow broken code to work. However, going above 47 bits means we?re different from x86_64. And that *may* be a compatibility problem. Unfortunately we won?t know until at least a few hundred ISVs started to port their crufty user space code to ARM and things fell apart from time to time ;).

> Personally, I would only ever tag bits in the VA space that I control
> (i.e. at the bottom of the pointer if I enforce alignment).

Don?t blame the messenger :). For code that I write I tend to agree, but we?re talking about software that is a core dependency of other code (CouchDB uses Spidermonkey, polkit uses mozjs, etc) and that has been unmaintained for almost a decade by now, written in times when 47 bits of VA was more than the contents of the whole internet ;).


Alex
