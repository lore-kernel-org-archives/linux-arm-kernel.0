From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 10:06:14 +0100
Subject: [PATCH 1/2] Allow constructor name selection by architecture.
In-Reply-To: <20120528203005.GA20560@merkur.ravnborg.org>
References: <1338230018-31052-1-git-send-email-vincent.sanders@collabora.co.uk>
 <1338230018-31052-2-git-send-email-vincent.sanders@collabora.co.uk>
 <20120528203005.GA20560@merkur.ravnborg.org>
Message-ID: <20120529090614.GD12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 10:30:05PM +0200, Sam Ravnborg wrote:
> On Mon, May 28, 2012 at 07:33:37PM +0100, Vincent Sanders wrote:
> > From: Vincent Sanders <vince@collabora.co.uk>
> > 
> > The constructor symbol name is different between platforms. Allow this
> > to be selected by configuration and set suitable default values.
> > 
> > Signed-off-by: Vincent Sanders <vincent.sanders@collabora.co.uk>
> > ---
> >  include/asm-generic/vmlinux.lds.h |    6 +++---
> >  init/Kconfig                      |    6 ++++++
> >  kernel/module.c                   |    2 +-
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 8aeadf6..fd34808 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -471,9 +471,9 @@
> >  	}
> >  
> >  #ifdef CONFIG_CONSTRUCTORS
> > -#define KERNEL_CTORS()	. = ALIGN(8);			   \
> > -			VMLINUX_SYMBOL(__ctors_start) = .; \
> > -			*(.ctors)			   \
> > +#define KERNEL_CTORS()	. = ALIGN(8);					\
> > +			VMLINUX_SYMBOL(__ctors_start) = .;		\
> > +			*(CONFIG_CONSTRUCTORS_NAME)			\
> >  			VMLINUX_SYMBOL(__ctors_end) = .;
> 
> What is wrong with adding both "standard" names for ctors uncnditionally?
> Like this:
> > 			*(.ctors)			   \
> > +			*(.init_array)			   \

That doesn't get rid of CONFIG_CONSTRUCTORS_NAME, because it's needed
in the module code.  Do you have a suggestion to solve that as well?
