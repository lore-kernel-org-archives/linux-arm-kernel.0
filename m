From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 29 May 2015 11:31:01 +0200
Subject: [PATCH] ALSA: fix building with CONFIG_SND_PROC_FS disabled
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90553BC12@SHSMSX101.ccr.corp.intel.com>
References: <4218314.pT4WQLSW4C@wuerfel>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553BC12@SHSMSX101.ccr.corp.intel.com>
Message-ID: <s5h7frr7msq.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Fri, 29 May 2015 09:03:35 +0000,
Jie, Yang wrote:
> 
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: Friday, May 29, 2015 4:47 PM
> > To: Takashi Iwai
> > Cc: broonie at kernel.org; alsa-devel at alsa-project.org; linux-arm-
> > kernel at lists.infradead.org; Jie, Yang
> > Subject: [PATCH] ALSA: fix building with CONFIG_SND_PROC_FS disabled
> > 
> > A recent change to split the procfs support for ALSA turned out to be
> > incomplete, leading to build errors:
> > 
> > sound/core/seq/seq_info.c:61:12: error: redefinition of 'snd_seq_info_init'
> > sound/core/seq/seq_device.c: In function 'seq_dev_proc_init':
> > sound/core/seq/seq_device.c:276:2: error: 'info_entry' undeclared (first use
> > in this function)
> > sound/core/seq/seq_device.c: In function 'alsa_seq_device_exit':
> > sound/core/seq/seq_device.c:309:22: error: 'info_entry' undeclared (first
> > use in this function)
> > 
> > This replaces some more instances of CONFIG_PROC_FS with
> > CONFIG_SND_PROC_FS, as the original patch started. It is enough to avoid all
> > randconfig regressions I saw on ARM because of the CONFIG_SND_PROC_FS
> > introduction.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: cd6a65036f0e ("ALSA: replace CONFIG_PROC_FS with
> > CONFIG_SND_PROC_FS")
> > ---
> > 
> > I assume this was already reported. If not, please apply my patch or fold it
> > into the original commit.
>  
> Thank you, Seems this already fixed by Takashi's latest series? 

Yes.


Takashi

> 
> ~Keyon
> 
> > 
> > diff --git a/sound/core/seq/Makefile b/sound/core/seq/Makefile index
> > b29ffe835205..b65fa5a1943b 100644
> > --- a/sound/core/seq/Makefile
> > +++ b/sound/core/seq/Makefile
> > @@ -7,7 +7,7 @@ snd-seq-device-objs := seq_device.o  snd-seq-objs :=
> > seq.o seq_lock.o seq_clientmgr.o seq_memory.o seq_queue.o \
> >                  seq_fifo.o seq_prioq.o seq_timer.o \
> >                  seq_system.o seq_ports.o
> > -snd-seq-$(CONFIG_PROC_FS) += seq_info.o
> > +snd-seq-$(CONFIG_SND_PROC_FS) += seq_info.o
> >  snd-seq-midi-objs := seq_midi.o
> >  snd-seq-midi-emul-objs := seq_midi_emul.o  snd-seq-midi-event-objs :=
> > seq_midi_event.o diff --git a/sound/core/seq/seq_device.c
> > b/sound/core/seq/seq_device.c index 288af56a43cd..c4acf17e9f5e 100644
> > --- a/sound/core/seq/seq_device.c
> > +++ b/sound/core/seq/seq_device.c
> > @@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(snd_seq_driver_unregister);
> > 
> >  static int __init seq_dev_proc_init(void)  { -#ifdef CONFIG_PROC_FS
> > +#ifdef CONFIG_SND_PROC_FS
> >  	info_entry = snd_info_create_module_entry(THIS_MODULE,
> > "drivers",
> >  						  snd_seq_root);
> >  	if (info_entry == NULL)
> > @@ -305,7 +305,7 @@ static void __exit alsa_seq_device_exit(void)  #ifdef
> > CONFIG_MODULES
> >  	cancel_work_sync(&autoload_work);
> >  #endif
> > -#ifdef CONFIG_PROC_FS
> > +#ifdef CONFIG_SND_PROC_FS
> >  	snd_info_free_entry(info_entry);
> >  #endif
> >  	bus_unregister(&snd_seq_bus_type);
> 
