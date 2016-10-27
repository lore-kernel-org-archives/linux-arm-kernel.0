From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Oct 2016 23:10:28 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <9B288597-7812-459D-A5C7-B61107751DA6@konsulko.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <9B288597-7812-459D-A5C7-B61107751DA6@konsulko.com>
Message-ID: <d7e6ae76-4ac8-4ad4-a72d-99a58654ba9c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-10-16 17:52, Pantelis Antoniou wrote:
> Hi Hans,

<snip>

>> Right, so again I think we need to split the discussion in 2 steps:
>>
>> 1) How do we apply the fixups, currently I'm using free-form changes
>> done from C-code. I can envision moving to something like the quirk
>> mechanism suggested by Pantelis in the past. Note this is not a perfect
>> fit for my rather corner-case use-case, but I can understand that in
>> general you want the variants to be described in dt, and activated
>> in some way, rather then have c-code make free-form changes to the dt
>>
>
> We?ve had this discussion before, so I guess here it goes again.
>
> I think the biggest objection is the programmatic way of applying
> every quirk by ?hand?.
>
> If there was a way to keep the probing mechanism but just spit out
> a ?model? number we could reasonably map it to an overlay to apply
> with a generic overlay manager.
>
> From an internal s/w standpoint having an expansion board or soldered
> parts makes no difference.

I disagree, with soldered parts it often is the board has
one of "accelerometer a", "b" or "c", where in the simple case
my suggested i2c-probe-stop-at-first-match property will
just work for a new board by creating a new dtb without needing any
kernel changes, where as your suggested model-string generator
C-code module would need updating.

I think that there is a need for both really.

>> 2) How do we select which fixups to apply. Again I can understand
>> you wanting some well defined mechanism for this, but again my
>> use-case is special and simply does not allow for this as there
>> is no id-eeprom to read or some such.
>>
>
> Yes there is no EEPROM but you might be able to map probing results to
> a fake ?model? number.
>
> Let me expand a bit:
>
> Assume that you have a number of probing steps, for example A, B, C each
> returning true or false, and C being executed only when B is ?true? you
> could do this to generate a bit field that identifies it.
>
> For example let?s assume that model FOO?s probing steps are
>
> A false, B true, C false -> 010
>
> Model?s BAR
>
> A true, B false, C don?t care -> 10x
>
> Mapping these to models could be
>
> Model FOO, (010 & 111) == 010 (all three probing steps must match)
>
> Model BAR, (10x & 110) = 100 (the first two probing steps must match)

Interesting this is actually the same direction my thoughts on this
lead me in my reply in the other thread on this started by
Antoine Tenart.

Only difference is that I suggested putting the model-string
generation in the bootloader, so it will just be there when the kernel
boots. But I agree that given things like upgradability having
the model-string generation code in the kernel is better.

<snip>

Regards,

Hans
