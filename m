From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 8 May 2013 09:04:34 +0300
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <20130507190628.GI5634@blackmetal.musicnaut.iki.fi>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
 <20130506223653.GA12089@obsidianresearch.com> <51884971.9050508@ti.com>
 <20130507003651.GA26035@obsidianresearch.com> <5188FE54.6050200@ti.com>
 <20130507182711.GB28628@obsidianresearch.com>
 <20130507190628.GI5634@blackmetal.musicnaut.iki.fi>
Message-ID: <5189EAF2.5020406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/13 22:06, Aaro Koskinen wrote:
> On Tue, May 07, 2013 at 12:27:11PM -0600, Jason Gunthorpe wrote:
>> On Tue, May 07, 2013 at 09:15:00AM -0400, Eduardo Valentin wrote:
>>>> But broadly the direction seems that drivers should have minimal
>>>> dependencies so, eg, the thermal maintainer compiling for x86 should
>>>> be able to compile test/static analyze your driver..
>>
>>> Well, I do not see much of this attempt actually. Do you have some link
>>> / evidene that shows someone who actually cares about compiling drivers
>>> for targets that they are not used for? On this specific driver, I
>>> actually have  had exactly the opposite advice [1]. I am not convinced
>>> people actually want to do that.
>>
>> There was a discussion a bit ago, but I can't find a link.. The
>> context was subsystem maintainers are being asked to look after more
>> code with the DT transition moving things out of arch/arm and at least
>> one complained they couldn't even compile test on x86... But again, I
>> can't find a link and you are right, there are lots and lots of
>> 'depends ARCH..' style things in kConfig already.
>>
>> Lets just call it something to think about.
> 
> Tomi started a thread related to this recently:
> 
> 	http://marc.info/?l=linux-kernel&m=136731558332265&w=2
> 
> I think there's some good reasons listed there, but I guess up to the
> subsystem maintainers to decide what they prefer.

As Sam pointed out in that thread, there's no need to change the Kconfig
language for this. I did some testing with fb drivers, by having a
CONFIG_ALL_FB_DRIVERS option which "removes" the arch dependencies for
some fb drivers.

It does uglify the Kconfig files a bit:

-       depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+       depends on FB && (SUPERH || ARCH_SHMOBILE || ALL_FB_DRIVERS) &&
HAVE_CLK

I'm still undecided if I want to pursue this with fb drivers, as it
seems that quite many of them do really depend on the arch code, and I'm
not interested in trying to fix them.

But if other subsystems would benefit of this also, perhaps we could
have a common CONFIG entry that would allow compiling a driver on any
arch. I just can't think of a good name for the config entry =).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130508/9e6b81df/attachment-0001.sig>
