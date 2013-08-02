From: csd_b@daudt.org (Christian Daudt)
Date: Fri, 2 Aug 2013 16:06:37 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] arch/arm SoC organization
In-Reply-To: <20130802083346.GC7656@atomide.com>
References: <20130731141841.GP5882@titan.lakedaemon.net>
 <20130802083346.GC7656@atomide.com>
Message-ID: <CAGFynZ-V6CUFXh+iC8M7spwHn3gma6gYgRFBaoAXRYtw1fbgHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 1:33 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Jason Cooper <jason@lakedaemon.net> [130731 07:25]:
>> So, I'd like to propose we discuss some lessons learned and maybe arrive
>> at some best practices.  eg, should we just go with mach-$COMPANY/?  How
>> best to handle config symbols for efficient building?  Deprecation path
>> for legacy (unconverted) boards?
>
> A lot of that problem goes away by initializing everything as late
> as possible, and making things to live under drivers.
One category of items that we haven't found a good place for in this
new multiplatform world is where does dt-driven non-driver code reside
? e.g. we have a secure monitor access function that only kicks in if
the appropriate dt entry is available . It currently resides in
mach-bcm/bcm_kona_smc.c as it seems like the only location for it at
the moment, but that doesn't seem like the best place because (a)
mach-bcm might end up littered with one-of cases like this and (b)
anything in mach-bcm is not visible to arm64 SoCs, and some of those
in the future will need to share with their arm32 cousins.
 But putting in drivers (e.g. drivers/smc) seems like the wrong thing
to do also because this is not a driver.
 We have a couple of other smallish pieces of IP that just need a bit
of generic init code to keep them happy, which we were discussing
internally where to best land them. At present they are also headed to
mach-bcm.
 Ultimately the question is 'what is allowed to reside in mach-<misc>
?' And by extension: 'is there a good home for everything else ?''

 Thanks,
   csd
