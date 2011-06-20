From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 20 Jun 2011 19:39:34 +0200
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106201306210.2142@xanadu.home>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1106201306210.2142@xanadu.home>
Message-ID: <4DFF85D6.1090104@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.06.2011 19:10, schrieb Nicolas Pitre:
> On Mon, 20 Jun 2011, Alan Stern wrote:
>
>> On Mon, 20 Jun 2011, Nicolas Pitre wrote:
>>
>>> On Mon, 20 Jun 2011, Alan Stern wrote:
>>>
>>>> On Sun, 19 Jun 2011, Nicolas Pitre wrote:
>>>>
>>>>>>> The question is: does the structure really has to be packed?
>>>>>>
>>>>>> What do you mean?  The structure really does need to be allocated
>>>>>> without padding between the fields; is that the same thing?  So do a
>>>>>> bunch of other structures that currently have no annotations at all.
>>>>>
>>>>> Yes, that's the same thing.  The packed attribute tells the compiler
>>>>> that you don't want it to insert padding in it as it sees fit.
>>>>
>>>> I thought the packed attribute does more than that.  For example, on
>>>> some architectures doesn't it also force the compiler to use
>>>> byte-oriented instructions for accessing the structure's fields?
>>>
>>> Yes, but that's a consequence of not being able to access those fields
>>> in their naturally aligned position anymore.  Hence the addition of the
>>> align attribute to tell the compiler that we know that the structure is
>>> still aligned to a certain degree letting the compiler to avoid
>>> byte-oriented instructions when possible.
>>
>> Not exactly.  As far as I can tell, the ((packed)) attribute caused the
>> compiler to change the structure's alignment from its natural value to
>> 1.  That's why the fields weren't in their naturally aligned positions
>> and why removing ((packed)) fixed the problem.
>
> Are we talking past each other?
>
> Remember that I was the one asking if the align attribute was needed in
> the first place.  If it is not then by all means please get rid of it!
>
> But if it _is_ needed, then the generated code can be much better if the
> packed attribute is _also_ followed by the align attribute to
> increase it from 1.

That reminds me of some time where I had fun asking someone with deeper 
ppc- and xlC-knowledge than I, if he is sure that assignments, are 
atomic. He always said yes. Got something like a running gag. ;)

I see it that way: packed is needed to be sure that at least for struct 
ehci_regs there are no padding bytes inbetween the members. It might 
work without, but that depends on the compiler (-version, architecture, 
whatever).

That packed without an additional aligned() caused errors on ARM with 
gcc 4.6 is another problem which got (currently) fixed by removing packed.
But this introduces imho doubts and uncertainty about if padding bytes 
could be between the members, therefore I would prefer to use packed 
with aligned instead of removing the packed.

Regards,

Alexander
