From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 05 Feb 2015 23:13:58 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <54CE354F.5090106@gmail.com>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
 <54CB6440.1010002@gmail.com> <20150130124144.501cf81d@armhf>
 <54CB732F.7010409@gmail.com> <20150130133913.083d1ade@armhf>
 <54CB7E33.3080909@gmail.com> <54CE354F.5090106@gmail.com>
Message-ID: <54D3EB26.9020909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.02.2015 15:16, Gabriel Dobato wrote:
>> I'd be happy to take over, but I admit that my current lack of spare
>> time would only allow me to support Gabriel and you.
>>
>> Let's wait for Gabriel's response on how he can help improving
>> Dove mainline with his cm-a510 and baseboard.
>
> First of all, I would like to give thanks all people like you for all
> your help and support. I really appreciate it.
>
> DT is new for me, I have never worked using this kind of hardware
> description, so I am involving in many issues due to my lack of skills
> in this kind of structure.
>
> At this moment, I am focusing in the update of the version of the kernel
> on the CM-A510 board (from 2.6 to 3.1x)in order to give more features to
> the system, but as I said before, I have lots of problems.
>
> Thanks to the help and support of Jean-Francois Moine, I have achieved
> to boot the kernel completely and to mount the rootfs via NFS. I have a
> prompt, what has been a very big step for me.

Gabriel,

great you can boot a recent kernel. I guess you had to quite heavily
modify current dove-cm-a510.dts? Can you upload the one you use now
to any pastebin and send the link?

>> Nope. One dove.dtsi, one dove-cm-a510.dtsi, and one baseboard.dts
>> including dove-cm-a510.dtsi for every baseboard we stumble upon.
>
> In reference to the structure of .dts and .dtsi files, I agree with this
> kind of structure, of course, nobody as you can consider it better. I
> think the idea of make a dove-cm-a510.dtsi file and different
> baseboards.dts depending of the peripherals used is great. But as I say,
> maybe I am not the right person to decide it, Jean-Froncois Moine and
> you have better criteria.So, whatever you decide I would very happy to help.

You didn't mention if you really use the sb-a510, i.e. the Compulab
reference baseboard. Is it what you are using with your cm-a510?

> At this moment, I am trying to configure the framebuffer, but as Moine
> told me,it seems there is not video driver support for this board in
> DT... :( .

Not quite true. Video is made up of at least 4 different devices:
Framebuffer, GPU, Decode engine, and usually DVI/HDMI transmitter or
VGA.

We do have a driver for the framebuffer (armada_drm) and there is great
work from Russell King and others on the GPU and Decode engine (IIRC).

If you are using the sb-a510, I can see from the manual, that DVI
transmitter is SIL164.. AFAIS there is a driver for it, that maybe
needs some polishing. Nobody ever tested VGA, but it shouldn't be too
hard to add support for it as it is directly supported by the
framebuffer HW.

One quite important driver at least for Dove is a clock source for
video. Internal clock generators for video are way to limited with
respect to frequencies to allow any useful resolution.

I'll see if I can have a look at the dts stuff this weekend.. that
way we'll have at least the basic done before moving to the other
devices.

Sebastian
