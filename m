From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 15 Sep 2015 17:34:46 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: enable usb3503
In-Reply-To: <1442305045.8733.20.camel@collabora.co.uk>
References: <1426254866-24772-1-git-send-email-riku.voipio@linaro.org>
 <556FF260.5060006@collabora.co.uk> <7hd21b2wo4.fsf@deeprootsystems.com>
 <4414616.t6CSY5FxHU@wuerfel>
 <CAAqcGHmaWXFAVairN+2pw6adDG8AMc-MTMKp4g5aUP9Kw+8i7A@mail.gmail.com>
 <CAJKOXPcmeYowKkUkz9zYm31YJLpSQ4V40KeiiEOGdkZkPyX7iw@mail.gmail.com>
 <1442305045.8733.20.camel@collabora.co.uk>
Message-ID: <55F7D826.6060104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.09.2015 17:17, Sjoerd Simons wrote:
> On Tue, 2015-09-15 at 15:50 +0900, Krzysztof Kozlowski wrote:
>> 2015-09-14 17:35 GMT+09:00 Riku Voipio <riku.voipio@linaro.org>:
>>> On 5 June 2015 at 15:45, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Thursday 04 June 2015 10:47:07 Kevin Hilman wrote:
>>>>>
>>>>>> But I wonder why is not working, shouldn't the driver defer
>>>>>> and
>>>>>> be probed again once the PHY driver probe succeeds?
>>>>>
>>>>> Yeah, I'm not sure why that isn't working, and didn't look into
>>>>> it.
>>>>>
>>>>> FWIW, the same problem happens when both are modules.  If you
>>>>> modprobe
>>>>> usb3503 first, then the phy, it doesn't work.  You have to load
>>>>> the phy
>>>>> before the usb3503.
>>>
>>>> The driver does not try to get a reference to the phy, and it
>>>> does
>>>> not return -EPROBE_DEFER in any circumstance, so I assume it just
>>>> runs into an error condition on the first probe and does not
>>>> try again.
>>>
>>>> I don't really understand why the driver registers both an
>>>> i2c_driver
>>>> and a platform_driver, or if that is required, but it may also
>>>> complicate getting deferred probing to work here.
>>>
>>> Is someone looking into fixing it?
>>
>> Fixing what? The PHY issue? The driver not supporting deferred probe?
>>
>> As for module vs builtin, this is somehow orthogonal for me.
>> Although modules are preferred on multi_v7 but in case of
>> boot-essential drivers this should not be a requirement. I also don't
>> use initrd for network boot... however my root is on MMC. Regardless
>> if of that I would expect nfsroot to be working on multi_v7 kernel.
> 
> When posting a set of multi_v7 config changes recently to improve how
> we support RockChip, Thierry argued the case for building things as
> modules as much as possible (even if that means needing an initramfs to
> complete boot)[0]..
> 
> You're arguing the exact oposite here, while I can see the points in
> both arguments (though i'm leaning to agreeing with Thierry) it would
> be nice to work out a common policy here as multi_v7 seems to be a
> rather big mismatch currently.

Not entirely the exact opposite. Opposite only for stuff important for
booting. I agree: put into modules as much as possible. But the
difference is in meaning of "possible". It is possible to network boot
with network rootfs when the adapter is a module. But it is not possible
to do it without initrd. :)

Anyway I agree that conclusion should be made a standard (or policy) so
other driver should be converted to 'm' or 'y'.


> Fwiw, looking at the arm64 defconfig it currently has everything built
> in. Which isn't too bad as there aren't that many arm64 boards in
> mainline yet, but I bet it's going to run into similar issues at some
> point.

Indeed, that is the easiest option for development... until Image grows
out of device partition.


Best regards,
Krzysztof
