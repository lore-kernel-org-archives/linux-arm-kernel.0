From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 04 Feb 2014 11:14:44 +0100
Subject: [PATCH v2 2/5] clk: sunxi: Add USB clock register defintions
In-Reply-To: <20140204094051.GL25625@lukather>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
 <1390426587-16287-3-git-send-email-hdegoede@redhat.com>
 <20140127144349.GJ3867@lukather> <52E67316.5020906@redhat.com>
 <20140128094427.GZ3867@lukather> <52E77FCD.5050701@redhat.com>
 <20140204094051.GL25625@lukather>
Message-ID: <52F0BD94.1060601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 02/04/2014 10:40 AM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Tue, Jan 28, 2014 at 11:00:45AM +0100, Hans de Goede wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Hi,
>> 
>> On 01/28/2014 10:44 AM, Maxime Ripard wrote:
>>> On Mon, Jan 27, 2014 at 03:54:14PM +0100, Hans de Goede wrote:
>>>>>> "allwinner,sun5i-a13-usb-gates-clk" - for usb gates + resets on A13
>>>>> 
>>>>> Maybe we can just remove the gates from there? Even though they are gates, they are also (a bit) more than that.
>>>> 
>>>> To be clear you mean s/usb-gates-clk/usb-clk/ right ?
>>> 
>>> Yep, exactly
>>> 
>>>>> I guess that means that we will have the OHCI0 gate declared with <&...-gates-clk 6>, while it's actually the first gate for this clock?
>>>> 
>>>> Correct.
>>>> 
>>>>> Maybe introducing an offset field in the gates_data would be a good idea, so that we always start from indexing the gates from 0 in the DT?
>>>> 
>>>> Well for the other "gates" type clks we also have holes in the range, and we always refer to the clk with the bit number in the reg as the clock-cell value.
>>> 
>>> Yes, we have holes, but I see two majors differences here: - the other gates are just gates, while the usb clocks are a bit more than that.
>> 
>> The usb-clk registers contain more then that, but the bits we are talking about now are gates.
>> 
>>> - the other gates' gating bits thus all start at bit 0, while - here, since it's kind of a "mixed" clock, the gating bits start - at bit 6 (on the A20 at least)
>> 
>> Right, still I believe that the consistent thing to do is keeping the bit-number for the bit in the register controlling the gate as the specifier.  When adding new dts entries / reviewing existing ones I'm used to matching the specifier to the bit-nr in the data-sheet, I think making things different just for this one register is counter productive.
> 
> And if you turn it the other way around, it would be inconsistent that all gates indices start at 0, and we would start at 6 here :)

I think the problem here is that you see the specifier part of the clk
phandle as an index, which it is not. All devicetree docs / code talks
about specifiers or arguments not indexes. Once you stop seeing this as
an index, you will hopefully also stop insisting this needs to
start at 0 :)

Also note that it already is not an index for existing sunxi clks which have
cells != 0, as there are holes in the bits used in the gates registers and
calling the specifier an index suggest we're dealing with an array, and
arrays never have holes.

The clk specifier as currently used in sunxi clks is a 1:1 mapping of the
gate register bit numbers, as is clearly documented in ie:
Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt
Where the datasheet is referenced as the source for (most) of the values
to put in the specifier.

My biggest objection is that this would loose 1:1 mapping we currently
have between the specifier and bit-nr in the register, which really is
convenient when writing new dts bindings.

When we add an offset users will need to first lookup which clk they need in
the datasheet and then look at both the dts bindings doc to find how this is
mapped to the specifier. In my experience such an extra level of indirection
in documentation is a PITA, and all that just so that some random number
(it is not an index!) can start at 0 ?

To me adding an offset here and making the clk gates different form all
our other clock gates just feels wrong.

Regards,

Hans
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLwvZMACgkQF3VEtJrzE/sz0gCfQNwhM/RpimtbhumvKKQ4a4V+
Vo4AoLTNKRZXlPC84hi1JInPGYvZIxuR
=dA68
-----END PGP SIGNATURE-----
