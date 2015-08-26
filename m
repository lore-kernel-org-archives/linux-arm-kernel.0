From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 26 Aug 2015 14:28:42 -0700
Subject: [PATCH v10 3/5] mtd: nand: vf610_nfc: add device tree bindings
In-Reply-To: <56589547ed623481ca2b94ff364d6434@agner.ch>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-4-git-send-email-stefan@agner.ch>
 <20150825202546.GL81844@google.com>
 <BLU436-SMTP1971442F63D96D55AC8E905B8600@phx.gbl>
 <20150826173903.25479201@bbrezillon>
 <56589547ed623481ca2b94ff364d6434@agner.ch>
Message-ID: <20150826212842.GT81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 02:15:45PM -0700, Stefan Agner wrote:
> On 2015-08-26 08:39, Boris Brezillon wrote:
> > On Wed, 26 Aug 2015 11:26:36 -0400
> > Bill Pringlemeir <bpringle@sympatico.ca> wrote:
> >> These would apply per chip, but the controller has to be configured to
> >> support each and every one.  Every time an operation was performed, we
> >> would have to check the chip type and reconfigure the controller.
> >> Currently, the driver does not support this and it would add a lot of
> >> overhead in some cases unless a register cache was used.
> >>
> >> Is the flexibility of using a system with combined 8/16bit devices
> >> really worth all the overhead?  Isn't it sort of brain dead hardware not
> >> to make all of the chips similar?  Why would everyone have to pay for
> >> such a crazy setup?
> >>
> >> To separate it would at least be a lie versus the code in the current
> >> form.  As well, there are only a few SOC which support multiple chip
> >> selects.  The 'multi-CS' register bits of this controller varies between
> >> PowerPC, 68K/Coldfire and ARM platforms.
> 
> The DT can be a lie versus the code. The DT should reflect how the
> hardware is wired, afaik, if we take shortcuts in the driver code, that
> is fine. If we don't support a certain configuration right now (e.g.
> second NAND chip), the driver can just return an appropriate error code.

Right, I was only asking for:
(1) a more accurate DT and
(2) clarity in the driver; the clarity might just be "we don't support
    multi-CS"

> >> I looked briefly at the brcmnand.c  and it seems that it is not
> >> supporting different ECC per chip even though the nodes are broken out
> >> this way.  In fact, if some raw functions are called, I think it will
> >> put it in ECC mode even if it wasn't before?  Well, I agree that this
> >> would be good generically, I think it puts a lot of effort in the
> >> drivers for not so much payoff?
> > 
> > Hm, the sunxi driver supports it, and it does not add such a big
> > overhead...
> > The only thing you have to do is cache a bunch of register values
> > per-chip and restore/apply them when the chip is selected
> > (in your ->select_chip() implementation).
> > 
> > Anyway, even if the suggested DT representation is a lie in regards to
> > your implementation, it's actually pretty accurate from an hardware
> > POV, and this is exactly what DT is supposed to represent.
> 
> I agree with both of you. I don't see much value implementing multi-NAND
> chip support, especially with different configurations, at the moment. I
> am not aware of any hardware making use of that now.
> 
> I will update the driver to parse a NAND sub node and get the ECC
> properties from the per flash configuration. However, I won't add chip
> select or multi-NAND support right now...
> 
> Any objection?

Nope, sounds good to me.

A few tips:
 * be defensive; i.e., error out if someone specifies 2 flash in the DT
 * use the 'reg' property to be the addressing index in the flash
   sub-node; i.e., the chip-select. This fits the practice done by most
   others, I think.

Regards,
Brian
