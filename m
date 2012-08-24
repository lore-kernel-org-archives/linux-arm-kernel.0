From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Fri, 24 Aug 2012 14:56:05 +0200
Subject: [RFC][PATCH] Disintegrate sharpsl_param.c
In-Reply-To: <CAHod+Gc8udMVChaezqte3dEns5E-udduwugL0o_VCYu=UCP9Tg@mail.gmail.com>
References: <1345656424-31234-1-git-send-email-dromede@gmail.com>
 <1345663182.3907.134.camel@ted> <20120824111211.GA28183@elf.ucw.cz>
 <20120824112536.GA19675@atrey.karlin.mff.cuni.cz>
 <CAHod+Gc8udMVChaezqte3dEns5E-udduwugL0o_VCYu=UCP9Tg@mail.gmail.com>
Message-ID: <CAHod+GcpVuutgU6uUrc1X5G=_B2YU2J4zsERqX8zcTobi-f6dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 2:53 PM, Marko Kati? <dromede@gmail.com> wrote:
> On Fri, Aug 24, 2012 at 1:25 PM, Cyril Hrubis <metan@ucw.cz> wrote:
>> Hi!
>>> > > I recently tried running 3.6-rc2 kernel on my Sharp Zaurus C-1000.
>>> > > It
>>> > > hanged almost immediately after uncompressing the kernel. I tracked
>>> > > the
>>> > > problem down to a single line in arch/arm/common/sharpsl_param.c:
>>> > >
>>> > > memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct
>>> > > sharpsl_param_info));
>>> > >
>>> > > Commenting out the line makes the kernel boot just fine. This left
>>> > > me
>>> > > wondering whether sharpsl_param.c is actually needed. Here's a
>>> > > comment
>>> > > from sharpsl_param.c that describes what sharpsl_param.c actually
>>> > > does:
>>> >
>>> > Sharp went to the trouble of saving these values into the hardware and
>>> > passing them into the drivers. They're basically used by the LCD
>>> > initialisation code from what I remember. I don't remember what the
>>> > risks are of incorrect values.
>>>
>>> We were seeing strange flicker on LCD on some machines...? Particulary
>>> metan's machine with wifi on did that. OTOH it looked like some kind
>>> of DMA issue.
>>
>> Yes, the problems with my LCD are DMA related (too much DMA to wifi cf
>> card
>> causes timing issues on display refresh). When there is no network
>> activity
>> it's okay.
>>
>> And as far as I remeber there are some magic values needed for the LCD in
>> order
>> not to have distorted picture (blurred, etc.) There is a callibration
>> program
>> in the service menu that allows you to modify the values stored in the
>> flash.
>>
>> I remeber Stanislav did some research on that (CCing).
>>
>> --
>> metan

As i said, this patch is not valid since i wrote it under false
assumptions. My tests were wrong, sharpsl_save_param() works as it
should in all kernels before 3.3-rc1.

3.3-rc1 breaks sharpsl_save_param() with this commit:

[72662e01088394577be4a3f14da94cf87bea2591] ARM: head.S: only include
__turn_mmu_on in the initial identity mapping

I already have a patch ready for 3.6-rc3 that fixes this (confirmed
working on my akita), i just need to test it on a SA1100 machine
before commiting.

As for your lcd/dma problems, the arbiter control register might help.
There's a paragraph in the pxa270 dev manual that says that the lcd
controller should have top priority when large lcd displays are used.
Try setting ARB_CNTRL in your machine init code so the lcd controller
has top priority or lower the dma controller priority.

Actually i've written a nice sysfs interface for the arbiter bus
register a while ago and i can't find the patch...
