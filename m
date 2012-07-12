From: sjg@chromium.org (Simon Glass)
Date: Thu, 12 Jul 2012 07:27:50 +0200
Subject: [PATCH 1/1] of: introduce helper to manage boolean
In-Reply-To: <4FFCB6A2.50805@freescale.com>
References: <1328588028-24766-1-git-send-email-plagnioj@jcrosoft.com>
 <20120309014441.8236B3E0903@localhost>
 <20120309100435.GN27213@game.jcrosoft.org>
 <20120309162638.92E813E0880@localhost>
 <20120309163608.GQ27213@game.jcrosoft.org>
 <4F5E50DA.6080000@freescale.com>
 <20120313031739.GA18320@game.jcrosoft.org>
 <20120313041652.563B63E0536@localhost>
 <CAPnjgZ2dj5pcuGhM2_2nwwnhhcCmKhyi6jVHS7Xf1f682i_j_w@mail.gmail.com>
 <4FFC9D46.6090006@freescale.com>
 <CAPnjgZ1D0hCZobFENTPN8Vkz04x5bXa9RviJuVcgBt66BL961Q@mail.gmail.com>
 <4FFCB6A2.50805@freescale.com>
Message-ID: <CAPnjgZ1fTVfhhBbEYjtwVxVZ9xYmLwyAkMPAiGJ7P-2odV16rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On Wed, Jul 11, 2012 at 1:11 AM, Scott Wood <scottwood@freescale.com> wrote:
> On 07/10/2012 05:53 PM, Simon Glass wrote:
>> Hi Scott,
>>
>> On Tue, Jul 10, 2012 at 11:23 PM, Scott Wood <scottwood@freescale.com
>> <mailto:scottwood@freescale.com>> wrote:
>>
>>     Also note that even non-boolean properties can mean something different
>>     when absent.  Sometimes this is a default value; sometimes, like with
>>     "ranges", it's something that can't be expressed with any value (empty
>>     ranges means all translations go straight through; no ranges means no
>>     translation is possible).
>>
>>
>> That's fine, but I'm not sure I understand why that relates to boolean
>> properties, which currently mean always the same thing (false) when
>> absent. I don't think there is any intent to change that.
>
> The point was this isn't the only scenario where the absence of a
> property means something, and where you might want to delete the property.

OK I see. We don't have that option for booleans, since absence will
always mean false.

>
>>     > I think it is useful to
>>     > support a boolean with a non-null value which can be 0, meaning
>>     true as
>>     > Jean-Christophe says.
>>     >
>>     > My reasons are:
>>     >
>>     > 1. dtc does not have a way to delete a property and it isn't clear
>>     what
>>     > syntax could be used there.
>>
>>     Surely some syntax can be created for this.  E.g. /delete-prop/ foo;
>>
>>
>> Yes, in fact I saw a patch after sending this email. So for normal
>> values to change the value we do
>>
>>    prop = <23>;
>>
>> but for booleans we must do EITHER:
>>
>>    bool;
>>
>> or
>>
>>    /delete-prop/ bool;
>>
>> depending on whether we want the make it true or false? Ick.
>
> Doesn't seem that bad to me except in the case you show below where
> you're trying to do it programmatically.
>
>> It seems worse to me, see above. Also if we end up with symbols it will
> *> be impossible to do something like:
>>
>>    bool-property = <WIBBLE_VALUE>;
>>
>> You will have to do:
>>
>> if WIBBLE_VALUE == 0
>>   /delete-prop/ bool-property;
>> #else
>>   bool-property;
>> #endif
>>
>> or whatever, or maybe I got that around the wrong way.... Not nice IMO.
>
> Yeah, that's unpleasant.
>
> I don't hugely object to a new boolean type for use in new bindings,
> where <0> or absence can both be used to indicate false, as long as it's
> clearly documented.  I'm hesitant to start doing this on existing
> bindings, though, and in any case would like to see support for
> property/node deletion in dtc.

Fair enough. Jean-Christophe's patch certainly changes existing
behaviour, and without that it might be confusing - we don't want two
functions for reading boolean properties. The only plus is that
(perhaps) no one expects "bool-prop = <0>" to mean true, so it might
be safe.

>
>> (any comments on point 2?)
>
> It's basically the same as the above, right?

Yes, and you commented above.

>
>>     > 3. Discoverability: it is nice to be able to see the possible options,
>>     > even if disabled.
>>
>>     This assumes the possible options were known in advance, or that you
>>     don't maintain compatibility with old device trees when a new option is
>>     added.
>>
>>
>> You can still add the option with a zero value - or maybe I
>> misunderstand what you mean.
>
> We normally want to work with existing device trees (which could be
> partially produced by firmware, so changing can be unpleasant), so the
> absence of the property is still going to be a possibility.  Plus
> enumerating every possibility, no matter how rarely used, in every node
> of a certain type seems excessively verbose.  It's not like these are
> user configuration knobs.

Yes agreed. The point of this is just to make it easier (I think) to
make a boolean value false either in the source, or later using
fdtput.

So what do we need to do? Take a vote? Revisit Jean-Christophe's patch?

>
> -Scott
>

Regards,
Simon
