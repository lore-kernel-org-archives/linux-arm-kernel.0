From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 27 Aug 2014 13:13:53 +0300
Subject: [PATCH 11/14] ARM: brcmstb: delete unneeded test before
 of_node_put
In-Reply-To: <20140814065310.GK11952@brian-ubuntu>
References: <1407492475-26283-11-git-send-email-Julia.Lawall@lip6.fr>
 <20140813222212.GB18411@ld-irv-0074>
 <alpine.DEB.2.02.1408140733190.2053@localhost6.localdomain6>
 <20140814065310.GK11952@brian-ubuntu>
Message-ID: <20140827101353.GG5046@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 11:53:10PM -0700, Brian Norris wrote:
> > > >  cleanup:
> > > > -	if (syscon_np)
> > > > -		of_node_put(syscon_np);
> > > > -
> > > > +	of_node_put(syscon_np);
> > > > +out:
> > > 
> > > Is there a good reason for this new label? I thought part of the point
> > > of this semantic patch is that the previous line (of_node_put()) is a
> > > no-op for NULL arguments.
> > 
> > Personally, I prefer code to only be executed if it needs to be.  It is 
> > helpful from a program analysis point of view, and I think it helps 
> > someone trying to understand the code.
> > 
> > That is, when I am trying to understand some unknown code, I may look at 
> > the cleanup code and try to figure out why each piece of it is executed.  
> > If some of it is statically known to be irrelevant, it is confusing.
> > 
> > But I you think the other way around, and would rather have just one label 
> > that contains anything that might ever be useful, then I guess that is a 
> > reasonable point of view as well.
> 
> Yeah, I personally just look to avoid unnecessary labels.
> 

Having more than one label is better because it helps you avoid "One Err
Bugs".  This is a common kind of bug which is cause when functions have
only one "err:" label which does all the error handling.

Some examples of this type of bug are:
234ad18249a4 ('staging: gdm7240: fix error handling of probe()')
85a258b70d48 ('ocfs2: fix error handling in ocfs2_ioctl_move_extents()')
920c4f4c3651 ('drivers/leds/leds-tca6507.c: cleanup error handling in tca6507_probe()')

If you unwind in the exact reversed order of how things were allocated
then it makes the code a lot easier to understand so it avoids bugs.

regards,
dan carpenter
