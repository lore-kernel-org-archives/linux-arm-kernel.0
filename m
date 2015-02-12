From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 12 Feb 2015 06:12:22 +0000
Subject: [PATCH] xen/arm: allow console=hvc0 to be omitted for guests
In-Reply-To: <54DC3813.2020908@linaro.org>
References: <1422626319-30752-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.DEB.2.02.1502100648050.29696@kaball.uk.xensource.com>
 <1423553200.5851.15.camel@citrix.com>
 <CAKv+Gu8kQ5e9dKTp9+e_11pnvskOPjin7ODpxXTj+HmTj+fPag@mail.gmail.com>
 <1423558788.5851.17.camel@citrix.com>
 <alpine.DEB.2.02.1502120433040.29696@kaball.uk.xensource.com>
 <1423716873.27551.30.camel@citrix.com> <54DC3813.2020908@linaro.org>
Message-ID: <alpine.DEB.2.02.1502120610590.29696@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Feb 2015, Julien Grall wrote:
> On 12/02/2015 12:54, Ian Campbell wrote:
> > On Thu, 2015-02-12 at 04:35 +0000, Stefano Stabellini wrote:
> > > On Tue, 10 Feb 2015, Ian Campbell wrote:
> > > > On Tue, 2015-02-10 at 15:51 +0800, Ard Biesheuvel wrote:
> > > > > > FWIW on x86 this doesn't depend on console_set_on_cmdline, does it
> > > > > > need
> > > > > > to here?
> > > > > > 
> > > > > 
> > > > > I didn't check the code, but it seems inappropriate to add a preferred
> > > > > console implicitly if the user has set 'console=' on the command line.
> > > > 
> > > > I had been thinking that add_preferred_console would DTRT, but it seems
> > > > not. Seems strange that most calls to it do not check if the console is
> > > > already set, but it does seem like the right thing in this case.
> > > > 
> > > > > > On x86 it does depend on !xen_initial_domain. I suppose on the
> > > > > > principal
> > > > > > that a VT is normally available there. I suppose that doesn't apply
> > > > > > to
> > > > > > ARM so much, although it could.
> > > > > > 
> > > > > 
> > > > > OK, I got confused by the xen_guest_init(). So do you mean if if
> > > > > (!xen_initial_domain) should be added?
> > > > 
> > > > (dom0 is "Just A Guest" too ;-))
> > > > 
> > > > Adding it would be consistent with x86, I'm not precisely sure if that
> > > > is important or desirable in this case. I'd be inclined to start with
> > > > the if there.
> > > 
> > > The reasoning is that dom0 command line arguments come from its old
> > > native grub stanza, therefore the console parameter is incorrect, right?
> > > As opposed to regular domUs, that being freshly installed, are supposed
> > > to have the correct console parameter?
> > 
> > Other way around I think, dom0 has the correct stuff from grub.cfg
> > whereas the guest may not.
> 
> Yes, currently for ARM guest you have to add 'extra="console=hvc0"' in the
> configuration file.

I see. If this is the concern that we are trying to address, then yes,
doing the same that we are already doing on x86 might be best.
