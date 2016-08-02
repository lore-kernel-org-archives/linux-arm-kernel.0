From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 2 Aug 2016 10:19:56 +0200
Subject: [PATCH 1/4] input: touchscreen: Add generic touchscreen
 softbutton handling code
In-Reply-To: <20160801165430.GA30345@rob-hp-laptop>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
 <1469978590-14081-2-git-send-email-hdegoede@redhat.com>
 <20160801165430.GA30345@rob-hp-laptop>
Message-ID: <88d3607c-1610-a5b3-2824-b96a28dfe6f3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01-08-16 18:54, Rob Herring wrote:
> On Sun, Jul 31, 2016 at 05:23:07PM +0200, Hans de Goede wrote:
>> Some touchscreens extend over the display they cover and have a number
>> of capacative softbuttons outside of the display the cover.
>>
>> With some hardware these softbuttons simply report touches with
>> coordinates outside of the normal coordinate space for touches on the
>> display.
>>
>> This commit adds a devicetree binding for describing such buttons in
>> devicetree and a bunch of helper functions to easily add support for
>> these to existing touchscreen drivers.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../bindings/input/touchscreen/softbuttons.txt     |  58 +++++++++
>>  drivers/input/touchscreen/Makefile                 |   2 +-
>>  drivers/input/touchscreen/softbuttons.c            | 145 +++++++++++++++++++++
>>  include/linux/input/touchscreen.h                  |   9 ++
>>  4 files changed, 213 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>>  create mode 100644 drivers/input/touchscreen/softbuttons.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>> new file mode 100644
>> index 0000000..3eb6f4c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>> @@ -0,0 +1,58 @@
>> +General Touchscreen Softbutton Properties:
>> +
>> +Some touchscreens extend over the display they cover and have a number
>> +of capacative softbuttons outside of the display the cover.
>> +
>> +Some of these softbuttons simply report touches with coordinates outside of
>> +the normal coordinate space for touches on the display. This binding is for
>> +describing such buttons in devicetree.
>> +
>> +Each softkey is represented as a sub-node of the touchscreen node.
>> +
>> +Required subnode-properties:
>> + - label			: Descriptive name of the key.
>> + - linux,code			: Keycode to emit.
>> + - softbutton-min-x		: X start of the area the softbutton area covers
>> + - softbutton-max-x		: X end of the area the softbutton area covers
>> + - softbutton-min-y		: Y start of the area the softbutton area covers
>> + - softbutton-max-y		: Y end of the area the softbutton area covers
>
> This generally looks fine to me, but I am wondering one thing. If the
> buttons are located at the origin of an axis, can we handle that case? I
> don't think you can unless you assume softbutton-max-? is 0 for the
> touchscreen. To put it another way, you have a gap from 1024 to 1084
> which you can't express for buttons at the origin unless you do negative
> numbers.

Actually for the touchscreen I'm working on:

https://content.hwigroup.net/images/products_xl/157078/dserve-dsrv-9703c.jpg

The buttons are past the display edge which corresponds to x coordinate 0,
so they should logically send negative coordinates but the "firmware" (which
I believe is more config / calibration data) maps them to coordinates above
1024, so logically across the other edge. But I can envision some other
hardware doing this differently. I suggest we deal with this when we need too,
likely we just need to add a note that the dt min/max values should be interpreted
as a s32 rather then an u32, I can do that now if you want.

Regards,

Hans




>
> Rob
>
