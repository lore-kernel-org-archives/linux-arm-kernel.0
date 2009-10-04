From: alex@digriz.org.uk (Alexander Clouter)
Date: Sun, 4 Oct 2009 12:13:36 +0100
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
	<20091004011424.12578.79467.stgit@localhost.localdomain>
Message-ID: <0kcmp6-75a.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud <cgagneraud@techworks.ie> wrote:
<
> From: Matthieu Crapet <mcrapet@gmail.com>
> 
> In early days Technologic Systems fixed the 0x163 value in redboot
> instead of 0x2a1, this patch allow to overwrite it.
> 
> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
> ---
> 
> arch/arm/kernel/head.S       |    3 +++
> arch/arm/mach-ep93xx/Kconfig |    7 +++++++
> 2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 38ccbe1..c2e4514 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -82,6 +82,9 @@ ENTRY(stext)
>        bl      __lookup_processor_type         @ r5=procinfo r9=cpuid
>        movs    r10, r5                         @ invalid processor (r5=0)?
>        beq     __error_p                       @ yes, error 'p'
> +#ifdef CONFIG_MACH_TS72XX_FORCE_MACHINEID
> +       ldr r1, =0x2a1
> +#endif
>        bl      __lookup_machine_type           @ r5=machinfo
>        movs    r8, r5                          @ invalid machine (r5=0)?
>        beq     __error_a                       @ yes, error 'a'
>
Brace yourself for Russell giving you a FPSesque "DENIED" here.  I 
suggested a similar patch over a year ago for my TS78XX board and got 
(rightly) gunned down. :)

If you are compiling your own kernels the best solution I have seen[1] 
is to simply patch the kernel image with:

http://ts78xx.digriz.org.uk/booting-woes

You will need to use the following devio line instead:

devio 'wl 0xe3a01c02,4' 'wl 0xe38110a1,4'

Cheers

[1] something I first saw on the NAS Buffolo site but then heavily 
	prompted by the orion5x Debian installer maintainers

-- 
Alexander Clouter
.sigmonster says: Acceptance testing:
                  	An unsuccessful attempt to find bugs.
