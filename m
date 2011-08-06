From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 6 Aug 2011 18:41:48 +0100
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <CAKGA1bkM6X533w20hDV7GCPwzzj2nrjGdN6zkXsS+hCvUD_s2A@mail.gmail.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<20110805070729.GA26563@huya.qualcomm.com>
	<CAKGA1bkM6X533w20hDV7GCPwzzj2nrjGdN6zkXsS+hCvUD_s2A@mail.gmail.com>
Message-ID: <20110806174148.GA31966@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 01:36:56PM -0500, Matt Sealey wrote:
> On Fri, Aug 5, 2011 at 2:07 AM, David Brown <davidb@codeaurora.org> wrote:
> > On Thu, Aug 04, 2011 at 06:07:15PM -0500, Matt Sealey wrote:
> >> Hi Grant, Shawn,
> >>
> >> On Mon, Jul 25, 2011 at 3:46 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >> > This could get really verbose in a really big hurry. ?Fortunately the
> >> > dtb format is sophisticated enough to only store each unique property
> >> > name once, so the data shouldn't be huge, but it is still going to
> >> > make for huge source files. ?Can you think of a more concise
> >> > representation?
> >>
> >> Yes: no representation at all. The correct place for IOMUX setup being
> >> done is *inside the boot firmware as soon as physically possible* and
> >> not seconds into boot after U-Boot has made a console, done a boot
> >> timeout, loaded scripts, kernels and ramdisks from media and then
> >> uncompressed and entered a Linux kernel.
> >
> > This is true in situations where we have control over the bootloader,
> > but that isn't always the case.
> 
> Indeed it is not, but then it is "their" fault the board won't boot
> Linux, and not yours, right? :)
> 
> I think it is a given that when designing hardware (and we do that)
> and proprietary firmware that the Linux kernel guys can't "control",
> you have to keep up with the changes when reasonable. While sometimes
> that is very difficult, this is not one of those "sometimes" -
> providing a setup that can boot Linux implies that you configured the
> chip correctly such that Linux is supplementing that configuration,
> not reimplementing it from scratch.

This whole argument is ridiculous.  Assume for a moment that I agree
and that the firmware (in the embedded context) can be relied upon to
leave the hardware in a sane state.  Even then, an initialization
sequence binding is completely appropriate.  Hardware not required to
boot doesn't need to be initialized, and there are some real reasons
(power consumption for instance) for leaving some pin io left
unconfigured.

Besides, trusting a pin mux init sequence passed in the device tree
inherently means you're trusting firmware has passed accurate data
*and* that the initial state is also sane.

g.
