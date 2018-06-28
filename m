From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Jun 2018 08:10:31 +0200
Subject: [Dev] [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <CABGGisxta7f_CQt1Lsz+QRiyG8qVJ=rdBYnL5kSzLfw0-UxizA@mail.gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAL_JsqK2DKPbaFvUPSU2E7oh1_pryrRXPMg8OASmK722jmznwA@mail.gmail.com>
 <CACRpkdZSk_jABqdcMGhyLaG42YXn3c0mqdKrfnUwNAuFj+kfbg@mail.gmail.com>
 <CABGGisxta7f_CQt1Lsz+QRiyG8qVJ=rdBYnL5kSzLfw0-UxizA@mail.gmail.com>
Message-ID: <fdf376f0-8a9e-0cc9-b47e-0d7d3c41ef3e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Pantelis

On 27.6.2018 17:23, Rob Herring wrote:
> On Tue, Jun 26, 2018 at 8:36 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Tue, Jun 19, 2018 at 5:52 PM Rob Herring <robh+dt@kernel.org> wrote:
>>> On Mon, Jun 18, 2018 at 1:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>>> A3: Overlays is Big Upfront Design.
>> (...)
>>> I don't agree. This can be broken down into various smaller mostly
>>> independent problems. Overlay handling is mostly an orthogonal
>>> problem. The exception is that we need to ensure bindings allow a
>>> decoupling of upstream of the connector and downstream of the
>>> connector so the downstream part can be a reusable overlay. Defining
>>> anything while ignoring this known criteria would be a mistake.
>>
>> Hopefully we can make a connector binding that can
>> be used in any way by the OS: either probe a board
>> populating driver (such as in this patch set) or allow
>> an overlay to be inserted (the aforementioned driver
>> compiled out or inactive) further down the road. I would
>> like to believe the board population problem is a
>> both/and thing, not an either/or thing here.
> 
> Certainly both can be supported. The base DT should be the same. I
> don't think populating via DT needs to be a further down the road
> thing. We're already further down the road...
> 
>> Could be a simple as a compatible-string for the
>> connector(s). We just keep it dirt simple.
> 
> Yes, that would be the most simple case. Not really any work to do
> there, so what's the point? Soon enough, we'll need to support all the
> things listed below and what we certainly don't need is each connector
> doing things their own way.
> 
>>> The list is roughly like this:
>>>
>>> - Connector node binding and probing infrastructure
>>> - GPIO (already done w/ gpio-map binding)
>>
>> I tested that actually, using the connector as nexus. It works
>> fine. The problem I ran into was more practical
>> (see below).
>>
>>> - I2C
>>> - SPI
>>> - Pinmux
>>> - clocks
>>> - OF graph (displays, cameras, etc.)
>>> - USB (re-use the USB connector binding for non-standard connectors)
>>> - Userspace interface
>>>
>>> We don't have to support every interface from the start. The bindings
>>> and corresponding kernel support can be designed 1-by-1 for the most
>>> part. Start with something simple like a GPIO LED on a mezzanine.
>>
>> I have that working today, I just didn't go beyond that.
>>
>> It's because of usability issues. (Described below.)
>>
>>> Once
>>> the base is functionality is there, the other parts can be worked on
>>> incrementally. We can punt any overlay handling to the bootloader
>>> initially.
>>
>> I didn't even do that. I just patched the DTS with a connector
>> and booted it.
> 
> Yes, or just do that. In any case, don't blame overlays for avoiding
> more fully defining connector bindings.
> 
>> From a user point of view whether having a
>> patched up DTS or a boot loader modifying the DTB at
>> run-time does not really matter as these boards are
>> non-discoverable anyway. The boot loader will now know
>> if they are there or not. What should the user do? Should
>> they send command line arguments to U-Boot to say that
>> we have the secure96 board? Flash different boot loaders
>> depending on what board(s) are connected? That is even
>> more awkward (IMO) than just modifying and redeploying
>> the DTB.
> 
> Ideally, it would be as simple as editing a syslinux style menu text
> file or setting an EFI variable. But yes, we do need to define exactly
> how that is done. It's something on the todo list for EBBR, but not
> going to happen until after the 1st release.
> 
>> The bright side of this patch set is that the user boots
>> and the kernel is aware of there being a connector
>> and presents sysfs files to populate the boards.
>>
>> User goes "hm OK I have a secure96":
>> cd /sys/bus/platform/devices/connector
>> echo 1 > secure96
>>
>> And there it populates.
>>
>> No special boot loaders. No special tools.
>>
>>> That punts all the issues around overlays like designing a
>>> userspace interface, where overlays are located (filesystem, passed
>>> from bootloader, built into the kernel), when they are loaded, and how
>>> to specify which overlays to load. Most of Frank's list is related to
>>> these issues.
>>
>> And that is where the user (also me) stops short.
>>
>> Now I want to plug this board. OK download device tree
>> compiler, author a fragment, compile it, compile a
>> special userspace for inserting it into the right node,
>> flash filesystem with that new userpace tool, also
>> do not forget the DTB fragment, parameterize that
>> tool to load the fragment into the connector node.
>> Maybe the user need to change stuff on the fly?
>> Hm then they need a text editor and a DT compiler
>> on the target too, OK things like that can be done.
> 
> With your series, they'd just have to edit and rebuild the kernel...
> 
>> Admittedly the above is more versatile. Probably
>> awesome when you need to populate a device forest
>> on an FPGA.
>>
>> But is that even a realistic usecase? And what about
>> the average plug-in board user? If they can do the
>> population by compiling a kernel driver for their
>> board and say it's there and populate it with a simple
>> echo into a sysfs file they will be happy.
> 
> Only a kernel developer would think compiling a kernel driver makes
> for a good usecase.
> 
> For users, I think all the board dtbs have to be on the filesystem and
> the user only has to set which ones to apply (when there is no eeprom
> to allow doing that automatically). That's essentially what you have
> on RPi today (though I've got issues with some of their overlays, but
> that's a whole other can of worms).
> 
> The other user usecase I think is custom or prototyping boards. For
> those cases, we probably do want some run-time interface which could
> be a kernel driver (as you have) or configfs overlay interface. But
> I'd start with the first usecase and worry about this one later.

Pantelis had (I believe still have) configs overlay interface already.
At least we are keep having it in xilinx soc tree.

Thanks,
Michal
