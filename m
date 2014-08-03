From: mark.rutland@arm.com (Mark Rutland)
Date: Sun, 3 Aug 2014 15:47:17 +0100
Subject: Kexec on arm64
In-Reply-To: <CAFdej00F56XLzNZEhYB0aV70mt+R+NN=gKQgE_5oDGsbxW0npA@mail.gmail.com>
References: <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej00F56XLzNZEhYB0aV70mt+R+NN=gKQgE_5oDGsbxW0npA@mail.gmail.com>
Message-ID: <20140803144717.GA9441@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 12:13:12PM +0100, Arun Chandran wrote:
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
> This question may be irrelevant to kexec and may be stupid also.
> 
> while debugging kexec in BIG-endian configuration I see
> _create_page_tables (arch/arm64/kernel/head.S) is
> doing __inval_cache_range on the addresses
> from idmap_pg_dir to swapper_pg_dir.
> 
> ie from 0x4000D5F000 to 0x4000D61000 + #SWAPPER_DIR_SIZE
> in my case.
> 
> Is it supposed to clear the corresponding virtual addresses?

The data caches behave in a PIPT like fashion, and there are no aliases.
Flushing by any VA that maps to a particular PA will flush out the only
entry that cna possibly exist for that PA.

While the MMU is off, the VA->PA mapping is an idmap. Given that, we can
flush by PA.

> There might be chance that first stage kernel may be using VA
> from the same area right? (cache (L3)containing valid lines in the
> area 0xffffffc000d5f000 to 0xffffffc000d5f000 + 16K)

The L3 cache should never see the VA, only the PA.

> Or is it the duty of the kexec to flush the entire
> VA regions used by the first stage kernel and
> the VA regions going to be used by the 2nd
> stage kernel?

We should only need ensure that the new kernel image and anything we
expect to use before the caches have been eanbled are flushed to the
PoC.

Thanks,
Mark.
