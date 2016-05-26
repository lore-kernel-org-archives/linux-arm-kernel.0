From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2016 11:59:22 +0100
Subject: [RFC][PATCH 1/3] staging: ion: Move away from the DMA APIs for
 cache flushing
In-Reply-To: <20160526095835.GT23566@e106497-lin.cambridge.arm.com>
References: <1464205684-5587-1-git-send-email-labbott@redhat.com>
 <1464205684-5587-2-git-send-email-labbott@redhat.com>
 <20160526095835.GT23566@e106497-lin.cambridge.arm.com>
Message-ID: <20160526105922.GH19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 10:58:35AM +0100, Liviu Dudau wrote:
> On Wed, May 25, 2016 at 12:48:02PM -0700, Laura Abbott wrote:
> > 
> > Ion is currently using the DMA APIs in non-compliant ways for cache
> > maintaince. The issue is Ion needs to do cache operations outside of
> > the regular DMA model. The Ion model matches more closely with the
> > DRM model which calls cache APIs directly. Add an appropriate
> > abstraction layer for Ion to call cache operations outside of the
> > DMA API.

I _really_ hate seeing architecture internal functions being abused in
drivers - architecture internal functions are there to implement the
official kernel APIs and are not for drivers to poke about with.

I've had this happen several times, and each time it makes maintanence
of architecture code harder than it should be.

In any case, the functions you are using are probably not appropriate -
the way I've defined the architecture internal functions is for each
to have a specific purpose.  Eg, if caches need flushing when page tables
change, then the function gets implemented, otherwise it's a no-op.  Using
a function which _seems_ to do the right thing today in a way which is
against its purpose is a recipe for your code breaking.

If you need something from the architecture which isn't already provided,
then you need to talk to architecture people about proposing an official
interface to that functionality, rather than trying to bolt per-
architecture shims into drivers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
