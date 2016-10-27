From: phh@phh.me (Pierre-Hugues Husson)
Date: Thu, 27 Oct 2016 10:10:18 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <20161026205451.cgk5xam334ncg6op@rob-hp-laptop>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <20161026205451.cgk5xam334ncg6op@rob-hp-laptop>
Message-ID: <CAJ-oXjQ-kQ70WnZ4DOBSEMudPzULbN04r-FgWdtH3gPaF2afxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(mail resent, because it had been filtered out by linux-arm-kernel and
and devicetree because it contained an HTML part, sorry about that)

2016-10-26 13:46 GMT+02:00 Hans de Goede <hdegoede@redhat.com>:

> And as I tried to explain before, for this specific use-case describing
> all this board specific knowledge in a generic manner in dt is simply
> impossible, unless we add a turing complete language to dt aka aml.


You keep saying this is a "specific use-case", but I don't agree.
Most of cheap phone and tablets SoC manufacturer's Linux variant that
I know of have (rather stupid) auto-detection methods.
Not every phone manufacturer use it, because some have proper and
constant supply chain, but still, that's not always the case.
For instance you might look at this dts:
https://github.com/Dee-UK/RK3288_Lollipop_Kernel/commit/9e056a10b0a773d285e8d2ae819e7c2451816492#diff-b25e1abc92522c85e9ef28704bf9284aR410
This DTS is meant, like what you do, to be compatible with as many
devices as possible at once.
So it declares 4 different PMICs (and no they will never all be there
at the same time), and two different accelerometers, 3 audio codecs,
and two touchscreens.
Or you can look at CodeAurora (Qualcomm public opensource tree) DTSs
and see that a standard DTS support at least three different panels (
see https://github.com/omnirom/android_kernel_oppo_msm8974/blob/27080b724f4cf281d598e7830abc5fc1292b5803/arch/arm/boot/dts/msm8974-mtp.dtsi#L15
)
And that's the fairly clean examples. Some SoC kernels are still using
good old platform_data detection methods.

Thus I believe that having a board-specific driver is not a good
thing, because we would get many of those.

When it comes to detection, I've witnessed various things.
It can be kernel-side or bootloader-side "global setting" reading
(like an ADC/resistor value, or an OTP), it can be bootloader doing
the "brute-force", or it can be the kernel doing all the probes.

For instance, as of today, on a Spreadtrum ODM tree, the bootloader
will detect the screen by testing all knowns screens, the
screen-drivers declare a get_id function, and the bootloader probes
until the get_id matches the id declared by the screen driver.
And then the bootloader tells the kernel, via cmdline, which screen is
actually there (but auto-detection is also coded in kernel).
Finally all possible sensors/touchscreen/camera are declared in DTS,
and probe will filter-out N/C ones in the kernel.

Now the big difference between my experience and what Hans is trying
to do, is that I've always worked with devices with "safely" queriable
IDs, either on i2c or dsi. I've never encountered SPI. This makes
probing inherently more dangerous, but I believe the question roughly
remains the same.

I understand Mark's will of taking care of this "earlier" (either
bootloader or a later kernel-loader (pxa-impedance-matcher)), but I
feel like this is only giving the problem to someone else.
I think that those auto-detection methods should be declared in a
device-tree, though as Hans noted, this might end to be a
turing-complete language.
In my experience, I have never encountered a device requiring more
than ordered probes, but backward compatibility was expected. (i.e. if
IDs couldn't help distinguish two devices, the manufacturer would add
another way to identify)

As to whether this is bootloader's job or kernel's job, I don't have a
really strong opinion.
On one side, the kernel has all the drivers and probe functions, this
would need little work to make this work.
On the other side, if the "rules" are something like "read bus XXX,
address YYY, expect ZZZ", the bootloader can handle it as well. But I
don't think it is a good idea to have the bootloader know all the
gsensor/screen/camera/... drivers (even if they are partial drivers
dedicated to detection only)

Regards,

2016-10-26 22:54 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Mon, Oct 24, 2016 at 06:39:01PM +0100, Mark Rutland wrote:
>> On Fri, Oct 14, 2016 at 09:53:31AM +0200, Hans de Goede wrote:
>> > Hi Rob, Mark, et al.,
>>
>> Hi Hans,
>>
>> Apologies for the delay in replying to this.
>>
>> I'd like to be clear that I do understand that there is a problem that
>> needs to be addressed here. However, I do not believe that the *current*
>> in-kernel approach is correct. More on that below.
>>
>> > Mark, I know that we discussed this at ELCE and you clearly indicated
>> > that according to you this does not belong in the kernel. I was a bit
>> > surprised by this part of the discussion.
>> >
>> > I had posted a RFC earlier and Rob had indicated that given that the q8
>> > tablets are a special case, as my code uses actual probing rather then some
>> > pre-arranged id mechanism with say an eeprom, that doing this in a
>> > non-generic manner would be ok for my special case.
>>
>> To some extent, Rob and I may have differing views here; I'm not
>> entirely sure what Rob's view is, and I cannot talk on his behalf. I
>> certainly must apologise for having not commented on said RFC, however.
>
> I've focused mainly on the bindings which I certainly had issues with
> how the RFC was done. As to where this should be done, keeping all the
> dirty bits in firmware/bootloader is certainly appealing. However, there
> are cases where data alone can't abstract out board differences and we
> need board code. Whether this is one of them, well, that is Hans' job to
> convince Mark.
>
> Rob
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
