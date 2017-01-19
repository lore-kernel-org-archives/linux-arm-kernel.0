From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2017 15:48:18 +0000
Subject: [Patch v3 1/2] arm: kernel: Add SMC structure parameter
In-Reply-To: <20170119154506.GB9631@hector.attlocal.net>
References: <1484173918-25090-1-git-send-email-andy.gross@linaro.org>
 <1484173918-25090-2-git-send-email-andy.gross@linaro.org>
 <20170119144008.GA27312@n2100.armlinux.org.uk>
 <20170119154506.GB9631@hector.attlocal.net>
Message-ID: <20170119154818.GE27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 09:45:06AM -0600, Andy Gross wrote:
> On Thu, Jan 19, 2017 at 02:40:08PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 11, 2017 at 04:31:57PM -0600, Andy Gross wrote:
> > > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > > index b5abfda..3e28d08 100644
> > > --- a/include/linux/arm-smccc.h
> > > +++ b/include/linux/arm-smccc.h
> > > @@ -72,19 +72,33 @@ struct arm_smccc_res {
> > >  };
> > >  
> > >  /**
> > > - * arm_smccc_smc() - make SMC calls
> > > + * struct arm_smccc_quirk - Contains quirk information
> > > + * id contains quirk identification
> > > + * state contains the quirk specific information
> > 
> > Given that this is a kerneldoc comment, it should really conform to the
> > kerneldoc requirements - see Documentation/kernel-doc-nano-HOWTO.txt:
> > 
> > /**
> >  * struct arm_smccc_quirk - Contains quirk information
> >  * @id: quirk identification
> >  * @state: the quirk specific information
> 
> Ah, I flubbed that.  I'll fix this.
> 
> > 
> > > + */
> > > +struct arm_smccc_quirk {
> > > +	int	id;
> > > +	union {
> > > +		unsigned long a6;
> > > +	} state;
> > > +};
> > > +
> > > +/**
> > > + * __arm_smccc_smc() - make SMC calls
> > >   * @a0-a7: arguments passed in registers 0 to 7
> > >   * @res: result values from registers 0 to 3
> > > + * @quirk: optional quirk structure
> > >   *
> > >   * This function is used to make SMC calls following SMC Calling Convention.
> > >   * The content of the supplied param are copied to registers 0 to 7 prior
> > >   * to the SMC instruction. The return values are updated with the content
> > > - * from register 0 to 3 on return from the SMC instruction.
> > > + * from register 0 to 3 on return from the SMC instruction.  An optional
> > > + * quirk structure provides vendor specific behavior.
> > 
> > It's quite odd to have the result buried in the middle of arguments
> > passed to a function, but I guess for the sake of simplicity in the
> > assembly code that's what we need.
> > 
> > Also:
> > 
> > "@quirk points to an arm_smccc_quirk, or NULL when no quirks are required."
> 
> Fixed.
> 
> > 
> > And... should this not be const?  Are we expecting anyone to modify
> > the quirk structure?
> 
> No, unfortunately.  For qcom, we are stuffing the contents of a6 into the
> structure so the caller can get that information.

Please add that detail to the kerneldoc comments for the structure
concerning state.a6.  It's important that such information is not
lost in the depths of history.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
