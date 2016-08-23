From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Aug 2016 11:39:06 +0200
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-gt90h
In-Reply-To: <20160823092614.GF2598@lukather>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
 <20160822183009.GX7104@lukather>
 <cf0186a0-f4ea-173c-4f93-df8798941199@redhat.com>
 <20160823092614.GF2598@lukather>
Message-ID: <a8de228d-2ba9-e23e-0c0c-e9a78dbe6e6a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23-08-16 11:26, Maxime Ripard wrote:
> On Mon, Aug 22, 2016 at 09:03:57PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 22-08-16 20:30, Maxime Ripard wrote:
>>> On Mon, Aug 08, 2016 at 09:43:14PM +0200, Hans de Goede wrote:
>>>> The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 8 ++++++++
>>>> 1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>>> index f27ebbb..da55b5a 100644
>>>> --- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>>> +++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>>> @@ -53,6 +53,14 @@
>>>> 	status = "okay";
>>>> };
>>>>
>>>> +&gsl1680 {
>>>> +	compatible = "silead,gsl3675";
>>>> +	touchscreen-fw-name = "silead/gsl3675-gt90h.fw";
>>>
>>> That's not documented anywhere, and looks really suspicious.
>>
>> Ugh, that should have been in:
>>
>> Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>
>> But somehow it is not (I believe it was there in earlier revisions of
>> the patch), I'll send a patch to fix this.
>>
>> About it being suspicious, this is not really firmware it is a bunch
>> of configuration data / lookup tables for the controller which tell
>> it in which order the touchscreen horizontal / vertical sensor
>> lines are connected to its sense pins, and what values to send
>> for finger x% between line z and line z+1, which differs per
>> tablet model, since not all tablets use the same digitizer.
>
> It's not really the firmware itself that I find suspicious, but more
> the encoding of a path to a file in the DT,

It is not a path it is a filename. We could drop the "silead/" prefix
and put that in the driver instead to really make it a filename.

> especially when you can
> apparently derive it from other informations already found in the DT
> (<vendor>/<compatible>-<board>.fw)

That will not work, sometimes different boards use the same digitizer
and thus the same firmware. Also in case of the q8 tablets, we need
different firmware for different variants (this is to be dealt with
by the q8-hardware-manager I'm working on), since although they
all use the same digitizer they do not wire it up to the controllers
pins the same in all models, so we need different firmware files
corresponding to different wirings.

TL;DR: There is no 1:1 mapping between board and the firmware filename.

Also note that this is not the first driver to introduce a firmware
filename in a dts binding, a quick grep shows at least:

Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt

Also does this, as well as several dt-bindings where board specific
firmware gets embedded in the device tree itself.

Regards,

Hans
