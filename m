From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 17:43:02 +0100
Subject: [PATCH v3 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <52406C97.3010800@wwwdotorg.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
 <5238CBE9.2060800@wwwdotorg.org> <1379522363.9244.12.camel@hornet>
 <52406646.709@wwwdotorg.org> <20130923160640.GT12758@n2100.arm.linux.org.uk>
 <52406C97.3010800@wwwdotorg.org>
Message-ID: <20130923164302.GW12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 10:30:15AM -0600, Stephen Warren wrote:
> On 09/23/2013 10:06 AM, Russell King - ARM Linux wrote:
> > On Mon, Sep 23, 2013 at 10:03:18AM -0600, Stephen Warren wrote:
> >> It sounds like you could just put LCDControl & 0x2e in the DT rather
> >> than using values such as 0x100..0x107, which don't appear to match the
> >> register format you mentioned above.
> > 
> > No.  Platforms which route the outputs to something like VGA or HDMI can
> > change the framebuffer format.  Your suggestions is far too restrictive.
> 
> Surely the DT should describe the HW setup only. Usually, a particular
> HW setup can support multiple different framebuffer formats. Hence, the
> DT wouldn't/shouldn't imply anything about the framebuffer format, but
> simply which wires are connected to the LCD.

Quite, and putting the contents of the LCDControl register - even just
bits 5 and 3-1 results in you having to modify the DT and reboot the
kernel just to change the framebuffer format.  That's why I'm objecting
to your comment.

When I rewrote the way the CLCD driver handles the various panels, I did
it with full information on how the hardware was being used at that time.
That is precisely why I came up with the capability system, where we
describe which formats the hardware can support up to the interface,
separately from the formats which the attached device - be it a LCD
panel, VGA socket or HDMI socket - can support.  The resulting set of
formats which can be used are a union of these.

Suggesting that we can do this by putting register values into DT is
completely wrong - if that were possible, I wouldn't have come up with
this capability system to sort this mess out in the first place - I
could've just hard-coded the register values and said to everyone
"tough, on these platforms you only get RGB444 support and that's it."
