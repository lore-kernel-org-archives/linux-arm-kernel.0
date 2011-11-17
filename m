From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 17 Nov 2011 18:37:26 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111117160536.GU9581@n2100.arm.linux.org.uk>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111117160536.GU9581@n2100.arm.linux.org.uk>
Message-ID: <20111117183726.GE3044@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 04:05:37PM +0000, Russell King - ARM Linux wrote:

[...]

> > @@ -383,11 +412,18 @@ static struct clk_lookup v2m_lookups[] = {
> >  	},
> >  };
> >  
> > +static void __init v2m_system_id(void)
> > +{
> > +	if (!system_rev)
> > +		system_rev = readl(v2m_sysreg_base + V2M_SYS_ID);
> 
> You do understand that system_rev is for the system _revision_ not for
> some kind of system ID.  For example, it's to identify whether we're on
> a revision 4, 5 or 6 system.
> 
> However, with DT the differences in system revision should be encoded
> into the DT itself, and the kernel should not be making choices about
> the hardware off this.

I can't comment on whether this is an abuse of system_rev, since I'm
not too familiar with that.

I feel that Whether the value of the V2M_SYS_ID register should be put
in the DT is more doubtful though: the DT must describe the hardware
which cannot be probed.  Hardware features which can be probed can still
be described in the DT and sometimes this is advantageous -- nonetheless
it does break the one-definition principle and may lead to problems.
One scenario where this does make sense is if the bootloader discovers
that value and injects it into the DT.  However, that would broaden the
interface between the bootloader and kernel in a platform-specific way
and may cause problems itself.

Cheers
---Dave
