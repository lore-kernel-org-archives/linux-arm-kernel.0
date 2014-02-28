From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Feb 2014 09:34:33 -0700
Subject: [PATCH V2 1/3] dt: palmas: support IRQ inversion at the board
 level
In-Reply-To: <20140228055818.GA29849@sirena.org.uk>
References: <1393534281-30759-1-git-send-email-swarren@wwwdotorg.org>
 <20140227210227.GE2931@xora-haswell> <530FAFAE.5050800@wwwdotorg.org>
 <20140228055818.GA29849@sirena.org.uk>
Message-ID: <5310BA99.4050203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2014 10:58 PM, Mark Brown wrote:
> On Thu, Feb 27, 2014 at 02:35:42PM -0700, Stephen Warren wrote:
>> On 02/27/2014 02:02 PM, Graeme Gregory wrote:
> 
>>>> +- ti,irq-externally-inverted : If missing, the polarity of the Palmas IRQ
>>>> +  output should be set to the opposite of the polarity indicated by the IRQ
>>>> +  specifier in the interrupts property. If absent, the polarity should be
>>>> +  configured to match. This allows the representation of an inverter between
>>>> +  the Palmas IRQ output and the interrupt parent's IRQ input.
> 
>>> This has got to be the wrong way to do things, all this leads to is every
>>> device doing this property in its own way and having totally inconsistent
>>> properties all meaning the same thing.
> 
>>> If there is some other hardware inverting lines then there should be
>>> a generic binding for this in DT. This is not describing the palmas hardware
>>> but some external object to the palmas.
> 
>> I'd be fine with removing the "ti," vendor prefix from the property
>> name, and promoting it to be a cross-device standard.
> 
>> I'm not sure that many devices will need this though; most don't have
>> configurable output polarity. Still, I guess that shouldn't stop us from
>> creating standards for the cases where it is needed.
> 
> It's really common for PMICs and CODECs to be able to set any interrupt
> polarity at least.
> 
>> If the DT reviewers can ack the concept, I'm happy to respin the patch
>> with the more generic property name.
> 
> I'm not sure that renaming the property really deals with the concerns
> though since drivers still all need to manually add support for this,
> shouldn't there be an interrupt controller described in the DT which
> just chains on to the parent with the polarity inverted to do the
> impedence match?

I had thought of that when first dealing with this a couple years ago,
but Olof suggested that was too complicated.

Certainly, adding an "inverting" interrupt controller into the path
would solve the problem without inventing any new concept in DT.
However, the inverter really isn't an interrupt controller in any
meaningful fashion. It has no status/mask/enable/... registers at all;
it's nothing more than an inverter gate, at least in my case. Hence, I'm
actually not convinced that adding an extra interrupt controller into
the path is correct here.

Another alternative might be to add an extra IRQ bit in the IRQ
specifier (and something similar would be needed for GPIO specifiers)
that indicates "inversion between source and destination". This could be
queried by drivers in exactly the same way as the existing polarity/type
IRQ flags. We'd need to update each individual IRQ controller binding to
enable that flag, since each binding defines its own definition of such
flags. (although in practice since most use the same centrally suggested
flags, this wouldn't be any more than just saying yes, this binding
allows that new flag to be used).
