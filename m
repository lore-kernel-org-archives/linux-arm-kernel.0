From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Jun 2016 19:22:57 +0800
Subject: Auto-detecting touchscreen controller and dealing with hw
 configuration differences on q8 tablets
In-Reply-To: <17e69e9e-06be-dc4f-cd47-152f6290d2ec@redhat.com>
References: <bc978925-46a4-c069-8793-903a87ec70b8@redhat.com>
 <5E70AD96-4E8E-4430-AF99-0AA0FCF5F8E7@konsulko.com>
 <17e69e9e-06be-dc4f-cd47-152f6290d2ec@redhat.com>
Message-ID: <314411466421777@web20m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm also a user of an A33 Q8 tablet with GSL1680.

However, I think a devicetree-per-device structure is not unacceptable...

We can still have sun{5,8}i-q8.common.dtsi, and write most of the q8 codes there.

Then the device dt can only contain wifi, touchscreen, accelerometer. (after including sun{5,8}i-q8-common.dtsi)

(On my tablet,
wifi(esp8089) should use "broken-cd" instead of "non-removable".
Touchscreen have a weird chip/firmware that cannot even set a correct STATUS.
And mma8452 iio driver will refuse to work if the chip number in dt is the same as the real chip, even the chip id can be probed)


20.06.2016, 19:07, "Hans de Goede" <hdegoede@redhat.com>:
> Hi,
>
> On 20-06-16 11:27, Pantelis Antoniou wrote:
>> ?Hi Hans,
>>
>> ?I?m going to commend only on the overlay related parts since I?m not I
>> ?get all the nuances right.
>
> No problem and thanks for the answer anyways!
>
>>> ?On Jun 19, 2016, at 14:06 , Hans de Goede <hdegoede@redhat.com> wrote:
>
> <snip>
>
>>> ?2) Give the user some way to override the dts settings.
>>>
>>> ?Which after a somewhat long intro brings me to the actual purpose of this thread, discuss
>>> ?how to best deal with this. I again see 2 options:
>>>
>>> ?1) Put a disabled gsl1680 node in the dts file, have a q8_autodetect.c in u-boot
>>> ?which probes i2c and if it finds the gsl1680 nodes enables it, and patches in a best-effort
>>> ?default for which fw file to use. Allow the user to set a touchscreen_fw u-boot env
>>> ?variable which will override this. Also allow the user to set a touchscreen_inverted_x env
>>> ?variable to add inverted-x to the dt node for the gsl1680.
>>
>> ?That can work. The problem is that having anything requiring smarts in u-boot always
>> ?leads to trouble with users. It all depends on your user?s technical proficiency, if
>> ?they are comfortable tweaking things in u-boot it?s fine. If it?s not, expect lots of
>> ?bricked boards when they mess up.
>>
>>> ?2) Write an in kernel overlay manager which does auto-detect as described by 1, and
>>> ?loads an overlay for the detected touchscreen controller, with module options to allow
>>> ?specifying the fw-file, x-inversion, etc.
>>>
>>> ?One things which worries me about 2. is that we would need to have 2 overlay files
>>> ?per fw-file, one regular config, one inverted-x, or is it possible for the overlay
>>> ?manager to modify an overlay before applying it ?
>>
>> ?Yes, it?s quite possible. You can even have stacked overlays.
>
> Ok, is there any example code how to change an overlay before applying it out there,
> or if not can you point to the functions to use to do this ?
>
> Specifically my plan is to:
>
> 1) Have a single overlay for q8 tablets with gsl1680 tablets
>
> 2) Write an in kernel overlay manager which when it detects a gsl1680 touchscreen
> will pick a best-default firmware-file + matching resolution + swap-x-y based on
> which SoC (A13/A23/A33) the tablet is based on as well as the gsl1680's chip-id
> and will then "patch" this info into the overlay before applying it. This
> means being able to set / modify several string, int and bool dt properties.
>
> 3) Offer a kernel-module option for the overlaymanager which will allows
> overriding the defaults for the firmware-filename, etc. This is also
> why I want to go with the patch approach instead of having multiple
> dt-overlay files.
>
> Thanks & Regards,
>
> Hans
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
