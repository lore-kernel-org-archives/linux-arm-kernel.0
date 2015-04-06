From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Apr 2015 11:13:09 +0100
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <f2b85e294afb55fdca85a16e6ad6c13c@agner.ch>
References: <20150403200931.GD13898@n2100.arm.linux.org.uk>
 <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
 <20150405161014.GG13898@n2100.arm.linux.org.uk>
 <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
 <20150405224455.GB12732@n2100.arm.linux.org.uk>
 <58bb3fd4f9e9b3acc7f8b83bd6664177@agner.ch>
 <20150406081523.GC12732@n2100.arm.linux.org.uk>
 <8737db3eea65563054df98c932870590@agner.ch>
 <20150406085443.GD12732@n2100.arm.linux.org.uk>
 <f2b85e294afb55fdca85a16e6ad6c13c@agner.ch>
Message-ID: <20150406101309.GE12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 11:33:53AM +0200, Stefan Agner wrote:
> On 2015-04-06 10:54, Russell King - ARM Linux wrote:
> > On Mon, Apr 06, 2015 at 10:38:10AM +0200, Stefan Agner wrote:
> >> We already prevent a kernel image which mixes V4/V4T/V5 and V6/V7. And
> >> so we would do with V7M too. Just because it's in multiplatform doesn't
> >> mean we need to mix things up.
> > 
> > I don't think you're getting what I'm saying at all... :(
> 
> It's not that I don't get it. I'm just arguing against it.
> 
> IMHO, it's wrong to create a parallel universe for v7M multiplatform...
> 
> Multiplatform as I understand it is mainly about selecting multiple SoC
> _platforms_ but not necessarily multiple CPU platforms. It happens to
> work well for V6/V7, but does not for others, and preventing
> multiselection for incompatible CPU platforms is the way to prevent
> creating such images.

Let's be clear: I'm _not_ arguing against being able to select multiple
SoC platforms at all.  I'm merely arguing about how it should be done.

What I'm saying, is that MULTIPLATFORM itself does _not_ work for all
noMMU platforms.  Yes, it _may_ work for V7M, but it doesn't work for
previous generation stuff - and that's confusing.

Let's look at what needs to happen to make V7M work the way you're
suggesting:
* Add "depends on !MMU" to all the existing ARCH_MULTI_* symbols.
* Append "if MMU" to the selection of ARM_PATCH_PHYS_VIRT and
  AUTO_ZRELADDR in multiplatform.

We then have the problem for the older generation noMMU stuff.  Should
we stuff into the multiplatform architecture options for selecting the
older generation noMMU _platforms_ into the "CPU Core family selection"
menu?  That's clearly wrong because they're not "CPU Cores".

So, we have to find somewhere else to put the older generation stuff,
and by doing so, that causes confusion, because we now have to select
multiplatform for one group of noMMU implementations, and _not_
select it for another group of noMMU implementations.

Imagine yourself writing up a document describing how to configure the
kernel for all noMMU platforms which will be read by many people with
varying degrees of English comprehension across the world, and how you
would describe to them, such that they clearly understood, how to
choose the right options.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
