From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 10:21:55 +0200
Subject: [PATCH v2 3/6] ARM: dts: sun8i: Add sun8i-a23-a33 dtsi
In-Reply-To: <556D6487.4010207@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-4-git-send-email-hdegoede@redhat.com>
 <20150602075120.GL23777@lukather> <556D6487.4010207@redhat.com>
Message-ID: <20150602082155.GP23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:08:39AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 02-06-15 09:51, Maxime Ripard wrote:
> >On Sat, May 30, 2015 at 04:55:03PM +0200, Hans de Goede wrote:
> >>From: Vishnu Patekar <vishnupatekar0510@gmail.com>
> >>
> >>Rename sun8i-a23.dtsi to sun8i-a23-a33.dtsi as the base dtsi for the A33
> >>is 99% the same and add a new sun8i-a23.dtsi including sun8i-a23-a33.dtsi
> >>and setting the few things not shared with the A33 (mbus-clk, pio
> >>compatible and interrupts).
> >>
> >>Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >Fixed the conflicts and applied.
> >
> >Also judging from a quick look at the datasheet, the A33 doesn't seem
> >to have that clock gates tree but rather one similar to the H3's. That
> >will probably mean we'll have to move out the gates from this DTSI at
> >some point.
> 
> Heuh...
> 
> Ok so I've done a full bit for bit comparison of the 2 datasheets for
> the clk gates, mostly they are mostly the same and the registers seem to
> just be renamed.
> 
> The only differences are:
> 
> 01c200060 (AHB1 MODULE CLOCK GATING REGISTER 0 / Bus Clock Gating Register 0):
> 
> Only A33 has bit 5 SS gating
> 
> 01c200064 (AHB1 MODULE CLOCK GATING REGISTER 1 / Bus Clock Gating Register 1):
> 
> Only A33 has bit 26 SAT gating, note that if we add support for this we
> must add it as a needed clock to the simplefb node
> 
> Only A33 has bit 21 MSGBOX_GATING
> 
> 01c200068 (APB1 MODULE CLOCK GATING REGISTER / Bus Clock Gating Register 2):
> 
> No differences
> 
> 01c20006c (APB2 MODULE CLOCK GATING REGISTER / Bus Clock Gating Register 3):
> 
> No differences
> 
> 
> So you are right that in the near future we should add a separate compatible
> + clk driver or the ahb1_gates on the A33, but it does not seem that there is
> the issue of one gate register having multiple parents like on the H3. Or maybe
> the H3 does also not have that issue, and this is a misinterpretation of
> the H3 datasheet ?

I might have been misguided by the clock name (AHB1, APB1,
etc... gates vs bus gates).

If it's just as simple as that, then yeah, we'll probably don't need
the H3 bus gates driver for this.

> Note I do not know what the actual parent clock for the new gates is, but
> it stands to reason that it is AHB1, I've been unable to find anything to
> confirm or deny this.

That's always something we can change if we find that it's not the
case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/ce9ced6c/attachment.sig>
