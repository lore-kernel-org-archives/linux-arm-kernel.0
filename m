From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 19 Jan 2017 12:33:05 +0100
Subject: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
In-Reply-To: <20170119105646.GA11176@leverpostej>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
 <20170119105646.GA11176@leverpostej>
Message-ID: <20170119113305.GB5110@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 10:56:46AM +0000, Mark Rutland wrote:
> > +config HARDENED_PAGE_MAPPINGS
> > +	bool "Mark kernel mappings with stricter permissions (RO/W^X)"
> > +	default y
> > +	depends on ARCH_HAS_HARDENED_MAPPINGS
> > +	help
> > +          If this is set, kernel text and rodata memory will be made read-only,
> > +	  and non-text memory will be made non-executable. This provides
> > +	  protection against certain security attacks (e.g. executing the heap
> > +	  or modifying text).
> > +
> > +	  Unless your system has known restrictions or performance issues, it
> > +	  is recommended to say Y here.
> 
> It's somewhat unfortunate that this means the feature is no longer
> mandatory on arm64 (and s390+x86). We have a boot-time switch to turn
> the protections off, so I was hoping we could make this mandatory on all
> architectures with support.
> 
> It would be good to see if we could make this mandatory for arm and
> parisc, or if it really needs to be optional for either of those.

Looks like the config option is a no-op on parisc just like it is on
s390. Irrelavant of the config option at least on s390 the page tables for
kernel text and rodata will be read-only anyway.

This works since ages and I don't see a reason why this should be
changed. Also trying to disable this with the "rodata=" command line option
does not work at least on s390, and I guess this is true for parisc as
well.

The only thing implemented with CONFIG_DEBUG_RODATA on both architectures
is to emit a message that states memory has been protected
(mark_rodata_ro).
This just avoids a wrong "Kernel memory protection disabled." message.

So yes, I'd really like to keep this option mandatory.
