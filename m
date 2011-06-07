From: olof@lixom.net (Olof Johansson)
Date: Tue, 7 Jun 2011 11:49:32 -0700
Subject: [PATCH 3/3] ARM: l2x0: Add OF based initialization
In-Reply-To: <4DEE57D7.1030704@gmail.com>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
	<1307456541-11026-4-git-send-email-robherring2@gmail.com>
	<BANLkTi=7rHjKV=+hNKzEHvZMeDPwknOWtg@mail.gmail.com>
	<4DEE57D7.1030704@gmail.com>
Message-ID: <BANLkTi=9XB3+LymO=CbnHNnXnMAK5FrMZM7zdvc51B_HDokSKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 7, 2011 at 9:54 AM, Rob Herring <robherring2@gmail.com> wrote:
> Olof,
>
> On 06/07/2011 11:20 AM, Olof Johansson wrote:
>>
>> On Tue, Jun 7, 2011 at 7:22 AM, Rob Herring<robherring2@gmail.com> ?wrote:
>>
>>> +- aux-value : Value to set the Auxillary Control register to. Setting
>>> masked
>>> + ?bits is undefined. Default value is 0.
>>> +- aux-mask : Mask of bits to preserve in the Auxillary Control register.
>>> + ?Default value is 0xffffffff.
>>
>> The device tree should describe the hardware, not the way the linux
>> kernel drives the hardware. In the case of the AUX register, it's
>> mostly a collection of options that are either turned on or off. I
>> don't think they should necessarily be described as an opaque 32-bit
>> word, but instead as separate attributes.
>
> Unfortunately, the meaning of the bits depends on the model and there
> doesn't seem to be any commonality or subset of options as to what each
> platform is setting up.

Luckily, the meaning of the bits can be derived from the most-specific
compatible string, but yeah, it seems like many SoC vendors choose to
enable different settings. Likely because of either what has been
verified to work well, or what worked well for some benchmarks that
they cared about enough to optimize the default case for.

>>
>> At least the geometry should be specified that way.
>
> That's probably the only part that doesn't get changed. :)

Yep, it should ideally still be described though.


>> For feature enable bits, it depends on what features should be enabled
>> and from the kernel side. I'm not sure that belongs in the device tree
>> at all.
>
> I don't think it can be decided what the kernel needs to setup by the device
> tree. The main reason it's needed in the kernel at all is probably because
> the bootloader didn't setup aux_ctrl or set it up incorrectly.
>
> Perhaps the magic values should just be left in the platforms and continue
> to be passed into the OF init function:
>
> l2x0_of_init(__u32 aux_val, __u32 aux_mask);

This might be the least painful way to do it, agreed.

If a specific platform wants to have firmware pass in the preferred
values, they could do so through /chosen or similar.


-Olof
