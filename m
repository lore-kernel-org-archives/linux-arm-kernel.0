From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 10:50:09 +0800
Subject: [PATCH 0/7] drm/sun4i: Introduce A33 display driver
In-Reply-To: <20160905203707.GF8596@lukather>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <18951472779805@web6g.yandex.ru> <20160902190605.GF6313@lukather>
 <CAGb2v64p2MMvTpS8nNT2hGF3_jBa7Odr2qkOHD=N4iVXMDxrwA@mail.gmail.com>
 <20160905203707.GF8596@lukather>
Message-ID: <CAGb2v65Ui5ys_=5fmW4FkfR+oc7sCnwq0cHbgGFt3r-Kgg=k5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 4:37 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Sep 03, 2016 at 09:43:59AM +0800, Chen-Yu Tsai wrote:
>> On Sat, Sep 3, 2016 at 3:06 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi Icenowy,
>> >
>> > On Fri, Sep 02, 2016 at 09:30:05AM +0800, Icenowy Zheng wrote:
>> >>
>> >>
>> >> 01.09.2016, 23:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> >> > Hi everyone,
>> >> >
>> >> > This serie introduces the support in the sun4i-drm driver for the A33.
>> >> >
>> >> > Beside the new IPs and special cases for the A33 new IPs, there's
>> >> > nothing really outstanding, and is now at feature parity with the A13.
>> >>
>> >> How can the driver be modified to support LVDS screen?
>> >>
>> >> I have an A33 tablet with a 1024x768 LVDS panel. (iNet D978 Rev2 board,
>> >> which I pushed a dt a few days ago)
>> >
>> > Awesome, I don't have such a screen myself, so feel free to work on
>> > it.
>> >
>> > I haven't looked into the details of LVDS, but it should be something
>> > along the lines of commit 29e57fab97fc ("drm: sun4i: Add RGB output").
>>
>> The implementation might be along the lines of
>>
>>   1. having multiple output ports, each for a different interface type.
>>      (Some platforms go this route)
>>
>> Or
>>
>>   2. having a DT property describe what the output interface is.
>>
>> The RGB/TCON driver would then setup the registers accordingly.
>
> Hmmm, yeah, we would need to adjust the bindings too...
>
> I guess I'd prefer 1), but that would also be the most invasive
> solution. I'm not sure how the DT maintainers feel about that.

I wonder if the TCON could use its 2 channels simultaneously?
Like output to one LCD, then mirror through HDMI/VGA?
The first option would be able to cover this better?

And you still need to add outgoing endpoints for the HDMI block.

In addition we'll have to rework the TV encoder binding as well.

The 2 TV encoders (on the A20) each have four DACs, which map
onto 4 external pins. The address space includes a not so easy
to use mux. More importantly, the binding needs to specify which
pin is used for what signal (RGB, YUV, S/Video, composite).
There seems to be an implicit rule that 1 pin is always used
for composite, and the 3 others RGB, though.


Regards
ChenYu
