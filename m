From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 27 Aug 2016 10:32:16 +0200
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-gt90h
In-Reply-To: <20160826204637.GC3165@lukather>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
 <20160822183009.GX7104@lukather>
 <cf0186a0-f4ea-173c-4f93-df8798941199@redhat.com>
 <20160823092614.GF2598@lukather>
 <a8de228d-2ba9-e23e-0c0c-e9a78dbe6e6a@redhat.com>
 <20160823151738.GM2598@lukather>
 <8541f3c3-c83b-bd20-42cf-03fdfb3a33d9@redhat.com>
 <20160826204637.GC3165@lukather>
Message-ID: <913fab6d-a5a9-fe3f-80bd-f52b70974300@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26-08-16 22:46, Maxime Ripard wrote:
> On Tue, Aug 23, 2016 at 05:59:50PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 08/23/2016 05:17 PM, Maxime Ripard wrote:
>>> On Tue, Aug 23, 2016 at 11:39:06AM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 23-08-16 11:26, Maxime Ripard wrote:
>>>>> On Mon, Aug 22, 2016 at 09:03:57PM +0200, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 22-08-16 20:30, Maxime Ripard wrote:
>>>>>>> On Mon, Aug 08, 2016 at 09:43:14PM +0200, Hans de Goede wrote:
>>>>>>>> The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.
>>>>>>>>
>>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>>> ---
>>>>>>>> arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 8 ++++++++
>>>>>>>> 1 file changed, 8 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>>>>>>> index f27ebbb..da55b5a 100644
>>>>>>>> --- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>>>>>>> +++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>>>>>>> @@ -53,6 +53,14 @@
>>>>>>>> 	status = "okay";
>>>>>>>> };
>>>>>>>>
>>>>>>>> +&gsl1680 {
>>>>>>>> +	compatible = "silead,gsl3675";
>>>>>>>> +	touchscreen-fw-name = "silead/gsl3675-gt90h.fw";
>>>>>>>
>>>>>>> That's not documented anywhere, and looks really suspicious.
>>>>>>
>>>>>> Ugh, that should have been in:
>>>>>>
>>>>>> Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>>>>>
>>>>>> But somehow it is not (I believe it was there in earlier revisions of
>>>>>> the patch), I'll send a patch to fix this.
>>>>>>
>>>>>> About it being suspicious, this is not really firmware it is a bunch
>>>>>> of configuration data / lookup tables for the controller which tell
>>>>>> it in which order the touchscreen horizontal / vertical sensor
>>>>>> lines are connected to its sense pins, and what values to send
>>>>>> for finger x% between line z and line z+1, which differs per
>>>>>> tablet model, since not all tablets use the same digitizer.
>>>>>
>>>>> It's not really the firmware itself that I find suspicious, but more
>>>>> the encoding of a path to a file in the DT,
>>>>
>>>> It is not a path it is a filename. We could drop the "silead/" prefix
>>>> and put that in the driver instead to really make it a filename.
>>>>
>>>>> especially when you can
>>>>> apparently derive it from other informations already found in the DT
>>>>> (<vendor>/<compatible>-<board>.fw)
>>>>
>>>> That will not work, sometimes different boards use the same digitizer
>>>> and thus the same firmware. Also in case of the q8 tablets, we need
>>>> different firmware for different variants (this is to be dealt with
>>>> by the q8-hardware-manager I'm working on), since although they
>>>> all use the same digitizer they do not wire it up to the controllers
>>>> pins the same in all models, so we need different firmware files
>>>> corresponding to different wirings.
>>>>
>>>> TL;DR: There is no 1:1 mapping between board and the firmware filename.
>>>
>>> The point still holds. It's exactly the same case than the broadcom
>>> nvram filename discussion, and it raised the same issues.
>>
>> No it is not, in this case we also want to be able to specify
>> different fw names on devices using the same base dts, here
>> is a tablet for all the q8 tablets with gsl1680 I've:
>
> At least two other dev told you exactly that in that thread though:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/439978.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/440024.html

That is a different scenario / different mail thread,
I agree that the solution proposed there should work
for the brcmfmac driver.

But that is _not_ what we're discussing here.

>> a13-94v-0:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600 inverted-x
>> a13-tzx-713b-v2.1:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
>> a23-q8h-v3:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
>> a23-tj-a23-q88-v4.0:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
>> a23-tw-ao721-v41:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600 inverted-x
>> a23-ippo-q8h-v1.2:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
>> a33-ippo-q8h-v1.2:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
>> a33-tzx-723q4:		b482 a33-Q8_V2.4_1118/GSL1680_FW_D702.fw		 960x640 inverted-x
>> a33-q8-v2.4-1118:	b482 a33-Q8_V2.4_1118/GSL1680_FW_D702.fw		 960x640
>> a33-q8h-v1.5:		b482 a33-q8h-v1.5/GSL1688_A70_FW.fw			 960x640
>>
>> I'm working on a q8hardware-mgr (inspired by the beagle bone cape mgr)
>> to automatically detect the touchscreen controller as well as the controller id
>> (the 2nd column above), and it will need to set a filename for the firmware
>> file based on this, deriving this from the machine compatible will
>> simply not work here.
>
> I'm not sure why we need to stick to some insane naming scheme. Or why
> can't we use symlinks.

All the above tablets use the same dts file (sun5i-a13-q8-tablet.dts,
sun8i-a23-q8-tablet.dts, sun8i-a33-q8-tablet.dts) while not having
the same touchscreen, as discussed in the past I'm working on a kernel
module to detect which touchscreen is in use and then automatically
update the dt using dynamic-devicetree since creating a separate dt
file for each variant is madness (there is a new revision every few
weeks).

I already have this sort of working and I can detect if a tablet has
a gsl1680 touchscreen (*) and if it is the a082 or b482 variant. Now
we could encode the chip-id (the a082/b482) in the firmware name
at the driver level, but that is still not good enough, e.g. these
2 tablets:

a23-q8h-v3:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
a23-tj-a23-q88-v4.0:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600

Both use a a082 revision gsl1680 but need different firmware files,
since they both use sun8i-a23-q8-tablet.dts, so simply embedding
the machine compatible string in the filename passed to
request_firmware is not going to help.

I hope to get permission to get these firmware files added to
linux-firmware and then the different files need unique names,
and we need a way to specify in devicetree which file to load.

We can do some weird indirect dance but that is not really
helpful, esp. since I also expect users to need to override
which firmware file gets used in certain cases and in that
scenario simply specifying the filename certainly is the most
userfriendly.

TL;DR: we need a way to specify which firmware needs to
be loaded and this CANNOT be derived from the machine
compatible as devices with the same machine compatible
need different firmwares.

Regards,

Hans



*) Not all a13/a23/a33 tablets have a gsl1680 touchscreen, I'm also
working on detecting other controllers
