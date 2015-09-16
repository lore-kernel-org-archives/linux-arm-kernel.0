From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Sep 2015 20:54:42 -0700
Subject: [PATCH] arm: rpi: Device tree modifications for U-Boot
In-Reply-To: <CAPnjgZ2L1TOOmiUSKk-=gpAUt8tvZU1SkGBmdbHJR1tBhE2nTA@mail.gmail.com>
References: <1439303153-12171-1-git-send-email-sjg@chromium.org>
 <1439312701.2451.3.camel@lynxeye.de>
 <CAPnjgZ3ztXnkxZJvitiXiKMzq5+x46hbv0PW4HcF7yGgsXUV+Q@mail.gmail.com>
 <CAPnjgZ0hzyjy=8o8ocaGCoOC7Js4CirhystidbvtabzbhRi4RQ@mail.gmail.com>
 <CAL_Jsq++ihz6svJAKWwT7-=KyJvyWXjdf=tZb4aDGgV_Dc=-Nw@mail.gmail.com>
 <CAPnjgZ3ubK_5j4AV4wO6xgoRf8iN+G8YSQm0pSW5fVzwpxYu5Q@mail.gmail.com>
 <CAL_JsqJ-N+nFEMEEmg4O45DVF0g382fUvjGTH=fP_HbgK38aKw@mail.gmail.com>
 <CAPnjgZ2L1TOOmiUSKk-=gpAUt8tvZU1SkGBmdbHJR1tBhE2nTA@mail.gmail.com>
Message-ID: <55F8E802.7090008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2015 11:27 AM, Simon Glass wrote:
> Hi Rob,
> 
> On 25 August 2015 at 10:22, Rob Herring <robherring2@gmail.com> wrote:
>> On Sat, Aug 15, 2015 at 8:46 AM, Simon Glass <sjg@chromium.org> wrote:
>>> Hi Rob,
>>>
>>> On 14 August 2015 at 14:29, Rob Herring <robherring2@gmail.com> wrote:
>>>> On Fri, Aug 14, 2015 at 1:34 PM, Simon Glass <sjg@chromium.org> wrote:
>>>>> -linux-tegra
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 12 August 2015 at 07:21, Simon Glass <sjg@chromium.org> wrote:
>>>>>> Hi Lucas,
>>>>>>
>>>>>> On 11 August 2015 at 11:05, Lucas Stach <dev@lynxeye.de> wrote:
>>>>>>> Hi Simon,
>>>>>>>
>>>>>>> why did you send this to the Tegra ML?
>>>>>>>
>>>>>>> Am Dienstag, den 11.08.2015, 08:25 -0600 schrieb Simon Glass:
>>>>>>>> This updates the device tree from the kernel version to something suitable
>>>>>>>> for U-Boot:
>>>>>>>>
>>>>>>>> - Add stdout-path alias for console
>>>>>>>> - Mark the /soc node to be available pre-relocation so that the early
>>>>>>>> serial console works (we need the 'ranges' property to be available)

[... discussion of u-boot,dm-pre-reloc property]
>>>> Can't the need for that property change over time? Either as more
>>>> drivers are converted to DM you need to add this or you add some
>>>> feature that depends on a driver (e.g. get a board rev or boot mode
>>>> from GPIO). You would have backwards compatibility issues with this.
>>>> I'm somewhat less worried about that for u-boot as we should be
>>>> bundling the dtb and bootloader rather than kernel and dtb. For the
>>>> UART, you can just get which UART to initialize early from
>>>> stdout-path. But for other cases, couldn't you just have the platform
>>>> provide the list of needed drivers. Then when u-boot needs change, you
>>>> just change u-boot.
>>>
>>> Yes U-Boot and its device tree are normally built from the same tree
>>> at the same time. We don't expect to have to support an older or newer
>>> device tree with the same U-Boot binary. So I don't see a problem
>>> here.
>>
>> My point is that if I had to pick how bootloader+dtb+kernel are
>> bundled or not, I would rather see the dtb in sync with the bootloader
>> rather than the kernel. But I can't decide that for everyone and
>> neither can you. You still have a compatibility problem and that has
>> to be addressed.
> 
> What are you getting at here? If I move to a new kernel and still use
> an old device tree I may be missing features, or fail to boot. Don't
> do that!

One of the central points of DT is that it is an ABI. As such, moving to
a new kernel and continuing to use the same old DTB *MUST NOT* break
anything. Of course, you won't get any features enabled/described in any
new DT if you don't use it.

...
> After reading your email I am none the wiser about what you are suggesting.
> 
> This is not a screwy case. Every board will have a console. In some
> cases it is inside a 'soc {' node and in some cases it is not. The
> pure solution would be to mark every UART node with
> u-boot,dm-pre-reloc and we can do that if you prefer. It isn't
> necessary though for the reasons I previously explained.
> 
> It seems reasonable that U-Boot should be able to add private
> properties to the device tree, intended for U-Boot, just as Linux
> does. What is the problem here?

Why is that reasonable? DT is intended to describe the HW. It is
supposed to be OS-agnostic. Having U-Boot-specific properties completely
goes against that.

What Linux-specific properties are you referring to? The only one I
recall you mentioning (although I'm missing a lot of sleep right now) is
the keycodes in the input binding. While the DT property name for those
is linux,... and the values happen to match internal Linux numbering,
there's absolutely nothing Linux specific about the /concept/ of a
keycode, and some numbering scheme had to be picked. There's nothing
practical or conceptual stopping any other OS/SW-stack from translating
those Linux IDs into something internally meaningful. Conversely, the
concept of e.g. "u-boot,dm-pre-reloc" is not something that translates
at all to any other OS/WW-stack.
