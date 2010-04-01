From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 01 Apr 2010 18:01:38 +0200
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <20100331083415.GR2241@pengutronix.de>
References: <4BB22576.1070108@epfl.ch> <20100331083415.GR2241@pengutronix.de>
Message-ID: <4BB4C362.3000803@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sascha Hauer wrote:
> 
> Find the latest version of my code here:
> 
> The following changes since commit 01e77706cdde7c0b47e5ca1f4284a795504c7c40:
>   Linus Torvalds (1):
>         Merge branch 'for-linus' of git://gitorious.org/linux-omap-dss2/linux
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/sha/linux-2.6.git mc13783
> 
> Sascha Hauer (3):
>       add a mc13783 codec driver
>       add phycore-mc13783 sound support
>       pcm038: add sound support
> 
>  arch/arm/mach-mx2/mach-pcm038.c |   23 ++-
>  sound/soc/codecs/Kconfig        |    4 +
>  sound/soc/codecs/Makefile       |    2 +
>  sound/soc/codecs/mc13783.c      |  727 +++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/mc13783.h      |   32 ++
>  sound/soc/imx/Kconfig           |    9 +
>  sound/soc/imx/Makefile          |    3 +
>  sound/soc/imx/phycore-mc13783.c |  160 +++++++++
>  8 files changed, 959 insertions(+), 1 deletions(-)
>  create mode 100644 sound/soc/codecs/mc13783.c
>  create mode 100644 sound/soc/codecs/mc13783.h
>  create mode 100644 sound/soc/imx/phycore-mc13783.c
> 
>> And do you know if your initial mc13783 codec support coupled with  
>> mx31 had some limitations ? Our setup is quite straightforward, we have  
>> direct connection from the mx31 to the mc13783 on a single SSI.
> 
> Our board uses both SSI channels of the MC13783 which we then mux into
> one channel in the DAM unit. I don't know how this affects you.
> 

I have struggled with the DAM unit (this thing is an awful bulk of 
wires) and now I get some sound on the loudspeaker.

The thing is that I get a less than a second sound loop (I use aplay to 
test, so userspace app should be ok), as if the buffer that the fiq asm 
interrupt (from ssi_fiq.S) copies to the SSI hardware never was updated.

If I have understood the fiq behaviour correctly, you have a asm fiq 
interrupt that does copy a larger tx buffer into the SSI hardware. 
Besides it, you have the imx_ssi_timer_callback that checks when the tx 
buffer was completely copied. If it is the case, then a new buffer tx 
buffer is "issued" with the snd_pcm_period_elapsed call (and then 
snd_pcm_update_hw_ptr0). Is this behaviour correct ?

If then it looks like on my system, I have a problem with the 
snd_pcm_update_hw_ptr0 call.

Thanks

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
