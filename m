From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 16:18:59 +0200
Subject: [PATCH v2 6/6] ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33 and
 1024x600 lcd support
In-Reply-To: <20150613135002.GP19653@lukather>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-7-git-send-email-hdegoede@redhat.com>
 <20150602081459.GO23777@lukather> <556D6955.8030708@redhat.com>
 <20150603094535.GI23777@lukather> <556EE104.3090803@redhat.com>
 <20150613135002.GP19653@lukather>
Message-ID: <557C3BD3.6030105@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13-06-15 15:50, Maxime Ripard wrote:
> Hi,
>
> Sorry for the late reply.
>
> On Wed, Jun 03, 2015 at 01:12:04PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 03-06-15 11:45, Maxime Ripard wrote:
>>> On Tue, Jun 02, 2015 at 10:29:09AM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 02-06-15 10:14, Maxime Ripard wrote:
>>>>> On Sat, May 30, 2015 at 04:55:06PM +0200, Hans de Goede wrote:
>>>>>> The Ippo-q8h is a tablet circuit board commonly found in cheap Android
>>>>>> tablets. The v1.2 version can be used with either an A23 or A33 SoC.
>>>>>>
>>>>>> This adds a dts file for the v1.2 board with an A33 SoC and a 1024x600
>>>>>> LCD screen (most of these tablets have a 800x480 screen).
>>>>>
>>>>> I think the difference between the resolution here is more of a case
>>>>> for the DT quirks interface:
>>>>> https://lkml.org/lkml/2015/2/18/258
>>>>
>>>> I would expect the only difference between the 2 dts files to be the
>>>> node describing the lcd panel, so yes that makes somewhat sense.
>>>>
>>>>> Do you know if there's some way to autodetect the two board versions
>>>>> (like a board id somewhere in an EEPROM)?
>>>>
>>>> No, AFAIK there is no way to tell the difference. There is no eeprom no
>>>> the board, and we really cannot rely on the nand contents.
>>>
>>> Ok.
>>>
>>>>> If not, then maybe u-boot can simply add that board compatible to the
>>>>> list, and we'll base our logic on that when we'll need it.
>>>>
>>>> That means extra logic in u-boot, and on the kernel side, for what
>>>> benefit exactly? Such logic would make sense if there was one u-boot
>>>> image which runtime adjusted itself, but that is not an option.
>>>
>>> For what benefit? One kernel image which runtime adjusts itself.
>>
>> You mean one dtb right, because the kernel itself already runtime
>> adjusts itself.
>
> Well, the kernel will runtime adjust the DT, so, both, I'd say?
>
>>> It's especially possible if u-boot's image is not, which seems to be what
>>> you're saying.
>>
>> But we will still need different configs in u-boot, and we need
>> to add code + config to u-boot to plug in the extra compatibles
>> to automatically select the right built-in overlays.
>
> You're going to have a different config anyway, but yeah, that's true.
>
>>>> And we can avoid copy and paste on the dts side by putting all
>>>> the common stuff in a common file and including that, I believe
>>>> that that is better (KISS = better) since we've no way to runtime
>>>> do the right thing AFAICT.
>>>
>>> My concern is about the ever-growing number of DTS that just are small
>>> variations of one or the other. What about the time when we'll
>>> discover that this board has a variant that has an emmc, and some that
>>> don't have any button, or the i2c bus 2 not wired, and one other that
>>> doesn't have any HDMI?
>>>
>>> Do we really want to have a dts called
>>> sun8i-a33-q8h-emmc-lcd800x600-nohdmi-noi2c2-nobuttons.dts?
>>>
>>> Especially when we will have the one that we include here that will
>>> not have followed this convention because it was introduced before
>>> that, and that we have a way to deal with this nicely?
>>>
>>> You chose to consider the DTS names an ABI, the best way to handle
>>> this is to have a DTS as generic as possible, and leave all these
>>> small variations outside of the name.
>>
>> Ok, so for now this is not really an issue at all since the dts
>> does not yet decribe the lcd at all. So can you merge this one
>> renamed to a more generic name for 4.2?
>>
>> That will work fine for now.
>>
>> Then we can use the DT quirks interface to add different lcd
>> nodes for different variants once we get lcd support in the kernel,
>> and teach u-boot to add the extra board compatible to select
>> the right lcd node at that time.
>
> I think we need to discuss this with Pantelis and what is his feeling
> about this.

Ok.

> Pantelis, to sum things up, we have a case of a tablet that comes with
> the exact same board, but coming in two flavours with two differents
> screen resolutions. It looks like a great case for your DT quirks
> work, but we have no way of runtime detecting the difference between
> the two variants. What do you think about this? Should we go with
> using the DT quirks or is this simply out of scope?
>
> There's not so much example of similar cases in the kernel, and none
> of them use quirks so far (obviously) but they all boil down to either
> the solution you were suggesting in that patch or adding the alternate
> configuration as a comment.
>
> I don't think the latter would work for you, and I agree with that, so
> I guess that depending on what Pantelis says, either we go with a
> better solution using the quirks, or we end up using what you
> suggested (with a nitpick though, I'd prefer if you used the display
> standard instead of the resolution, which would make it xga I guess?)

If we go with a separate dts file for each of the 800x480 and 1024x600
screens, I would greatly prefer to stick with the lcd1024x600 in the dts
filename instead of using something like xga, the fact that you say:
"I guess" that my answer to that is: I dunno I would need to look this
up in wikipedia or some such makes me think that using a qualifier like
xga is not going the help end users decide which dts file to pick, it
will just lead to them needing to go to wikipedia too. Also note that
the advertising of these tablets on ebay / aliexpress almost always
uses the resolution and not something like "xga".

So all in all if we do not decide to use quirks for this I would like
to keep the filename as is.

Regards,

Hans






>
> Maxime
>
