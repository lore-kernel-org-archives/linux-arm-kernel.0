From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 23:33:51 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: sun6i: dt: Add new Mele I7 device
In-Reply-To: <20150310184449.GZ5085@lukather>
References: <1425131285-8640-1-git-send-email-codekipper@gmail.com>
 <20150303071635.GC4713@lukather> <54F568F8.1040104@redhat.com>
 <20150303082209.GE4713@lukather> <54F5B51F.6030609@redhat.com>
 <20150303135847.GH4911@lukather> <54FED277.4040000@redhat.com>
 <20150310184449.GZ5085@lukather>
Message-ID: <54FF714F.4010303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/10/2015 07:44 PM, Maxime Ripard wrote:
> On Tue, Mar 10, 2015 at 12:16:07PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 03-03-15 14:58, Maxime Ripard wrote:
>>> On Tue, Mar 03, 2015 at 02:20:31PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 03-03-15 09:22, Maxime Ripard wrote:
>>>>> On Tue, Mar 03, 2015 at 08:55:36AM +0100, Hans de Goede wrote:
>>>>>>>> +/ {
>>>>>>>> +	model = "Mele I7 Quad top set box";
>>>>>>>> +	compatible = "mele,i7", "allwinner,sun6i-a31";
>>>>>>>> +
>>>>>>>> +	chosen {
>>>>>>>> +		bootargs = "earlyprintk console=ttyS0,115200";
>>>>>>>
>>>>>>> Using earlyprintk by default is a bad idea if the kernel is configured
>>>>>>> with DEBUG_LL support for another SoC.
>>>>>>
>>>>>> While on this subject, u-boot now sets the chosen/stdout-path property
>>>>>> up by default, which means that the kernel will do the right thing by
>>>>>> default. So we we really do not need any bootargs= in our dts files.
>>>>>
>>>>> I just tested that this weekend, and it turned out that the kernel
>>>>> couldn't use it so far (ie, no output until init takes over and setup
>>>>> a TTY on ttyS0).
>>>>>
>>>>> Was it working for you?
>>>>
>>>> Yes, note that the kernel only honors the stdout-path property if
>>>> there is no console= argument present if there is a console= argument
>>>> present on the kernel cmdline then that will overrule the stdout-path
>>>> property
>>>
>>> Yeah, I removed the bootargs entirely.
>>>
>>>> Which board did you test with, and what u-boot and kernel version ?
>>>
>>> I tested it on my A31 hummingbird, with allwinner's u-boot, but with
>>> /chosen/stdout-path hardcoded to "serial0:115200n8", with a 4.0-rc1
>>> kernel.
>>
>> I'm not sure if stdout-path supports aliases this is what u-boot is using,
>> and which works fine (with 4.0-rc1 kernel): "/soc at 01c00000/serial at 01c28000:115200"
>
> I gave that another try, and it worked like a charm, so it really
> looks like an instance of PEBKAC.
>
>>> But it might very well just be me. We just tested it on a Marvell
>>> board (that uses the same serial driver) this morning and it was fine,
>>> so I don't think it's really worth worrying about this :)
>>>
>>>>>> Currently we've a random mix where we do have bootargs in some, but
>>>>>> not in most sunxi dts files. I believe we should simply remove it
>>>>>> everywhere...
>>>>>
>>>>> We used to set them in SoCs that are not supported by U-boot yet, and
>>>>> where the bootloader won't come and patch the DT (A31, A23, A80).
>>>>
>>>> Ah, so that is (was) the logic, following that logic we should probably
>>>> remove bootargs= from at least the a23 and a31 boards (basically
>>> >from all boards but a80).
>>>
>>> I'm not so sure about the A31, since most boards won't even boot by
>>> default on the SD card
>>
>> True.
>>
>>> and we have no way to replace U-Boot in NAND
>>> so far (afaik). But replacing them by stdout-path is a very good
>>> solution too.
>>
>> You mean putting stdout-path in the dts, I'm not sure if I like that,
>> to me both bootargs and stdout-path are something which should be
>> left to the bootloader to set. But I understand that when not
>> using upstream u-boot that may be an issue.
>
> I know that some other platforms ask for stdout-path when they review
> it, because iirc, barebox uses it to know on which console to output
> its log and export its shell, which is also a valid interpretation of
> that property, and, contrary to bootargs, doesn't really imply that
> the bootloader should update it.

Hmm, that is interesting we should probably start doing the same in
all the sunxi dts files, as eventually I would like to move all u-boot
board config to devicetree, so that we only need to maintain dts files
and not both dts files and u-boot board configs.

Regards,

Hans
