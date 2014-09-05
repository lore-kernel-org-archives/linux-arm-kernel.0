From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Sep 2014 13:25:51 -0700
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140905122232.GP13515@arm.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
Message-ID: <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Fri, Sep 5, 2014 at 5:22 AM, Will Deacon <will.deacon@arm.com> wrote:
> [Looks like it's not just Rutland that can't spell the address of the
>  mailing list today. Fixed here, so please use this post in any replies].
>
> On Fri, Sep 05, 2014 at 12:57:04PM +0100, Will Deacon wrote:
>> Hi all,
>>
>> I'm one of the few, foolish people to try running mainline on my 5250-based
>> Samsung Chromebook (snow). I can live without wireless, usb3 and video
>> acceleration, so actually it makes a reasonable development platform for
>> doing A15-based (micro)-architectural work.
>>
>> However, since 3.15 I've not been able to boot *any* mainline kernels on
>> this board. I did mean to report this earlier, but I have other machines
>> that can run mainline so this has fallen by the wayside.
>>
>> The problems started with 3.16, where simple-fb would fail to initialise
>> and I lost my display. Note that I don't have a serial console on this
>> machine (I looked at the PCB and there's no way I can solder one of those
>> myself :) I bisected the issue at the time, and I could get my display back
>> by removing some of the new regulator and hdmi properties from the DT. At
>> that point, I could boot, but DMA didn't initialise for the MMC controller
>> so I couldn't mount my root filesystem.
>>
>> With 3.17-rc3, it seems a lot worse -- I don't get any output after nv-uboot
>> (i.e. the nv-uboot screen just remains on the display, with the last line
>> reading "Stashed 20 records").
>>
>> I'd usually try to debug this a bit further, but without a console it's
>> really painful to get anywhere. I've been working with 3.15, but now I'm
>> having to backport patches when I want to test them, which is more effort
>> than I can be bothered with.
>>
>> Is anybody else running mainline on this device and are these known/fixed
>> problems?

I've added Javier, who says he'll try to take a look at the problem on
Monday.  He's got a snow and I think he's got a serial console hooked
up to it (but I don't think he's tried the simplefb workflow).


He also added the following thoughts:

> Have you seen the very long "[PATCH 4/4] simplefb: add clock handling
> code" thread [0]?. I wonder if the problem is that the display clocks were
> not known to the kernel before 3.15 but now are getting disabled and thus
> the simplefb driver not working?
>
> So probably is worth to try passing clk_ignore_unused as a parameter to
> the kernel command line.
>
> [0]: https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06623.html
