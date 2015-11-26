From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 26 Nov 2015 12:08:55 +0100
Subject: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
In-Reply-To: <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
 <20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
 <20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
 <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
Message-ID: <20151126110855.GA32226@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> > - why is the patch mucking with access to PCI and BIOS space?  Is the
> >   persistent memory even mappable in those regions?  Or is the concern
> >   that userspace can access control registers associated with the
> >   persistent memory?  What is the problem scenario?
> 
> It seems to me that letting /dev/mem do arbitrary access to any region
> of memory is a dangerous capability for a production environment.

So basically the original motivation years ago was to disable /dev/mem altogether: 
it used to be a wide open roothole if anything with write access to it (such as 
old Xorg) is exploited, plus it's a favorite and convenient tool for stealth 
access to system areas of memory in cases where the attacker already has root. 

(this is relevant as even being root might not give easy access to system mmio 
areas if things like being able to load modules is restricted even for room, and 
if the system has readonly storage and a few other things configured.)

But we couldn't disable /dev/mem completely due to Xorg and dosemu legacies - so 
we came up with this restriction feature that limits its scope.

Any additional steps that limit the scope of access under the STRICT_DEVMEM option 
(which is really a misnomer: it should be RESTRICT_DEVMEM instead) are welcome 
from a generic Linux distro POV.

Thanks,

	Ingo
