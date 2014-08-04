From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Aug 2014 12:35:28 +0100
Subject: Kexec on arm64
In-Reply-To: <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
References: <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
Message-ID: <20140804113528.GC3197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 11:16:02AM +0100, Arun Chandran wrote:
> Hi Geoff,
> 
> On Wed, Jul 30, 2014 at 12:52 PM, Arun Chandran <achandran@mvista.com> wrote:
> > On Wed, Jul 30, 2014 at 2:49 AM, Geoff Levand <geoff@infradead.org> wrote:
> >> Hi Mark,
> >>
> >> On Tue, 2014-07-29 at 14:35 +0100, Mark Rutland wrote:
> >>> Since c218bca74eea (arm64: Relax the kernel cache requirements for
> >>> boot), the kernel will flush the cache for anything outside of the Image
> >>> that it writes to before enabling the MMU and caches (e.g. the idmap and
> >>> swapper page tables). Once caches are up we shouldn't care.
> >>>
> >>> Assuming that the existing kernel code is correct, the only region we
> >>> should need to flush out to the PoC is the region from _text to _edata
> >>> (i.e. just the contents of the Image).
> >>
> >> If the new kernel will overwrite the old one, then we do the final copy
> >> of the new kernel in the relocate_new_kernel routine.  relocate_new_kernel
> >> is executed after the dcache is disabled, so that should write it directly
> >> to the PoC.  It seems the protocol expects us to invalidate the dcache
> >> for that range though, so I added code to do this, essentially what Arun
> >> had added.
> >>
> >> Arun, please try.
> >>
> > It works without any hiccups :)..
> > I have attached the log.
> >
> > I will try with big-endian UP configuration next.
> >
> 
> The latest kexec code is working fine in LE/BE mode in UP configuration.
> 
> I had to change kexec-tools code a bit to make sure that "kexec -l"
> is not putting dtb at an area where kernel is building its initial page
> tables.
> 
> #########################
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index ab7a9ac..8f04473 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -526,6 +526,7 @@ int arm64_load_other_segments(struct kexec_info *info)
>         off_t dtb_base;
>         char *initrd_buf = NULL;
>         char command_line[COMMAND_LINE_SIZE] = "";
> +       unsigned long dtb_start;
> 
>         /* Processing for arm64_opts.dtb and arm64_opts.command_line. */
> 
> @@ -554,8 +555,16 @@ int arm64_load_other_segments(struct kexec_info *info)
>          * kernel with an alignment of 128 KiB, giving a max supported DTB
>          * size of 128 KiB (worst case). */
> 
> +       /*
> +        * arm64 kernel uses area above kernel image to build
> +        * initial page tables. Max required size for this area is 384K. It
> +        * happens when CONFIG_ARM64_PGTABLE_LEVELS is set.
> +        * So place dtb 512k above kernel image area.
> +        */

The area above the kernel Image holds the BSS too, and from some
experiments I did a while back with an allyesconfig, it was possible to
have many megabytes of BSS.

While 512k might be adequate for a defconfig today, it will become less
so as time goes on.

For kernel Images post v3.17 you can and should read the Image header's
image_size field to figure out how much memory is needed from _text to
_end (i.e. all the memory the kernel will assume is available statically
and will happily clobber). For kernel Images prior to v3.17 the best
thing we can do is guess as you've done here, or place the DTB below the
kernel and page tables in the TEXT_OFFSET area; neither option is
particularly brilliant.

Thanks,
Mark.
