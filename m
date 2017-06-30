From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Jun 2017 14:12:02 +0100
Subject: [linux-sunxi] [PATCH v4 5/6] ARM: sun7i: Convert to CCU
In-Reply-To: <20170629114905.hr6icycjcn2fekfd@flea>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <ac9cc7f0a67d3e9e5edd0d5eb21cc60820c2b457.1498422562.git-series.plaes@plaes.org>
 <a08cbe0d-dad4-7d0c-9845-452e0d6e3f03@arm.com>
 <20170629114905.hr6icycjcn2fekfd@flea>
Message-ID: <fd899ddb-c6bf-f9e9-e347-73448e62d30e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29/06/17 12:49, Maxime Ripard wrote:
> On Thu, Jun 29, 2017 at 11:57:05AM +0100, Andre Przywara wrote:
>> Hi,
>>
>> On 25/06/17 21:45, Priit Laes wrote:
>>> Convert sun7i-a20.dtsi to new CCU driver.
>>
>> I know that some people hat^Wget annoyed by me asking this, but anyway:
>>
>> Why do we actually need this?
>>
>> This ultimately makes the DT incompatible with older kernels (as
>> actually shipped by distros today).
>>
>> So if we for instance use UEFI boot or otherwise just use "one golden
>> DT" to drive all kernels (like using the DT from U-Boot), we now don't
>> have one good DT that fits all.
> 
> What is broken exactly?

Having *one* DT (in U-Boot, for instance), and just passing this one via
UEFI to the kernel - without knowing *which* exact kernel this will be
(older Linux, newer Linux, some *BSD). Using this we would need to have
the current DT in there (because we would break older kernels
otherwise). Which means we can't benefit from newer DTs and clocks in
there. Which would counteract the actual purpose of this change
(improved clock support) - hence my question.
In UEFI boot land we generally don't consider per-kernel DTs, as the DT
is referenced in the UEFI system table. Yes, grub can pass on a specific
DT, but this is considered a hacking and development vehicle (for people
like you and me) and not meant for public consumption.
So booting via UEFI mandates *one* valid DT for a particular system.

>> This is really a showstopper for boards which ship a DT in firmware
>> (in SPI flash, for instance, or on some eMMC).
>>
>> So:
>> - Do we actually need to change the .dtsi? The old .dtsi should still work.
> 
> It does.
> 
>> - Is there anything that the new and fancy clocks gives us over the
>> existing clocks? If yes, that should be a  stated in the commit message
>> or cover letter.
> 
> Yes, support for all the clocks used in the SoC, and not a single
> fraction of them

Fair enough, but this should be mentioned somewhere.

> (which will reduce the number of additions of new
> bindings and drivers, which will in turn make the DT have less
> changes, which will make it far more easier for distros and / or
> firmwares to ship an immutable DT).

Well, as far as we only talk about *additions* (or compatible changes) I
don't see much of an issue. There will always be feature updates, and
this would just boil down to update the DT to make use of them. Older
kernels would just ignore any new and fancy nodes.

>> - Why do we change the clocks for those older SoCs in the first place?
>> Can't we just keep on using what worked for years?
> 
> Please tell me where the displays clocks, CSI or HDMI clocks are in
> the old code.

Fair enough, but as mentioned above that would have been a good
rationale in some commit message or cover letter. As it stands now it
reads to me as: "Let's break stuff because sunxi-ng is much cooler" ;-)

>> I think we really can't remove the old code anyway.
> 
> We don't.
> 
>> The new clock driver moves information from the DT into the kernel. That
>> means it is no longer available for a DT consumer and the SoC details
>> (which clocks is located where, for instance), have to be replicated to
>> other DT users (U-Boot, *BSD, you-name-it). We already came across this
>> issue when looking at converting U-Boot over to use DT clocks.
>> Also it ultimately requires kernel changes for each new SoC, even if it
>> only differs in some detail which could be perfectly modelled in DT
>> (think of H3 vs. H5).
> 
> Doing otherwise would also assume that you have a perfect
> understanding of all the clocks interactions, relationship and
> computations from day one, which is something the old code proved that
> it was unreasonable.

I completely understand the reasoning from a point of view like five
years ago. But in the meantime I think we have a pretty good
understanding of how the clocks work - sunxi-ng having almost complete
support proves this. And we also know how to abstract this properly, as
this is now done inside the driver. What's just unfortunate is that
those abstraction are modelled inside the *Linux* *driver* file, and not
inside DT. I understand that it's easier to just model this with some
linked C structs, but this now has the unfortunate side effect of
requiring kernel changes for slightly different SoCs. If those details
would be described in the DT, a vendor could just provide a .dtb (for
instance in some on-board memory) and we could boot existing
distributions (or installers) without further ado.

> The new binding also makes it easier to add SCPI that you're
> interested in iirc, where you basically just have to change the CCU
> compatible, and be done with it as long as you use the same IDs.

That's an interesting argument, but I wonder if it's that hard to change
all clock references instead.

> It also lowers the barrier of entry for people that would want to
> write new drivers, since the first thing you'd need to do otherwise
> would be to create a clock driver for that, which is yet another thing
> to learn.

OK, but I don't see how this differs from providing a separate clock
driver (with it's own compatible) from the outright.

Also it brings the burden of duplicating the Linux driver implementation
to other DT consumers. And I feel a bit bad towards BSD people since
they can't just copy code over.

Cheers,
Andre.

> The reduced duplication is also neat and reduces the number of similar
> bugs in each and every clock, even though it's not related to clocks.
> 
> Maxime
> 
