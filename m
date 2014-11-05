From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 5 Nov 2014 17:19:30 +0100
Subject: [PATCH v2 1/4] of: Rename "poweroff-source" property to
 "system-power-controller"
In-Reply-To: <20141105100827.GP31358@localhost>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
 <1414568135-8311-2-git-send-email-romain.perier@gmail.com>
 <20141105100827.GP31358@localhost>
Message-ID: <CABgxDoJ4CCjvtFxPFu+wBAWDNNJufsRqaDihMVdPkF1ckGZJwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-05 11:08 GMT+01:00 Johan Hovold <johan@kernel.org>:
> [ Resend with lkml, arm, Felipe on CC -- why were these dropped from CC? ]
>
> On Wed, Oct 29, 2014 at 07:35:32AM +0000, Romain Perier wrote:
>> As discussed on the mailing list, it makes more sense to rename this property
>> to "system-power-controller".
>
> Please also refer to the commit in the regulator tree renaming it to
> "poweroff-source", and that this in effect is a revert to the old name
> but without the vendor prefix.

Ok

>
>> Problem being that the word "source" usually tends
>> to be used for inputs and that is out of control of the OS. The poweroff
>> capability is an output which simply turns the system-power off. Also, this
>> property might be used by drivers which power-off the system and power back on
>> subsequent RTC alarms. This seems to suggest to remove "poweroff" from the
>> property name and to choose "system-power-controller" as the more generic name.
>> This patchs adds the required renaming changes and defines an helper function
>> which is compatible with both properties, the old one prefixed by a vendor name
>> and the new one without any prefix.
>>
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>
> First of all, always run your patches through checkpatch.pl before
> submitting. There's a few warnings there for you to fix.

Ok, noted.

>
> I think this is the wrong approach. This way any driver will recognise
> the old deprecated vendor prefixes. But not only those -- also
> misspelled vendor prefixes.
>
> Keep it simple and only parse the new property name (inline in the
> header file).
>
> If we need to support the old property names with vendor prefix (we have
> dropped vendor prefixes in the past), then you could add a second helper
>
>         of_is_system_power_controller_compat(np, compat_propname)
>
> where you pass in the whole old property name (e.g.
> "ti,system-power-controller") and use that name as a fall back.
>
> This way it will be clear which drivers are still supporting the
> deprecated property names, and we can make sure that no new ones will.
>

I just want to be sure, do we need to keep backward compatibility or
not ? Previous series did not contain backward compatibility and it
was like "The Nursery Chainsaw Massacre" and created a lot of drama...
People's opinion are welcome.
