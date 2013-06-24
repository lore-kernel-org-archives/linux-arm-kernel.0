From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Jun 2013 17:27:53 -0600
Subject: [PATCH v1 10/12] input: keypad_matrix: use usleep_range() for
 scan delay
In-Reply-To: <20130622101739.GI24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-11-git-send-email-gsi@denx.de>
 <51C4CCF3.20603@wwwdotorg.org>
 <20130622101739.GI24305@book.gsilab.sittig.org>
Message-ID: <51C8D5F9.7040603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2013 04:17 AM, Gerhard Sittig wrote:
> On Fri, Jun 21, 2013 at 16:00 -0600, Stephen Warren wrote:
>>
>> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
>>> querying keyboards isn't a time critical task and does not depend on
>>> exact timing in the microseconds order -- the timeouts and delays are
>>> arbitrary choices or educated guesses at best anyway
>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>>
>>> @@ -93,7 +93,10 @@ Optional Properties:
>>>  			a column line and reading back its row status,
>>>  			such that pin levels can settle after
>>>  			propagating through the matrix and its
>>> -			associated hardware components
>>> +			associated hardware components, can be specified
>>> +			with either one value giving the exact delay, or
>>> +			with two values giving a delay range (allowing
>>> +			for reduced timer management overhead)
>>>  - col-switch-delay-ms:	columns switch interval in milliseconds instead
>>>  			of using interrupts to detect key press changes,
>>>  			enables polling mode when specified
>>> @@ -146,7 +149,7 @@ Examples:
>>>  	matrix_keypad {
>>>  		compatible = "gpio-matrix-keypad";
>>>  		debounce-delay-ms = <5>;
>>> -		col-scan-delay-us = <1>;
>>> +		col-scan-delay-us = <2 10>;
>>
>> Is it really useful to change the binding this way?
>>
>> The values in DT presumably represent the minimum delays that the HW
>> will tolerate or that are useful. SW is always free to scan more slowly
>> than that. As such, if you're simply modifying the driver to allow more
>> flexibility in timing, then I don't think you have to modify the DT
>> binding to allow for this?
> 
> Yes, this puts less burdon on the .dts author.  The "problem"
> would be to come up (programmatically, without the user's spec)
> with an appropriate upper bound.
> 
> One might choose "half the col switch delay" when available (in
> the polling scenario).  Or "three times the lower bound".  Or an
> arbitrary upper bound in the 100us order.  Or actually with the
> minimum of all the above.  That should keep the absolute minimum
> (user specified) in the loop, and scan the keys fast enough, yet
> drastically reduce timer management overhead, and hide all of
> this from the .dts author.
> 
> I will ponder this for a moment ...

Shouldn't this be driven by whatever key repeat delays the user
configured in SW; scan only fast enough to implement the correct repeat
delay/rate?
