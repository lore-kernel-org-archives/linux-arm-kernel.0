From: Maximilian.Schwerin@tigris.de (Maximilian Schwerin)
Date: Tue, 18 Sep 2012 08:32:06 +0200
Subject: AW: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
In-Reply-To: <alpine.LFD.2.02.1209171322290.28681@xanadu.home>
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E307@dolphin.TIGRIS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Urspr?ngliche Nachricht-----
> Von: Nicolas Pitre [mailto:nico at fluxnic.net] 
> Gesendet: Montag, 17. September 2012 19:30
> An: Maximilian Schwerin
> Cc: linux-arm-kernel at lists.infradead.org
> Betreff: Re: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
> 
> On Mon, 17 Sep 2012, Maximilian Schwerin wrote:
> 
> > This change allows preventing the message "Uncompressing 
> Linux..." from
> > being sent to serial port. This is necessary if the primary 
> serial port is
> > used for something other than kernel debugging (e.g. some 
> external device
> > controlled by serial commands).
> > 
> > Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
> > ---
> >  arch/arm/Kconfig.debug          |    9 +++++++++
> >  arch/arm/boot/compressed/misc.c |    4 ++++
> >  2 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index e968a52..96e90dc 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -46,6 +46,15 @@ config OLD_MCOUNT
> >  	depends on FUNCTION_TRACER && FRAME_POINTER
> >  	default y
> >  
> > +config DEBUG_DECOMPRESS_KERNEL
> > +	bool "Using serial port during decompressing kernel"
> > +	depends on DEBUG_KERNEL
> > +	default n
> > +	help
> > +	  If you say Y here you will confirm the start and the end of
> > +	  decompressing Linux seeing "Uncompressing Linux... " and
> > +	  " done, booting the kernel.\n" on console.
> 
> First, "default n" is the default already, so you don't need 
> to provide 
> it.

Makes sense.

> Next, this is going to disable the output by default for 
> everyone which 
> is an unwelcome change.  You should make sure that the 
> default behavior 
> is like before, and that the option allows you to disable the output.
> 
> And then the DEBUG_DECOMPRESS_KERNEL option is a rather bad 
> name.  This 
> output has not been considered "debugging" before.  What about 
> "INHIBIT_DECOMPRESSOR_OUTPUT" instead?

This is something I copied from arch/mn10300/Kconfig.debug (see http://kernel.org/doc/menuconfig/arch-mn10300-Kconfig.debug.html).

> > diff --git a/arch/arm/boot/compressed/misc.c 
> b/arch/arm/boot/compressed/misc.c
> > index 8e2a8fc..edf4a35 100644
> > --- a/arch/arm/boot/compressed/misc.c
> > +++ b/arch/arm/boot/compressed/misc.c
> > @@ -144,11 +144,15 @@ decompress_kernel(unsigned long 
> output_start, unsigned long free_mem_ptr_p,
> >  
> >  	arch_decomp_setup();
> >  
> > +#ifdef CONFIG_DEBUG_DECOMPRESS_KERNEL
> >  	putstr("Uncompressing Linux...");
> > +#endif /* CONFIG_DEBUG_DECOMPRESS_KERNEL */
> >  	ret = do_decompress(input_data, input_data_end - input_data,
> >  			    output_data, error);
> >  	if (ret)
> >  		error("decompressor returned an error");
> > +#ifdef CONFIG_DEBUG_DECOMPRESS_KERNEL
> >  	else
> >  		putstr(" done, booting the kernel.\n");
> > +#endif /* CONFIG_DEBUG_DECOMPRESS_KERNEL */
> 
> That would be cleaner if you simply redefined putstr() to an 
> empty stub.  
> Similarly for error() which still can output to the same UART.
> 
> 
> Nicolas
> 

Thanks for the feedback both of you. I'll get into contact with the OMAP guys and will try to find a fix on the platform level.

Cheers, m.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120918/ca648346/attachment-0001.sig>
