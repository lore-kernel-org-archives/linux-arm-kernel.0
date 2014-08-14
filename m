From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 13 Aug 2014 23:53:10 -0700
Subject: [PATCH 11/14] ARM: brcmstb: delete unneeded test before
 of_node_put
In-Reply-To: <alpine.DEB.2.02.1408140733190.2053@localhost6.localdomain6>
References: <1407492475-26283-11-git-send-email-Julia.Lawall@lip6.fr>
 <20140813222212.GB18411@ld-irv-0074>
 <alpine.DEB.2.02.1408140733190.2053@localhost6.localdomain6>
Message-ID: <20140814065310.GK11952@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 07:37:28AM +0200, Julia Lawall wrote:
> On Wed, 13 Aug 2014, Brian Norris wrote:
> > On Fri, Aug 08, 2014 at 12:07:52PM +0200, Julia Lawall wrote:
> > > diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
> > > index af780e9..c515ea1 100644
> > > --- a/arch/arm/mach-bcm/platsmp-brcmstb.c
> > > +++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
> > > @@ -227,7 +227,7 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
> > >  	if (!syscon_np) {
> > >  		pr_err("can't find phandle %s\n", name);
> > >  		rc = -EINVAL;
> > > -		goto cleanup;
> > > +		goto out;
> > >  	}
> > >  
> > >  	cpubiuctrl_block = of_iomap(syscon_np, 0);
> > > @@ -256,9 +256,8 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
> > >  	}
> > >  
> > >  cleanup:
> > > -	if (syscon_np)
> > > -		of_node_put(syscon_np);
> > > -
> > > +	of_node_put(syscon_np);
> > > +out:
> > 
> > Is there a good reason for this new label? I thought part of the point
> > of this semantic patch is that the previous line (of_node_put()) is a
> > no-op for NULL arguments.
> 
> Personally, I prefer code to only be executed if it needs to be.  It is 
> helpful from a program analysis point of view, and I think it helps 
> someone trying to understand the code.
> 
> That is, when I am trying to understand some unknown code, I may look at 
> the cleanup code and try to figure out why each piece of it is executed.  
> If some of it is statically known to be irrelevant, it is confusing.
> 
> But I you think the other way around, and would rather have just one label 
> that contains anything that might ever be useful, then I guess that is a 
> reasonable point of view as well.

Yeah, I personally just look to avoid unnecessary labels.

Thanks for explaining your thought process.

Brian
